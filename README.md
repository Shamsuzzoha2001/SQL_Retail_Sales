# SQL_Retail_Sales
## Project overview
**Project titile**: Retail Sales Analysis
**Data Base** : `Retail_db`
## Objective
1.**Set up a retail database** : Create a retail database and import sales data to the table.<br>
2.**Data Cleaning**: Identify and remove null values if any exists in retail table.
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



