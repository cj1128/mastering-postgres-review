\set start '2017-02-01'

select
  cast(calendar.date as date) as date,
  coalesce(shares, 0) as shares,
  coalesce(trades, 0) as trades,
  coalesce(dollars, 0) as dollars
from
  generate_series(
    date :'start',
    date :'start' + interval '1 month' - interval '1 day',
    interval '1 day'
  ) as calendar(date)
  left join factbook
  on calendar.date = factbook.date
order by date;
