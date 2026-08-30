-- ==========================================
-- SALES ANALYTICS DASHBOARD
-- SQL ANALYSIS
-- ==========================================

USE sales_dashboard;


-- 1. Total Orders
SELECT COUNT(*) AS total_orders
FROM sales;


-- 2. Total Sales
SELECT SUM(total_amount) AS total_sales
FROM sales;


-- 3. Total Customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM sales;


-- 4. Average Order Value
SELECT AVG(total_amount) AS average_order_value
FROM sales;


-- 5. Region-wise Sales
SELECT
    region,
    SUM(total_amount) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;


-- 6. Category-wise Sales
SELECT
    category,
    SUM(total_amount) AS total_sales
FROM sales
GROUP BY category
ORDER BY total_sales DESC;


-- 7. Payment Method Analysis
SELECT
    payment_method,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_sales
FROM sales
GROUP BY payment_method
ORDER BY total_sales DESC;


-- 8. Return Analysis
SELECT
    returned,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_sales,
    SUM(profit_margin) AS total_profit
FROM sales
GROUP BY returned;


-- 9. Monthly Sales
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(total_amount) AS total_sales
FROM sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;


-- 10. Top 10 Customers
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_spent
FROM sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;


-- 11. Total Profit
SELECT
    SUM(profit_margin) AS total_profit
FROM sales;


-- 12. Profit by Category
SELECT
    category,
    SUM(profit_margin) AS total_profit,
    AVG(profit_margin) AS average_profit
FROM sales
GROUP BY category
ORDER BY total_profit DESC;


-- 13. Profit by Region
SELECT
    region,
    SUM(profit_margin) AS total_profit,
    AVG(profit_margin) AS average_profit
FROM sales
GROUP BY region
ORDER BY total_profit DESC;


-- 14. Delivery Performance
SELECT
    region,
    AVG(delivery_time_days) AS average_delivery_days
FROM sales
GROUP BY region
ORDER BY average_delivery_days DESC;


-- 15. Top 10 Products
SELECT
    product_id,
    COUNT(*) AS total_orders,
    SUM(quantity) AS units_sold,
    SUM(total_amount) AS total_sales,
    SUM(profit_margin) AS total_profit
FROM sales
GROUP BY product_id
ORDER BY total_sales DESC
LIMIT 10;


-- 16. Category Ranking
SELECT
    category,
    SUM(total_amount) AS total_sales,
    RANK() OVER (
        ORDER BY SUM(total_amount) DESC
    ) AS sales_rank
FROM sales
GROUP BY category;


-- 17. Monthly Sales Comparison
WITH monthly_sales AS (
    SELECT
        YEAR(order_date) AS year,
        MONTH(order_date) AS month,
        SUM(total_amount) AS total_sales
    FROM sales
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT
    year,
    month,
    total_sales,
    LAG(total_sales) OVER (
        ORDER BY year, month
    ) AS previous_month_sales
FROM monthly_sales
ORDER BY year, month;