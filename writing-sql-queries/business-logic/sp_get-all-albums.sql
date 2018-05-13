create or replace function get_all_albums(
  in artistid bigint,
  out album text,
  out duration interval
)
returns setof record
language sql
as $$
  select
     album.title as album,
     interval '1 ms' * sum(track.milliseconds) as duration
  from
    album
    join artist using(artistid)
    -- use left join to show all albums even if it has no tracks
    left join track using(albumid)

  where artist.artistid  = get_all_albums.artistid

  group by album
  order by album;
$$;
