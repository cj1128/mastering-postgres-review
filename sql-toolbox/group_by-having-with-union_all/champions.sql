with driver_points as
(
  select
    year,
    driverid,
    rank() over (partition by year order by sum(points) desc) as rank
  from
    results
    join drivers using(driverid)
    join races using(raceid)
  group by year, driverid
),
driver_champions as
(
  select year, driverid
  from driver_points
  where rank = 1
),
constructor_points as
(
  select
    year,
    constructorid,
    rank() over (partition by year order by sum(points) desc) as rank
  from
    results
    join constructors using(constructorid)
    join races using(raceid)
  group by year, constructorid
),
constructor_champions as
(
  select year, constructorid
  from constructor_points
  where rank  = 1
)
  select
    year,
    format('%s %s', forename, surname) as "Driver's Champion",
    constructors.name as "Constructor's Champion"
  from
    driver_champions
    join constructor_champions using(year)
    join drivers using(driverid)
    join constructors using(constructorid)
  order by year
;
