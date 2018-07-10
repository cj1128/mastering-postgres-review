<div align="center">
  <h1>
    <a href="https://masteringpostgresql.com/">
      Mastering PostgreSQL 
    </a>
    Review
</h1>

  <img src="http://ww1.sinaimg.cn/large/9b85365dgy1fr8tj2cl4qj20cc0e4dqw">
</div>

## About Python Code

first create virtual env under `~/Documents/python/envs`.

```bash
python3 -m venv ~/Documents/python/envs/mastering-pg
```

then activate virtual env. if `direnv` has been installed, virtual env will be automaticaly activated when enters the root directory.

```bash
$ source ~/Documents/python/envs/mastering-pg/bin/activate
```

## Quotes

> If you want to use stored procedures, please always write them in SQL, and only switch to PLpgSQL when necessary. If you want to be efficient, the default should be SQL. -- page 42

> The SQL writing process is mainly about discovery. In SQL you need to explain your problem, unlike in most programming languages where you need to focus on a solution you think is going to solve your problem. That’s quite different and requires looking at your problem in another way and understanding it well enough to be able to express it in details in a single sentence. -- page 86

> In any case, using the offset clause is very bad for your query performances, so we advise against it. -- page 107

> We can think of null as meaning I don’t know what this is rather than no value here. -- page 127

> Any and all aggregate function you already know can be used against a window frame rather than a grouping clause, so you can already start to use sum, min, max, count, avg, and the other that you’re already used to using. -- page 134

> You need to remember that the windowing clauses are always considered last in the query, meaning after the where clause. -- page 136

## 1. Preface

## 2. Introduction

### A First Use Case

- `load-data.sql`: load tsv data to postgres

  + use `\copy` command.

- `select-february.sql`: select records of specific date range, e.g. february 2017

  + use `date` and `interval` function to manipulate date.
  + use `to_char` function to format numbers.

- `select-full-february.sql`: show records of every day of february 2017, if not present, use zero

  + use `generate_series` to generate a date range.

- `add-wow.sql`: add a column *wow* to show dollars difference between current day and previous week

  + use `lag` window function.

## 3. Writing SQL Queries

### Business Logic

- `artist-album-duration.sql`: display the list of albums from a given artist, each with its total duration

  + use `interval` data type, remember to set `intervalstyle` to `postgres_verbose`.

- `artist-album-duration.py`: use python to do the same thing as above.

- `sp_get-all-albums.sql`: stored procedure to do the same thing as above.

- `four-albums.sql`: display albums and durations from artists who only have 4 albums

  use `lateral` sub queries and stored procedure.

### A Small Application

- `load-data.sql`: use `pgloader` to load sqlite data to pg

- `top-artists-by-album`: list top n artists ordered by album count

- `top-artists-by-genre`: list top n artists by genre

  + use `lateral` join.

### The SQL REPL - An Interactive Setup

- `get-database-size.sql`: user postgres `pg_database` to get name and size of all databases

### SQL is Code

- `tracks-named-after-artists`: find out tracks being named after another artists

## 4. SQL Toolbox

### Get Some Data

- `loda-data.sql`: creat tables and load data to `f1db` database. Data was downloaded from http://ergast.com/mrd/db/.

  ```bash
  $ createdb f1db
  $ psql -d f1db < load_data.sql
  ```

### Select, From, Where

- `date-calc.sql`: use PG to do some date calcs

- `top-drivers.sql`: get top 3 drivers

- `race-and-winner.sql`: list races and their winners of a period of time

- `unlucky-drivers.sql`: list drivers who did not finish the race of some season

### Order By, Limit, No Offset

- `order-by.sql`: show use case of multiple `order by` expressions and using `case` in `order by`

- `knn.sql`: find top 10 nearest circuits to Pairs(2.349014, 48.864716)

- `top-drivers-per-decade.sql`: List top three drivers in terms of race wins for each decade

  + use `date_trunc` to get decade from date.
  + use window function to calc rank

- `page-by-seek.sql`: use seek to page results, never use `offset`

### Group By, Having, With, Union All

- `races-per-decade.sql`: list races count of every decade

- `decade-races-with-diff.sql`: like before, but add a `diff` column

  + use `lng` window function to get previous row value
  + use `format(%3s)` to format numbers to fixed with string

- `never-finished.sql`: find out drivers who never finished a race in their career

  + use `bool_and` aggregate function

- `never-finished-by-season.sql`: find out number of drivers who never finished a race by season

- `status-count.sql`: list status count for unfinished drivers at a specific season

  + use `having` to filter groups

- `driver-constructor-points.sql`: list drivers and constructors points

  + use `grouping sets` to calc based upon multiple groups

- `driver-constructor-rollup.sql`: list drivers and constructors points using `rollup`

- `driver-constructor-cube.sql`: list driver and constructor points using `cube`

- `dangerous-seasons.sql`: list top 5 dangerous seasons in terms of accidents

- `accident-pct.sql`: list accident percentage of every season

- `champions.sql`: list driver's champion and constructor's champion of every season

  + use `with` to construct sub table
  + use `rank` window function to select champion

- `ever-won.sql`: list drivers who ever won the Formula One race

  + use `distinct on`

- `972-points.sql`: list drivers' and constructors' points in race id 972

  + use `union all` to union two query sets

- `971-not-972.sql`: list drivers who didn't get points in race 972 but did get points in race 971

### Understanding Nulls

- `truth-table.sql`: generate a truth table to reveal the `three-valued logic`

