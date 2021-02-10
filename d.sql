-- Find the bowler(s) who has the 
-- best average(no. of runs given/wickets taken) in edition 5.
-- IPL 2012

create view t1 as (
    select match_id, over_id, ball_id, innings_no, bowler from ball_by_ball
)
;
-- select * from t1;    

create view t2 as (
    select t1.bowler, t1.match_id, t1.over_id, t2.runs_scored  from t1
    inner join batsman_scored as t2
    where t1.match_id = t2.match_id
    and t1.over_id = t2.over_id
    and t1.ball_id = t2.ball_id
    and t1.innings_no = t2.innings_no
);
-- select * from t2;

create view t3 as (
    select bowler, match_id, over_id, sum(runs_scored) as runs from t2
    group by bowler, match_id, over_id
)
;
-- select * from t3;

create view t4 as(
    select bowler,  avg(runs) as avg from t3
    group by bowler
    order by avg asc
);
-- select * from t4;


select bowler, t4.avg from t4
inner join (
    select min(avg) as avg from t4
)as t5
where t4.avg = t5.avg
;

drop view if exists t1,t2,t3,t4,t5,t6;