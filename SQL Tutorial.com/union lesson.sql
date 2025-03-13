SELECT
	first_name,
    last_name
FROM
	employees
UNION
SELECT
	first_name,
    last_name
FROM
	dependents
ORDER BY last_name;


SELECT
	first_name,
    last_name,
    'employee' AS status 
FROM
	employees
UNION
SELECT
	first_name,
    last_name,
    'dependent' AS status
FROM
	dependents
ORDER BY last_name;


SELECT
	first_name,
    last_name,
    'dependent' AS status
FROM
	dependents
UNION
SELECT
	first_name,
    last_name,
    'employee' AS status 
FROM
	employees
ORDER BY last_name;


-- parks and recreations

SELECT
	first_name,
    last_name,
    'Old' AS label
FROM
	employee_demographics
WHERE 
	age > 45
UNION
SELECT
	first_name,
    last_name,
    'High salary' AS label
FROM
	employee_salary
WHERE
	salary > 67000
ORDER BY 
	first_name,
    last_name;
    
    
SELECT
	first_name,
    last_name,
    'Old Man' AS label
FROM
	employee_demographics
WHERE 
	age > 45 
    AND gender = 'Male'
UNION    
SELECT
	first_name,
    last_name,
    'Old Lady' AS label
FROM
	employee_demographics
WHERE 
	age > 45
    AND gender = 'Female'
UNION
SELECT
	first_name,
    last_name,
    'High salary' AS label
FROM
	employee_salary
WHERE
	salary > 67000
ORDER BY 
	first_name,
    last_name
;