-- List the stadium(s)  
-- where the maximum number of “legbyes” is taken.

create view t as(
    select distinct(venue), count(venue) as cnt from (
        select M.venue from matches as M
        inner join (
            select match_id from extra_runs
            where extra_type = "legbyes"
        ) as t1
        where t1.match_id = M.match_id
    ) as t2
    group by venue
)
;

select venue from t
inner join (
    select max(cnt) as cnt from t
) as t4
where t.cnt = t4.cnt
;

drop view if exists t;