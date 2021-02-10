-- For all the matches_id, 
-- find the minimum runs scored in any over and 
-- the bowler who bowled that over.
-- Sort by increasing over_ids if ties occur.


create view t1 as(
    select sum(runs_scored) as runs, match_id, over_id, innings_no from batsman_scored
    group by match_id, over_id, innings_no
    order by sum(runs_scored) asc
)
;

create view t2 as(
    select match_id, over_id, innings_no from t1
    inner join (
        select min(runs) as runs from t1
    )as t2
    where t1.runs = t2.runs
)
;

select distinct(bowler), B.over_id from ball_by_ball as B
inner join t2
where t2.match_id = B.match_id and t2.over_id = B.over_id and t2.innings_no = B.innings_no
order by B.over_id
;

drop view if exists t1,t2,t3,t4,t5,t6;