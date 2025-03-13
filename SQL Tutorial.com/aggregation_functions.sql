SELECT 
    department_name, 
    ROUND(AVG(salary), 1) AS avg_wage
FROM
    employees AS e
        INNER JOIN
    departments AS d ON d.department_id = e.department_id
GROUP BY department_name
ORDER BY department_name;
    

SELECT
	AVG(hire_date)
FROM
	employees;
    

SELECT
	SUM(hire_date)
FROM
	employees;
    
    
SELECT
	AVG(phone_number),
    COUNT(phone_number)
FROM
	employees;