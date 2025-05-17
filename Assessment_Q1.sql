-- Assessment_Q1.sql

SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COUNT(DISTINCT CASE WHEN p.plan_type_id = 1 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.plan_type_id = 2 THEN p.id END) AS investment_count,
    ROUND(SUM(s.confirmed_amount) / 100, 2) AS total_deposits  -- Convert from kobo to naira
FROM users_customuser u
JOIN plans_plan p ON u.id = p.owner_id
JOIN savings_savingsaccount s ON p.id = s.plan_id
WHERE p.is_archived = 0 AND p.is_deleted = 0
GROUP BY u.id, u.first_name, u.last_name
HAVING 
    savings_count > 0 AND 
    investment_count > 0
ORDER BY total_deposits DESC;
