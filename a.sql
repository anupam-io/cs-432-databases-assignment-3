-- For all the matches_id, 
-- find the minimum runs scored in any over and 
-- the bowler who bowled that over.
-- Sort by increasing over_ids if ties occur.

create view t as (
    select match_id, over_id, innings_no, sum(runs) as runs from (
        (
            select match_id, over_id, innings_no, sum(runs_scored) as runs from batsman_scored
            group by match_id, over_id, innings_no
            order by runs asc
        )
        union
        (
            select match_id, over_id, innings_no, 
            sum(extra_runs) as runs from extra_runs
            group by match_id, over_id, innings_no
        )
    )as t
    group by match_id, over_id, innings_no 
)
;

select P.player_name, t1.over_id from (
    select distinct(bowler), B.over_id from ball_by_ball as B
    inner join (
        select match_id, over_id, innings_no from t
        where t.runs = (select min(runs) from t)
    )as t2
    where t2.match_id = B.match_id 
    and t2.over_id = B.over_id 
    and t2.innings_no = B.innings_no
    order by B.over_id asc
)as t1
inner join player as P
where t1.bowler = P.player_id
order by t1.over_id asc
INTO OUTFILE '/var/lib/mysql-files/1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

drop view if exists t;