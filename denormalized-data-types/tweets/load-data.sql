begin;

create schema if not exists raw;

create table raw.tweets(
  id bigint primary key,
  date date,
  hour time,
  uname text,
  nickname text,
  bio text,
  message text,
  favs bigint,
  rts bigint,
  latitude double precision,
  longitude double precision,
  country text,
  place text,
  picture text,
  followers bigint,
  following bigint,
  listed bigint,
  lang text,
  url text
);

\copy raw.tweets from 'tweets.csv' with csv

create table tweets(
  id bigint primary key,
  date timestamptz,
  uname text,
  message text,
  location point,
  tags text[]
);

with match as
(
  select
    id,
    regexp_matches(message, '(#[^ ,]+)', 'g') as match
  from raw.tweets
),
tags as (
  select
    id,
    -- downcase and remove duplications
    array_agg(distinct lower(match[1]) order by lower(match[1])) as tags
  from match
  group by id
)
insert into tweets
  select
    id,
    date + hour as date,
    uname,
    message,
    point(longitude, latitude) as location,
    tags
  from
    tags
    join raw.tweets using(id)
;

create index on tweets using gin(tags);

commit;
