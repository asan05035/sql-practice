--- Provide a view that combines the details from orders, producst, customers and employees

CREATE VIEW Sales.v_order_details AS

(SELECT 
	o.OrderID,
	o.OrderDate,
	o.Sales,
	o.Quantity,
	-- o.ProductID,
	-- o.CustomerID,
	-- o.SalesPersonID,
	p.Product,
	p.Category,
	CONCAT(c.FirstName, ' ', c.LastName) CustomerName,
	c.Country AS CusomtercCountry,
	CONCAT(e.FirstName, ' ', COALESCE(e.LastName, '' )) SalesPerson,
	e.Department
FROM Sales.Orders AS o
LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID
)

SELECT *
FROM Sales.v_order_details



CREATE VIEW Sales.v_monthly_summary AS 
(
SELECT 
	DATETRUNC(month, o.OrderDate) AS month,
	SUM(o.Sales) AS totalSales,
	COUNT(o.OrderID) AS totalOrders,
	COUNT(o.Quantity) AS totalQuantities
FROM Sales.Orders AS o
GROUP BY DATETRUNC(month, o.OrderDate)

)

DROP VIEW dbo.v_monthly_summary;


-- View
-- CTE Query
SELECT 
	DATETRUNC(month, o.OrderDate) AS month,
	SUM(o.Sales) AS totalSales,
	COUNT(o.OrderID) AS totalOrders,
	COUNT(o.Quantity) AS totalQuantities
FROM Sales.Orders AS o
GROUP BY DATETRUNC(month, o.OrderDate)


CREATE VIEW v_monthly_summary AS 
(
SELECT 
	DATETRUNC(month, o.OrderDate) AS month,
	SUM(o.Sales) AS totalSales,
	COUNT(o.OrderID) AS totalOrders,
	COUNT(o.Quantity) AS totalQuantities
FROM Sales.Orders AS o
GROUP BY DATETRUNC(month, o.OrderDate)

)


SELECT *
FROM dbo.v_monthly_summary;


SELECT *,
	SUM(totalSales) OVER (ORDER BY month ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) running_total
FROM dbo.v_monthly_summary;