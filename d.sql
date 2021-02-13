-- Find the bowler(s) who has the 
-- best average(no. of runs given/wickets taken) in edition 5.
-- IPL 2012

create view t as(
    select bowler,  avg(runs) as avg from (
        select t3.bowler, t3.match_id, t3.over_id, t3.runs from (
            select bowler, match_id, over_id, sum(runs_scored) as runs from (
                select t1.bowler, t1.match_id, t1.over_id, t2.runs_scored from (
                    select match_id, over_id, ball_id, innings_no, bowler from ball_by_ball
                ) as t1
                inner join batsman_scored as t2
                where t1.match_id = t2.match_id
                and t1.over_id = t2.over_id
                and t1.ball_id = t2.ball_id
                and t1.innings_no = t2.innings_no
            ) as t2
            group by bowler, match_id, over_id
        )as t3
        inner join matches
        where t3.match_id = matches.match_id and year(matches.match_date) = 2012
    ) as A
    group by bowler
    order by avg asc
);
-- select * from t4;

select bowler, t.avg from t
inner join (
    select min(avg) as avg from t
)as t5
where t.avg = t5.avg
;

drop view if exists t;