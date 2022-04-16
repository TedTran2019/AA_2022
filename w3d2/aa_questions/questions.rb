require 'sqlite3'
require 'singleton'

class QuestionDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question
  attr_accessor :id, :title, :body, :author_id

  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
      id = ?
    SQL
    return nil if data.empty?

    data.map { |datum| Question.new(datum) }.first
  end

  def self.find_by_author_id(author_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
      author_id = ?
    SQL

    data.map { |datum| Question.new(datum) }
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def save
    id.nil? ? create : update
  end

  def update
    raise "#{id} not in DB" unless id

    QuestionDBConnection.instance.execute(<<-SQL, title, body, author_id, id)
    UPDATE
      questions
    SET
      title = ?, body = ?, author_id = ?
    WHERE
      id = ?
    SQL
  end
  
  def create
    raise "#{id} already in DB" if id

    QuestionDBConnection.instance.execute(<<-SQL, id, title, body, author_id)
    INSERT INTO
      questions (id, title, body, author_id)
    VALUES
      (?, ?, ?, ?)
    SQL
    id = QuestionDBConnection.instance.last_insert_row_id
  end

  def author
    User.find_by_id(author_id)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def followers
    QuestionFollow.followers_for_question_id(id)
  end

  def likers
    QuestionLike.likers_for_question_id(id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(id)
  end

  def most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
end

class User
  attr_accessor :id, :fname, :lname

  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM users")
    data.map { |datum| User.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
      id = ?
    SQL
    return nil if data.empty?

    data.map { |datum| User.new(datum) }.first
  end

  def self.find_by_name(fname, lname)
    data = QuestionDBConnection.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    SQL

  data.map { |datum| User.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def save
    id.nil? ? create : update
  end

  def update
    raise "#{id} not in DB" unless id

    QuestionDBConnection.instance.execute(<<-SQL, fname, lname, id)
    UPDATE
      users
    SET
      fname = ?, lname = ?
    WHERE
      id = ?
    SQL
  end
  
  def create
    raise "#{id} already in DB" if id

    QuestionDBConnection.instance.execute(<<-SQL, id, fname, lname)
    INSERT INTO
      users (id, fname, lname)
    VALUES
      (?, ?, ?)
    SQL
    id = QuestionDBConnection.instance.last_insert_row_id
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_author_id(id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_follower_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end

  def average_karma
    data = QuestionDBConnection.instance.execute(<<-SQL, id)
    SELECT
      CAST (COUNT(question_likes.id) / COUNT(DISTINCT questions.id) AS FLOAT) as avg_karma
    FROM
      users
    JOIN
      questions ON questions.author_id = users.id
    LEFT JOIN
      question_likes ON questions.id = question_likes.question_id
    WHERE
      author_id = ? AND question_likes.id IS NOT NULL
    SQL
    data.first['avg_karma']
  end
end

class QuestionFollow
  attr_accessor :id, :question_id, :follower_id

  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM question_follows")
    data.map { |datum| QuestionFollow.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions_follows
      WHERE
      id = ?
    SQL
    return nil if data.empty?

    data.map { |datum| QuestionFollow.new(datum) }.first
  end

  def self.followers_for_question_id(question_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        followers.*
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      JOIN
        users AS followers ON question_follows.follower_id = followers.id
      WHERE
        question_id = ?
    SQL

    data.map { |datum| User.new(datum) }
  end
  
  def self.followed_questions_for_follower_id(follower_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, follower_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      JOIN
        users AS followers ON question_follows.follower_id = followers.id
      WHERE
        follower_id = ?
    SQL

    data.map { |datum| Question.new(datum) }
  end

  def self.most_followed_questions(n)
    data = QuestionDBConnection.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_id) DESC
      LIMIT
        ?
    SQL

    data.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @follower_id = options['follower_id']
  end
end

class Reply
  attr_accessor :id, :question_id, :parent_id, :author_id, :body

  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
      id = ?
    SQL
    return nil if data.empty?

    data.map { |datum| Reply.new(datum) }.first
  end

  def self.find_by_author_id(author_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        replies
      WHERE
      author_id = ?
    SQL

    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
      question_id = ?
    SQL

    data.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @author_id = options['author_id']
    @body = options['body']
  end

  def save
    id.nil? ? create : update
  end

  def update
    raise "#{id} not in DB" unless id

    QuestionDBConnection.instance.execute(<<-SQL, question_id, parent_id, author_id, body, id)
    UPDATE
      replies
    SET
      question_id = ?, parent_id = ?, author_id = ?, body = ?
    WHERE
      id = ?
    SQL
  end
  
  def create
    raise "#{id} already in DB" if id

    QuestionDBConnection.instance.execute(<<-SQL, id, question_id, parent_id, author_id, body)
    INSERT INTO
      replies (id, question_id, parent_id, author_id, body)
    VALUES
      (?, ?, ?, ?, ?)
    SQL
    id = QuestionDBConnection.instance.last_insert_row_id
  end

  def author
    User.find_by_id(author_id)
  end

  def question
    Question.find_by_id(question_id)
  end
  
  def parent_reply
    Reply.find_by_id(parent_id)
  end

  def child_replies
    data = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL

    data.map { |datum| Reply.new(datum) }
  end
end

class QuestionLike
  attr_accessor :id, :question_id, :user_id

  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| QuestionLike.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
      id = ?
    SQL
    return nil if data.empty?

    data.map { |datum| QuestionLike.new(datum) }.first
  end

  def self.likers_for_question_id(question_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        questions
      JOIN 
        question_likes ON questions.id = question_likes.question_id
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_id = ?
    SQL

    data.map { |datum| User.new(datum) }
  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(question_id) AS num_likes
      FROM
        questions
      JOIN 
        question_likes ON questions.id = question_likes.question_id
      WHERE
        question_id = ?
      GROUP BY
        questions.id
    SQL
    return 0 if data.empty?

    data.first['num_likes']
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN 
        question_likes ON questions.id = question_likes.question_id
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        user_id = ?
    SQL

    data.map { |datum| Question.new(datum) }
  end

  def self.most_liked_questions(n)
    data = QuestionDBConnection.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_id) DESC
      LIMIT
        ?
    SQL

    data.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end
