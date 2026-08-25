-- Find the total sales acroos all orders
-- find the total sales for each product
-- additionally provide details such as orderId, orderDate 


SELECT 
	-- o.OrderID,
	-- o.ProductID,
	SUM(o.Sales) AS totalSales
FROM Sales.Orders AS o;


SELECT 
	-- o.OrderID,
	o.ProductID,
	SUM(o.Sales) AS totalSalesEachProduct
FROM Sales.Orders AS o
GROUP BY o.ProductID;


SELECT 
	o.OrderID,
	o.ProductID,
	o.OrderDate,
	SUM(o.Sales) OVER () AS totalSales,
	SUM(o.Sales) OVER (PARTITION BY o.ProductID) SalesEachProduct
FROM Sales.Orders AS o;

-- Find the percentage contribution of each product's sales to total sales
-- Part to whole analysis
SELECT 
	o.OrderID,
	o.ProductID,
	o.OrderDate,
	SUM(o.Sales) OVER () AS totalSales,
	SUM(o.Sales) OVER (PARTITION BY o.ProductID) SalesEachProduct,
	ROUND((CAST(SUM(o.Sales) OVER (PARTITION BY o.ProductID) AS Float) / SUM(o.Sales) OVER () * 100), 2) AS PercentageContribution
FROM Sales.Orders AS o;


-- AVG() OVER ()
-- Find the average sales across all orders 
-- Find the average across each product

SELECT 
	o.OrderID,
	o.OrderDate,
	o.ProductID,
	-- SUM(COALESCE(o.Sales,0)) OVER () AS TotalSales,
	-- SUM(COALESCE(o.Sales,0)) OVER (PARTITION BY o.ProductID) AS TotalSales,
	-- COUNT(*) OVER (PARTITION BY o.ProductID) eachProdduct,
	-- CAST(SUM(COALESCE(o.Sales,0)) OVER (PARTITION BY o.ProductID) AS Float ) / COUNT(*) OVER (PARTITION BY o.ProductID) AvgSalesEachProduct,
	AVG(COALESCE(o.Sales,0)) OVER () AS AvgSales,
	AVG(COALESCE(o.Sales,0)) OVER (PARTITION BY o.ProductID) AS AvgSalesEachProduct
FROM Sales.Orders AS o;

-- Find the average score of the customers
-- additionally provide details such as customer id and last name

SELECT 
	c.CustomerID,
	c.LastName,
	c.Score,
	AVG(ISNULL(c.Score, 0)) OVER () AvgScore
FROM Sales.Customers AS c;

-- Comparision analysis
-- Find all orders where sales is higher than tha average sales across all products
SELECT *
FROM (SELECT 
	o.OrderID,
	o.ProductID,
	o.Sales,
	AVG(COALESCE(o.Sales,0)) OVER () avgSales
FROM Sales.Orders AS o) t
WHERE t.Sales > t.avgSales



--- MAX() AND MIN ()

-- Find the lowest and highest sales across all orders
-- Find the lowest and highest sales for each product
-- Additonally provide info such as productID. orderID, orderID
SELECT 
	o.OrderID,
	o.OrderDate,
	o.ProductID,
	o.Sales,
	MAX(COALESCE(o.Sales, 0)) OVER () HighestSales,
	MIN(COALESCE(o.Sales, 0)) OVER () LowestSales,
	MAX(COALESCE(o.Sales, 0)) OVER (PARTITION BY o.ProductID) HighestSalesEachProduct,
	MIN(COALESCE(o.Sales, 0)) OVER (PARTITION BY o.ProductID) LowestSalesEachProduct
FROM Sales.Orders AS o
ORDER BY o.ProductID



--- show the employees who have the hishest salary
SELECT *
FROM Sales.Employees
WHERE Salary = (SELECT 
	MAX(e.Salary) AS HighestSalary
FROM Sales.Employees AS e)

SELECT *
FROM (
	SELECT 
		*,
		MAX(e.Salary) OVER () HighestSalary
	FROM Sales.Employees AS e
	) t
WHERE t.Salary = t.HighestSalary

-- Find the the deviation of each sales from minimum and maximum of sales amounts

SELECT
	o.OrderID,
	o.OrderDate,
	o.ProductID,
	o.Sales,
	MAX(COALESCE(o.Sales, 0)) OVER () HighestSales,
	MIN(COALESCE(o.Sales, 0)) OVER () LowestSales,
	o.Sales - MIN(COALESCE(o.Sales, 0)) OVER () AS devisationFromMin,
	MAX(COALESCE(o.Sales, 0)) OVER () - o.Sales AS deviationFromMax
FROM Sales.Orders AS o


--- Calculate the moving average of each product over time

SELECT 
	o.OrderID,
	o.OrderDate,
	o.ProductID,
	o.Sales,
	AVG(COALESCE(o.Sales, 0)) OVER (PARTITION BY o.ProductID ORDER BY OrderDate ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) MovingAverageOverTime
FROM Sales.Orders AS o


--- Calculate the moving average of each product over time including only the next order

SELECT 
	o.OrderID,
	o.OrderDate,
	o.ProductID,
	o.Sales,
	AVG(COALESCE(o.Sales, 0)) OVER (PARTITION BY o.ProductID ORDER BY OrderDate ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) MovingAverageOverTime,
	AVG(COALESCE(o.Sales, 0)) OVER (PARTITION BY o.ProductID ORDER BY OrderDate ASC ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAverageOnFixedWindow
FROM Sales.Orders AS o