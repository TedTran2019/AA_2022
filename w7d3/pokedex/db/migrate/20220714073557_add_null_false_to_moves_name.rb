class AddNullFalseToMovesName < ActiveRecord::Migration[7.0]
  def change
    remove_column :moves, :name
  end
end
