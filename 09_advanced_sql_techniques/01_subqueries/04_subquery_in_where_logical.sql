  SELECT * FROM INFORMATION_SCHEMA.TABLES

  SELECT * FROM INFORMATION_SCHEMA.COLUMNS


  SELECT 
	e.Salary
  FROM Sales.Employees AS e
  WHERE e.Gender = 'M';


-- Find the female employee whose salries are greater
-- than the salaries of any male employees

  SELECT *
  FROM Sales.Employees AS e
  WHERE e.Gender = 'F' AND e.Salary > ANY (  SELECT 
												e.Salary
											  FROM Sales.Employees AS e
											  WHERE e.Gender = 'M')
