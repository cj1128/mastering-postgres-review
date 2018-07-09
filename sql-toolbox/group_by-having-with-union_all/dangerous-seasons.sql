select
  year as season,
  count(*) as accidents
from
  results
  join races using(raceid)
  join status using(statusid)
where statusid = 3
group by year
order by accidents desc
limit 5
;