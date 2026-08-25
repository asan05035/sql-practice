

-- Find the lowest and highest sales for each product


-- FIRST_VALUE() 
-- Access the value from the first row winthin the window

-- LAST_VALUE()
-- Access the value from last last row within the window

-- Question: Find the lowest and highest sales each product

SELECT 
	o.OrderID,
	o.CustomerID,
	o.ProductID,
	o.Sales,
	FIRST_VALUE(o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.Sales) LowestSalesEachProduct,
	LAST_VALUE(o.Sales) OVER (PARTITION BY o.ProductID 
								ORDER BY o.Sales 
								ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSalesEachProduct,
	FIRST_VALUE(o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.Sales DESC) HighestSalesEachProduct_2,
	MIN(o.Sales) OVER (PARTITION BY o.ProductID) lowestSalesMIN,
	MAX(o.Sales) OVER (PARTITION BY o.ProductID) highestSalesMax 

FROM Sales.Orders AS o
-- ORDER BY o.ProductID, o.Sales


-- Comparison analysis 
-- comparision to extremes

-- Question: Find the deviation of each sales from lowest sales
SELECT 
	o.OrderID,
	o.CustomerID,
	o.ProductID,
	o.Sales,
	FIRST_VALUE(o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.Sales) LowestSalesEachProduct,
	o.Sales - FIRST_VALUE(o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.Sales) DeviationFromLowestSales,
	FIRST_VALUE(o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.Sales DESC) HighestSalesEachProduct,
	FIRST_VALUE(o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.Sales DESC) - o.Sales DeviationFromHighestSales
FROM Sales.Orders AS o