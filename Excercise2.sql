-- Exercise 2: Highest-Spending Customers
-- Objective: Identify the most valuable customers.

-- 🔹 Query:
-- List the top 10 customers with the highest total spending, along with the number of purchases they made.

-- Key Tables:
    -- FactSales (sales)
    -- DimCustomer (customers)

SELECT 
    di.FirstName, 
    di.LastName, 
    SUM(fa.SalesAmount) AS total_sales
FROM FactSales fa
JOIN DimCustomer di ON fa.CustomerKey = di.CustomerKey
GROUP BY di.FirstName, di.LastName
ORDER BY total_sales DESC
LIMIT 10;
