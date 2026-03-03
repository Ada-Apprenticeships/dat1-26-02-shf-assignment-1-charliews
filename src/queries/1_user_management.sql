.open fittrackpro.db
.mode box

-- 1.1
SELECT * 
FROM members;

-- 1.2
UPDATE members
SET email = 'emily.jones.updated@email.com',
    phone_number = '07000 100005'
WHERE member_id = 5;

-- 1.3
SELECT
COUNT(*) AS total_members
FROM members;

-- 1.4
SELECT 
    m.member_id, 
    m.first_name, 
    m.last_name, 
    COUNT(ca.class_attendance_id) AS registration_count
FROM class_attendance ca
    ON m.member_id = ca.member_id
WHERE ca.attendance_status = 'Registered'
GROUP BY m.member_id
ORDER BY registration_count DESC
LIMIT 1;

-- 1.5
SELECT 
    m.member_id,
    m.first_name,
    m.last_name,
    COUNT(ca.class_attendance_id) AS registration_count
FROM members m
LEFT JOIN class_attendance ca
    ON m.member_id = ca.member_id
    AND ca.attendance_status = 'Registered'
GROUP BY m.member_id
ORDER BY registration_count
LIMIT 1;

-- 1.6
SELECT COUNT(*) AS Count
FROM(
    SELECT member_id
    FROM class_attendance
    WHERE attendance_status = 'Attended'
    GROUP BY member_id
    HAVING COUNT(*) >= 2
);

