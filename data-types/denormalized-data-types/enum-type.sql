create type color_t as enum('blue', 'red', 'grey');

create table cars(
  brand text,
  color color_t
);

insert into cars values
  ('ferari', 'red'),
  ('aston martin', 'blue'),
  ('bentley', 'grey')
;
