class AddIndexToShortenedUrl < ActiveRecord::Migration[7.0]
  def change
    add_index :shortened_urls, :short_url, unique: true
  end
end
