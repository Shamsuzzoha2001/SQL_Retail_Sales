
-- Creating a database retail_sales

CREATE DATABASE retail_sales;
USE retail_sales;

-- Created a table where data will be stored
DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);



-- Checking null values
SELECT * FROM sales
WHERE transactions_id IS NULL
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
   
   
-- Deleting null values from every field
DELETE from sales
WHERE transactions_id IS NULL
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

-- Q1. How many sales the shop has got?

SELECT COUNT(*)
FROM sales;

-- Q2 How many customers bought things from the shop ?

SELECT Count(customer_id)  
FROM sales;

-- Q3 What categories of products the shop sell to customers?

SELECT DISTINCT category 
FROM sales;
 
 -- Q4 How many sales were made on '2022-11-05' ?
 
SELECT COUNT(*)
FROM sales
WHERE sale_date = '2022-11-05';

 -- Q.3 Sales those took place in the shope for Clothing category and quantity greater than 3 in 2022 in November
SELECT *
FROM sales
WHERE category = 'Clothing'
  AND quantity > 3
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

 
 -- Q.4 Calculate the total sales in each category?
 
SELECT category, 
       SUM(total_sale)
FROM sales
GROUP BY category;

 
 -- Q.5 Find average age of customers who purchased items from beauty category?
 select  avg(age) as avg_age from sales 
 where category = 'Beauty';
 
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 SELECT category, 
       gender, 
       COUNT(*) AS total_transections
FROM sales
GROUP BY category, gender;

 
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year ?

SELECT year, 
       month, 
       avg_sale
FROM (
    SELECT YEAR(sale_date) AS year,
           MONTH(sale_date) AS month,
           AVG(total_sale) AS avg_sale,
           RANK() OVER (
               PARTITION BY YEAR(sale_date)
               ORDER BY AVG(total_sale) DESC
           ) AS rnk_salary
    FROM sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
    ORDER BY 1, 3 DESC
) AS sub
WHERE sub.rnk_salary = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

-- using window function 
SELECT sub.customer_id, 
       sub.highest_sale
FROM (
    SELECT customer_id, 
           SUM(total_sale) AS highest_sale,
           RANK() OVER w AS rnk_sale
    FROM sales
    GROUP BY customer_id
    WINDOW w AS (
        ORDER BY SUM(total_sale) DESC
    )
) AS sub
WHERE sub.rnk_sale BETWEEN 1 AND 5;


-- using only aggregate function
SELECT customer_id, sum(total_sale) as total_sale 
from sales
GROUP BY customer_id
order by total_sale desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category ?

SELECT category, 
       COUNT(DISTINCT customer_id) AS numb_of_unique_customers
FROM sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



SELECT shift, 
       COUNT(transactions_id) AS num_order
FROM (
    SELECT *, 
           CASE 
               WHEN HOUR(sale_time) <= 12 THEN 'Morning'
               WHEN HOUR(sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM sales
) AS sub
GROUP BY shift;

 
 -- with Common table expression (cte)
 WITH cte AS (
    SELECT *, 
           CASE 
               WHEN HOUR(sale_time) <= 12 THEN 'Morning'
               WHEN HOUR(sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM sales
)
SELECT shift, 
       COUNT(*) AS number_of_order
FROM cte
GROUP BY shift;
