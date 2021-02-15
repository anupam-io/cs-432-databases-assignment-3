-- Find out the top 3 batsmen whose
-- [number of runs scored/number of matches played]
-- is the best in edition 2.

select player_name, avg from (
    select t5.player_id, t4.all_runs/t5.total_matches as avg from (
        select player_id, sum(all_runs) as all_runs from (
            select player_id, sum(total_runs) as all_runs from bat_run
            inner join matches
            where matches.match_id = bat_run.match_id 
            and year(matches.match_date) = 2009
            group by player_id
        ) as t3
        group by player_id
    )as t4
    inner join (
        select player_id, count(player_match.match_id)
        as total_matches from player_match
        inner join matches
        where matches.match_id = player_match.match_id
        and year(matches.match_date) = 2009
        group by player_id
    )as t5
    where t4.player_id = t5.player_id
    order by avg desc
    limit 3
)as t6 
inner join player
where t6.player_id = player.player_id
INTO OUTFILE '/var/lib/mysql-files/6.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;
;