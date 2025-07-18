# SQL_Retail_Sales
## Project overview
**Project titile**: Retail Sales Analysis <br>
**Database** : `retail_sales`
## Objective
1. **Set up a retail database** : Create a retail database and import sales data to the table.
2. **Data Cleaning**: Identify and remove null values if any exists in retail table.
3. **Exploratory Data Analysis (EDA)**: Basic EDA is conducted to understand the sale data.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.
## Project structure
### 1.Database Setup
- **Database creation**: The project starts by creating a database named `retail_sales`.
- **Table creation** : A table called `sales` is created to the sales data. The table contains columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (cogs), and total sale amount.
```sql
CREATE DATABASE retail_sales;
USE retail_sales;
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
```
### 3. Data Exploration and Cleaning
- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
```sql
SELECT count(*) FROM sales;
SELECT count(DISTINCT customer_id) FROM sales;
SELECT DISTINCT category FROM sales;

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

-- Deleting records containing null values
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

```
### 3. Exploratory Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05?**
```sql
SELECT COUNT(*)
FROM sales
WHERE sale_date = '2022-11-05';
```
2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**
```sql
SELECT *
FROM sales
WHERE category = 'Clothing'
  AND quantity > 3
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
```
3. **Write a SQL query to calculate the total sales for each category**
```sql
SELECT category, 
       SUM(total_sale)
FROM sales
GROUP BY category;
```
4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category**
```sql
 select  avg(age) as avg_age from sales 
 where category = 'Beauty';
```
5. **Write a SQL query to find all transactions where the totals ale is greater than 1000**
 ```sql
   SELECT * from sales 
 where total_sale >1000;
```
6.**Write a SQL query to find the total number of transactions made by each gender in each category**
```sql
SELECT category, 
       gender, 
       COUNT(*) AS total_transections
FROM sales
GROUP BY category, gender;
```
7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**
```sql
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
```
8. **Write a SQL query to find the top 5 customers based on the highest total sales**
```sql
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
```
9. **Write a SQL query to find the number of unique customers who purchased items from each category**
```sql
SELECT category, 
       COUNT(DISTINCT customer_id) AS numb_of_unique_customers
FROM sales
GROUP BY category;
```
10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**
```sql
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
```
### Findings
- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.
### Reports
-**Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.
## Author - Shamsuz Zoha
- **LinkedIn**: [Connect with me](https://www.linkedin.com/in/shamsuzzoha52/)

