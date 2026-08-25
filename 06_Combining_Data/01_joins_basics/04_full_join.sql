-- Question: Find all customers and all orders even if there is no match


-- FULL JOIN
-- Table Order is NOT important
SELECT
	c.CustomerID,
	c.FirstName,
	o.OrderID,
	o.Sales
FROM Sales.Customers AS c
FULL JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID