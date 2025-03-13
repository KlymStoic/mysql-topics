USE mysql_sample_db;


-- IF... THEN statement:

/** Syntax:
IF condition THEN
	statements;
END IF;
**/


DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
	IN pCustomerNumber INT,
    OUT pCustomerLevel VARCHAR(20))
BEGIN
	DECLARE credit DECIMAL(10, 2) DEFAULT 0;
    
    SELECT creditLimit
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;
    
    IF credit > 50000 THEN
		SET pCustomerLevel = 'PLATINUM';
	END IF;
END$$

DELIMITER ;

-- Check:

CALL GetCustomerLevel(104, @level);
SELECT @level;

CALL GetCustomerLevel(112, @level); -- With credit level over 50k;
SELECT @level;


-- Query to find all customers with high credit limit:

SELECT
	customerNumber,
    creditLimit
FROM
	customers
WHERE
	creditLimit > 50000
ORDER BY creditLimit DESC;


-- IF-THEN-ELSE statements:

/** Syntax:
IF condition THEN
	statements;
ELSE
	else-statements;
END IF;
**/

-- Modifying GetCustomerLevel procedure:

DROP PROCEDURE GetCustomerLevel;

DELIMITER //

CREATE PROCEDURE GetCustomerLevel(
	IN pCustomerNumber INT,
    OUT pCustomerLevel VARCHAR(20))
BEGIN
	DECLARE credit DECIMAL(10, 2) DEFAULT 0;
    
    SELECT creditLimit
	INTO credit
    FROM customers
    WHERE pCustomerNumber = customerNumber;
    
    IF credit > 50000 THEN
		SET pCustomerLevel = 'PLATINUM';
	ELSE
		SET pCustomerLevel = 'NOT PLATINUM';
	END IF;
END//

DELIMITER ;


-- Query to get all customers with credit limin above 50k:

SELECT 
    customerNumber, creditLimit
FROM
    customers
WHERE
    creditLimit <= 50000
ORDER BY creditLimit DESC;


-- Checking procedure:

CALL GetCustomerLevel(447, @level);
SELECT @level;

CALL GetCustomerLevel(112, @level);
SELECT @level;


-- IF-THEN-ELSEIF-ELSE statements:

/** Syntax:
IF condition THEN
	statements;
ELSEIF elseif-condition THEN
	elseif-statements;
...
ELSE
	else-statements;
END IF;
**/

-- Modifying procedure:

DROP PROCEDURE GetCustomerLevel;

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
	IN pCustomerNumber INT,
    OUT pCustomerLevel VARCHAR(20))
BEGIN
	DECLARE credit DECIMAL(10, 2) DEFAULT 0;
    
    SELECT creditLimit
    INTO credit
    FROM customers
    WHERE pCustomerNumber = customerNumber;
    
    IF credit > 50000 THEN
		SET pCustomerLevel = 'PLATINUM';
	ELSEIF credit BETWEEN 10000 AND 50000 THEN
		SET pCustomerLevel = 'GOLD';
	ELSE
		SET pCustomerLevel = 'SILVER';
	END IF;
END$$

DELIMITER ;

-- Query to find all gold level customers:

SELECT
	customerNumber,
    creditLimit
FROM
	customers
WHERE
	creditLimit < 50000 AND creditLimit > 10000
    -- OR creditLimit BETWEEN 10000 AND 50000
ORDER BY
	creditLimit DESC;
    

-- Checking procedure:

CALL GetCustomerLevel(447, @level);
SELECT @level;

CALL GetCustomerLevel(125, @level);
SELECT @level;
