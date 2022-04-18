# == Schema Information
#
# Table name: polls
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Poll < ApplicationRecord
  validates :title, presence: true

  belongs_to :author,
  class_name: :User,
  foreign_key: :author_id

  has_many :questions,
  dependent: :destroy

  has_many :answer_choices,
  through: :questions,
  source: :answer_choices
end
