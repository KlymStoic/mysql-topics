USE sample_db;

SELECT 
    employee_id,
    CONCAT_WS(' ', first_name, last_name) AS full_name,
    email,
    phone_number,
    hire_date,
    j.job_id,
    job_title,
    salary
FROM
    employees emp
        JOIN
    jobs j ON emp.job_id = j.job_id
ORDER BY salary DESC;


DELIMITER $$
CREATE PROCEDURE get_job_info()
BEGIN
	SELECT 
		employee_id,
		CONCAT_WS(' ', first_name, last_name) AS full_name,
		email,
		phone_number,
		hire_date,
		j.job_id,
		job_title,
		salary
	FROM
		employees emp
			JOIN
		jobs j ON emp.job_id = j.job_id
	ORDER BY salary DESC;
END$$
DELIMITER ;

CALL get_job_info();

DROP PROCEDURE get_job_info;


DELIMITER //
CREATE PROCEDURE get_employees()
BEGIN
	SELECT *
    FROM employees;
END//
DELIMITER ;

CALL get_employees();

DROP PROCEDURE get_employees;


DELIMITER $$

CREATE PROCEDURE find_employee(IN emp_id INT)
BEGIN
	SELECT *
	FROM
		employees
	WHERE
		employee_id = emp_id;
END$$

DELIMITER ;

CALL find_employee(111);

DROP PROCEDURE find_employee;


DELIMITER $$

CREATE PROCEDURE find_employee(
	IN f_name VARCHAR(50),
    IN l_name VARCHAR(50)
)
BEGIN
	SELECT *
	FROM employees
	WHERE
		first_name = f_name AND last_name = l_name;
END$$

DELIMITER ;

CALL find_employee('John', 'Russell');

DROP PROCEDURE find_employee;
