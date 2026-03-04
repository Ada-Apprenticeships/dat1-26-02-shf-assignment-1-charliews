.open fittrackpro.db
.mode box

-- 6.1 
INSERT INTO attendance (
    member_id, 
    location_id, 
    check_in_time)
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
--strftime ('%w', check_in_time) extracts the day of the week
    strftime ('%w', check_in_time) AS day_of_week,
    COUNT(*) AS visit_count
FROM attendance
GROUP BY strftime('%w', check_in_time)
--ORDER BY visit_count DESC ensures busiest day appears first
ORDER BY visit_count DESC
--LIMIT 1; returns only the busiest weekday
LIMIT 1;

-- 6.4 
SELECT 
    l.name AS location_name,
    AVG(
        (SELECT COUNT(*)
        FROM attendance a
        WHERE a.location_id = l.location_id
            AND DATE(a.check_in_time) = d.visit_date
        )
        ) AS avg_daily_attendance
FROM locations l,
--(SELECT DISTINCT DATE(check_in_time) AS visit_date generates all distinct attendance dates
    (SELECT DISTINCT DATE(check_in_time) AS visit_date
    FROM attendance) d
--GROUP BY l.location_id; separates each gym location
GROUP BY l.location_id;
