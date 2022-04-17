class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.integer :prereq_id
      t.integer :instructor_id, null: false

      t.timestamps
    end

    add_index :courses, :prereq_id
    add_index :courses, :instructor_id
  end
end
