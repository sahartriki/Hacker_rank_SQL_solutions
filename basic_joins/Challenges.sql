WITH ChallengeCounts AS (
    SELECT 
        H.hacker_id, 
        H.name, 
        COUNT(C.challenge_id) AS total_count
    FROM 
        Hackers H 
    JOIN 
        Challenges C ON H.hacker_id = C.hacker_id
    GROUP BY 
        H.hacker_id, H.name
),
MaxChallengeCount AS (
    SELECT 
        MAX(total_count) AS max_count
    FROM 
        ChallengeCounts
),
FilteredCounts AS (
    SELECT 
        hacker_id, 
        name, 
        total_count
    FROM 
        ChallengeCounts
    WHERE 
        total_count = (SELECT max_count FROM MaxChallengeCount)
    OR 
        total_count IN (
            SELECT other_counts
            FROM (
                SELECT 
                    total_count AS other_counts
                FROM 
                    ChallengeCounts
                GROUP BY 
                    total_count
                HAVING 
                    COUNT(*) = 1
            ) AS temp
        )
)

SELECT 
    hacker_id, 
    name, 
    total_count
FROM 
    FilteredCounts
ORDER BY 
    total_count DESC, 
    hacker_id;
