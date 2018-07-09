with accidents as
(
  select
    year as season,
    count(*) as total,
    count(*) filter(where statusid = 3) as accidents
  from
    results
    join races using(raceid)
    join status using(statusid)
  group by year
)
  select
    season,
    round(100.0 * accidents / total, 2) as pct,
    repeat('■', ceil(100.0*accidents/total)::int) as bar
  from accidents
  where season between 1974 and 1990
  order by season
;