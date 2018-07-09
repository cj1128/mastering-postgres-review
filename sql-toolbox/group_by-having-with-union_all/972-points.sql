(
  select
    raceid,
    'driver' as type,
    format('%s %s', forename, surname) as name,
    points
  from
    driverstandings
    join drivers using(driverid)
  where raceid = 972
  and points > 0
)
union all
(
  select
    raceid,
    'constructor' as type,
    name,
    points
  from
    constructorstandings
    join constructors using(constructorid)
  where raceid = 972
  and points > 0
)
order by points desc
;