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
