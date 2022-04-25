class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.boolean :private, default: false, null: false
      t.integer :user_id, null: false
      t.boolean :completed, default: false, null: false
      t.string :title, null: false
      t.text :details
      t.timestamps
    end

    add_index :goals, :user_id
  end
end
