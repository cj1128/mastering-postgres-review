\set beginning '2017-04-1'
\set months 3

select
  date,
  name,
  format('%s %s', forename, surname) as winner
from
  races
  left join results
    on results.raceid = races.raceid
    and results.position = 1
  left join drivers using(driverid)
where
  date >= date :'beginning'
  and date <= date :'beginning' + :months * interval '1 month'
order by date;
