
-------------
-- NULLIF(value1, value2)
-------------

-- compare two values value1 and value2 if it is equal then NULL else value1

-- Use_case

-------------------------
-- Avoiding division by ZERO error
------------------------
SELECT 
	o.OrderID,
	o.Sales,
	o.Quantity,
	-- o.Sales/o.Quantity AS salesPrice,
	o.sales / NULLIF(o.Quantity,0) AS SalesPrice
FROM Sales.Orders AS o;