-- Using view, create a table say “IndianPlayers”
-- which contains information about the total runs 
-- scored by all the Indian players till now and sort 
-- them alphabetically.

drop view if exists indian_players;
create view indian_players as (
    select P.player_name, t4.all_runs from (
        select player_id, sum(total_runs) as all_runs from bat_run
        group by player_id
    )as t4
    inner join player as P
    where P.player_id = t4.player_id and P.country_name = "India"
    order by P.player_name
)
;

select * from indian_players;