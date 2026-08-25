----- 
--- Aggregate functions
------

-----------------------------------
---- Q1: Total no of orders


SELECT
	o.CustomerID,
	COUNT(*) Total_nr_orders,
	SUM(o.Sales) Total_sales,
	AVG(o.Sales) Avg_sales,
	MIN(o.Sales) min_sales,
	MAX(o.Sales) max_sales
FROM Sales.Orders AS o
GROUP BY o.CustomerID

