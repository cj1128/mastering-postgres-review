begin;

create schema if not exists magic;

create table if not exists magic.allsets(data jsonb);

commit;
