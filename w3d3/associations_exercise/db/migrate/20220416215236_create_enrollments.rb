class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.integer :course_id, null: false
      t.integer :student_id, null: false
      t.timestamps
    end

    add_index :enrollments, :course_id
    add_index :enrollments, :student_id
  end
end
