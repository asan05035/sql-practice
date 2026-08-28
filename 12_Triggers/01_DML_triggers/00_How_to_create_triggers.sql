/*
========================
-- SQL Triggers
-- Special stored procedure that automatically runs after event occurs in table or view
============================
*/



-- ===================
-- Use case : Audit logs
-- ===================


-- Step 1: Create Logs table

CREATE TABLE EmployeeLogs (
	LogID INT IDENTITY(1, 1) PRIMARY KEY,
	EmployeeID INT,
	LogMessage VARCHAR(255),
	LogDate DATE

)

DROP TRIGGER trg_afterInserEmployee

-- Step 2: Create Trigger on a table 
CREATE OR ALTER TRIGGER Sales.trg_AfterInsertEmployee ON Sales.Employees
AFTER INSERT
AS 
BEGIN
	INSERT INTO dbo.EmployeeLogs(EmployeeID, LogMessage, LogDate)
	SELECT 
		EmployeeID,
		'New Employee Added: ' + CAST(EmployeeID AS NVARCHAR),
		GETDATE()
	FROM INSERTED
END


-- Step 3: Insert new data into emplopyee table
SELECT *
FROM dbo.EmployeeLogs

SELECT *
FROM Sales.Employees

INSERT INTO Sales.Employees
VALUES 
	(7, 'Marie', 'Dorothy', 'Marketing', '1999-12-31', 'F', 75000, 1)