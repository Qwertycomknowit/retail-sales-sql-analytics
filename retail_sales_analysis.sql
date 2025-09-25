-- Retail Sales SQL Analysis Project
-- Author: Shubhashri V P

-- ---------------------------
-- 1. Database & Table Setup
-- ---------------------------

CREATE DATABASE retail_sales_db;

CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(30),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- ---------------------------
-- 2. Data Cleaning Queries
-- ---------------------------

-- Check for NULL values
SELECT * FROM retail_sales
WHERE transaction_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Delete NULL records
DELETE FROM retail_sales
WHERE transaction_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- ---------------------------
-- 3. Analysis Queries
-- ---------------------------

-- Q1: Total number of transactions
SELECT COUNT(*) AS total_transactions FROM retail_sales;

-- Q2: Unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM retail_sales;

-- Q3: Total sales by category
SELECT category, SUM(total_sale) AS net_sales, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

-- Q4: Profit margin by category (Novel)
SELECT category,
       ROUND(SUM(total_sale - cogs),2) AS total_profit,
       ROUND(AVG((total_sale - cogs)/cogs*100),2) AS avg_margin_pct
FROM retail_sales
GROUP BY category
ORDER BY total_profit DESC;

-- Q5: Repeat customers (Novel)
SELECT customer_id, COUNT(DISTINCT sale_date) AS visit_count
FROM retail_sales
GROUP BY customer_id
HAVING COUNT(DISTINCT sale_date) > 1
ORDER BY visit_count DESC;

-- Q6: Peak sales day of the week (Novel)
SELECT TO_CHAR(sale_date, 'Day') AS day_of_week,
       SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY TO_CHAR(sale_date, 'Day')
ORDER BY total_revenue DESC;

-- Q7: Average customer spend by gender (Novel)
SELECT gender, ROUND(AVG(total_sale),2) AS avg_spend
FROM retail_sales
GROUP BY gender;
