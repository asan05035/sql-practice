

-- Three ways of how DateTime Appear

SELECT 
	o.OrderID,
	'2025-07-05' AS HardCoded,
	GETDATE() Today,
	o.CreationTime
FROM Sales.Orders AS o

-- Basic Date Functions
-- DATEPART(part, date) and DATENAME(part, date) Functions

SELECT
	o.CustomerID,
	o.CreationTime,
	--DATENAME(PART, DATE) -- MONTH, WEEKDAY --USEFUL FOR REPORT ANALYSIS

	DATENAME(month, o.CreationTime) Month,
	DATENAME(weekday, o.CreationTime) AS weekday, 

	--Datepart(part, date) --week, quarter

	DATEPART(week, o.CreationTime) AS week,
	DATEPART(quarter, o.CreationTime) AS quarter,

	-- Basic_Date_time_functions

	DAY(o.CreationTime) AS Day,
	MONTH(o.CreationTime) AS Month,
	YEAR(o.CreationTime) AS Year
FROM Sales.Orders AS o



-- Part extraction: 

-- Uses cases 1: Report Sales analysisi by month
-- Question_1: How many orders placed each year

SELECT
	YEAR(o.CreationTime) AS Year,
	COUNT(*) OrdersPlaced
FROM Sales.Orders AS o
GROUP BY YEAR(o.CreationTime)

-- Question_2: How many orders placed each month

SELECT
	-- MONTH(o.CreationTime) AS Month,
	DATENAME(month, o.CreationTime) AS Month,
	COUNT(*) OrdersPlaced
FROM Sales.Orders AS o
GROUP BY DATENAME(month, o.CreationTime)

-- uses_case_2: Filtering data by month

-- Question_3: Show all orders that were placed during the month of february
-- Filtering data using integer is faster than string

SELECT *
FROM Sales.Orders AS o
WHERE MONTH(o.OrderDate) = 2;



-- DATETRUNC(part, date)

--- How many orders placed monthwise
---- Datepart reset to 01, Time part reset to 00

SELECT 
	DATENAME(month, DATETRUNC(month, o.CreationTime)) AS Month,
	COUNT(*) OrdersPlaced
FROM Sales.Orders AS o
GROUP BY DATENAME(month, DATETRUNC(month, o.CreationTime))





-- E0MONTH(date)

SELECT 
	o.CreationTime,
	EOMONTH(o.CreationTime) EndOfMonth,
	CAST(DATETRUNC(month, o.CreationTime) AS DATE) StartOfMonth

FROM Sales.Orders AS o