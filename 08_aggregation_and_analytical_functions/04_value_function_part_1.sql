 SELECT *
 FROM Sales.Orders


-- Time series analysis

-- Question_1
-- Analyze the month over month performance by finding the percentage change
-- in the sales betwen current month and previous month

SELECT *, 
	LAG(t.totalSales, 1, 0) OVER (ORDER BY t.CurrentMonth ASC) AS previousMonth,
	ROUND(((CAST(t.totalSales AS FLOAT) / NULLIF(LAG(t.totalSales, 1, 0) OVER (ORDER BY t.CurrentMonth ASC), 0)) - 1) * 100, 2) 
FROM (
	SELECT 
		MONTH(o.OrderDate) AS CurrentMonth,
		SUM(o.Sales) AS totalSales
	FROM Sales.Orders AS o
	GROUP BY MONTH(o.OrderDate)
	--ORDER BY MONTH(o.OrderDate)
) t
-- ORDER BY MONTH(o.OrderDate)
SELECT *,
	t.currentSales - t.previousMonthSales AS MoM_Change,
	ROUND(CAST(t.currentSales - t.previousMonthSales AS Float) / t.previousMonthSales * 100, 2) MoM_percentChange
FROM (
	SELECT 
		MONTH(o.OrderDate) Month,
		SUM(o.Sales) currentSales,
		-- LAG(SUM(o.Sales))
		LAG(SUM(o.Sales)) OVER (ORDER BY MONTH(o.OrderDate)) previousMonthSales
	FROM Sales.Orders AS o
	GROUP BY MONTH(o.OrderDate)
	) t


SELECT 
	MONTH(o.OrderDate) Month,
	SUM(o.Sales) totalSales,
	SUM(SUM(o.Sales)) OVER (ORDER BY MONTH(o.OrderDate) ASC) RunningTotalMonth
FROM Sales.Orders AS o

-- Time series analysis
-- Customer retention analysis

-- Question_2 
-- in order to analyze the customer loyalty
-- rank customers based on the avrage days bewteen the orders
GROUP BY MONTH(o.OrderDate)

SELECT 
	t.CustomerID,
	AVG(t.DaysBetweenOrders) AvgOrderDate,
	-- CASE WHEN AVG(t.DaysBetweenOrders) IS NULL THEN 1 ELSE 0 END AS SortingFlag,
	RANK() OVER (ORDER BY CASE WHEN AVG(t.DaysBetweenOrders) IS NULL THEN 1 ELSE 0 END ASC, AVG(t.DaysBetweenOrders)ASC) RankBasedOnAvgOrderDate
FROM (
	SELECT 
		o.CustomerID,
		o.OrderDate,
		LEAD(OrderDate, 1) OVER (PARTITION BY CustomerID ORDER BY OrderDate ASC) NextOrderDate,
		DATEDIFF(DAY,o.OrderDate, LEAD(OrderDate, 1) OVER (PARTITION BY CustomerID ORDER BY OrderDate ASC)) DaysBetweenOrders
	 FROM Sales.Orders AS o
	 -- ORDER BY CustomerID
	 ) t
GROUP BY t.CustomerID
