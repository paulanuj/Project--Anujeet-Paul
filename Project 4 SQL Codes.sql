-- Create a database to store sales data
CREATE DATABASE SalesAnalysis;

-- Create the "sales_sample" table
CREATE TABLE sales_sample (
    Product_Id INTEGER,
    Region VARCHAR(50),
    Date DATE,
    Sales_Amount NUMERIC
);

-- Insert 10 sample records into the "sales_sample" table
INSERT INTO sales_sample (Product_Id, Region, Date, Sales_Amount)
VALUES
    (1, 'East', '2023-10-01', 1000.00),
    (2, 'West', '2023-10-02', 1500.00),
    (1, 'North', '2023-10-03', 800.00),
    (3, 'East', '2023-10-04', 1200.00),
    (2, 'North', '2023-10-05', 900.00),
    (3, 'West', '2023-10-06', 1600.00),
    (1, 'North', '2023-10-07', 750.00),
    (2, 'East', '2023-10-08', 1400.00),
    (3, 'West', '2023-10-09', 1550.00),
    (1, 'East', '2023-10-10', 1050.00);

-- Drill down from region to product level
SELECT Region, Product_Id, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY Region, Product_Id;

-- Roll up from product to region level
SELECT Product_Id, Region, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY Product_Id, Region;

-- Cube to analyze sales data from multiple dimensions
SELECT Region, Product_Id, Date, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY CUBE (Region, Product_Id, Date);

-- Slice to view sales for specific combinations
SELECT Product_Id, Region, Date, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
WHERE Region = 'East' AND Product_Id = 1 AND Date = '2023-10-01'
GROUP BY Product_Id, Region, Date;

-- Dice to view sales for specific combinations of product, region, and date
SELECT Product_Id, Region, Date, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
WHERE (Product_Id = 1 OR Product_Id = 2)  -- Filter by specific products (e.g., Product 1 and Product 2)
  AND Region = 'East'                       -- Filter by a specific region (e.g., 'East')
  AND Date = '2023-10-01'                  -- Filter by a specific date (e.g., '2023-10-01')
GROUP BY Product_Id, Region, Date;


