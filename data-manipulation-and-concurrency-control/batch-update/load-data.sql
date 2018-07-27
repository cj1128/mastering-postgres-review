begin;

create schema if not exists moma;

drop table if exists moma.artist;

create table moma.artist(
  constituentid bigint primary key,
  name text,
  bio text,
  nationality text,
  gender text,
  begin_date int,
  end_date int,
  wiki_qid text,
  ulan text
);

\copy moma.artist from 'artists.2017-05-01.csv' with csv header

commit;
