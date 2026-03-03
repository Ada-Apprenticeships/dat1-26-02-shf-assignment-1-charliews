.open fittrackpro.db
.mode box

-- 3.1 
SELECT equipment_id, 
name, 
next_maintenance_date
FROM equipment 
WHERE date(next_maintenance_date)
BETWEEN '2025-01-01'
AND '2025-01-31';

-- 3.2 
SELECT type AS equipment_type,
COUNT(*) AS count
FROM equipment 
GROUP BY type;

-- 3.3 
SELECT 
    type AS equipment_type,
    ROUND(AVG((strftime('%s','now') - strftime('%s', purchase_date)) / 86400), 0) AS avg_age
FROM equipment 
GROUP BY type;
