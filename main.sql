drop database X;
create database X;
use X;
set global local_infile=true;

create table team(
    team_id int(10) unsigned,
    team_name varchar(50)
);
load data local infile "data/team.csv" 
into table team
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
;
-- -- select * from team;



create table player(
    player_id int(10) unsigned primary key,
    player_name varchar(50),
    dob date,
    batting_hand varchar(50),
    bowling_skill varchar(50),
    country_name varchar(50)
);
load data local infile "data/player.csv" 
into table player
fields terminated by ','
lines terminated by '\n'
ignore 2 rows
;
-- -- select * from player;


create table player_match(
    match_id int(10) unsigned,
    player_id int(10) unsigned,
    role varchar(50),
    team_id int(10) unsigned
);
load data local infile "data/player_match.csv" 
into table player_match
fields terminated by ','
lines terminated by '\n'
ignore 2 rows
;
-- -- select * from player_match;



create table wicket_taken(
    match_id int(10) unsigned,
    over_id int(10) unsigned,
    ball_id int(10) unsigned,
    player_out int(10) unsigned,
    kind_out varchar(50),
    innings_no int(10) unsigned
);
load data local infile "data/wicket_taken.csv" 
into table wicket_taken
fields terminated by ','
lines terminated by '\n'
ignore 2 rows
;
-- -- select * from wicket_taken;



create table matches(
    match_id int(10),
    team_1 int(10),
    team_2 int(10),
    match_date date,
    season_id int(10),
    venue varchar(50),
    toss_winner int(10),
    toss_decision varchar(50),
    win_type varchar(50),
    win_margin int(10),
    outcome_type varchar(50),   
    match_winner int(10),
    man_of_the_match int(10)
)
;
load data local infile "data/match.csv" 
into table matches
fields terminated by ','
lines terminated by '\n'
ignore 2 rows
;
-- -- select * from matches;



create table extra_runs(
    match_id int(10),
    over_id int(10),
    ball_id int(10),
    extra_type varchar(50),
    extra_runs int(10),
    innings_no int(10)
);
load data local infile "data/extra_runs.csv" 
into table extra_runs
fields terminated by ','
lines terminated by '\n'
ignore 2 rows
;
-- -- select * from extra_runs;


create table batsman_scored(
    match_id int(10),
    over_id int(10),
    ball_id int(10),
    runs_scored int(10),
    innings_no int(10)
);
load data local infile "data/batsman_scored.csv" 
into table batsman_scored
fields terminated by ','
lines terminated by '\n'
ignore 2 rows
;
-- select * from extra_runs;



create table ball_by_ball(
    match_id int(10),
    over_id int(10),
    ball_id int(10),
    innings_no int(10),
    team_batting int(10),
    team_bowling int(10),
    striker_batting_position int(10),
    striker int(10),
    non_striker int(10),
    bowler int(10)
);
load data local infile "data/ball_by_ball.csv" 
into table ball_by_ball
fields terminated by ','
lines terminated by '\n'
ignore 3 rows
;
-- -- select * from ball_by_ball;
