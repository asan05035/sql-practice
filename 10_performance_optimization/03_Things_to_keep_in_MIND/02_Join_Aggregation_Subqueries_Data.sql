 -- ====================
 -- Aggregation
 -- =====================

 -- 1. Use columnstore index on a large table for aggregation
 CREATE CLUSTERED COLUMNSTORE INDEX idx_SalesOrders_Columnstore ON Sales.Orders 

 SELECT 
 	c.CustomerID AS CustomerId,
	c.FirstName AS CustomerName,	
	COUNT(o.OrderID) total_orders,
	SUM(o.Sales) total_sales,
	SUM(o.Quantity) total_quantities
 FROM Sales.Orders AS o
 LEFT JOIN Sales.Customers AS c
 ON o.CustomerID = c.CustomerID
 GROUP BY  	c.CustomerID, c.FirstName

 -- 2. Pre-aggraegated data should be stored in new table for reporting
  SELECT 
 	c.CustomerID AS CustomerId,
	c.FirstName AS CustomerName,	
	COUNT(o.OrderID) AS total_orders,
	SUM(o.Sales) AS total_sales,
	SUM(o.Quantity) AS total_quantities
INTO  #SalesSummary
 FROM Sales.Orders AS o
 LEFT JOIN Sales.Customers AS c
 ON o.CustomerID = c.CustomerID
 GROUP BY  	c.CustomerID, c.FirstName



 -- ==========================
 -- Subqueries
 -- ===========================


 -- ====================================
 -- 1. JOIN VS EXISTS VS IN
 -- ====================================

  -- 2. Pre-aggraegated data should be stored in new table for reporting

  -- JOIN (Best practice if performace equals to exists)
 SELECT 
	o.OrderID,
	o.OrderStatus

FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA'

-- Best practice (use it for large tables)
 SELECT 
	o.OrderID,
	o.OrderStatus
FROM Sales.Orders AS o
WHERE EXISTS (SELECT 1
			FROM Sales.Customers AS c
			WHERE c.CustomerID = o.CustomerID AND c.Country = 'USA')

-- Bad practice
 SELECT 
	o.OrderID,
	o.OrderStatus
FROM Sales.Orders AS o
WHERE o.CustomerID IN (SELECT c.CustomerID
			FROM Sales.Customers AS c
			WHERE c.Country = 'USA')
-- ==================================
-- 2. Avoid Redundant logic
-- ===================================

-- Bad practice
SELECT *, 'BelowAverage' AS ScoreSegmentation
FROM Sales.Customers AS c
WHERE c.Score < (SELECT AVG(COALESCE(Score, 0)) FROM Sales.Customers)

UNION ALL

SELECT *, 'AboveAverage'
FROM Sales.Customers AS c
WHERE c.Score > (SELECT AVG(COALESCE(Score, 0)) FROM Sales.Customers)

-- Best Practice
SELECT *,
	CASE 
		WHEN Score > AVG(Score) OVER () THEN 'Above Average'
		WHEN Score < AVG(Score) OVER () THEN 'Below Average'
	END AS ScoreSegmentation
FROM Sales.Customers AS c

