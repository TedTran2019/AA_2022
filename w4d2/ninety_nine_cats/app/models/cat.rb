# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'action_view'
class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  COLORS = %w[black white orange].freeze

  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: %w[M F] }

  has_many :cat_rental_requests,
  dependent: :destroy

  def age
    time_ago_in_words(birth_date)
  end
end
