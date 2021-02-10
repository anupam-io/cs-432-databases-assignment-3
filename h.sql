-- Write down a simple query to make 
-- a copy of the player table(with data).

drop table if exists player_copy;
create table player_copy like player;
insert into player_copy select * from player;

select * from player_copy;
