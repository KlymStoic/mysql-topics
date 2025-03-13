USE parks_and_recreation;


-- Simple example:

DELIMITER $$

CREATE EVENT delete_retirees
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
	DELETE
    FROM employee_demographics
    WHERE age >= 60;
END$$

DELIMITER ;


-- Query to remove event from database:

DROP EVENT delete_retirees;


-- To check result:

SELECT *
FROM employee_demographics;


