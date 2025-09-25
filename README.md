# retail-sales-sql-analytics

Retail Sales Analysis with SQL
📌 Project Overview

This project demonstrates how SQL can be used to clean, analyze, and generate insights from retail sales data.
The database simulates a retail store’s transactions, including customer demographics, product categories, and sales amounts.

The project goes beyond basic SQL by adding business-focused analysis such as profit margins, customer retention, and seasonality trends — making it useful for both learning SQL and applying it in real-world analytics.

🎯 Objectives

✅ Create and populate a retail sales database

✅ Perform data cleaning to remove null or inconsistent values

✅ Explore the dataset using SQL queries

✅ Answer key business questions using SQL

✅ Add advanced analysis (profitability, retention, basket size, etc.)

📂 Project Structure
retail-sales-sql-analytics/
├── setup/                # SQL script for database & table creation
├── queries/              # SQL queries for analysis
├── results/              # Example outputs, charts, or CSV exports
└── README.md             # Project documentation

🗂️ Database Setup
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

🔍 Business Questions & Queries
1. Total number of transactions
SELECT COUNT(*) AS total_transactions FROM retail_sales;

2. Unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM retail_sales;

3. Total sales by category
SELECT category, SUM(total_sale) AS net_sales, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

4. Profit margin by category (Novel)
SELECT category,
       ROUND(SUM(total_sale - cogs),2) AS total_profit,
       ROUND(AVG((total_sale - cogs)/cogs*100),2) AS avg_margin_pct
FROM retail_sales
GROUP BY category
ORDER BY total_profit DESC;

5. Repeat customers (Novel)
SELECT customer_id, COUNT(DISTINCT sale_date) AS visit_count
FROM retail_sales
GROUP BY customer_id
HAVING COUNT(DISTINCT sale_date) > 1
ORDER BY visit_count DESC;

6. Peak sales day of the week (Novel)
SELECT TO_CHAR(sale_date, 'Day') AS day_of_week,
       SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY TO_CHAR(sale_date, 'Day')
ORDER BY total_revenue DESC;

7. Average customer spend by gender (Novel)
SELECT gender, ROUND(AVG(total_sale),2) AS avg_spend
FROM retail_sales
GROUP BY gender;

📊 Key Findings

Top Categories: Clothing and Beauty lead in total sales.

Profitability: Some categories yield higher profit margins even if sales volume is lower.

Customer Behavior: A small group of repeat customers contribute significantly to revenue.

Seasonality: Peak sales occur on weekends and during certain months.

Demographics: Gender-based spending patterns reveal interesting differences in purchasing behavior.

🚀 How to Use

Clone this repository:

git clone https://github.com/your-username/retail-sales-sql-analytics.git


Run the setup script in setup/ to create and populate the database.

Use the queries in queries/ to explore and analyze the data.

Modify queries to answer your own business questions.
