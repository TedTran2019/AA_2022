class RemoveIndexFromShortenedUrl < ActiveRecord::Migration[7.0]
  def change
    remove_index :shortened_urls, column: [:short_url, :long_url]
  end
end
