select
  driverid,
  forename,
  surname,
  races
from
  (
    select
      driverid,
      forename,
      surname,
      count(*) as races,
      bool_and(position is null) as never_finished
    from
      drivers
      left join results using(driverid)
    group by driverid
  ) as ss
where never_finished
order by races desc
;