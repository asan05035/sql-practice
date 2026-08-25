
-- Main query 

SELECT 
	*,
	-- subquery
	(SELECT COUNT(OrderId) total_orders FROM Sales.Orders) AS total_orders
FROM Sales.Products


SELECT 
	COUNT(OrderId) total_orders
FROM Sales.Orders;



SELECT *
FROM Sales.Customers

SELECT 
	CustomerID,
	COUNT(OrderID) total_orders_each_customers
FROM Sales.Orders
GROUP BY CustomerID

-- Main query
SELECT c.*, t.total_orders_each_customers
FROM Sales.Customers AS c
LEFT JOIN ( 
			-- Subquery
			SELECT 
			CustomerID,
			COUNT(OrderID) total_orders_each_customers
			FROM Sales.Orders
			GROUP BY CustomerID) AS t
ON c.CustomerID = t.CustomerID