select name, location, country
from circuits
order by position <-> point(2.349014, 48.864716)
limit 10;