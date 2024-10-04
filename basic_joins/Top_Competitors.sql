WITH score_to_achieve AS (
    SELECT ch.challenge_id, 
           ch.hacker_id, 
           ch.difficulty_level, 
           diff.score AS full_score
    FROM challenges ch 
    JOIN difficulty diff ON ch.difficulty_level = diff.difficulty_level
),
total_full_score AS (
    SELECT h.hacker_id,
           h.name, 
           COUNT(CASE  
                     WHEN sub.score = ch.full_score THEN 1
                     ELSE NULL 
                END) AS total_full_score 
    FROM hackers h 
    JOIN submissions sub ON sub.hacker_id = h.hacker_id 
    JOIN score_to_achieve ch ON sub.challenge_id = ch.challenge_id 
    GROUP BY h.hacker_id, h.name  
    HAVING COUNT(CASE  
                     WHEN sub.score = ch.full_score THEN 1
                     ELSE NULL 
                END) > 1
)

SELECT hacker_id, name
FROM total_full_score
ORDER BY total_full_score DESC, hacker_id ASC;