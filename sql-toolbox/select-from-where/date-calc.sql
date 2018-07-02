select
  date::date,
  extract('isodow' from date) as dow,
  to_char(date, 'dy') as day,
  extract('isoyear' from date) as iso_year,
  extract('week' from date) as week,
  extract('day' from date + interval '2 months - 1 day') = 29 as leap
from
  generate_series(
    date '2000-01-01',
    date '2010-01-01',
    interval '1 year'
  ) as t(date)
;
