-- ========================
-- Stored Procedure Basics
-- =======================

-- Step 1: write a query
-- For US Customers find the total number of customers and the average score
SELECT 
	COUNT(*) TotalCustomers,
	AVG(COALESCE(Score, 0)) AvgScore
FROM Sales.Customers
WHERE Country = 'USA'

-- Step 2: Turning the Query into a Stored procedure

-- Define procedure
CREATE PROCEDURE GetCustomerSummary AS
BEGIN

SELECT 
	COUNT(*) TotalCustomers,
	AVG(COALESCE(Score, 0)) AvgScore
FROM Sales.Customers
WHERE Country = 'USA'

END

-- Execute procedure
EXEC GetCustomerSummary

-- =========================
-- 1. Parameters
-- =========================

/* =====
	1. Define the paramter
	2. use the paramter
	3. pass a value to paramenter when executing
-- ===== */

-- For German Customers find the total number of customers and the average score


-- Alter the existing Procedure
ALTER PROCEDURE dbo.GetCustomerSummary @Country NVARCHAR(50) = 'USA'
AS

BEGIN 

SELECT 
	COUNT(*) TotalCustomers,
	AVG(COALESCE(Score, 0)) AvgScore
FROM Sales.Customers
WHERE Country = @Country


END

-- Execute Procedure
EXEC dbo.GetCustomerSummary @Country = 'Germany'

EXEC dbo.GetCustomerSummary

-- Defining default value to parameter

-- ===================================================
--	2.Multiple statemensts
-- Doing multiple query inside stored procedure
-- ==================================================

-- Question: Find the total no. of orders and total sales

-- Alter the existing Procedure
ALTER PROCEDURE dbo.GetCustomerSummary @Country NVARCHAR(50) = 'USA'
AS

BEGIN 

SELECT 
	COUNT(*) TotalCustomers,
	AVG(COALESCE(Score, 0)) AvgScore
FROM Sales.Customers
WHERE Country = @Country;


-- Tip: add semincolon at the end of each sql statement
-- Find the total no.of orders and total sales

SELECT 
	COUNT(DISTINCT o.OrderID) TotalOrders,
	SUM(o.Sales) TotalSales
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
WHERE c.Country = @Country

END

-- Execute Procedure
EXEC dbo.GetCustomerSummary @Country = 'Germany'


/*======================== 
Date: 26 Aug 26
============================*/

-- ===============================
-- 3. Variables
-- A placeholder to hold a value

-- 4. Control flow (IF ELSE)
-- ===============================

-- Total customer from germany : 2
-- Average score of customers from germany : 425

-- Alter the existing Procedure
ALTER PROCEDURE dbo.GetCustomerSummary @Country NVARCHAR(50) = 'USA'
AS

BEGIN 

DECLARE @TotalCustomers INT, @AverageScore FLOAT;

-- Prepare and clean up
IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Country = @Country AND Score IS NULL)
BEGIN
	PRINT ('Updating NULLs to Zero');
	UPDATE Sales.Customers
		SET Score = 0
		WHERE Score IS NULL
END

ELSE
BEGIN
	PRINT ('No NULLs Found');
END;


-- Generate Report
SELECT 
	@TotalCustomers = COUNT(*),
	 @AverageScore = AVG(Score)
FROM Sales.Customers
WHERE Country = @Country;

PRINT 'Total customer from ' + @Country + ': ' + CAST(@TotalCustomers AS VARCHAR(20)) ;
PRINT 'Average score of customers from ' + @Country + ': ' + CAST(@AverageScore AS VARCHAR(20));

-- Tip: add semincolon at the end of each sql statement
-- Find the total no.of orders and total sales

SELECT 
	COUNT(DISTINCT o.OrderID) TotalOrders,
	SUM(o.Sales) TotalSales
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
WHERE c.Country = @Country

END

-- Execute Procedure
EXEC dbo.GetCustomerSummary @Country = 'USA'

-- ===================================
-- 5. Error Handling & Styling
-- ====================================

-- Alter the existing Procedure
ALTER PROCEDURE dbo.GetCustomerSummary @Country NVARCHAR(50) = 'USA'
AS

BEGIN 
	BEGIN TRY
		DECLARE @TotalCustomers INT, @AverageScore FLOAT;

		-- =====================
		-- Step 1: Prepare and clean up
		-- =====================
		IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Country = @Country AND Score IS NULL)
		BEGIN
			PRINT ('Updating NULLs to Zero');
			UPDATE Sales.Customers
				SET Score = 0
				WHERE Score IS NULL
		END

		ELSE
		BEGIN
			PRINT ('No NULLs Found');
		END;

		-- ====================
		-- Generate Report
		-- ====================
		-- Total customers And Average score for a specific country
		SELECT 
			@TotalCustomers = COUNT(*),
			 @AverageScore = AVG(Score)
		FROM Sales.Customers
		WHERE Country = @Country;

		PRINT 'Total customer from ' + @Country + ': ' + CAST(@TotalCustomers AS VARCHAR(20)) ;
		PRINT 'Average score of customers from ' + @Country + ': ' + CAST(@AverageScore AS VARCHAR(20));

		-- Tip: add semincolon at the end of each sql statement
		-- Total no.of orders and total sales For Specific country

		SELECT 
			COUNT(DISTINCT o.OrderID) TotalOrders,
			SUM(o.Sales) TotalSales
			--1/0
		FROM Sales.Orders AS o
		INNER JOIN Sales.Customers AS c
		ON o.CustomerID = c.CustomerID
		WHERE c.Country = @Country
	END TRY


	BEGIN CATCH
		-- =================
		-- Error Handling
		-- =================

		PRINT ('Error Meassage: ' + ERROR_MESSAGE());
		PRINT ('Error Number: ' + CAST(ERROR_LINE() AS NVARCHAR));
		PRINT ('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR));
		PRINT ('Error Procedure: ' + ERROR_PROCEDURE());
	END CATCH

END

EXEC dbo.GetCustomerSummary 



