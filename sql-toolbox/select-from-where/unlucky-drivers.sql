\set season '1978-01-01'

select
  forename,
  surname,
  constructors.name as constructor,
  count(*) as races,
  count(distinct status) as reaons
from
  drivers
  join results using(driverid)
  join races using(raceid)
  join constructors using(constructorid)
  join status using(statusid)
where
  date >= date :'season'
  and date < date :'season' + interval '1 year'
  and position is null
group by constructors.constructorid, driverid
order by count(*) desc;