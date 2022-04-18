# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :authored_polls, 
  class_name: :Poll, 
  foreign_key: :poll_id,
  dependent: :destroy

  has_many :authored_questions, 
  through: :authored_polls,
  source: :questions

  has_many :authored_answer_choices,
  through: :authored_questions,
  source: :answer_choices
end
