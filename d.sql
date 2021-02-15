-- Find the bowler(s) who has the 
-- best average(no. of runs given/wickets taken) in edition 5.
-- IPL 2012

create view my_matches as (
    select match_id from matches
    where year(match_date) = 2012
)
;

create view my_balls as (
    select B.match_id, B.over_id, B.ball_id, B.innings_no, B.bowler from ball_by_ball as B
    inner join my_matches as M
    where B.match_id = M.match_id
)
;

select P.player_name, t.average from (
    select W.bowler, R.runs/W.wickets as average from (
    select M.bowler, count(W.kind_out) as wickets from wicket_taken as W
    inner join my_balls as M
    where W.match_id = M.match_id
    and W.over_id = M.over_id
    and W.ball_id = M.ball_id 
    and W.innings_no = M.innings_no
    and W.kind_out != "run out" 
    group by M.bowler
    )as W inner join (
        select bowler, sum(runs_scored) as runs from (
        select B.bowler, R.runs_scored  from (
            (select B.* from batsman_scored as B
            inner join my_matches as M 
            where B.match_id = M.match_id)
            union
            (select E.match_id, E.over_id, E.ball_id, E.innings_no, E.extra_runs as runs
            from extra_runs as E
            inner join my_matches as M
            where E.match_id = M.match_id)
        )as R
        inner join my_balls as B
        where R.match_id = B.match_id
        and R.over_id = B.over_id
        and R.ball_id = B.ball_id
        and R.innings_no = B.innings_no
    )as t
    group by bowler
    ) as R
    where W.bowler = R.bowler
    order by average asc
    limit 3
)as t
inner join player as P
where t.bowler = P.player_id
;

drop view if exists my_matches, my_balls;