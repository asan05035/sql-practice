/* -----------------------------------------------------
-- Best practices for Query performance optimization by BaaraSalkini
		- Filtering Data
		- Fetching Data
-------------------------------------------------------- */


 
-- ===============
-- Filtering Data
-- ===============

/*--------------------------------
-- Tip 1: Select Only what you need
----------------------------------*/

-- Bad practice
SELECT * FROM Sales.Customers

-- Good practice 
SELECT c.CustomerID, c.FirstName FROM Sales.Customers AS c


/*--------------------------------
-- Tip 2: Avoid unnecessary DISTINCT and ORDER BY
-- DISTINCT and ORDER BY is really expensive 
-- Was columnn realyy needed distinct
----------------------------------*/


-- Bad practice
SELECT	DISTINCT c.FirstName FROM Sales.Customers AS c ORDER BY c.FirstName ASC

-- Good practice 
SELECT	c.FirstName FROM Sales.Customers AS c


/*--------------------------------
-- Tip 3: For exploration purpose always limit rows
----------------------------------*/

-- Bad practice
SELECT	c.CustomerID, .FirstName FROM Sales.Customers AS c

-- Good practice 
SELECT	TOP 10 c.CustomerID, c.FirstName FROM Sales.Customers AS c


-- ===============
-- Filtering Data
-- ===============


/*--------------------------------
-- Tip 1: Create Non Clustered index on the frequently used columns in WHERE Clause
------------------------*/

-- Bad practice
SELECT	o.OrderID,
	o.OrderStatus
FROM Sales.Orders AS o
WHERE o.OrderStatus = 'Delivered'

-- Good practice 
CREATE NONCLUSTERED INDEX idx_Orders_OrderStatus ON Sales.Orders(OrderStatus)
SELECT	o.OrderID,
	o.OrderStatus
FROM Sales.Orders AS o
WHERE o.OrderStatus = 'Delivered'


/*--------------------------------
-- Tip 2: Avoid applying the function to columns in WHERE Clause
-- Function can block index usage
------------------------*/
SELECT	o.OrderID,
	o.OrderStatus
FROM Sales.Orders AS o
WHERE LOWER(o.OrderStatus) = 'delivered'

-- Example 2

-- Bad practice
SELECT	c.FirstName FROM Sales.Customers AS c WHERE SUBSTRING(c.FirstName, 2, 1) = 'a'

-- Good practice
SELECT	c.FirstName FROM Sales.Customers AS c WHERE c.FirstName LIKE '_a%'

-- Example 3
-- Bad practice
SELECT	o.OrderID,
	o.OrderStatus,
	o.OrderDate
FROM Sales.Orders AS o
WHERE YEAR(o.OrderDate) = 2025

-- Good practice
SELECT	o.OrderID,
	o.OrderStatus,
	o.OrderDate
FROM Sales.Orders AS o
WHERE o.OrderDate BETWEEN '2025-01-01' AND '2025-12-31'


/*--------------------------------
-- Tip 3: Avoid using leading wildcard as they prevent index usage 
------------------------*/

-- Bad parctice
SELECT	c.FirstName FROM Sales.Customers AS c WHERE c.FirstName LIKE '%M%'

-- Good practice
SELECT	c.FirstName FROM Sales.Customers AS c WHERE c.FirstName LIKE 'M%'

/*--------------------------------
-- Tip 4: Use IN instead of OR Operator
------------------------*/

-- Bad parctice
SELECT	c.CustomerID FROM Sales.Customers AS c WHERE c.CustomerID = 1 OR c.CustomerID = 2

-- Good practice
SELECT	c.CustomerID FROM Sales.Customers AS c WHERE c.CustomerID IN (1, 2)


-- ===============
-- Joining Data
-- ===============

/*--------------------------------
-- Tip 1: Understand the speed of joins and use INNER JOIN whenever possible 
-- Keep in MIND, INNER JOIN filters Data
------------------------*/

-- Best perfomrmnace 
SELECT *
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID

-- Slightly best performance
SELECT *
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID

-- Worst Performance
SELECT *
FROM Sales.Customers AS c
FULL JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID

/*--------------------------------
-- Tip 2: Use explicit JOIN (ANSI JOIN) instead of Implicit JOIN (NON ANSI JOIN)
------------------------*/

-- Bad practice

-- Poor readability
-- Risk of making cartesian joins

SELECT *
FROM Sales.Customers AS c,Sales.Orders AS o
WHERE c.CustomerID = o.CustomerID

-- Good practice
SELECT *
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID


/*--------------------------------
-- Tip 3: Make sure to use Index in the colums used in the ON Cluase
------------------------*/

SELECT *
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID

CREATE NONCLUSTERED INDEX idx_Sales_Customers ON Sales.Customers (CustomerID)

/*--------------------------------
-- Tip 4: Filter before joining
-- Try to isolate the preparation step in CTE OR Subquery
------------------------*/

-- 1. Filter After Join (WHERE)
-- For small, medium tables
SELECT *
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Delivered'

-- 2. Filter During Join (ON)
SELECT *
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
AND o.OrderStatus = 'Delivered'

-- 3. Filter BEFORE Join (Subquery)
-- For Large tables
SELECT *
FROM Sales.Customers AS c
INNER JOIN (SELECT * FROM Sales.Orders AS o WHERE o.OrderStatus = 'Delivered')t
ON c.CustomerID = t.CustomerID



/*--------------------------------
-- Tip 6: Use union instead of or in JOINS
------------------------*/

-- Bad Practice
SELECT *
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID OR c.CustomerID = o.SalesPersonID



-- Best Practice
SELECT *
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID

UNION

SELECT *
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.SalesPersonID


/*--------------------------------
-- Tip 7: Check for nested loops and use sql hints
------------------------*/


SELECT *
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.SalesPersonID
OPTION (HASH JOIN)


/*--------------------------------
-- Tip 8: Use UNION ALL instead of UNION || If the dupliactes are acceptable
------------------------*/

-- Bad Practice
SELECT CustomerID
FROM Sales.Orders

UNION

SELECT CustomerID
FROM Sales.OrdersArchive


-- Best Practice
SELECT CustomerID
FROM Sales.Orders

UNION ALL

SELECT CustomerID
FROM Sales.OrdersArchive



/*--------------------------------
-- Tip 8: Use UNION ALL + DISTINCT instead of UNION || If the dupliactes are NOT acceptable
------------------------*/

-- Best Practice

SELECT DISTINCT t.CustomerID
FROM (
		SELECT CustomerID
		FROM Sales.Orders

		UNION ALL

		SELECT CustomerID
		FROM Sales.OrdersArchive ) t
