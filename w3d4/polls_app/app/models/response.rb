# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Response < ApplicationRecord
  validate :can_only_answer_once, :cannot_reply_to_own_poll

  def can_only_answer_once
    if respondent_already_answered?
      errors.add(:response, 'You can only answer a question once.')
    end
  end

  def cannot_reply_to_own_poll
    if own_poll?
      errors.add(:response, 'You cannot reply to your own poll!')
    end
  end

  def sibling_responses
    question.responses.where.not(id: id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: user_id)
  end

  def own_poll?
    author.id == user_id
  end

  belongs_to :answer_choice

  belongs_to :respondent, 
  class_name: :User,
  foreign_key: :user_id

  has_one :question,
  through: :answer_choice,
  source: :question

  has_one :poll,
  through: :question, 
  source: :poll

  has_one :author, 
  through: :poll,
  source: :author
end
