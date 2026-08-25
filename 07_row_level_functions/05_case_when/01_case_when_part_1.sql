
--- CASE WHEN



--- use_case_1: Data Transformation ;; Data categorization


---------------
-- Generate the report total sales
---- Categorize High if sales > 50, Medium if sales > 20, otherwise Low
---- Sort the total sales from lowest to highest



SELECT 
	t.Category,
	SUM(t.Sales) AS totalSales
FROM (SELECT 
	o.OrderID,
	o.Sales,
	CASE 
		WHEN o.Sales > 50 THEN 'High'
		WHEN o.Sales >= 20 AND o.Sales <= 50 THEN 'Medium'
		ELSE 'Low'
	END AS Category
FROM Sales.Orders AS o) t
GROUP BY t.Category
ORDER BY totalSales DESC

----------------------
--- Use_case_2: Mapping 
-- Transform from one value to another value


SELECT *,
CASE 
	WHEN TRIM(Gender) = 'M' THEN 'Male'
	WHEN TRIM(Gender) = 'F' THEN 'Female'
	ELSE 'N/A'
END AS MappedGender
FROM Sales.Employees;

-----------------
-- Retreive customer details with abbreiviated country code
-----------------
SELECT *,
CASE
	WHEN Country = 'Germany' THEN 'DE'
	WHEN Country = 'USA' THEN 'US'
	ELSE 'N/A'
END AS Country_codes
FROM Sales.Customers;