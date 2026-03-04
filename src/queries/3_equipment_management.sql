.open fittrackpro.db
.mode box

-- 3.1 
SELECT 
    equipment_id, 
    name, 
    next_maintenance_date
FROM equipment 
WHERE DATE(next_maintenance_date)
BETWEEN '2025-01-01'
AND '2025-01-31';

-- 3.2 
SELECT 
    type AS equipment_type,
    COUNT(*) AS count
FROM equipment 
GROUP BY type;

-- 3.3 
SELECT 
    type AS equipment_type,
--julianday returns number of days since a fixed point
--AVG calculates average age per equipment type
    AVG (julianday(DATE('now')) - julianday(purchase_date)) AS avg_age_days
FROM equipment
--GROUP BY separates cardio and strength equipment
GROUP BY type;
