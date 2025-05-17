-- Assessment_Q4.sql

WITH customer_txn AS (
    SELECT 
        s.owner_id,
        COUNT(*) AS total_transactions,
        SUM(s.confirmed_amount) AS total_value_kobo
    FROM savings_savingsaccount s
    GROUP BY s.owner_id
),
customer_clv AS (
    SELECT 
        u.id AS customer_id,
        CONCAT(u.first_name, ' ', u.last_name) AS name,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
        c.total_transactions,
        ROUND((c.total_value_kobo * 0.001) / c.total_transactions / 100, 2) AS avg_profit_per_transaction,  -- convert to naira
        ROUND(((c.total_transactions * 1.0) / TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE())) 
              * 12 * ((c.total_value_kobo * 0.001) / c.total_transactions) / 100, 2) AS estimated_clv
    FROM users_customuser u
    JOIN customer_txn c ON u.id = c.owner_id
    WHERE TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) > 0  -- avoid divide by zero
)
SELECT 
    customer_id,
    name,
    tenure_months,
    total_transactions,
    estimated_clv
FROM customer_clv
ORDER BY estimated_clv DESC;
