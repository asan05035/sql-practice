 
 ---- CASE....WHEN
 ----
 --- use_case_3: handling nulls before aggregation\
 -----------
 
 -- Question_1: find the average score and treat nulls as 0 and provide additional details customer id, lastname
 SELECT 
	c.CustomerID,
	c.LastName,
	AVG(
	CASE 
		WHEN c.Score IS NULL THEN 0
		ELSE c.Score
	END ) OVER() AvgScore
 FROM Sales.Customers AS c


---------
---- use_case_4: Condtinal aggregation
--- applying aggregation only for the subset of data which met the condition 
--------
--- Question_2: count how many customers who made a sales greater than 30 

SELECT 
	o.CustomerID,
	-- CASE WHEN o.Sales > 30 THEN 1 ELSE 0 END SalesClean,
	SUM(CASE WHEN o.Sales > 30 THEN 1 ELSE 0 END) TotalOrdersHighSales ,
	COUNT(*) TotalOrders
FROM Sales.Orders AS o
GROUP BY o.CustomerID
ORDER BY o.CustomerID


--- step_1: Put up a biniary flag
--- step_2: summarize the binary