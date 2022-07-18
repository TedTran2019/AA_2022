class AddBackNameToMoves < ActiveRecord::Migration[7.0]
  def change
    add_column :moves, :name, :string, null: false
    add_index :moves, :name, unique: true
  end
end
