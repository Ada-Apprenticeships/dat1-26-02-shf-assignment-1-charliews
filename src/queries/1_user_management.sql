.open fittrackpro.db
.mode box

-- 1.1
SELECT * 
FROM members;

-- 1.2
UPDATE members
SET email = 'alice.new@email.com',
    phone_number = '07799 999999'
WHERE member_id = 1;

-- 1.3
SELECT COUNT(*) AS total_members
FROM members;

-- 1.4
SELECT m.first_name, m.last_name, COUNT(*) AS total_registrations
FROM class_attendance AS ca 
JOIN members AS m ON ca.member_id = m.member_id
GROUP BY ca.member_id
ORDER BY total_registrations DESC 
LIMIT 1;

-- 1.5


-- 1.6

