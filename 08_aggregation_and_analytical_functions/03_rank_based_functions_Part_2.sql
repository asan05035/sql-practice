
-- NTILE()

-- Divide the entire dataset into approz equalized group or buckets

SELECT 
	o.OrderID,
	o.ProductID,
	o.OrderDate,
	o.Sales,
	NTILE(1) OVER (ORDER BY o.Sales) AS oneBucket,
	NTILE(2) OVER (ORDER BY o.Sales) AS twoBucket,
	NTILE(3) OVER (ORDER BY o.Sales) AS threeBucket,
	NTILE(4) OVER (ORDER BY o.Sales) AS fourBucket
FROM Sales.Orders AS o

-- Data segmention :: Data anlyst use_case
-- Divide the entire dataset into speicic subset based on certain conditin


-- segment all orders into high, low, medium
SELECT *,
CASE
	WHEN t.threeBucket = 1 THEN 'High'
	WHEN t.threeBucket = 2 THEN 'Medium'
	ELSE 'Low'
END AS segemented_bucket

FROM (
	SELECT 
		o.OrderID,
		o.ProductID,
		o.OrderDate,
		o.Sales,
		NTILE(3) OVER (ORDER BY o.Sales DESC) AS threeBucket
	FROM Sales.Orders AS o
) t



-- Equalized load processing :: Data engineer

-- In order to export the data, divide the order table into 2 groups

SELECT 
	o.OrderID,
	o.ProductID,
	o.OrderDate,
	o.Sales,
	NTILE(3) OVER (ORDER BY o.OrderID) AS twoBucket
FROM Sales.Orders AS o