
----ISNULL VS COALESCE Function

-- Use_case_1: Prepare the data before Data Aggregation
-- Q1: Find the Average score of the customers


-- ISNULL( value, replacement_value) 
-------- Replace the null value with a specific value
SELECT 
	AVG(ISNULL(Score, 0)) AvgScore
FROM Sales.Customers AS c;

-- COALESCE(value1, value2, value3....)
-------- Returns the first non null value from the list

SELECT
	AVG(COALESCE(c.Score, 0)) AvgScore
FROM Sales.Customers AS c

--- Use_case_2: Handle null before mathematical operations

-- Q2: Display FULLNAME of the customers by merging their first and last name
--- Add 10 to their score as bonus

SELECT 
	c.FirstName,
	c.LastName,
	CONCAT(TRIM(c.FirstName),' ' ,COALESCE(TRIM(c.LastName), '')) AS FullName,
	c.Score, 
	ISNULL(c.Score, 0) + 10 AS Score_with_bonus_10
FROM Sales.Customers AS c;


-- use_case_3: Handle NULLS before joininf the tables

-- use_case_4: Handle the NULLS before sorting the data
-- Q3: Sort the customers score with nulls appearing last

----- method_1: replace null with large value
SELECT *	
FROM Sales.Customers
ORDER BY COALESCE(Score,1000000) ASC;

-- method_2: use flag and then nested sorting
SELECT *,
	CASE WHEN Score IS NULL THEN 1 ELSE 0 END AS flag
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END ASC, Score ASC

SELECT *,
	CASE WHEN Score IS NULL THEN 0 ELSE 1 END AS flag
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 0 ELSE 1 END DESC, Score DESC
