SELECT * FROM sales;

SELECT
	date,
	TO_CHAR(date, 'Day') AS "day_name"
FROM sales;

ALTER TABLE sales ADD COLUMN "day_name" VARCHAR(10);
UPDATE sales
SET "day_name" = TO_CHAR(date, 'Day');