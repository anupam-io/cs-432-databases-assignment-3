-- Using view, create a table say “IndianPlayers”
-- which contains information about the total runs 
-- scored by all the Indian players till now and sort 
-- them alphabetically.

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
    select P.player_id, P.player_name, t4.total_runs from t4
    inner join player as P
    where P.player_id = t4.striker and P.country_name = "India"
    order by P.player_name
);
select * from t5;