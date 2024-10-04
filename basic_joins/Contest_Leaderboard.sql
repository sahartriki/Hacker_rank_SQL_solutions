SELECT 
    h.hacker_id, 
    h.name, 
    SUM(MAX_SCORE.t1) AS total_score
FROM 
    Hackers h 
INNER JOIN 
    (
        SELECT 
            MAX(s.score) AS t1, 
            s.hacker_id  
        FROM 
            Submissions s
        GROUP BY 
            s.challenge_id, s.hacker_id
        HAVING 
            MAX(s.score) > 0
    ) AS MAX_SCORE
ON 
    h.hacker_id = MAX_SCORE.hacker_id
GROUP BY 
    h.hacker_id, h.name
ORDER BY 
    total_score DESC, 
    h.hacker_id ASC;
