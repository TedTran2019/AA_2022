class CreatePokeMoves < ActiveRecord::Migration[7.0]
  def change
    create_table :poke_moves do |t|
      t.integer :pokemon_id, null: false
      t.integer :move_id, null: false
      t.timestamps
    end
    add_index :poke_moves, %i[pokemon_id move_id], unique: true
    add_index :poke_moves, :pokemon_id
    add_index :poke_moves, :move_id
  end
end
