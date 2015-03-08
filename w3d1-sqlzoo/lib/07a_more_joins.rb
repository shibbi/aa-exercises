# == Schema Information
#
# Table name: albums
#
#  asin        :string       not null, primary key
#  title       :string
#  artist      :string
#  price       :float
#  rdate       :date
#  label       :string
#  rank        :integer
#
# Table name: styles
#
# album        :string       not null
# style        :string       not null
#
# Table name: tracks
# album        :string       not null
# disk         :integer      not null
# posn         :integer      not null
# song         :string

require_relative './sqlzoo.rb'

def alison_artist
  # Select the name of the artist who recorded the song 'Alison'.
  execute(<<-SQL)
    SELECT
      albums.artist
    FROM
      albums
    JOIN
      tracks ON tracks.album = albums.asin
    WHERE
      tracks.song = 'Alison'
  SQL
end

def exodus_artist
  # Select the name of the artist who recorded the song 'Exodus'.
  execute(<<-SQL)
    SELECT
      albums.artist
    FROM
      albums
    JOIN
      tracks ON tracks.album = albums.asin
    WHERE
      tracks.song = 'Exodus'
  SQL
end

def blur_songs
  # Select the `song` for each `track` on the album `Blur`.
  execute(<<-SQL)
    SELECT
      tracks.song
    FROM
      albums
    JOIN
      tracks ON tracks.album = albums.asin
    WHERE
      albums.title = 'Blur'
  SQL
end

def heart_tracks
  # For each album show the title and the total number of tracks containing
  # the word 'Heart' (albums with no such tracks need not be shown). Order by
  # the number of such tracks.
  execute(<<-SQL)
    SELECT
      albums.title, COUNT(tracks.song)
    FROM
      albums
    JOIN
      tracks ON tracks.album = albums.asin
    WHERE
      tracks.song ~ '.*Heart.*'
    GROUP BY
      albums.title
    ORDER BY
      COUNT(tracks.song) DESC
  SQL
end

def title_tracks
  # A 'title track' has a `song` that is the same as its album's `title`. Select
  # the names of all the title tracks.
  execute(<<-SQL)
    SELECT DISTINCT
      tracks.song
    FROM
      albums
    JOIN
      tracks ON tracks.song = albums.title
  SQL
end

def eponymous_albums
  # An 'eponymous album' has a `title` that is the same as its recording
  # artist's name. Select the titles of all the eponymous albums.
  execute(<<-SQL)
    SELECT
      albums.title
    FROM
      albums
    WHERE
      albums.title = albums.artist
  SQL
end

def song_title_counts
  # Select the song names that appear on more than two albums. Also select the
  # COUNT of times they show up.
  execute(<<-SQL)
    SELECT
      tracks.song, COUNT(*)
    FROM
      albums
    JOIN
      tracks ON tracks.album = albums.asin
    GROUP BY
      tracks.song
    HAVING
      COUNT(*) > 2
  SQL
end

def best_value
  # A "good value" album is one where the price per track is less than 50
  # pence. Find the good value albums - show the title, the price and the number
  # of tracks.
  execute(<<-SQL)
    SELECT
      albums.title, albums.price, COUNT(*)
    FROM
      albums
    JOIN
      tracks ON tracks.album = albums.asin
    GROUP BY
      albums.title, albums.price
    HAVING
      albums.price / COUNT(*) < 0.50
  SQL
end

def top_track_counts
  # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
  # tracks. List the top 10 albums in order of track count. Select both the
  # album title and the track count.
  execute(<<-SQL)
    SELECT
      albums.title, COUNT(*)
    FROM
      albums
    JOIN
      tracks ON tracks.album = albums.asin
    GROUP BY
      albums.title
    ORDER BY
      COUNT(*) DESC
    LIMIT
      10
  SQL
end

def soundtrack_wars
  # Select the artist who has recorded the most soundtracks, as well as the
  # number of albums. HINT: use LIKE '%Soundtrack%' in your query.
  execute(<<-SQL)
    SELECT
      albums.artist, COUNT(*)
    FROM
      albums
    JOIN
      styles ON styles.album = albums.asin
    WHERE
      styles.style LIKE '%Soundtrack%'
    GROUP BY
      albums.artist
    ORDER BY
      COUNT(*) DESC
    LIMIT
      1
  SQL
end

def expensive_tastes
  # Select the five styles of music with the highest average price per track,
  # along with the price per track. One or more of each aggregate functions,
  # subqueries, and joins will be required.
  execute(<<-SQL)
    SELECT
      styles.style, (SUM(albums.price) / all_tracks.count) AS price
    FROM
      styles
    JOIN
      albums ON albums.asin = styles.album
    JOIN (
      SELECT
        albums.asin AS asin, COUNT(*) AS count
      FROM
        tracks
      JOIN
        albums ON albums.asin = tracks.album
      GROUP BY
        asin
    ) AS all_tracks ON all_tracks.asin = albums.asin
    GROUP BY
      styles.style, all_tracks.count
    ORDER BY
      price DESC
    LIMIT
      5
  SQL
end
