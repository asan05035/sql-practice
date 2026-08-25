SELECT 
	t.schema_id AS SchemaName,
	s.name AS StatisticName,
	t.name AS tableName,
	sp.last_updated AS LastUpdate,
	DATEDIFF(DAY, sp.last_updated, GETDATE()) AS Lastupdateday,
	sp.rows as Rows,
	sp.modification_counter as modificationSinceUpdate
	
FROM sys.stats AS s 
INNER JOIN sys.tables AS t
ON s.object_id = t.object_id
CROSS APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) AS sp


UPDATE STATISTICS [dbo].[gold.fact_sales_index] _WA_Sys_00000007_73BA3083

INSERT INTO [dbo].[gold.fact_sales_index](order_number, product_key, customer_key, order_date, shipping_date, due_date, sales_amount, quantity, price)
VALUES (3, 12345, 987, '2025-08-19' , '2025-08-19' , '2025-08-19', 768, 90, 8.56)

EXECUTE sp_updatestats