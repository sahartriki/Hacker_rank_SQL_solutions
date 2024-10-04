WITH grades_assign AS (
    SELECT s.id, s.name, s.marks, g.grade
    FROM students s
    JOIN grades g ON s.marks BETWEEN g.min_mark AND g.max_mark 
),
report AS (
    SELECT 
        CASE 
            WHEN grade < 8 THEN NULL 
            ELSE name 
        END AS name, 
        grade, 
        marks
    FROM grades_assign
)

SELECT 
    name, 
    grade, 
    marks
FROM 
    report
ORDER BY 
    grade DESC,                       -- Order by grade in descending order
    CASE 
        WHEN grade < 8 THEN marks     -- If grade is below 8, order by marks in ascending order
        ELSE NULL                     -- Use NULL for names in case of grade >= 8
    END, 
    name;                            -- Order by name alphabetically for grades >= 8
