select
  code, surname, position, laps, status
from
  results
  join drivers using(driverid)
  join status using(statusid)
where raceid=972
order by
  position,
  laps desc,
  case
    when status = 'Power Unit' then 0
    else 1
  end
;