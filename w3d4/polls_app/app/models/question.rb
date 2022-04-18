# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  text       :text             not null
#  poll_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord

  def results_n_plus_one
    results = {}
    answer_choices.each do |answer_choice|
      results[answer_choice.text] = answer_choice.responses.count
    end
    results
  end

  def results_includes
    results = {}
    answer_choices.includes(:responses).each do |answer_choice| 
      results[answer_choice.text] = answer_choice.responses.length
    end
    results
  end

  # SQL solution since we only want the count
  # Count already doesn't count NULL values. Can just use that instead.
  def results
    results = {}
    data = answer_choices
    .joins('LEFT JOIN responses ON responses.answer_choice_id = answer_choices.id')
    .group('answer_choices.id')
    .select('answer_choices.*, SUM(
        CASE
        WHEN responses.answer_choice_id IS NULL THEN 0
        ELSE 1
        END
    ) AS count')

    data.each { |datum| results[datum['text']] = datum['count']}
    results
  end

  validates :text, presence: true  

  belongs_to :poll

  has_many :answer_choices,
  dependent: :destroy

  has_many :responses,
  through: :answer_choices,
  source: :responses
end
