with t as
(
  select
    driverid,
    year,
    bool_and(position is null) as never_finished
  from
    results
    join races using(raceid)
    join drivers using(driverid)
  group by year, driverid
)
  select
    year as season,
    count(*) as count
  from t
  where never_finished
  group by year
  order by count desc
  limit 5
;