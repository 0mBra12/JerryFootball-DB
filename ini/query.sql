
-- three general queries --
SELECT *
FROM university u, coach c, work_for w
WHERE u.university_id = w.university_id AND c.coach_id = w.coach_id;

SELECT *
FROM coach c, address a
WHERE c.coach_address_id = a.address_id AND c.coach_id = 1;

SELECT coach.coach_name, player.player_name
FROM coach, player, play_for, work_for
WHERE coach.coach_id = work_for.coach_id AND player.player_id = play_for.player_id AND work_for.university_id = play_for.player_id;

-- one "union" query --
SELECT city
FROM address, locate WHERE address.address_id = locate.address_id
UNION
SELECT city
FROM address, hold_at WHERE address.address_id = hold_at.address_id;

-- find the names of the players working for "odn" university --
-- "join" query --
SELECT player_name
FROM university NATURAL JOIN play_for NATURAL JOIN player
WHERE university_name = "odn";

-- find the address of the coach working for "odn" university --
-- "join" query --
SELECT coach_name, number, street, city, state, zip
FROM university NATURAL JOIN work_for NATURAL JOIN coach, address
WHERE university_name = "odn" AND coach_address_id = address_id;

-- find the number of mathces every university wins --
-- one "group by" query --
SELECT university_name, count(*) AS Wins
FROM game, university
WHERE university_id = game_result
GROUP BY university_name;

-- one "order by" query --
SELECT player.player_id, play_for.university_id
FROM player, play_for
WHERE player.player_id = play_for.player_id
ORDER BY university_id, player.player_id ASC;

-- one "DISTINCT" query --
SELECT DISTINCT(address_id)
FROM live_at, play_for, university
WHERE live_at.player_id = play_for.player_id AND play_for.university_id =  university.university_id AND university_name = 'odn';

-- one "Aggregate" query --
SELECT game_result, COUNT(game_result)
FROM game
GROUP BY game_result
HAVING COUNT(game_result) >= 2;