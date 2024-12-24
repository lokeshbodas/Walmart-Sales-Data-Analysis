SELECT
    time,
    (CASE
        WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN time BETWEEN '12:00:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END) AS time_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(50);
UPDATE sales SET time_of_day = (
CASE 
	WHEN time BETWEEN '00:00:00' AND '12:59:59' THEN 'Morning'
        WHEN time BETWEEN '12:00:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
END);

SELECT
	date,
	TO_CHAR(date, 'Day') as day_name
FROM sales;