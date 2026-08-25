IF OBJECT_ID('Sales.v_order_details_eu', 'v') IS NOT NULL
	DROP VIEW Sales.v_order_details_eu

GO
CREATE VIEW Sales.v_order_details_eu AS (
	SELECT 
		o.OrderID,
		c.CustomerID,
		c.FirstName AS CustomerName,
		c.Country,
		p.Product,
		p.Category,
		o.OrderDate,
		e.FirstName AS SalesPerson
	FROM Sales.Orders AS o
	LEFT JOIN Sales.Customers AS c
	ON o.CustomerID = c.CustomerID
	LEFT JOIN Sales.Products AS p
	ON o.ProductID = p.ProductID
	LEFT JOIN Sales.Employees AS e
	ON o.SalesPersonID = e.EmployeeID
	WHERE c.Country != 'USA'
)

SELECT * FROM Sales.v_order_details_eu;