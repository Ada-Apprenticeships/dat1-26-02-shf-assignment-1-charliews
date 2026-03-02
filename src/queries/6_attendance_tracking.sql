.open fittrackpro.db
.mode box

-- 6.1 
INSERT INTO attendance (member_id, location_id, check_in_time)
VALUES (7, 1, '2025-02-14 16:00:00');

-- 6.2 
SELECT 
    DATE(check_in_time) AS visit_date,
    check_in_time,
    check_out_time
FROM attendance
WHERE member_id = 5;

-- 6.3 
SELECT 
    strftime ('%w', check_in_time) AS day_of_week,
    COUNT(*) AS visit_count
FROM attendance
GROUP BY strftime('%w', check_in_time)
ORDER BY visit_count DESC
LIMIT 1;

-- 6.4 
SELECT 
    l.name AS location_name,
    AVG(daily_count) AS avg_daily_attendance 
FROM locations l
LEFT JOIN (
    SELECT 
        location_id,
        DATE(check_in_time) AS visit_date,
        COUNT(*) AS daily_count
    FROM attendance
    GROUP BY location_id, DATE(check_in_time)
)
d 
ON l.location_id = d.location_id
GROUP BY l.location_id;