# == Schema Information
#
# Table name: steps
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  body       :string           not null
#  done       :boolean          default(FALSE)
#  todo_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Step < ApplicationRecord
  validates :title, :body, presence: true
  validates :done, inclusion: { in: [true, false] }

  belongs_to :todo,
  class_name: :Todo,
  foreign_key: :todo_id
end
