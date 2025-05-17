-- Assessment_Q2.sql

WITH transaction_stats AS (
    SELECT 
        s.owner_id,
        COUNT(*) AS total_transactions,
        TIMESTAMPDIFF(MONTH, MIN(s.created_on), MAX(s.created_on)) + 1 AS active_months
    FROM savings_savingsaccount s
    GROUP BY s.owner_id
),
frequency_classification AS (
    SELECT 
        t.owner_id,
        (t.total_transactions * 1.0) / t.active_months AS avg_txn_per_month,
        CASE 
            WHEN (t.total_transactions * 1.0) / t.active_months >= 10 THEN 'High Frequency'
            WHEN (t.total_transactions * 1.0) / t.active_months BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM transaction_stats t
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 2) AS avg_transactions_per_month
FROM frequency_classification
GROUP BY frequency_category;
