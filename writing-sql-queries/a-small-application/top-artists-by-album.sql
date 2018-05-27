select
  artist.name as artist,
  count(*) as count
from
  artist
  left join album using(artistid)
group by artist
order by count desc
limit :n;
