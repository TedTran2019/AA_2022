class CreateArtworks < ActiveRecord::Migration[7.0]
  def change
    create_table :artworks do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.integer :artist_id, null: false
      t.timestamps
    end

    add_index :artworks, :artist_id
    add_index :artworks, [:artist_id, :title], unique: true
  end
end
