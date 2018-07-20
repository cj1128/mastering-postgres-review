-- category, article, comment
-- goal: get most recent articles per category with the most recent three comments
begin;

create schema if not exists sandbox;

create table sandbox.category(
  id serial primary key,
  name text not null
);

insert into sandbox.category(name) values ('support'), ('news'), ('office'), ('music');

create table sandbox.article(
  id bigserial primary key,
  category_id int references sandbox.category(id),
  pubdate timestamptz,
  title text not null,
  content text not null
);

create table sandbox.comment(
  id bigserial primary key,
  article_id bigint references sandbox.article(id),
  pubdate timestamptz,
  content text not null
);

insert into sandbox.article(category_id, pubdate, title, content)
  select
    random(1, 4) as category_id,
    random(now() - interval '3 months', now() + interval '1 month') as pubdate,
    initcap(lorem(5)) as title,
    lorem(100) as content
  from generate_series(1, 1000) as t(x)
;

insert into sandbox.comment(article_id, pubdate, content)
  select
    random(1, 1000) as article_id,
    random(now() - interval '1 months', now() + interval '1 month') as pubdate,
    lorem(100) as content
  from generate_series(1, 50000) as t(x)
;

commit;
