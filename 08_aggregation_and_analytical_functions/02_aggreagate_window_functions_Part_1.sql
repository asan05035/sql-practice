
--- Window Function Basics

  SELECT 
	o.OrderID,
	o.ProductID,
	o.OrderDate,
	o.Sales,
	o.OrderStatus,
	SUM(o.Sales) OVER () total_sales,
	SUM(o.Sales) OVER (PARTITION BY o.ProductID) totalSalesEachProduct,
	SUM(o.Sales) OVER (PARTITION BY o.ProductID, o.OrderStatus) 
  FROM Sales.Orders AS o;


  SELECT *
  FROM Sales.Orders


SELECT 
	o.CustomerID,
	o.Sales,
	SUM(o.Sales) OVER (PARTITION BY o.CustomerID) SalesPerCustomer
FROM Sales.Orders AS o


-- Rank each order based on their sales from highest to lowest
-- Additionally provode details susch as order id , order date

SELECT 
	o.OrderID,
	o.OrderDate,
	o.Sales,
	RANK() OVER (ORDER BY o.Sales DESC) SalesRank
FROM Sales.Orders AS o

-- Rank cusomter based on their sales *********

SELECT 
	o.CustomerID,
	SUM(o.Sales) SalesPerCustomer,
	RANK() OVER (ORDER BY SUM(o.Sales) DESC) RankBasedOnSales
FROM Sales.Orders AS o
GROUP BY o.CustomerID

-----
----- Aggregate window functions


SELECT *
FROM Sales.Orders;

--- Task_1: Find the total number of orders for each product

--- Way_1: simple aggregation using group by (losing information)


SELECT 
	-- o.OrderID,
	o.ProductID,
	COUNT(*) OrdersEachProduct
	-- o.Sales
FROM Sales.Orders AS o
GROUP BY o.ProductID;

--- way_2: aggregate window functions ( without losing information)
SELECT 
	o.OrderID,
	o.ProductID,
	COUNT(*) OVER (PARTITION BY o.ProductID) OrdersEachProduct,
	 o.Sales
FROM Sales.Orders AS o
-- GROUP BY o.ProductID;


SELECT *
FROM Sales.Products

-- Find the total no of order
-- Find the total orders for each customers
-- Additional details orderid, order date

SELECT
	o.OrderID,
	o.OrderDate,
	o.CustomerID,
	COUNT(*) OVER () AS TotalOrders,
	COUNT(*) OVER (PARTITION BY o.CustomerID) AS OrdersPerCustomer
FROM Sales.Orders AS o

SELECT *
FROM Sales.Orders AS o


-- Find the total number of customers
-- Find the total number of scores for customers
-- additional details about customers

SELECT *,
	COUNT(1) OVER () totalCustomers,
	COUNT(c.Score) OVER () total_nr_of_score
FROM Sales.Customers AS c

--- Find whether the orders table has any duplicate rows
SELECT *

FROM (SELECT 
	OrderID,
	COUNT(*) OVER (PARTITION BY OrderID) checkPK
FROM Sales.OrdersArchive) t
WHERE checkPK > 1


--- COUNT
-- Overall analysis
-- category analysis
-- identify nulls
-- identigy duplicate