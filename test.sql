drop database if exists db;
create database db;
use db;

drop table if exists a,b;

create table a(attr1 varchar(50), score int(10));
insert into a (attr1, score)values
("info1", 1), ("info2", 2);

create table b(attr1 varchar(50));
insert into b (attr1)values
("info1"), ("info2"), ("info3"), ("info4");

-- start
select b.attr1, CASE WHEN a.score IS NULL THEN 0 ELSE a.score END as score
from a right join b
on a.attr1 = b.attr1
;
-- end