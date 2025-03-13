SELECT 
    *
FROM
    employee_demographics
WHERE
    employee_id IN (SELECT 
            employee_id
        FROM
            employee_salary
        WHERE
            dept_id = 1);
            

SELECT 
    CONCAT_WS(' ', first_name, last_name) 'full name',
    salary,
    (SELECT 
            AVG(salary)
        FROM
            employee_salary) avg_salary
FROM
    employee_salary
ORDER BY salary;


SELECT 
    gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM
    employee_demographics
GROUP BY gender;


SELECT 
    AVG(`MAX(age)`)
FROM
    (SELECT 
        gender, AVG(age), MAX(age), MIN(age), COUNT(age)
    FROM
        employee_demographics
    GROUP BY gender) AS agr_table;
    
    
SELECT
    *
FROM
    (SELECT 
        gender, AVG(age) AS avg_age, MAX(age) AS max_age, MIN(age) AS min_age, COUNT(age)
    FROM
        employee_demographics
    GROUP BY gender) AS agr_table;
    

SELECT
    AVG(min_age)
FROM
    (SELECT 
        gender, AVG(age) AS avg_age, MAX(age) AS max_age, MIN(age) AS min_age, COUNT(age)
    FROM
        employee_demographics
    GROUP BY gender) AS agr_table;
    
    
-- Sample DB

SELECT 
    employee_id, first_name, last_name
FROM
    employees
WHERE
    department_id IN (SELECT 
            department_id
        FROM
            departments
        WHERE
            location_id = 1700)
ORDER BY first_name , last_name;


SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employees);
            
            
SELECT 
    *
FROM
    departments AS d
WHERE
    EXISTS( SELECT 
            department_id
        FROM
            employees AS e
        WHERE
            salary > 10000
                AND e.department_id = d.department_id)
ORDER BY department_name;


SELECT 
    MIN(salary)
FROM
    employees
GROUP BY department_id
ORDER BY MIN(salary) DESC;


SELECT 
    employee_id,
    CONCAT_WS(' ', first_name, last_name) AS full_name,
    salary
FROM
    employees
WHERE
    salary >= ALL (SELECT 
            MIN(salary)
        FROM
            employees
        GROUP BY department_id)
ORDER BY full_name;


SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary >= ALL (SELECT 
            MIN(salary)
        FROM
            employees
        GROUP BY department_id)
ORDER BY first_name , last_name;


SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary >= SOME (SELECT 
            MAX(salary)
        FROM
            employees
        GROUP BY department_id)
ORDER BY first_name , last_name;


SELECT 
    AVG(salary) AS average_wage
FROM
    employees
GROUP BY department_id;


SELECT 
    ROUND(AVG(average_wage), 1)
FROM
    (SELECT 
        AVG(salary) AS average_wage
    FROM
        employees
    GROUP BY department_id) AS avg_salary_table;
    
    
SELECT 
    employee_id,
    UPPER(first_name),
    UPPER(last_name),
    salary,
    (SELECT 
            ROUND(AVG(salary), 1)
        FROM
            employees) AS avg_salary,
    salary - (SELECT 
            ROUND(AVG(salary), 1)
        FROM
            employees) AS difference
FROM
    employees
ORDER BY first_name, last_name;