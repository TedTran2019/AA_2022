# == Schema Information
#
# Table name: todos
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  body       :string           not null
#  done       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Todo < ApplicationRecord
  validates :title, :body, presence: true
  validates :done, inclusion: { in: [true, false] }

  belongs_to :user
  
  has_many :steps,
  class_name: 'Step',
  foreign_key: :todo_id,
  dependent: :destroy

  has_many :taggings,
  inverse_of: :todo,
  dependent: :destroy

  has_many :tags,
  through: :taggings,
  source: :tag

  def tag_names=(tag_names)
    self.tags = tag_names.map do |tag_name|
      Tag.find_or_create_by(name: tag_name)
    end
  end
end
