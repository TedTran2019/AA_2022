# == Schema Information
#
# Table name: benches
#
#  id          :bigint           not null, primary key
#  description :string           not null
#  lat         :float            not null
#  lng         :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  seating     :integer          not null
#  rating      :integer          not null
#  comment     :text
#
class Bench < ApplicationRecord
  validates :description, :lat, :lng, :seating, :rating, presence: true
  validates :rating, inclusion: { in: [1, 2, 3, 4, 5] }

  def self.in_bounds(bounds)
    return Bench.all if bounds.nil?
    
    Bench.where("lat < ?", bounds[:northEast][:lat])
    .where("lat > ?", bounds[:southWest][:lat])
    .where("lng > ?", bounds[:southWest][:lng])
    .where("lng < ?", bounds[:northEast][:lng])
  end
end
