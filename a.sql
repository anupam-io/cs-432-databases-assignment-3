-- For all the matches_id, 
-- find the minimum runs scored in any over and 
-- the bowler who bowled that over.
-- Sort by increasing over_ids if ties occur.

create view t as (
    select sum(runs_scored) as runs, match_id, over_id, innings_no from batsman_scored
    group by match_id, over_id, innings_no
    order by runs asc
)
;

select distinct(bowler), B.over_id from ball_by_ball as B
inner join (
    select match_id, over_id, innings_no from t
    where t.runs = (select min(runs) from t)
)as t2
where t2.match_id = B.match_id 
and t2.over_id = B.over_id 
and t2.innings_no = B.innings_no
order by B.over_id asc
;

drop view if exists t;