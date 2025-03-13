CREATE TEMPORARY TABLE krustycrabs_employees(
	employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hour_pay DECIMAL(5, 2),
    hire_date DATE
);


SELECT 
    *
FROM
    krustycrabs_employees;
    
    
INSERT INTO krustycrabs_employees
VALUES(1, 'Eugene', 'Crabs', 25.00, '2012-01-01');


INSERT INTO krustycrabs_employees
VALUES  (2, "Squidward", "Tentacles", 15.00, "2023-01-03"), 
		(3, "Spongebob", "Squarepants", 12.50, "2023-01-04"), 
		(4, "Patrick", "Star", 12.50, "2023-01-05"), 
		(5, "Sandy", "Cheeks", 17.25, "2023-01-06");
        

INSERT INTO krustycrabs_employees(
	employee_id,
	first_name,
    last_name
)
VALUES(6, 'Sheldon', 'Plankton');

SELECT *
FROM krustycrabs_employees;


USE sample_db;

INSERT INTO dependents (
	first_name,
    last_name,
    relationship,
    employee_id
)
VALUES
	('Dustin', 'Johnson', 'Child', 178);
    
    
-- Just another variant for that query    
INSERT INTO dependents (
	first_name,
	last_name,
	relationship,
	employee_id
)
VALUES
	(
		'Dustin',
		'Johnson',
		'Child',
		178
	);
    

SELECT *
FROM
	dependents
WHERE
	employee_id = 178;
    
    
INSERT INTO dependents(
	first_name,
    last_name,
    relationship,
    employee_id
)
VALUES
	('Bob', 'Astrong', 'Child', 192),
    ('Karen', 'Astrong', 'Child', 192);
    
    
SELECT *
FROM
	dependents
WHERE
	employee_id = 192;
    

-- Note: It's better practice to specify column names


CREATE TEMPORARY TABLE dependents_archive
SELECT *
FROM
	dependents
LIMIT 0;

-- Example how to insert info from other table:

INSERT INTO dependents_archive
SELECT
	*
FROM
	dependents;
    
    
SELECT *
FROM
	dependents_archive;