SELECT * FROM Sales.Customers;

SELECT * FROM Sales.Orders;

-- Show the details of orders made by customers in germany

SELECT *
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
WHERE c.Country = 'Germany'

-- Main query 
SELECT *
FROM Sales.Orders 
WHERE CustomerID IN ( -- subquery
				        SELECT 
						CustomerID
						FROM Sales.Customers
						WHERE Country = 'Germany')

SELECT 
	CustomerID
FROM Sales.Customers
WHERE Country = 'Germany'