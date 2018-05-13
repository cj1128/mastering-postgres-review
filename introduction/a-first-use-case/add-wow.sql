\set start '2017-02-01'

with computed_data as (
  select
    cast(calendar.date as date) as date,
    to_char(calendar.date, 'Dy') as day,
    shares,
    trades,
    dollars,
    lag(dollars, 1)
      over (
        partition by extract('isodow' from date)
        order by date
      ) as last_week_dollars
  from
    generate_series(
      date :'start' - interval '1 week',
      date :'start' + interval '1 month' - interval '1 day',
      interval '1 day'
    ) as calendar(date)
  left join factbook using(date)
)
  select
    date,
    day,
    coalesce(dollars, 0) as dollars,
    case when dollars is not null
         and last_week_dollars is not null
         and dollars <> 0
         then round(100.0 * (dollars - last_week_dollars) / dollars, 2)
         else null
    end as "WoW %"
  from computed_data
  where date >= :'start'
  order by date;
