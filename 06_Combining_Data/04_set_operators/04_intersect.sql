--Intersect

--Return common rows from both queries
SELECT 
	c.FirstName,
	c.LastName
FROM Sales.Customers AS c

INTERSECT

SELECT
	e.FirstName,
	e.LastName
FROM Sales.Employees AS e;