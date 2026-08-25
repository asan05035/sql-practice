
sp_helpindex'[dbo].[gold.fact_salesRS]'

--1. Moniter index usage

SELECT
	tbl.name AS TableName,
	idx.name AS indexName,
	idx.type_desc AS indexType,
	is_primary_key AS IsPrimarykey,
	is_unique AS IsUnique,
	is_disabled AS IsDisabled,
	s.user_seeks AS UserSeeks,
	s.user_scans AS UserScans,
	s.user_lookups AS UserLookups,
	s.user_updates AS UserUpdates,

	COALESCE(s.last_user_seek, s.last_user_scan) LastUpdate
FROM sys.indexes AS idx
JOIN sys.tables AS tbl
ON idx.object_id = tbl.object_id
LEFT JOIN sys.dm_db_index_usage_stats s
ON idx.object_id = s.object_id AND idx.index_id  = s.index_id
-- ORDER BY tbl.name, idx.name

SELECT * FROM sys.tables

SELECT * FROM sys.dm_db_index_usage_stats

-- 2. Missing Index details

SELECT *
FROM sys.dm_db_missing_index_details;


-- 3. Moniter duplicate indexes

SELECT *
FROM sys.index_columns

SELECT *
FROM sys.columns

SELECT
    t.name AS table_name,
    c.name AS ColumnName,
    i.name AS index_name,
    i.type_desc,
    i.is_unique,
    i.is_primary_key,
    i.is_disabled,
    COUNT(*) OVER(PARTITION BY t.name, c.name ORDER BY t.name, c.name) Flag
    -- ius.last_user_seek,
    -- ius.user_seeks,
    -- ius.user_scans,
    -- ius.user_lookups,
    -- ius.user_updates
FROM sys.indexes AS i
INNER JOIN sys.tables AS t
ON i.object_id = t.object_id
-- LEFT JOIN sys.dm_db_index_usage_stats AS ius
-- ON i.object_id = ius.object_id AND i.index_id = ius.index_id
INNER JOIN sys.index_columns AS ic
ON i.object_id = ic.object_id AND i.index_id = ic.index_id
INNER JOIN sys.columns AS c
ON ic.object_id = c.object_id AND ic.column_id = c.column_id
-- ORDER BY t.name, c.name

CREATE NONCLUSTERED INDEX idx_factSales_customerkey ON [dbo].[gold.fact_salesCS] ([customer_key])

SELECT *
FROM [dbo].[gold.fact_salesCS]

