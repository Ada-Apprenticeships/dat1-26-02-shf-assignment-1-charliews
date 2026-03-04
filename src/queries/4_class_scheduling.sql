.open fittrackpro.db
.mode box

-- 4.1 
SELECT 
    c.class_id,
    c.name AS class_name,
    s.first_name ||' '|| s.last_name AS instructor_name
FROM classes c 
JOIN class_schedule cs on c.class_id = cs.class_id
JOIN staff s ON cs.staff_id - s.staff_id;

-- 4.2 
SELECT 
    c.class_id,
    c.name,
    cs.start_time,
    cs.end_time,
    c.capacity - COUNT(ca.class_attendance_id) AS available_spots
FROM class_schedule cs
--Join with classes to get class details
JOIN classes c 
    ON cs.class_id = c.class_id
--LEFT JOIN with class_attendance to count the number of members registered for each schedule
LEFT JOIN class_attendance ca
    ON cs.schedule_id = ca.schedule_id
WHERE DATE (cs.start_time) = '2025-02-01'
GROUP BY cs.schedule_id;

-- 4.3 
INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES (1, 11, 'Registered');

-- 4.4 
DELETE FROM class_attendance
WHERE member_id = 3
AND schedule_id = 7;

-- 4.5 
SELECT 
    c.class_id,
    c.name AS class_name,
    COUNT (ca.class_attendance_id) AS registration_count
FROM classes c
--join class_schedule to link each class to its scheduled sessions
JOIN class_schedule cs 
    ON c.class_id = cs.class_id
--join class_attendance to count how many members are registered for each scheduled class
JOIN class_attendance ca 
    ON cs.schedule_id = ca.schedule_id
WHERE ca.attendance_status = 'Registered'
GROUP BY c.class_id
ORDER BY registration_count DESC
--return only the top class with the highest registration count
LIMIT 1;

-- 4.6 
SELECT 
    AVG(class_count) AS avg_classes_per_member
FROM (
    SELECT 
        member_id,
        COUNT(*) AS class_count
    FROM class_attendance
    WHERE attendance_status IN ('Registered','Attended')
    GROUP BY member_id
);
