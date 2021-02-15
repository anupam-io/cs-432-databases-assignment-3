drop database X;
create database X;
use X;
set global local_infile=true;

create table team(
    team_id int(10) unsigned primary key,
    team_name varchar(50) not null
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
    player_name varchar(50) not null,
    dob date not null,
    batting_hand varchar(50) not null,
    bowling_skill varchar(50) not null,
    country_name varchar(50) not null
);
load data local infile "data/player.csv" 
into table player
fields terminated by ','
lines terminated by '\n'
ignore 2 rows
;
-- -- select * from player;


create table player_match(
    match_id int(10) unsigned not null,
    player_id int(10) unsigned not null,
    role varchar(50) not null,
    team_id int(10) unsigned not null
);
load data local infile "data/player_match.csv" 
into table player_match
fields terminated by ','
lines terminated by '\n'
ignore 2 rows
;
-- -- select * from player_match;



create table wicket_taken(
    match_id int(10) unsigned not null,
    over_id int(10) unsigned not null,
    ball_id int(10) unsigned not null,
    player_out int(10) unsigned not null,
    kind_out varchar(50) not null,
    innings_no int(10) unsigned not null
);
load data local infile "data/wicket_taken.csv" 
into table wicket_taken
fields terminated by ','
lines terminated by '\n'
ignore 2 rows
;
-- -- select * from wicket_taken;



create table matches(
    match_id int(10) not null,
    team_1 int(10) not null,
    team_2 int(10) not null,
    match_date date not null,
    season_id int(10) not null,
    venue varchar(50) not null,
    toss_winner int(10) not null,
    toss_decision varchar(50) not null,
    win_type varchar(50) not null,
    win_margin int(10) not null,
    outcome_type varchar(50) not null, 
    match_winner int(10) not null,
    man_of_the_match int(10) not null
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
    match_id int(10) not null,
    over_id int(10) not null,
    ball_id int(10) not null,
    extra_type varchar(50) not null,
    extra_runs int(10) not null,
    innings_no int(10) not null
);
load data local infile "data/extra_runs.csv" 
into table extra_runs
fields terminated by ','
lines terminated by '\n'
ignore 2 rows
;
-- -- select * from extra_runs;


create table batsman_scored(
    match_id int(10) not null,
    over_id int(10) not null,
    ball_id int(10) not null,
    runs_scored int(10) not null,
    innings_no int(10) not null
);
load data local infile "data/batsman_scored.csv" 
into table batsman_scored
fields terminated by ','
lines terminated by '\n'
ignore 2 rows
;
-- select * from extra_runs;



create table ball_by_ball(
    match_id int(10) not null,
    over_id int(10) not null,
    ball_id int(10) not null,
    innings_no int(10) not null,
    team_batting int(10) not null,
    team_bowling int(10) not null,
    striker_batting_position int(10) not null,
    striker int(10) not null,
    non_striker int(10) not null,
    bowler int(10) not null
);
load data local infile "data/ball_by_ball.csv" 
into table ball_by_ball
fields terminated by ','
lines terminated by '\n'
ignore 3 rows
;
-- -- select * from ball_by_ball;



-- Helping view for multiple queries
create view bat_run as (
    select match_id, striker as player_id, sum(runs_scored) as total_runs 
    from (
        select striker, B.match_id, runs_scored from batsman_scored as B
        inner join (
            select match_id, over_id, ball_id, innings_no, striker from ball_by_ball
        )as t1
        where B.match_id = t1.match_id
        and B.over_id = t1.over_id
        and B.ball_id = t1.ball_id
        and B.innings_no = t1.innings_no
    ) as t2
    group by striker, match_id
)
;