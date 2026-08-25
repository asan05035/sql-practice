SELECT *
FROM Sales.Products


-- Find the products that fall within the highest of 40% of the prices

SELECT *,
	CONCAT(DistRank*100, '%') DistRankPercent,
	CONCAT(PercentPrice*100, '%') PricePercent
FROM(
	SELECT *,
		CUME_DIST() OVER (ORDER BY Price DESC) DistRank,
		PERCENT_RANK() OVER (ORDER BY Price DESC) PercentPrice
	FROM Sales.Products
	) t
WHERE DistRank <= 0.4 OR PercentPrice <= 0.4

