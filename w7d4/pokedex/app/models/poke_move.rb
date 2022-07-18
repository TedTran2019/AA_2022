# == Schema Information
#
# Table name: poke_moves
#
#  id         :bigint           not null, primary key
#  pokemon_id :integer          not null
#  move_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PokeMove < ApplicationRecord
  belongs_to :pokemon
  belongs_to :move
end
