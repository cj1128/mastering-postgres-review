-- we need to create index first
-- create index on sandbox.article(pubdate);
-- create index on sandbox.comment(article_id);
-- create index on sandbox.comment(pubdate);
select
  category.name as category,
  article.title,
  article.pubdate,
  jsonb_pretty(article.comments) as comments
from
  sandbox.category
  left join lateral (
    select
      article.title,
      article.pubdate,
      jsonb_agg(comment) as comments
    from
      sandbox.article
      join lateral (
        select
          id,
          content,
          pubdate
        from
          sandbox.comment
        where comment.article_id = article.id
        order by pubdate desc
        limit 3
      ) as comment
      on true -- required by lateral join
    where article.category_id = category.id
    group by article.id
    order by pubdate desc
    limit 3
  ) as article
  on true -- required by lateral join
order by
  category,
  pubdate desc
;
