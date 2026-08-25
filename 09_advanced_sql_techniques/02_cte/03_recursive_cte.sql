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