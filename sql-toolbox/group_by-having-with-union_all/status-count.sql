\set season '1978-01-01'

select
  status,
  count(*) as count
from
  results
  join status using(statusid)
  join races using(raceid)
where
  date >= date :'season'
  and date < date :'season' + interval '1 year'
  and position is null
group by status
having count(*) >= 10
order by count desc
;

