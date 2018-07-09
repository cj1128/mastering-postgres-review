with decade_races as
(
  select
    extract('year' from date_trunc('decade', date)) as decade,
    count(*) as races
  from races
  group by decade
  order by decade
)
  select
    decade,
    races,
    case
     when lag(races, 1) over (order by decade) is null
     then ''
     when races >= lag(races, 1) over (order by decade)
     then format('+%3s', races - lag(races, 1) over (order by decade))
     when races < lag(races, 1) over (order by decade)
     then format('-%3s', lag(races, 1) over (order by decade) - races)
    end as diff
  from decade_races
  order by decade
;
