 
 -- 3. Create datafile
 /*
 ALTER DATABASE SalesDB ADD FILE
 (
	Name=  -- logical_name
	FILENAME = ''-- Physical_name
) TO FILEGROUP FileGroupName
*/

 -- Query listing all the file group and its datafiles

 SELECT 
	fg.name as filegroup_name,
	mf.name as logical_name,
	mf.physical_name as filepath,
	mf.size / 128  as datafileSize,
	mf.database_id
 FROM sys.filegroups AS fg
 INNER JOIN sys.master_files AS mf
 ON fg.data_space_id = mf.data_space_id
 WHERE mf.database_id = DB_ID('SalesDB')

 --
 -- 4. Create partition scheme
 /*
 CREATE PARTITION SCHEME SchemeName
 AS PARTITION PartitionFunctionName
 TO (FileGroup files) */


 -- Query listinf all partion scheme
 SELECT 
	ps.name,
	pf.name,
	dds.destination_id,
	fg.name
 FROM sys.partition_schemes as ps
 JOIN sys.partition_functions AS pf
 ON pf.function_id = ps.function_id
 INNER JOIN sys.destination_data_spaces AS dds ON dds.partition_scheme_id = ps.data_space_id
 INNER JOIN sys.filegroups AS fg ON fg.data_space_id = dds.data_space_id


 --- 5. Create partitioned table
 CREATE TABLE Sales.Orders_Partiotioned 
 (
	OrderID INT,
	OrderDate DATE,
	SalesAmount INT
) ON SchemePartitionByYear (OrderDate)

SELECT * FROM Sales.Orders_Partiotioned 

INSERT INTO Sales.Orders_Partiotioned 
VALUES (2, '2024-12-13', 450)

-- Query to check if the data is stored in the correct partition
SELECT 
	p.partition_number,
	p.rows,fg.name

FROM sys.partitions AS p
JOIN sys.destination_data_spaces AS dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups AS fg ON fg.data_space_id = dds.data_space_id
WHERE OBJECT_NAME(p.object_id) = 'Orders_Partiotioned'
