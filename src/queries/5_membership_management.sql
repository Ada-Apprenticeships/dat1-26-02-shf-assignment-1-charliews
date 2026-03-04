.open fittrackpro.db
.mode box

-- 5.1 
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    ms.type,
    m.join_date
FROM members m
JOIN memberships ms
    ON m.member_id = ms.member_id
WHERE ms.status = 'Active';

-- 5.2 
SELECT 
    ms.type AS membership_type,
    AVG((julianday(a.check_out_time) - julianday(a.check_in_time)) * 24 * 60)
        AS avg_visit_duration_minutes
FROM attendance a 
JOIN memberships ms 
    ON a.member_id = ms.member_id
GROUP BY ms.type;

-- 5.3 
SELECT 
    m.member_id,
    mem.first_name,
    mem.last_name,
    mem.email,
    m.end_date
FROM memberships m
JOIN members mem 
    ON m.member_id = mem.member_id
WHERE strftime('%Y', m.end_date) = '2025';
