SELECT 
	o.OrderId,
	o.ProductID,
	o.OrderDate,
	o.Sales
FROM Sales.Orders AS o

-- RANk Functions

-- Assign unique  number to each row
-- doesnt handle ties
-- leave no gaps


-- Question_1: Rank the orders nased on their sales from highest to lowest
SELECT 
	o.OrderId,
	o.ProductID,
	o.OrderDate,
	o.Sales,
	ROW_NUMBER()	OVER (ORDER BY o.Sales DESC) salesRank_row,
	RANK()			OVER (ORDER BY o.Sales DESC) salesRank_rank,
	DENSE_RANK()	OVER (ORDER BY o.Sales DESC) salesRank_denseRank
FROM Sales.Orders AS o


-- use_cases: Top-n analysis

SELECT *
FROM (
	SELECT 
		o.OrderId,
		o.ProductID,
		o.OrderDate,
		o.Sales,
		ROW_NUMBER() OVER (PARTITION BY o.ProductID ORDER BY o.Sales DESC) salesRank_row
	FROM Sales.Orders AS o ) t
	-- ORDER BY o.ProductID ) 
WHERE t.salesRank_row = 1


-- Quesyion_2 : lowest 2 customers based on their sales

SELECT *
FROM Sales.Customers



/*SELECT *,
	DENSE_RANK() OVER (ORDER BY t.CustomerSales)
FROM 
( SELECT 
	c.CustomerID,
	c.FirstName,
	o.OrderID,
	o.ProductID,
	o.OrderDate,
	o.Sales,
	COALESCE(o.Sales, 0) cleanedSales,
	SUM(COALESCE(o.Sales, 0)) OVER (PARTITION BY o.customerID) CustomerSales
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID) t
*/


-- Bottom analysis
-- find the lowest 2 customers based on their total sales
SELECT*
	FROM (
		SELECT *,
			ROW_NUMBER() OVER (ORDER BY t.totalSales ASC) salesRank_row
		FROM(
			SELECT 
				-- o.OrderID,
				o.CustomerID,
				SUM(o.Sales) totalSales
			FROM Sales.Orders AS o
			GROUP BY o.CustomerID) t ) s
WHERE salesRank_row IN (1, 2)

SELECT *
FROM
	(SELECT 
		-- o.OrderID,
		o.CustomerID,
		SUM(o.Sales) totalSales,
		ROW_NUMBER() OVER (ORDER BY SUM(o.Sales) ASC) rank_customers
	FROM Sales.Orders AS o
	GROUP BY o.CustomerID) t
WHERE t.rank_customers  IN (1, 2)


--- Use_case_3: assign unique id 
-- Assign unique id to table ordersarchive

SELECT 
	ROW_NUMBER() OVER (ORDER BY oa.OrderID ),
	*
FROM Sales.OrdersArchive AS oa



-- identify duplicate rows in the orders table & return clean without any dupliucates



-- my_try : identify duplicates
SELECT *
FROM (SELECT *,
	COUNT(*) OVER (PARTITION BY dense_rank) AS count
FROM
	(SELECT 
	oa.OrderID,
	oa.OrderStatus,
	oa.ShipAddress,
	oa.Sales,
	oa.CreationTime,
	DENSE_RANK() OVER (ORDER BY oa.OrderID) AS dense_rank
FROM Sales.OrdersArchive AS oa) t ) s
WHERE s.count > 1

SELECT *
FROM (SELECT *,
	ROW_NUMBER() OVER (PARTITION BY OrderID ORDER BY CreationTime DESC) row_duplicate
FROM Sales.OrdersArchive) t
WHERE t.row_duplicate  = 1