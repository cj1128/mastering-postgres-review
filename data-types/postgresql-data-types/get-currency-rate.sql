select
  currency,
  rate
from rates
where
  currency = 'Chinese Yuan'
  and validity @> date '2018-06-18'
;
