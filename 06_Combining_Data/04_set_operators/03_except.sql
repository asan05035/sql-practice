--Except

--Get distinch rows from the first query
SELECT 
	c.FirstName,
	c.LastName
FROM Sales.Customers AS c

EXCEPT

SELECT
	e.FirstName,
	e.LastName
FROM Sales.Employees AS e;