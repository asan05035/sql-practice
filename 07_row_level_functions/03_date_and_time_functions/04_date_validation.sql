


-----------------
-- ISDATE(value) Return 1 if the string value is date
-----------------


----
---- Data quality check
--------


SELECT 
	t.OrderDate,
	ISDATE(t.OrderDate),
	CASE
		WHEN ISDATE(t.OrderDate) = 1 THEN CAST(t.OrderDate AS DATE) ELSE NULL
		END AS NewOrderDate

FROM (SELECT '2025-08-25' AS OrderDate
UNION
SELECT '2026-07-23'
UNION
SELECT '2023-10-18'
UNION
SELECT '2027-09') t

-- WHERE t.OrderDate = 0


