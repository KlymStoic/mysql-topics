SELECT
	CONCAT_WS(' ', m.first_name, m.last_name) as manager_full_name,
	COUNT(e.manager_id) AS total_employees
FROM
	employees AS e
		INNER JOIN
	employees AS m ON m.employee_id = e.manager_id
GROUP BY
	manager_full_name
ORDER BY
	total_employees DESC;
    
    
SELECT 
    COUNT(*)
FROM
    employees;
    
    
SELECT
	COUNT(*)
FROM
	employees
WHERE
	department_id = 6;
    

SELECT
	d.department_id,
    department_name,
	COUNT(*) AS employee_cnt
FROM
	employees e
		INNER JOIN
	departments d ON d.department_id = e.department_id
GROUP BY
	department_id
HAVING
	employee_cnt >= 5
ORDER BY
	employee_cnt DESC;
    

-- SUM func

SELECT
	d.department_id,
    department_name,
	SUM(salary) AS department_salary
FROM
	employees e
		INNER JOIN
	departments d ON d.department_id = e.department_id
GROUP BY
	department_id
HAVING
	department_salary > 35000
ORDER BY
	department_salary DESC;
