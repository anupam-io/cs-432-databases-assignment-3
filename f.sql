-- Find out the top 3 batsmen whose
-- [number of runs scored/number of matches played]
-- is the best in edition 2.

drop table if exists t1;
create table t1 as (
    select match_id, over_id, ball_id, innings_no, striker  from ball_by_ball
)
;
-- select * from t1;


drop table if exists t2;
create table t2 as (
    select striker, B.match_id, runs_scored from batsman_scored as B
    inner join t1
    where B.match_id = t1.match_id
    and B.over_id = t1.over_id
    and B.ball_id = t1.ball_id
    and B.innings_no = t1.innings_no
)
; 
-- select * from t2;


drop table if exists t3;
create table t3 as (
    select striker, sum(runs_scored) as runs from t2
    group by striker, match_id
)
;
-- select * from t3;


drop table if exists t4;
create table t4 as (
    select striker, sum(runs) as total_runs from t3
    group by striker
)
;
-- select * from t4;


drop table if exists t5;
create table t5 as (
    select player_id, count(match_id) 
    as total_matches from player_match
    group by player_id
)
;
-- select * from t5;


select t4.total_runs/t5.total_matches as avg from t4
inner join t5
where t4.striker = t5.player_id
order by avg desc
limit 3
;