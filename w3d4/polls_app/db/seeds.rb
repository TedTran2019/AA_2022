# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
u1 = User.create(username: 'Ted')
u2 = User.create(username: 'Helen')
u3 = User.create(username: 'Brian')

Poll.destroy_all

p1 = Poll.create!(title: 'Programming', author_id: u1.id)
p2 = Poll.create!(title: 'Cats', author_id: u2.id)
p3 = Poll.create!(title: 'Elden Ring', author_id: u1.id)

Question.destroy_all
q1 = Question.create!(text: 'Is Ruby a good programming language?', poll_id: p1.id)
q2 = Question.create!(text: 'Is C++ the best language for interviews?', poll_id: p1.id)
q3 = Question.create!(text: 'What type of cat is the best cat?', poll_id: p2.id)

AnswerChoice.destroy_all
ac1 = AnswerChoice.create!(text: 'Yes', question_id: q1.id)
ac2 = AnswerChoice.create!(text: 'No', question_id: q1.id)
ac3 = AnswerChoice.create!(text: 'Yes',question_id:  q2.id)
ac4 = AnswerChoice.create!(text: 'No', question_id: q2.id)
ac5 = AnswerChoice.create!(text: 'Black cat', question_id: q3.id)
ac6 = AnswerChoice.create!(text: 'Orange cat', question_id: q3.id)
ac7 = AnswerChoice.create!(text: 'Tuxedo cat', question_id: q3.id)

Response.destroy_all
r1 = Response.create!(user_id: u1.id, answer_choice_id: ac5.id)
r2 = Response.create!(user_id: u2.id, answer_choice_id: ac1.id)
r3 = Response.create!(user_id: u3.id, answer_choice_id: ac4.id)