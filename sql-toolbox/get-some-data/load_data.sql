begin;

drop table if exists circuits;

create table circuits(
  circuitid serial primary key,
  circuitref text not null,
  name text not null,
  location text,
  country text,
  lat double precision,
  lng double precision,
  alt int,
  url text not null unique,
  -- populated using `lat` and `lng`
  position point
);

create index on circuits using gist(position);

\copy circuits(circuitid, circuitref, name, location, country, lat, lng, alt, url) from 'f1db/csv/circuits.csv' with (format csv, null '\N')

update circuits
  set position = point(lng, lat);

drop table if exists constructorresults;

create table constructorresults(
  constructorresultid serial primary key,
  raceid int not null,
  constructorid int not null,
  points double precision,
  status text
);

\copy constructorresults from 'f1db/csv/constructor_results.csv' with (format csv, null '\N')

drop table if exists constructorstandings;

create table constructorstandings(
  constructorstandingsid serial primary key,
  raceid int not null,
  constructorid int not null,
  points double precision not null,
  position int,
  positiontext text,
  wins int not null
);

\copy constructorstandings from 'f1db/csv/constructor_standings.csv' with (format csv, null '\N')

drop table if exists constructors;

create table constructors(
  constructorid serial primary key,
  constructorref text not null,
  name text not null,
  nationality text,
  url text not null
);

\copy constructors from 'f1db/csv/constructors.csv' with (format csv, null '\N')

drop table if exists driverstandings;

create table driverstandings(
  driverstandingsid serial primary key,
  raceid int not null,
  driverid int not null,
  points double precision not null,
  position int,
  positiontext text,
  wins int
);

\copy driverstandings from 'f1db/csv/driver_standings.csv' with (format csv, null '\N')

drop table if exists drivers;

create table drivers(
  driverid serial primary key,
  driverref text not null,
  number int,
  code text,
  forename text not null,
  surname text not null,
  dob date,
  nationality text,
  url text not null unique
);

\copy drivers from 'f1db/csv/driver.csv' with (format csv, null '\N')

drop table if exists laptimes;

create table laptimes(
  raceid int not null,
  driverid int not null,
  lap int not null,
  position int,
  time text,
  milliseconds int,
  primary key (raceid, driverid, lap)
);

\copy laptimes from 'f1db/csv/lap_times.csv' with (format csv, null '\N')

drop table if exists pitstops;

create table pitstops(
  raceid int not null,
  driverid int not null,
  stop int not null,
  lap int not null,
  time time not null,
  duration text,
  milliseconds int,
  primary key (raceid, driverid, stop)
);

\copy pitstops from 'f1db/csv/pit_stops.csv' with (format csv, null '\N')

drop table if exists qualifying;

create table qualifying(
  qualifyid serial primary key,
  raceid int not null,
  driverid int not null,
  constructorid int not null,
  number int not null,
  position int,
  q1 text,
  q2 text,
  q3 text
);

\copy qualifying from 'f1db/csv/qualifying.csv' with (format csv, null '\N')

drop table if exists races;

create table races(
  raceid serial primary key,
  year int not null,
  round int not null,
  circuitid int not null,
  name text not null,
  date date not null,
  time time,
  url text unique
);

\copy races from 'f1db/csv/races.csv' with (format csv, null '\N')

drop table if exists results;

create table results(
  resultid serial primary key,
  raceid int not null,
  driverid int not null,
  constructorid int not null,
  number int,
  grid int not null,
  position int,
  positiontext text not null,
  positionorder int not null,
  points double precision not null,
  laps int not null,
  time text,
  milliseconds int,
  fastestlap int,
  rank int,
  fastestlaptime text,
  fastestlapspeed text,
  statusid int not null
);

\copy results from 'f1db/csv/results.csv' with (format csv, null '\N')

drop table if exists seasons;

create table seasons(
  year int primary key,
  url text not null unique
);

\copy seasons from 'f1db/csv/seasons.csv' with (format csv, null '\N')

drop table if exists status;

create table status(
  statusid serial primary key,
  status text not null
);

\copy status from 'f1db/csv/status.csv' with (format csv, null '\N')

commit;
