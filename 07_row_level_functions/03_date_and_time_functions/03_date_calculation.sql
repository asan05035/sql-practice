
---------------
-- DATEADD(part, interval, date)
-- add/ subtract a specific time interval to a date
---------------

SELECT 
	o.CustomerID,
	o.OrderDate,
	o.ShipDate,
	DATEADD(year,3 ,o.ShipDate) ThreeYearsLater,
	DATEADD(year, -3, o.ShipDate) ThreeYearBefore
FROM Sales.Orders AS o

-------------
-- DATEDIFF(part, start_date, end_date)
--- find the date diff between two dates
-----------

-- Question_1: Find the current age of employees
SELECT *,
	CAST(GETDATE() AS DATE) AS CurrentDate,
	DATEDIFF(year, e.BirthDate, CAST(GETDATE() AS DATE) ) AS age
FROM Sales.Employees as e

-- Quesion_2: Find the average shipping duration in days for each month
SELECT 
	DATENAME(month, o.OrderDate) AS OrderMonth,
	AVG(DATEDIFF(day, o.OrderDate, o.ShipDate)) AvgShippingDuration
FROM Sales.Orders AS o
GROUP BY DATENAME(month, o.OrderDate)
