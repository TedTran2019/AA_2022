# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  description      :text             not null
#  author_id        :integer          not null
#  commentable_type :string           not null
#  commentable_id   :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Comment < ApplicationRecord
  validates :description, presence: true

  belongs_to :author,
  class_name: :User,
  foreign_key: :author_id

  belongs_to :commentable, polymorphic: true
end
