drop database if exists db;
create database db;
use db;

create table a(attr1 varchar(50), score int(10));
insert into a (attr1, score)values
("info1", 1), 
("info2", 2);

create table b(attr1 varchar(50));
insert into b (attr1)values("info1"), ("info2"), ("info3");

-- start
select * from a inner join b
where a.attr1 = b.attr1
;
-- end

drop table a,b;