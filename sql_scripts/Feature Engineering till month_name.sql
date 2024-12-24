SELECT * from sales;

SELECT
	date,
	TO_CHAR(date, 'Month') as month_name
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales
SET day_name = TO_CHAR(date, 'Month');