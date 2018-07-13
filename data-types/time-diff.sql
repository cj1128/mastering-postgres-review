with t as
(
  select
    project,
    percentile_cont(array[0.5, 0.9, 0.95, 0.99]) within group (order by cts-ats) as pers
  from commitlog
  where ats <> cts
  group by project
)
  select
    project,
    pers[1] as median,
    pers[2] as "90%th",
    pers[3] as "95%th",
    pers[4] as "99%th"
  from t
;
