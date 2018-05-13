\set artist_name 'Red Hot Chili Peppers'

select
   album.title as album,
   interval '1 ms' * sum(track.milliseconds) as duration
from
  album
  join artist using(artistid)
  -- use left join to show all albums even if it has no tracks
  left join track using(albumid)

where artist.name  = :'artist_name'

group by album
order by album;
