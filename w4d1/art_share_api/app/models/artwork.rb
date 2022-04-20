# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord
  validates :title, :image_url, presence: true
  validates :artist_id, uniqueness: { scope: :title, 
    message: "Can't have 2 artworks with same title!" }

  belongs_to :artist,
  class_name: :User

  has_many :artwork_shares

  has_many :comments,
  dependent: :destroy

  has_many :shared_viewers,
  through: :artwork_shares,
  source: :viewer
end
