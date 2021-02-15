-- List all captains who scored 
-- more than 50 runs in edition 3.

select P.player_name, B.all_runs as runs from (
    select B.player_id, sum(B.total_runs) as all_runs from (
        select bat_run.player_id, total_runs from bat_run
        inner join matches as M
        where M.match_id = bat_run.match_id
        and year(M.match_date) = 2010
    )as B
    inner join (
        select player_id from player_match
        where role = "Captain"
        group by player_id
    )as t
    where B.player_id = t.player_id
    group by B.player_id
) as B
inner join player as P
where B.all_runs > 50
and B.player_id = P.player_id
order by P.player_name asc
INTO OUTFILE '/var/lib/mysql-files/10.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;