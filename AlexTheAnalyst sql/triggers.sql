USE parks_and_recreation;


SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;


DELIMITER $$

CREATE TRIGGER employee_insert
	AFTER INSERT 
	ON employee_salary FOR EACH ROW
BEGIN
	INSERT INTO employee_demographics(employee_id, first_name, last_name)
    VALUES(NEW.employee_id, NEW.first_name, NEW.last_name);
END $$

DELIMITER ;


/** Note: gui is not so convenient about controlling over triggers. 
	Only way to drop it through query **/

DROP TRIGGER employee_insert;


-- Example insert

INSERT INTO employee_salary(
	employee_id, 
    first_name, 
    last_name, 
    occupation,
    salary,
    dept_id)
VALUES(13, 'John', 'Smith', 'Brokleen 420 CEO', 1000000, NULL);

-- Check for changes:

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;


-- Another database

USE sample_db;


-- First, create a new table

CREATE TABLE salary_changes (
	employee_id INT,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	old_salary DECIMAL(8, 2),
    new_salary DECIMAL(8, 2),
    PRIMARY KEY (employee_id, changed_at)
);


DELIMITER $$

CREATE TRIGGER before_salary_update
	BEFORE UPDATE ON employees
	FOR EACH ROW
BEGIN
	CASE
		WHEN NEW.salary != OLD.salary THEN
			INSERT INTO salary_changes (employee_id, old_salary, new_salary)
            VALUES(NEW.employee_id, OLD.salary, NEW.salary);
	END CASE;
END $$

DELIMITER ;


-- Check time!

SELECT
	employee_id,
    first_name,
    last_name,
    salary
FROM
	employees
WHERE
	employee_id = 110;
    
UPDATE employees 
SET 
    salary = salary * 1.1
WHERE
    employee_id = 110;
    
SELECT 
    *
FROM
    salary_changes;

    
/** In other sql you can you can use:
CREATE OR REPLACE TRIGGER trigger_name
and rest as normal**/


-- To drop trigger:

DROP TRIGGER before_salary_update;

-- [IF EXISTS] is optional part to avoid error;

DROP TRIGGER IF EXISTS before_salary_update;


-- To show trigger in current db:

SHOW TRIGGERS;


-- For another db triggers:

USE sample_db;

SHOW TRIGGERS;