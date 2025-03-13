USE sample_db;


UPDATE employees
SET
	last_name = 'Lopez'
WHERE
	employee_id = 192;
    

-- Check:
SELECT *
FROM
	employees
WHERE
	employee_id = 192;
    

SELECT *
FROM
	dependents
WHERE
	employee_id = 192;
    
-- Need to change last name here too

UPDATE dependents
SET
	last_name = 'Lopez'
WHERE
	employee_id = 192;
    
-- Note: both change with one query


-- Ultimate query if you wanna change the last name for parent and their children:

SET SQL_SAFE_UPDATES = 0;

UPDATE dependents 
SET 
    last_name = (SELECT 
            last_name
        FROM
            employees
        WHERE
            employees.employee_id = dependents.employee_id)
WHERE
    employee_id IS NOT NULL;

SET SQL_SAFE_UPDATES = 1;

-- Note: can't use this query without turning off sql safe mode :^(



