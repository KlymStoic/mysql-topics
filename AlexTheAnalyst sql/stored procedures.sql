USE parks_and_recreation;

SELECT *
FROM employee_salary;


CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 55000;


CALL large_salaries;

CALL parks_and_recreation.large_salaries();


DELIMITER $$
CREATE PROCEDURE min_max_salaries()
BEGIN
	SELECT *
	FROM employee_salary
    WHERE salary <= 25000;
    
    SELECT *
    FROM employee_salary
	WHERE salary >= 65000;
END $$
DELIMITER ;

CALL min_max_salaries();


-- use of gui auto create skript for stored procedure
USE `parks_and_recreation`;
DROP procedure IF EXISTS `autocreated_script`;

DELIMITER $$
USE `parks_and_recreation`$$
CREATE PROCEDURE `autocreated_script` ()
BEGIN
	SELECT *
	FROM employee_salary
    WHERE salary <= 25000;
    
    SELECT *
    FROM employee_salary
	WHERE salary >= 65000;
END$$

DELIMITER ;
-- the end of autocreated skript xd(

CALL autocreated_script;


CREATE PROCEDURE employee_seeker(employee_id_param INT)
SELECT *
FROM employee_demographics
WHERE employee_id = employee_id_param;
    
CALL employee_seeker(1);


SELECT *
FROM employee_salary emp
JOIN parks_departments pd
	ON pd.department_id = emp.dept_id;


DELIMITER $$

CREATE PROCEDURE department_employees(
	p_dept_name VARCHAR(115)
)
BEGIN
	SELECT *
	FROM employee_salary emp
	JOIN parks_departments pd
		ON pd.department_id = emp.dept_id
	WHERE department_name LIKE p_dept_name;
END$$

DELIMITER ;

CALL department_employees('Finance');

CALL department_employees('Parks%');

