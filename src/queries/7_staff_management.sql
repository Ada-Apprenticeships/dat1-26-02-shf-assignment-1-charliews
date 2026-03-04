.open fittrackpro.db
.mode box

-- 7.1 
SELECT 
    staff_id,
    first_name,
    last_name,
    position AS role
FROM STAFF
ORDER BY position;

-- 7.2 
SELECT 
    s.staff_id AS trainer_id,
    s.first_name || ' ' || s.last_name AS trainer_name,
    COUNT(p.session_id) AS session_count
FROM staff s
JOIN personal_training_sessions p
    ON s.staff_id = p.staff_id
WHERE s.position = 'Trainer'
--BETWEEN '2025-01-20' AND '2025-02-19' filters sessions between 2025-02-19 and 30 days after could have also done '+30 days'
AND p.session_date BETWEEN '2025-01-20' AND '2025-02-19'
--GROUP BY s.staff_id; counts sessions per trainer
GROUP BY s.staff_id;