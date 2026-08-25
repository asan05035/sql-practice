
-- Question: Find Customers who placed an order including those without orders


-- LEFT JOIN
-- Table Order is  important
SELECT
	c.CustomerID,
	c.FirstName,
	o.OrderID,
	o.Sales
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID