
-- Recursive CTE

-- Generate a sequence of number from 1 to 20

WITH CTE_numbers AS (
	SELECT 1 AS number
	
	UNION ALL 

	SELECT number + 1
	FROM CTE_numbers
	WHERE number < 20
)

SELECT * FROM CTE_numbers;




-- Task: Show the employee hierarchy by displaying each employee's level within the organization
WITH CTE_emp_hieararchy AS (
SELECT 
	EmployeeID,
	FirstName,
	Salary,
	ManagerID,
	1 AS Level
FROM Sales.Employees
WHERE ManagerID IS NULL

UNION ALL

SELECT 
	e.EmployeeID,
	e.FirstName,
	e.Salary,
	e.ManagerID,
	ceh.Level + 1
FROM Sales.Employees AS e
INNER JOIN CTE_emp_hieararchy AS ceh
ON e.ManagerID = ceh.EmployeeID
-- WHERE ceh.EmployeeID IS NOT NULL
)

SELECT * FROM CTE_emp_hieararchy