# == Schema Information
#
# Table name: goals
#
#  id         :bigint           not null, primary key
#  private    :boolean          default(FALSE), not null
#  user_id    :integer          not null
#  completed  :boolean          default(FALSE), not null
#  title      :string           not null
#  details    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Goal < ApplicationRecord
  include Commentable
  
  validates :title, presence: true
  validates :private, :completed, inclusion: { in: [true, false] }

  belongs_to :user

  # has_many :comments, as: :commentable,
  #   class_name: :Comment,
  #   foreign_key: :commentable_id,
  #   foreign_type: :commentable_type,
  #   dependent: :destroy
end
