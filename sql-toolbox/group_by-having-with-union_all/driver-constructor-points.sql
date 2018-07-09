\set season '1978-01-01'

select
  surname,
  constructors.name,
  sum(points) as points
from
  results
  join drivers using(driverid)
  join races using(raceid)
  join constructors using(constructorid)
where
  date >= date :'season'
  and date < date :'season' + interval '1 year'
group by grouping sets((drivers.surname), (constructors.name))
having sum(points) >= 20
order by
  surname is null,
  constructors.name is null,
  points desc
;
