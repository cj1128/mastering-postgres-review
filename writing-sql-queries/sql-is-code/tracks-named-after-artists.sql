select
  track.name as track,
  author.name as author,
  album.title as album,
  artist.name as artist
from artist
  join track on track.name = artist.name
  join album using(albumid)
  join artist author on author.artistid = album.artistid
where author.artistid <> artist.artistid;