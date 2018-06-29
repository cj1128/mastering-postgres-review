select datname as name,
       pg_database_size(datname) as bytes
from pg_database
order by bytes desc;