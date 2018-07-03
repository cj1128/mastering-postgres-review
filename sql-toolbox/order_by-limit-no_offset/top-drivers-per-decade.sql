with decades as
(
  select extract('year' from date_trunc('decade', date)) as decade
  from races
  group by decade
)
  select
    decade,
    rank() over (partition by decade order by wins desc) as rank,
    forename, surname, wins
  from
    decades
    left join lateral (
      select forename, surname, count(*) as wins
      from results
      join drivers using(driverid)
      join races using(raceid)
      where
        extract('year' from date_trunc('decade', races.date)) = decades.decade
        and position = 1
      group by decades.decade, drivers.driverid
      order by wins desc
      limit 3
    ) as winners(forename, surname, wins) on true
  order by
    decade,
    wins desc
;
