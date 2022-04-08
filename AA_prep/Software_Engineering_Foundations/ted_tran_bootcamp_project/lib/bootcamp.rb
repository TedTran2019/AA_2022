class Bootcamp
  attr_reader :name, :slogan, :students, :teachers
  def initialize(name, slogan, student_capacity)
    @name = name
    @slogan = slogan
    @student_capacity = student_capacity
    @students = []
    @teachers = []
    @grades = Hash.new { |h, k| h[k] = [] }
  end

  def hire(teacher)
    @teachers << teacher
  end

  def enroll(student)
    students.length < @student_capacity ? (students << student) && true : false 
  end

  def enrolled?(student)
    students.include? student
  end

  def student_to_teacher_ratio
    students.length / teachers.length
  end

  def add_grade(student, grade)
    enrolled?(student) ? (@grades[student] << grade) && true : false
  end

  def num_grades(student)
    @grades[student].length
  end

  def average_grade(student)
    return @grades[student].sum / @grades[student].length if enrolled?(student) &&
                                                             num_grades(student).positive?

    nil
  end
end
