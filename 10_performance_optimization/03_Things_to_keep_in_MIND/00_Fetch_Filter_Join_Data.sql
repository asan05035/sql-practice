SELECT 
	c.CustomerID,
	o.CustomerID,
	o.SalesPersonID
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID OR c.CustomerID = o.SalesPersonID