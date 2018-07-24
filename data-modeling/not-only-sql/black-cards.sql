select
  jsonb_pretty(data)
from
  magic.cards
where
  data @> '{"colors": ["Black"]}'
;
