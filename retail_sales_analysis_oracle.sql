/*
PROJECT: Retail Sales Analysis using SQL
DIALECT: Oracle SQL
DATA: retail_sales.csv (150 synthetic practice transactions)
NOTE: This is a learning dataset created for practice, not real business data.
*/

-- STEP 1: Create the table
CREATE TABLE retail_sales (
    sale_id NUMBER PRIMARY KEY,
    sale_date DATE,
    customer_id VARCHAR2(10),
    customer_name VARCHAR2(100),
    product_id VARCHAR2(10),
    product_name VARCHAR2(100),
    category VARCHAR2(50),
    quantity NUMBER,
    unit_price NUMBER(10,2),
    discount_percent NUMBER(5,2)
);

-- STEP 2: After importing retail_sales.csv into the table, run these analyses.
-- Revenue after discount = quantity * unit_price * (1 - discount_percent / 100)

-- Q1. Preview the data
SELECT * FROM retail_sales
ORDER BY sale_id
FETCH FIRST 10 ROWS ONLY;

-- Q2. Total revenue, units sold and transactions
SELECT
    ROUND(SUM(quantity * unit_price * (1 - discount_percent / 100)), 2) AS total_revenue,
    SUM(quantity) AS units_sold,
    COUNT(*) AS total_transactions
FROM retail_sales;

-- Q3. Revenue by product category
SELECT
    category,
    ROUND(SUM(quantity * unit_price * (1 - discount_percent / 100)), 2) AS category_revenue
FROM retail_sales
GROUP BY category
ORDER BY category_revenue DESC;

-- Q4. Top 10 products by revenue
SELECT
    product_name,
    SUM(quantity) AS units_sold,
    ROUND(SUM(quantity * unit_price * (1 - discount_percent / 100)), 2) AS product_revenue
FROM retail_sales
GROUP BY product_name
ORDER BY product_revenue DESC
FETCH FIRST 10 ROWS ONLY;

-- Q5. Monthly revenue trend
SELECT
    TO_CHAR(sale_date, 'YYYY-MM') AS sales_month,
    ROUND(SUM(quantity * unit_price * (1 - discount_percent / 100)), 2) AS monthly_revenue
FROM retail_sales
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY sales_month;

-- Q6. Top 10 customers by revenue
SELECT
    customer_id,
    customer_name,
    ROUND(SUM(quantity * unit_price * (1 - discount_percent / 100)), 2) AS customer_revenue
FROM retail_sales
GROUP BY customer_id, customer_name
ORDER BY customer_revenue DESC
FETCH FIRST 10 ROWS ONLY;

-- Q7. Average order value
SELECT
    ROUND(AVG(quantity * unit_price * (1 - discount_percent / 100)), 2) AS average_transaction_value
FROM retail_sales;

-- Q8. Discount impact
SELECT
    discount_percent,
    COUNT(*) AS transaction_count,
    ROUND(SUM(quantity * unit_price * (1 - discount_percent / 100)), 2) AS net_revenue
FROM retail_sales
GROUP BY discount_percent
ORDER BY discount_percent;

-- Q9. Category-wise quantity sold
SELECT
    category,
    SUM(quantity) AS total_quantity
FROM retail_sales
GROUP BY category
ORDER BY total_quantity DESC;

-- Q10. Daily revenue for the highest-sales day
SELECT
    sale_date,
    ROUND(SUM(quantity * unit_price * (1 - discount_percent / 100)), 2) AS daily_revenue
FROM retail_sales
GROUP BY sale_date
ORDER BY daily_revenue DESC
FETCH FIRST 1 ROW ONLY;
