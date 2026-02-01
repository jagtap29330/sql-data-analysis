-- Customer KPI Analysis
-- Objective: Calculate key customer performance metrics

WITH customer_orders AS (
    SELECT
        c.customer_id,
        c.customer_name,
        COUNT(o.order_id) AS total_orders,
        SUM(o.quantity * p.price) AS total_spent
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN products p ON o.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
)

SELECT
    customer_name,
    total_orders,
    total_spent,
    DENSE_RANK() OVER (ORDER BY total_spent DESC) AS customer_rank
FROM customer_orders;
