# == Schema Information
#
# Table name: artwork_shares
#
#  id         :bigint           not null, primary key
#  artwork_id :integer          not null
#  viewer_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ArtworkShare < ApplicationRecord
  validates :viewer_id, uniqueness: { scope: :artwork_id, 
    message: "Can't share same artwork twice with one user."}

  belongs_to :artwork

  belongs_to :viewer,
  class_name: :User
end
