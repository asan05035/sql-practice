 
-- standalone cte
-- defined and used indenpendemtluy

-- Find the total sales per customer
-- Measure Exploration
-- Find the key metric of business
 
 SELECT 
	SUM(o.Sales) totalSales
 FROM Sales.Orders AS o;

 -- Magnitude analysis 
 -- Measure by dimension
 SELECT
	o.CustomerID,
	SUM(o.Sales) totalSales
FROM Sales.Orders AS o
GROUP BY o.CustomerID;

WITH cte_total_sales AS 
(
SELECT
	o.CustomerID,
	SUM(o.Sales) totalSales
FROM Sales.Orders AS o
GROUP BY o.CustomerID
)

-- Main Query
SELECT 
	c.CustomerID,
	c.FirstName,
	c.Country,
	cts.totalSales
FROM Sales.Customers AS c
LEFT JOIN cte_total_sales AS cts
ON c.CustomerID = cts.CustomerID;