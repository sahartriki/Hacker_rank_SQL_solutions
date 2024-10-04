SELECT w.id, p.age, w.coins_needed, w.power
FROM wands w
JOIN wands_property p ON w.code = p.code
WHERE p.is_evil = 0
AND w.coins_needed = (
    SELECT MIN(w2.coins_needed)
    FROM wands w2
    WHERE w2.power = w.power AND w2.code = w.code
)
ORDER BY w.power DESC, p.age DESC;
