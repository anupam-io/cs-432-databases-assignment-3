-- Find out the names of all batsmen 
-- who scored more than 100 runs and,
-- their runs scored. Sort names alphabetically.
-- (if multiple entries of the same player, 
-- show the one with highest runs)

select distinct(player_name), max(total_runs) as total_runs from (
    select P.player_name, t4.total_runs from (
        select * from bat_run
        where total_runs > 100
    )as t4
    inner join player as P
    where t4.player_id = P.player_id
    order by  P.player_name
)as t5
group by player_name
order by player_name
INTO OUTFILE '/var/lib/mysql-files/5.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;
;