-- parks_and_recreation

SELECT 
    gender, AVG(salary), MIN(salary), MAX(salary), COUNT(salary)
FROM
    employee_demographics dem
        JOIN
    employee_salary sal ON dem.employee_id = sal.employee_id
GROUP BY gender;

WITH CTE_Example AS
(SELECT 
    gender, AVG(salary), MIN(salary), MAX(salary), COUNT(salary)
FROM
    employee_demographics dem
        JOIN
    employee_salary sal ON dem.employee_id = sal.employee_id
GROUP BY gender)

SELECT AVG(`AVG(salary)`)
FROM CTE_Example;


WITH CTE_Example (gender, avg_salary, min_salary, max_salary, count_salary) AS
(
SELECT 
    gender, AVG(salary), MIN(salary), MAX(salary), COUNT(salary)
FROM
    employee_demographics dem
        JOIN
    employee_salary sal ON dem.employee_id = sal.employee_id
GROUP BY gender
)

SELECT *
FROM CTE_Example;


WITH CTE_Example AS 
(
SELECT
	employee_id, salary
FROM
	employee_salary
WHERE 
	salary > 50000
),

CTE_Example2 AS 
(
SELECT 
	employee_id, first_name, last_name, gender
FROM
	employee_demographics
WHERE
	birth_date > '1980-01-01'
)

SELECT *
FROM 
	CTE_Example2
		JOIN
	CTE_Example ON CTE_Example.employee_id = CTE_Example2.employee_id;
    


-- MySQL DB

WITH usa_customers AS
(
SELECT
	customerName,
    state
FROM
	customers
WHERE
	country = 'USA'
)
SELECT *
FROM
	usa_customers;
    

WITH usa_customers AS
(
SELECT
	customerName,
    state
FROM
	customers
WHERE
	country = 'USA'
)
SELECT
	customerName
FROM
	usa_customers
WHERE
	state = 'NY'
ORDER BY customerName;


WITH usa_customers AS (
SELECT
	customerName,
    state
FROM
	customers
WHERE
	country = 'USA'
)
SELECT
	customerName
FROM
	usa_customers
WHERE
	state = 'CA'
ORDER BY 
	customerName;
    

