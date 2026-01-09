USE parks_and_recreation;


/** CASE expression lets you add conditional logic to a `SELECT` statement similar to an `IF`/`ELSE` structure
    in many programming languages (and comparable to nested `IF` formulas in Excel);
**/

-- Practice:

SELECT *
FROM employee_demographics;

SELECT
    first_name,
    last_name,
    age,
    CASE
        WHEN age < 30 THEN 'Young'
        WHEN age < 50 THEN 'Old'
        ELSE "On Death's Door"
    END AS age_bracket
FROM
    employee_demographics;


SELECT 
    CONCAT_WS('_', first_name, last_name) AS full_name,
    occupation,
    salary,
    CASE
        WHEN salary < 50000 THEN salary * 1.07
        WHEN salary > 50000 THEN salary * 1.05
    END AS new_salary,
    CASE
        WHEN department_name LIKE 'puB%' THEN salary * .1
    END bonus,
    department_name
FROM
    employee_salary AS emps
        INNER JOIN
    parks_departments AS pd ON pd.department_id = emps.dept_id;


SELECT 
    CONCAT_WS('_', first_name, last_name) AS full_name,
    occupation,
    salary,
    CASE
        WHEN salary <= 50000 THEN salary * 1.07
        WHEN salary > 50000 THEN salary * 1.05
    END AS new_salary,
    CASE
        WHEN department_name LIKE 'puB%' THEN salary * 0.1
	ELSE
		salary * .05
    END bonus,
    department_name
FROM
    employee_salary AS emps
        INNER JOIN
    parks_departments AS pd ON pd.department_id = emps.dept_id;

