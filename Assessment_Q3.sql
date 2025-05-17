-- Assessment_Q3.sql

WITH latest_transactions AS (
    SELECT 
        s.plan_id,
        MAX(s.created_on) AS last_transaction_date
    FROM savings_savingsaccount s
    GROUP BY s.plan_id
),
plan_activity AS (
    SELECT 
        p.id AS plan_id,
        p.owner_id,
        CASE 
            WHEN p.plan_type_id = 1 THEN 'Savings'
            WHEN p.plan_type_id = 2 THEN 'Investment'
            ELSE 'Other'
        END AS type,
        lt.last_transaction_date,
        DATEDIFF(CURDATE(), lt.last_transaction_date) AS inactivity_days
    FROM plans_plan p
    LEFT JOIN latest_transactions lt ON p.id = lt.plan_id
    WHERE p.is_archived = 0 AND p.is_deleted = 0
)
SELECT 
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    inactivity_days
FROM plan_activity
WHERE inactivity_days > 365
ORDER BY inactivity_days DESC;
