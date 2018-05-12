<div align="center">
  <h1>
    <a href="https://masteringpostgresql.com/">
      Mastering PostgreSQL 
    </a>
    Review
</h1>

  <img src="http://ww1.sinaimg.cn/large/9b85365dgy1fr8tj2cl4qj20cc0e4dqw">
</div>

## Introduction

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
