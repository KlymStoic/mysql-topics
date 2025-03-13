USE sample_db;


DELETE FROM dependents
WHERE
	dependent_id = 16;


-- Check:

SELECT
	COUNT(*)
FROM
	dependents
WHERE
	dependent_id = 16;
    

DELETE FROM
	dependents
WHERE
	dependent_id IN (100, 101, 102);
    

DELETE FROM
	employees
WHERE
	employee_id = 192;
    
SELECT *
FROM
	dependents
WHERE 
	employee_id = 192;
    
-- Note: don't need of below query because mysql auto delete it 

DELETE FROM
	dependents
WHERE
	employee_id = 192;