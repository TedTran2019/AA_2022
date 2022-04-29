# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
  validates :title, presence: true
  validates :subs, presence: true

  belongs_to :author,
             class_name: :User

  has_many :post_subs,
  dependent: :destroy,
  inverse_of: :post

  has_many :subs,
  through: :post_subs,
  source: :sub

  has_many :comments,
  dependent: :destroy

  def top_level_comments
    comments.where(parent_comment_id: nil)
  end

  def comments_by_parent_id
    comment_dict = Hash.new { |h, k| h[k] = []}
    comments.each do |comment|
      comment_dict[comment.parent_comment_id] << comment
    end
    comment_dict
  end
end
