select
  oprname,
  oprleft::regtype,
  oprright::regtype,
  oprcode::regproc
from pg_operator
where
  oprname = '='
  and oprleft::regtype::text ~ 'int|time|text|circle|ip'
order by oprleft
;
