-- Rank customers based on total sales per customer


WITH CTE_total_sales AS (
	SELECT 
		o.CustomerID,
		SUM(o.Sales) TotalSales
	FROM Sales.Orders AS o
	GROUP BY o.CustomerID
)
,
CTE_last_order AS (
SELECT 
	o.CustomerID,
	MAX(o.OrderDate) lastOrderDate
FROM Sales.Orders AS o
GROUP BY o.CustomerID
)

,CTE_Rank_sales AS 
(
	SELECT *,
	RANK() OVER (ORDER BY TotalSales DESC) RankSales
	FROM CTE_total_sales AS cts

)

-- SELECT * FROM CTE_Rank_sales

-- Segments the each customer based on their sales
, CTE_Segments AS (
		SELECT 
			CustomerID,
			CASE
				WHEN TotalSales > 100 THEN 'High'
				WHEN TotalSales > 50 THEN 'Medium'
				ELSE 'Low'
			END AS customerSegment
		FROM CTE_total_sales
)

-- SELECT * FROM CTE_Segments

-- Main query

SELECT c.*, cts.TotalSales,
	cto.lastOrderDate, crs.RankSales,
	cs.customerSegment
FROM Sales.Customers AS c
LEFT JOIN CTE_total_sales AS cts
ON c.CustomerID = cts.CustomerID
LEFT JOIN CTE_last_order AS cto
ON c.CustomerID = cto.CustomerID
LEFT JOIN CTE_Rank_sales AS crs
ON c.CustomerID = crs.CustomerID 
LEFT JOIN CTE_Segments AS cs
ON c.CustomerID = cs.CustomerID

/* My_solution

SELECT *
FROM Sales.Customers AS c
LEFT JOIN (
SELECT 
	o.CustomerID,
	SUM(o.Sales) TotalSales,
	RANK() OVER (ORDER BY SUM(o.Sales) DESC) RankSales
FROM Sales.Orders AS o
GROUP BY o.CustomerID
)t
ON c.CustomerID = t.CustomerID

*/


