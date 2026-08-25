
--------------------
-- ISNULL AND IS NOT NULL
---------------------


-- use_case_1: Filtering data
-- Q1: Find customers who have no scores
SELECT 
	c.*
FROM Sales.Customers AS c
WHERE c.Score IS NULL

-- Q2: Find customers who have scores

SELECT 
	c.*
FROM Sales.Customers AS c
WHERE c.Score IS NOT NULL


-----
-- use_case_2: only unmatching rows (join + null)
-- Q3: Find the customers who have not placed any orders


-------------
-- LEFT ANTI JOIN
-------------
SELECT 
	c.*,
	o.*
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL

--------------
-- INNER JOIN USING LEFT JOIN + NULL
--------------

SELECT 
	c.*,
	o.*
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS  NOT NULL
