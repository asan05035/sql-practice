
-- Show all details of customer and find the total orders for each customer

-- Magnitude analysis 
-- measure value by dimension
SELECT 
	o.CustomerID,
	COUNT(o.OrderID) totalOrders
FROM Sales.Orders  AS o
GROUP BY o.CustomerID;

-- Join Subquery
-- used to prepare date before combining

-- Main query
SELECT c.*,
		o.totalOrders
FROM Sales.Customers AS c
LEFT JOIN ( -- Suquery 
			-- Non correlated subquery
			-- subquery that runs independently from the main query
			SELECT 
			o.CustomerID,
			COUNT(o.OrderID) totalOrders
			FROM Sales.Orders  AS o
			GROUP BY o.CustomerID) AS o
ON c.CustomerID = o.CustomerID



 SELECT *,
	 -- (SELECT COUNT(*) FROM Sales.Orders AS o) AS totalOrders,
	 -- (SELECT o.CustomerID ,COUNT(*) AS totalOrders FROM Sales.Orders AS o GROUP BY o.CustomerID)
	  (SELECT COUNT(*) FROM Sales.Orders AS o WHERE o.CustomerID = c.CustomerID) AS totalOrders 
 FROM Sales.Customers AS c;
		
 SELECT o.CustomerID ,COUNT(*) AS totalOrders FROM Sales.Orders AS o GROUP BY o.CustomerID


 SELECT * FROM Sales.Orders;

 SELECT * FROM Sales.Customers;

 SELECT CustomerID
 FROM Sales.Customers
 WHERE Country = 'Germany'

 -- Filering rows ---> WHERE Clause

 -- Main query
 SELECT * FROM Sales.Orders
 WHERE CustomerID IN (  --- Subquery
						 SELECT CustomerID
						 FROM Sales.Customers
						 WHERE Country = 'Germany')


SELECT *
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID 
WHERE c.Country = 'Germany'


SELECT *
FROM Sales.Orders AS o
WHERE EXISTS (	-- correlated subquery
				SELECT 1
				FROM Sales.Customers AS c
				WHERE c.CustomerID = o.CustomerID AND c.Country = 'Germany'
				)



 SELECT * FROM Sales.Orders;

 SELECT * FROM Sales.Customers;
