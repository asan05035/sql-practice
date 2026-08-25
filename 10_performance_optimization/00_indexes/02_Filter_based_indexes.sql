
-- UNIQUE INDEX

SELECT *
INTO [DataAnalytics_2].dbo.SalesProducts
FROM SalesDB.Sales.Products


SELECT *
FROM [dbo].[SalesProducts]

CREATE UNIQUE CLUSTERED INDEX idx_SalesProducts_ProductID ON [dbo].[SalesProducts] (ProductID)

INSERT INTO [DataAnalytics_2].[dbo].[SalesProducts] (ProductID, Product, Category, Price)
VALUES (106, 'Caps', 'Clothing', 135)


-- FILTERED INDEX
 USE [DataAnalytics_2];

CREATE NONCLUSTERED INDEX idx_dbo_SalesProducts_Category ON [dbo].[SalesProducts] ([Category])
WHERE [Category] = 'Clothing'