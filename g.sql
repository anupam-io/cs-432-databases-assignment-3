-- Find out the batting average of all players.
-- Then only show the list of the top 3 countries with 
-- the highest country batting 
-- average( ∑ battingaverage / Totalnumber of players in that country)

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


drop table if exists t6;
create table t6 as (
    select striker, t4.total_runs/t5.total_matches as avg from t4
    inner join t5
    where t4.striker = t5.player_id
)
;
-- select * from t6;


-- select  from t6
-- inner join player
-- where player.player_id = t6.striker


select country_name, avg(avg) as avg from 
t6 inner join player
where t6.striker = player.player_id
group by country_name
;