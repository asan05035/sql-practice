SELECT *
FROM Sales.DBCustomers AS c
WHERE c.CustomerID = 1

-- Clustered _index
CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID ON Sales.DBCustomers (Score)

SELECT *
FROM Sales.DBCustomers AS c
WHERE c.CustomerID = 1


-- Non_clustered Index

SELECT *
FROM Sales.DBCustomers AS c
WHERE c.LastName = 'Brown'

CREATE NONCLUSTERED INDEX idx_DBCustomers_LastName ON Sales.DBCustomers (LastName)



-- Columstore index
CREATE CLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CustomerID ON Sales.DBCustomers 

DROP INDEX [idx_DBCus tomers_CustomerID] ON [Sales].[DBcustomers]