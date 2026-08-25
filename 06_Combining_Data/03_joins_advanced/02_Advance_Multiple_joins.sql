-- Joining Multiple Tables

-- Master Table 
-- Secondary Table

SELECT 
	o.OrderID,
	c.FirstName AS CustomerName,
	p.Product AS ProductName,
	p.Price AS ProductPrice,
	e.FirstName AS SalesPersonName,
	o.Sales
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c 
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p 
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e 
ON o.SalesPersonID = e.EmployeeID

