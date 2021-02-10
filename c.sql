-- List the stadium(s)  
-- where the maximum number of “legbyes” is taken.

create view t1 as (
    select match_id from extra_runs
    where extra_type = "legbyes"
);

create view t2 as (
    select M.venue from matches as M
    inner join t1
    where t1.match_id = M.match_id
)
;

create view t3 as(
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

drop view if exists t1,t2,t3,t4,t5,t6;