select
  surname,
  constructors.name,
  sum(points) as points
from
  results
  join drivers using(driverid)
  join constructors using(constructorid)
where
  surname in ('Prost', 'Senna')
group by cube(surname, constructors.name)
order by
  surname,
  constructors.name is null,
  points desc
;
