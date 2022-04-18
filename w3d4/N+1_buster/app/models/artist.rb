class Artist < ApplicationRecord
  has_many :albums,
    class_name: 'Album',
    foreign_key: :artist_id,
    primary_key: :id

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  def better_tracks_query
    data = Album.find_by_sql ["
    SELECT
      albums.title, COUNT(*) AS count
    FROM
      artists
    JOIN
      albums ON artists.id = albums.artist_id
    JOIN
      tracks ON albums.id = tracks.album_id
    WHERE
      artists.id = ?
    GROUP BY
      albums.title
    ORDER BY
      COUNT(*) DESC
    ", id]
    info = {}
    data.each { |datum| info[datum['title']] = datum['count'] }
    info
  end
end
