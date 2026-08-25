
-- Subquery
-- Query inside another query



-- Question_1
/* Find the products that have a price 
	higher than the average price of all products */

-- Subquery in from :: act as a temporary table for main query

-- Main query
SELECT *
FROM (
	-- subquery
	SELECT *,
		AVG(Price) OVER () AvgPrice
	FROM Sales.Products ) t
WHERE t.Price > t.AvgPrice

-- Way_2: Subquery in WHERE Comparision
SELECT 
	AVG(Price) AvgPrice
FROM Sales.Products

SELECT *
FROM Sales.Products
WHERE Price > ( -- subquery
				SELECT 
				AVG(Price) AvgPrice
				FROM Sales.Products)


-- Question_2
-- Rank customers based on their total amount of sales

-- Main query 
SELECT *,
	RANK() OVER (ORDER BY totalSales DESC) rankSales
FROM(
	-- Subquery
	SELECT 
		o.CustomerID,
		-- o.OrderID,
		-- o.OrderDate,
		SUM(o.Sales) totalSales
	FROM Sales.Orders AS o
	GROUP BY o.CustomerID) t