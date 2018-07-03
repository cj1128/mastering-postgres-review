select
  lap, code, position,
  milliseconds * interval '1 ms' as milliseconds
from
  laptimes
  join drivers using(driverid)
where
  raceid = 972
  and (lap, position) > (1, 3)
order by lap, position
limit 3;