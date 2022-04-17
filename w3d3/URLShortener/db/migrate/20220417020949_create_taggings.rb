class CreateTaggings < ActiveRecord::Migration[7.0]
  def change
    create_table :taggings do |t|
      t.integer :shortened_url_id, null: false
      t.integer :tag_topic_id, null: false
      t.timestamps
    end

    add_index :taggings, %i[shortened_url_id tag_topic_id], unique: true
    add_index :taggings, :tag_topic_id
  end
end
