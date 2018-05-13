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

should activate virtual env first. if `direnv` has been installed, virtual env will be automaticaly activated when enters the root directory.

```bash
$ source venv/bin/activate
```

## Quotes

> If you want to use stored procedures, please always write them in SQL, and only switch to PLpgSQL when necessary. If you want to be efficient, the default should be SQL. -- page 42

## 1. Introduction

### A First Use Case

- `load-data.sql`: load tsv data to postgres

  use `\copy` command.

- `select-february.sql`: select records of specific date range, e.g. february 2017

  use `date` and `interval` function to manipulate date.

  use `to_char` function to format numbers.

- `select-full-february.sql`: show records of every day of february 2017, if not present, use zero

  use `generate_series` to generate a date range.

- `add-wow.sql`: add a column *wow* to show dollars difference between current day and previous week

  use `lag` window function.

## 2. Writing SQL Queries

## Business Logic

- `artist-album-duration.sql`: display the list of albums from a given artist, each with its total duration

  use `interval` data type, remember to set `intervalstyle` to `postgres_verbose`.

- `artist-album-duration.py`: use python to do the same thing as above.

- `sp_get-all-albums.sql`: stored procedure to do the same thing as above.

- `four-albums.sql`: display albums and durations from artists who only have 4 albums

  use `lateral` sub queries and stored procedure.
