# == Schema Information
#
# Table name: pokemons
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  attack     :integer          not null
#  defense    :integer          not null
#  poke_type  :string           not null
#  image_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Pokemon < ApplicationRecord
  TYPES = %w[bug dragon electric fighting fire flying ghost grass ground ice normal
             poison psychic rock steel water].freeze

  validates :attack, :defense, :image_url, :name, :poke_type, presence: true
  validates :name, uniqueness: true
  validates :attack, :defense, numericality: true
  validates :poke_type, inclusion: { in: TYPES }

  has_many :items

  has_many :poke_moves

  has_many :moves,
           through: :poke_moves,
           source: :move
end
