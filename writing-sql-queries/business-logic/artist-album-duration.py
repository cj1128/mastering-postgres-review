import psycopg2
from psycopg2.extras import DictCursor
import sys
from datetime import timedelta

ARTIST_NAME = "Red Hot Chili Peppers"

PGCONNSTRING = "user=cj dbname=appdev"

pgconn = psycopg2.connect(PGCONNSTRING, cursor_factory=DictCursor)

def exec(sql):
  # print("sql:", sql)
  curs = pgconn.cursor()
  curs.execute(sql)
  return curs.fetchall()

def fetch_artist(name):
  result = exec("select * from artist where name = '%s'" % name)
  return result[0]

def fetch_albums(artist_id):
  return exec("select * from album where artistid = %s order by title" % artist_id)

def fetch_tracks(album_id):
  return exec("select * from track where albumid = %s" % album_id)

def run():
  if len(sys.argv) > 1:
    artist_name = sys.argv[1]
  else:
    artist_name = ARTIST_NAME

  print("artist name:", artist_name)
  artist = fetch_artist(artist_name)

  for album in fetch_albums(artist["artistid"]):
    ms = 0
    for track in fetch_tracks(album["albumid"]):
      ms += track["milliseconds"]
    print("%-25s: %s" % (album["title"], timedelta(milliseconds=ms)))

run()
