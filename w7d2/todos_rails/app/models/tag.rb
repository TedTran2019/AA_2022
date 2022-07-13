# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :taggings,
  inverse_of: :tag,
  dependent: :destroy

  has_many :todos,
  through: :taggings,
  source: :todo
end
