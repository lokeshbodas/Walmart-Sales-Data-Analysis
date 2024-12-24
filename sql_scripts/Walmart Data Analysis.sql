CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

SELECT * FROM sales;

SELECT
    time,
    (CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END) AS time_of_day
FROM sales;
--Add time_of_day column
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(50);
UPDATE sales SET time_of_day = (
CASE 
	WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
END);

SELECT
	date,
	TO_CHAR(date, 'Day') as day_name
FROM sales;

--Add day_name column
ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
UPDATE sales
SET day_name = TO_CHAR(date, 'Day');

SELECT
	date,
	TO_CHAR(date, 'Month') as month_name
FROM sales;

--Add month_name column
ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales
SET month_name = TO_CHAR(date, 'Month');

SELECT DISTINCT city FROM sales;

SELECT DISTINCT city, branch, product_line FROM sales;

--The most selling product line
SELECT
	SUM(quantity) as qty, product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;

--The total revenue by month
SELECT
	month_name AS month,
	SUM(total) AS total_revenue
FROM sales
GROUP BY month_name 
ORDER BY total_revenue;

--Gives the month which has the longest COGS($COGS = Unit Price * Quantity $)
SELECT month_name AS month,
	SUM(cogs) AS cogs
FROM sales
GROUP BY month_name 
ORDER BY cogs;

--Product Line which has the largest revenue
SELECT product_line,
	SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

--City which has the largest revenue
SELECT branch, city,
	SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue;

--Product Line which has the largest VAT
SELECT product_line,
	AVG(tax_pct) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

--Gives the average for quantity
SELECT 
	AVG(quantity) AS avg_qnty
FROM sales;

SELECT
	product_line,
	CASE
		WHEN AVG(quantity) > 6 THEN 'Good'
        ELSE 'Bad'
    END AS remark
FROM sales
GROUP BY product_line;

--Branch which sold more products than average product sold
SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

--Most common product line by gender
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

--Average rating of each product line
SELECT
	ROUND(AVG(CAST(rating AS numeric)), 2) as avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

--Types of unique customers our dataset has
SELECT
	DISTINCT customer_type
FROM sales;

--Number of unique payment methods the dataset has
SELECT
	DISTINCT payment
FROM sales;

--Most common customer types
SELECT
	customer_type,
	count(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;

--Customer type who buys the most
SELECT
	customer_type,
    COUNT(*)
FROM sales
GROUP BY customer_type;

--Gender of most of the customers
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

--Gender Distribution per branch
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
WHERE branch = 'C'
GROUP BY gender
ORDER BY gender_cnt DESC;

--Time of the day to customers where most of the rating is given
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

--Time of the day to customers where most of the rating per branch is given
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
WHERE branch = 'A'
GROUP BY time_of_day
ORDER BY avg_rating DESC;

--Day of the week which has the best avg ratings
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;

--Day of the week which has the best avg ratings per branch
SELECT
	day_name,
	COUNT(day_name) total_sales
FROM sales
WHERE branch = 'C'
GROUP BY day_name
ORDER BY total_sales DESC;

--Number of sales made in each time of the day per weekday
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
WHERE day_name = 'Sunday'
GROUP BY time_of_day 
ORDER BY total_sales DESC;

--Customer type who brings the most revenue
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue;

--City which has the largest tax/VAT percent
SELECT
	city,
    ROUND(AVG(cast(tax_pct AS numeric)), 2) AS avg_tax_pct
FROM sales
GROUP BY city 
ORDER BY avg_tax_pct DESC;

--Customer type who pays the most in VAT
SELECT
	customer_type,
	AVG(tax_pct) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax;

-- Instructions to run the SQL code:
-- 1. Open your SQL client or database management tool (e.g., MySQL Workbench, pgAdmin, etc.).
-- 2. Connect to your database server.
-- 3. Create a new database or use an existing one.
-- 4. Open a new SQL query window.
-- 5. Copy and paste the entire content of this file into the query window.
-- 6. Execute the script to create the table and run the queries.

-- Note: Ensure you have the necessary permissions to create tables and execute queries on the database.