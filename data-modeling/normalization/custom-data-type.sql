begin;

-- 中国手机号
-- 13[0-9], 14[5,7, 9], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0-9], 18[0-9]
create domain cn_phone_number as text
  check
  (
    value ~ '^1(3[0-9]|4[579]|5[0-35-9]|7[0-9]|8[0-9])\d{8}$'
  )
;

create table test_phone_number(
  id serial primary key,
  number cn_phone_number not null
);

insert into test_phone_number(number)
  values
    ('13911074274'),
    ('17700630128')
;

select * from test_phone_number;

rollback;
