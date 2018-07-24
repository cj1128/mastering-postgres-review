begin;

drop table if exists magic.sets, magic.cards;

create table magic.sets as
  select
    key as name,
    value - 'cards' as data
  from
    magic.allsets, jsonb_each(data)
;

create table magic.cards as
  select
    key as set,
    jsonb_array_elements(value -> 'cards') as data
  from
    magic.allsets, jsonb_each(data)
;

create index on magic.cards using gin(data);

commit;
