class AddUniqueToPokemonName < ActiveRecord::Migration[7.0]
  def change
    add_index :pokemons, :name, unique: true
  end
end
