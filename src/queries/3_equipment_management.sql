.open fittrackpro.db
.mode box

-- 3.1 
SELECT equipment_id, name, type, next_maintenance_date
FROM equipment 
WHERE date(next_maintenance_date)
BETWEEN date('now')
AND date('now','+30 days');

-- 3.2 
SELECT type, COUNT(*) AS total_equipment
FROM equipment 
GROUP BY type;

-- 3.3 
SELECT 
    type,
    ROUND(AVG((strftime('%s','now') - strftime('%s', purchase_date)) / 86400), 0) AS avg_age
FROM equipment 
GROUP BY type;
