
-- Question: Find Customers who placed an order


-- INNER JOIN
-- Table Order is NOT important
SELECT
	c.CustomerID,
	c.FirstName,
	o.OrderID,
	o.Sales
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID