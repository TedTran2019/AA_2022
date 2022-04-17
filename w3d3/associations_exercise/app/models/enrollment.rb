# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  course_id  :integer          not null
#  student_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Enrollment < ApplicationRecord
  belongs_to(
    :course,
  )
  
  belongs_to(
    :user,
    class_name: :User,
    foreign_key: :student_id
  )
end
