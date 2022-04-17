# == Schema Information
#
# Table name: courses
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  prereq_id     :integer
#  instructor_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Course < ApplicationRecord
  validates :name, presence: true

  has_many(
    :enrollments
  )

  has_many :enrolled_students,
  through: :enrollments,
  source: :user

  belongs_to(
    :prerequisite,
    class_name: :Course,
    foreign_key: :prereq_id
  )

  belongs_to(
    :instructor, 
    class_name: :User,
    foreign_key: :instructor_id
  )
end
