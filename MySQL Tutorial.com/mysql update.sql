USE mysql_sample_db;

/** Syntax:
UPDATE [LOW_PRIORITY] [IGNORE] table_name
SET
	column_name1 = expr1,
    column_name2 = expr2,
    ...
[WHERE
	condition];
**/

-- Note: Besides expressions you can use subquries;

/** Note: MySQL UPDATE statement supports two modifiers:
	LOW_PRIORITY -> Delays the update until no connection is reading
		from the table. Applies to storage engines that use table-level 
        locking, such as MyISAM, MEMORY, and MERGE;
		
	*Default InnoDB uses row-level locking, so LOW_PRIORITY does not apply to it.
    
    IGNORE -> Allows the update to proceed despite errors, skipping
		problematic rows instead of stopping execution;
**/


-- Let's practice!

SELECT
	firstName,
    lastName,
    email
FROM
	employees
WHERE
	employeeNumber = 1056;
    
UPDATE employees
SET
	email = 'mary.patterson@classicmodelcars.com'
WHERE
	employeeNumber = 1056;
    
-- Check:
SELECT firstName, lastName, email
FROM employees
WHERE employeeNumber = 1056;

-- Note: The WHERE clause is crucial for single-row updates;


-- Multiple columns:

UPDATE employees
SET
	lastName = 'Hill',
    email = 'mary.hill@classicmodelcars.com'
WHERE
	employeeNumber = 1056;
    
-- Check:
SELECT firstName, lastName, email
FROM employees
WHERE employeeNumber = 1056;


-- Replace string example:

UPDATE employees 
SET email = REPLACE(email, '@classicmodelcars.com', '@mysqltutorial.org')
WHERE
    jobTitle = 'Sales Rep' AND 
    officeCode = 6;
        
-- Syntax: REPLACE(str, old_string, new_string);

-- Note: Don't confuse REPLACE statement with REPLACE string function;


-- UPDATE by a SELECT statement example:

SELECT
	customerName,
    salesRepEmployeeNumber
FROM
	customers
WHERE
	salesRepEmployeeNumber IS NULL;
    
-- Note: The query below returns a random salesman each time;

SELECT
	employeeNumber
FROM
	employees
WHERE
	jobTitle = 'Sales Rep'
ORDER BY RAND()
LIMIT 1;

-- Note: The RAND function returns a random float number between 0 and 1;

UPDATE customers 
SET 
    salesRepEmployeeNumber = (SELECT 
            employeeNumber
        FROM
            employees
        WHERE
            jobTitle = 'Sales Rep'
        ORDER BY RAND()
        LIMIT 1)
WHERE
    salesRepEmployeeNumber IS NULL;
    
-- Check:
SELECT customerName, salesRepEmployeeNumber
FROM customers
WHERE salesRepEmployeeNumber IS NULL;

-- The End ;)
