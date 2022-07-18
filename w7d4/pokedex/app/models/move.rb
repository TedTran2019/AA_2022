# == Schema Information
#
# Table name: moves
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Move < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
