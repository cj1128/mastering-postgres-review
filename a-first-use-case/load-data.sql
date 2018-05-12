begin;

drop table factbook;

create table factbook_raw(
  year int,
  date date,
  shares_raw text,
  shares bigint,

  trades_raw text,
  trades bigint,

  dollars_raw text,
  dollars bigint
);

create table factbook(
  like factbook_raw
  including all
);

\copy factbook(year, date, shares_raw, trades_raw, dollars_raw) from 'factbook.csv' with delimiter E'\t' null ''

update factbook
  set shares = replace(shares_raw, ',', '')::bigint,
      trades = replace(trades_raw, ',', '')::bigint,
      dollars = substring(replace(dollars_raw, ',', '') from 2)::bigint;

commit;
