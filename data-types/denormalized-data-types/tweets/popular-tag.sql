select
  tag,
  count(*) as count
from
  tweets,
  unnest(tags) as t(tag)
group by tag
order by count desc
limit 10;
