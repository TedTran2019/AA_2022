# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

ActiveRecord::Base.transaction do
  User.destroy_all
  user1 = User.create!(name: 'CJ')
  user2 = User.create!(name: 'Flarnie')
  user3 = User.create!(name: 'Jeff')
  user4 = User.create!(name: 'Georges St. Pierre')
  user5 = User.create!(name: 'Ned')

  Course.destroy_all
  course1 = Course.create!(name: 'Ruby 101', instructor_id: user5.id)
  course2 = Course.create!(name: 'Ruby 102', instructor_id: user5.id, prereq_id: course1.id)

  Enrollment.destroy_all
  Enrollment.create!(student_id: user3.id, course_id: course1.id)
  Enrollment.create!(student_id: user4.id, course_id: course1.id)
  Enrollment.create!(student_id: user1.id, course_id: course2.id)
  Enrollment.create!(student_id: user2.id, course_id: course2.id)
end
