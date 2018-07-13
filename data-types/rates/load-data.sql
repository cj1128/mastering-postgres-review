begin;

create schema if not exists raw;

-- Must be run as a Super User
create extension if not exists btree_gist;

drop table if exists raw.rates, rates;

create table raw.rates(
  currency text,
  date date,
  rate numeric
);

\copy raw.rates from 'processed.csv' with csv null 'NA'

create table rates(
  currency text,
  validity daterange,
  rate numeric,

  exclude using gist (currency with =, validity with &&)
);

insert into rates(currency, validity, rate)
  select
    currency,
    daterange(
      date,
      lead(date) over (partition by currency order by date),
      '[)'
    ),
    rate
  from raw.rates
  order by date
;

commit;
