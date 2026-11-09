-- Q1: WHERE then HAVING
SELECT 
    customer_id,
    COUNT(*) as order_count,
    SUM(order_amount) as total_spent
FROM orders
WHERE status = 'completed' AND order_amount > 500
GROUP BY customer_id
HAVING SUM(order_amount) > 8000
ORDER BY total_spent DESC;

-- Q2: Three-table JOIN
SELECT 
    c.city,
    p.category,
    ROUND(SUM(o.order_amount), 2) as revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY c.city, p.category
ORDER BY revenue DESC;

-- Q3: Scalar SUBQUERY
SELECT 
    product_id,
    product_name,
    price_inr
FROM products
WHERE price_inr > (SELECT AVG(price_inr) FROM products)
ORDER BY price_inr DESC;

-- Q4: LEFT JOIN
SELECT 
    c.customer_id,
    c.city,
    c.gender
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id AND o.status = 'completed'
WHERE o.order_id IS NULL
ORDER BY c.customer_id;

-- Q5: Common Table Expression (CTE)
WITH customer_spend AS (
    SELECT 
        customer_id,
        ROUND(SUM(order_amount), 2) as total_spend
    FROM orders
    WHERE status = 'completed'
    GROUP BY customer_id
),
average_spend AS (
    SELECT ROUND(AVG(total_spend), 2) as avg_spend
    FROM customer_spend
)
SELECT 
    cs.customer_id,
    cs.total_spend
FROM customer_spend cs
WHERE cs.total_spend > (SELECT avg_spend FROM average_spend)
ORDER BY cs.total_spend DESC;

-- Q6: Ranking Window Functions
WITH customer_city_spend AS (
    SELECT 
        c.customer_id,
        c.city,
        ROUND(SUM(o.order_amount), 2) as total_spend
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE o.status = 'completed'
    GROUP BY c.customer_id, c.city
)
SELECT 
    customer_id,
    city,
    total_spend,
    RANK() OVER (PARTITION BY city ORDER BY total_spend DESC) as rank_val,
    DENSE_RANK() OVER (PARTITION BY city ORDER BY total_spend DESC) as dense_rank_val,
    ROW_NUMBER() OVER (PARTITION BY city ORDER BY total_spend DESC) as row_num
FROM customer_city_spend
ORDER BY city, rank_val;

-- Q7: Running Total (Window Function)
WITH daily_revenue AS (
    SELECT 
        SUBSTR(order_ts, 1, 10) as day,
        ROUND(SUM(order_amount), 2) as daily_revenue
    FROM orders
    WHERE status = 'completed'
    GROUP BY SUBSTR(order_ts, 1, 10)
)
SELECT 
    day,
    daily_revenue,
    ROUND(SUM(daily_revenue) OVER (ORDER BY day), 2) as cumulative_revenue
FROM daily_revenue
ORDER BY day;