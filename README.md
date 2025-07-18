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

