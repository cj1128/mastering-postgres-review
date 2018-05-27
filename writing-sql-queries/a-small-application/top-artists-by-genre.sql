select
  genre.name as genre,
  ss.name as track,
  artist.name as artist
from
  genre
  left join lateral
    (
      select track.name,
             track.albumid,
             count(*)
      from
        track
        left join playlisttrack using(trackid)
      where track.genreid = genre.genreid
      group by trackid
      order by count desc, name
      limit :n
    ) ss(name, albumid, count) on true
  join album using(albumid)
  join artist using(artistid)
order by genre, ss.count desc;
