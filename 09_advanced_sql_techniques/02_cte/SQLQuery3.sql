-- Find the last order date for each customer

--- Date exploration
-- Get the lastest and earliest date

-- CTE Query

WITH cte_total_sales AS 
(
SELECT
	o.CustomerID,
	SUM(o.Sales) totalSales
FROM Sales.Orders AS o
GROUP BY o.CustomerID
)

, cte_last_order AS (
SELECT 
		o.CustomerID,
		MAX(o.OrderDate) AS lastOrderDate
FROM Sales.Orders AS o
GROUP BY o.CustomerID
)

-- Main query 

SELECT *
FROM Sales.Customers AS c
LEFT JOIN cte_total_sales AS cts
ON c.CustomerID = cts.CustomerID
LEFT JOIN cte_last_order AS clo
ON c.CustomerID = clo.CustomerID

