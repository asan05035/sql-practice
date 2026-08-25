
-- Data Definition Language 

/*  Create a table called persons with columns:
id, person_name, birth_date, phone */

CREATE TABLE persons (
	id INT NOT NULL,
	person VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY (id)
)

SELECT *
FROM dbo.persons


-- ALTER 
-- Change the definition of the table

-- Add a new column called email to the persons table


ALTER TABLE persons 
ADD email VARCHAR(50) NOT NULL

-- Remove the colum phone from persons table
ALTER TABLE persons
DROP COLUMN phone


-- Delete table persons from the database

DROP TABLE persons