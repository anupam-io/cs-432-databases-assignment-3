-- List the stadium(s)  
-- where the maximum number of “legbyes” is taken.

drop table if exists t1;
create table t1 as (
    select match_id from extra_runs
    where extra_type = "legbyes"
);

drop table if exists t2;
create table t2 as (
    select M.venue from matches as M
    inner join t1
    where t1.match_id = M.match_id
)
;

drop table if exists t3;
create table t3 as(
    select distinct(venue), count(venue) as cnt from t2
    group by venue
)
;

select venue from t3
inner join (
    select max(cnt) as cnt from t3
) as t4
where t3.cnt = t4.cnt
;