-- For all the matches_id, 
-- find the minimum runs scored in any over and 
-- the bowler who bowled that over. 
-- Sort by increasing over_ids if ties occur.

-- select over_id, sum(runs_scored) from batsman_scored
-- group by over_id
-- ;


select count(match_id) from batsman_scored;