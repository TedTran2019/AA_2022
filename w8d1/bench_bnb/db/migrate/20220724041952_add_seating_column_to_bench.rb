class AddSeatingColumnToBench < ActiveRecord::Migration[7.0]
  def change
    add_column :benches, :seating, :integer, null: false
  end
end
