WITH Orders AS (

SELECT 1 AS Id,
	'A' AS  Category
UNION
SELECT
	2 ,
	NULL
UNION
SELECT 
	3,
	''
UNION
SELECT 
	4,
	'    '
)
SELECT *,
	DATALENGTH(Category) DataLength,

	--- Policy_1: Only null and empty string is allowed
	TRIM(Category) AS Policy1,
	DATALENGTH(TRIM(Category)) AS Policy1_Length,

	--- Policy_2: Only null are allowed
	NULLIF(TRIM(Category),'') Policy2,

	--- Policy_3: use default value 'N/A' no null, empty space, blank space allowed
	COALESCE(NULLIF(TRIM(Category), ''),'N/A') Policy3,
	ISNULL(NULLIF(TRIM(Category), ''),'Unknown ') Policy3


FROM Orders;