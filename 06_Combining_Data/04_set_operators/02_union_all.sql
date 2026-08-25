-- Union_All

-- Get all entries from both queries including duplicates
SELECT 
	c.FirstName,
	c.LastName
FROM Sales.Customers AS c

UNION ALL

SELECT
	e.FirstName,
	e.LastName
FROM Sales.Employees AS e;