select
  a::text as left,
  b::text as right,
  (a = b)::text as "=",
  (a <> b)::text as "<>",
  (a is distinct from b)::text as "is distinct",
  (a is not distinct from b)::text as "is not distinct"
from
  (values (true), (false), (null)) as v1(a)
  cross join
  (values (true), (false), (null)) as v2(b)
;
