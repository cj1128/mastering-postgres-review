\set start '2017-02-01'

select date,
  to_char(shares, '999,999,999,999') as shares,
  to_char(trades, '999,999,999') as trades,
  to_char(dollars, '$999,999,999,999') as dollars
from  factbook
where date >= date :'start'
  and date < date :'start' + interval '1 month'
order by date;
