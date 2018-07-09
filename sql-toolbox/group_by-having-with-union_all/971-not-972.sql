(
  select
    driverid,
    format('%s %s', forename, surname)
  from
    results
    join drivers using(driverid)
  where
    raceid = 971
    and points > 0
)
intersect
(
  select
    driverid,
    format('%s %s', forename, surname)
  from
    results
    join drivers using(driverid)
  where
    raceid = 972
    and points = 0
)
;
