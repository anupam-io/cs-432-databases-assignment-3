-- Find the bowler(s) who has the 
-- best average(no. of runs given/wickets taken) in edition 5.
-- IPL 2012

create view t as (
    select B.match_id, B.over_id, B.ball_id, B.innings_no, B.bowler from ball_by_ball as B
    inner join matches as M
    where M.match_id = B.match_id
    and year(M.match_date) = 2012
)
;
-- select * from t;

create view t1 as (
    select bowler, count(bowler) as total_wickets from t
    inner join wicket_taken as W
    where t.match_id = W.match_id
    and t.over_id = W.over_id
    and t.ball_id = W.ball_id
    and t.innings_no = W.innings_no
    group by bowler
)
;
-- -- select * from t1;

create view t2 as (
    select t1.bowler, sum(t2.runs_scored) all_runs from t as t1 
    inner join batsman_scored as t2
    where t1.match_id = t2.match_id
    and t1.over_id = t2.over_id
    and t1.ball_id = t2.ball_id
    and t1.innings_no = t2.innings_no
    group by t1.bowler
);
-- select * from t2;


select player.player_id, player.player_name, t3.avg from (
    select t1.bowler, all_runs/total_wickets as avg from t1
    inner join t2
    where t1.bowler = t2.bowler
    order by avg
    limit 100
)as t3
inner join player
where player.player_id = t3.bowler
;

drop view if exists t,t1,t2,t3,t4,t5,t6;