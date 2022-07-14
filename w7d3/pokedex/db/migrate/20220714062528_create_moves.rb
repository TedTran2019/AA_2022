class CreateMoves < ActiveRecord::Migration[7.0]
  def change
    create_table :moves do |t|
      t.string :name, nulll: false
      t.timestamps
    end
    add_index :moves, :name, unique: true
  end
end
