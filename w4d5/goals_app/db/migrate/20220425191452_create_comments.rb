class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :description, null: false
      t.integer :author_id, null: false
      t.references :commentable, polymorphic: true, null: false
      t.timestamps
    end

    add_index :comments, :author_id
    add_index :comments, %i[commentable_id commentable_type]
  end
end
