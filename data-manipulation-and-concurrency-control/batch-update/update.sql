begin;

create temp table tmp(
  like moma.artist
  including all
) on commit drop;

\copy tmp from 'artists.2017-06-01.csv' with csv header

with upd as
(
  update moma.artist
    set
      (name, bio, nationality, gender, begin_date, end_date, wiki_qid, ulan)
      =
      (tmp.name, tmp.bio, tmp.nationality, tmp.gender,
       tmp.begin_date, tmp.end_date, tmp.wiki_qid, tmp.ulan)
    from tmp
    where
      tmp.constituentid = artist.constituentid
      and
        (artist.name, artist.bio, artist.nationality,
           artist.gender, artist.begin_date, artist.end_date,
           artist.wiki_qid, artist.ulan)
        is distinct from
          (tmp.name, tmp.bio, tmp.nationality,
           tmp.gender, tmp.begin_date, tmp.end_date,
           tmp.wiki_qid, tmp.ulan)
  returning artist.constituentid
),
ins as
(
  insert into moma.artist
    select
      constituentid, name, bio, nationality, gender, begin_date, end_date,
      wiki_qid, ulan
    from
      tmp
    where
      not exists (
        select 1
        from moma.artist
        where tmp.constituentid = artist.constituentid
      )
  returning artist.constituentid
)
  (
    select
      'update' as type,
      (select count(*) from upd) as count,
      constituentid
    from upd
  )
  union
  (
    select
      'insert' as type,
      (select count(*) from ins) as count,
      constituentid
    from ins
  )
  order by type
;

commit;
