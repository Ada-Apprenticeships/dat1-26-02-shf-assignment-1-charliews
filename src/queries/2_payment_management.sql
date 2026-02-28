.open fittrackpro.db
.mode box

-- 2.1 
INSERT INTO payments
(member_id, amount, payment_date, payment_method, payment_type)
VALUES
(2, 60.00, '2025-02-10 10:00:00', 'Bank Transfer', 'Monthly membership fee');

-- 2.2 
SELECT strftime('%Y-%m', payment_date) AS month,
    SUM(amount) AS total_revenue
FROM payments
WHERE payment_type = 'Monthly membership fee'
GROUP BY month
ORDER BY month;

-- 2.3 
SELECT *
FROM payments
WHERE payment_type = 'Day pass';
