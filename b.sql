-- Find the names of all the batsmen and 
-- the frequency of their “caught” out in increasing order of the number of “caught”.
-- If a tie occurs, sort names alphabetically.

select P.player_name, 
case when t.cnt is null then 0 else t.cnt end as count 
from player as P
left join (
    select player_out, count(kind_out) as cnt from wicket_taken
    where kind_out = "caught"
    group by player_out
) as t
on t.player_out = P.player_id
order by count asc, P.player_name asc
INTO OUTFILE '/var/lib/mysql-files/2.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;
;