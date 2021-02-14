-- Find out the batting average of all players.
-- Then only show the list of the top 3 countries with 
-- the highest country batting 
-- average( ∑ battingaverage / Totalnumber of players in that country)

select country_name, avg(avg) as avg from (
    select t4.player_id, t4.all_runs/t5.total_matches as avg from (
        select player_id, sum(total_runs) as all_runs
        from bat_run
        group by player_id
    )as t4
    inner join (
        select player_id, count(match_id) as total_matches 
        from player_match
        group by player_id
    )as t5
    where t4.player_id = t5.player_id
)as t6 
inner join player
where t6.player_id = player.player_id
group by country_name
order by avg desc
limit 3
;