USE mysql_sample_db;

SELECT 
    customerName, 
    city, 
    state, 
    postalCode, 
    country
FROM
    customers
ORDER BY customerName;


DELIMITER $$

CREATE PROCEDURE GetCustomers()
BEGIN
	SELECT 
		customerName, 
		city, 
		state, 
		postalCode, 
		country
	FROM
		customers
	ORDER BY customerName;
END$$

DELIMITER ;


CALL GetCustomers();


DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
	SELECT * FROM products;
END//

DELIMITER ;

CALL GetAllProducts();


DELIMITER //

CREATE PROCEDURE IF NOT EXISTS GetAllProducts()
BEGIN
	SELECT * FROM products;
END//

DELIMITER ;

CALL GetAllProducts;


-- mysql workbench wizard:
USE `mysql_sample_db`;
DROP procedure IF EXISTS `GetAllProductsAutoCreated`;

DELIMITER $$
USE `mysql_sample_db`$$
CREATE PROCEDURE GetAllProductsAutoCreated ()
BEGIN
	SELECT * FROM products;
END$$

DELIMITER ;

CALL GetAllProductsAutoCreated;


DELIMITER //

CREATE PROCEDURE GetOfficeByCountry(
	IN country_param VARCHAR(255)
)
BEGIN
	SELECT *
	FROM offices
    WHERE
		country = country_param
	ORDER BY officeCode;
END//

DELIMITER ;

CALL GetOfficeByCountry('USA');

CALL GetOfficeByCountry('France');

-- example of error by wrong parameter:
CALL GetOfficeByCountry();


-- Procedures with OUT parameter:

DELIMITER $$

CREATE PROCEDURE GetOrderCountByStatus(
	IN orderStatus VARCHAR(25),
    OUT total INT
)
BEGIN
	SELECT COUNT(orderNumber)
	INTO total
    FROM
		orders
	WHERE
		orderStatus = status;
END$$

DELIMITER ;

-- Note: instead of @total can be any other word

CALL GetOrderCountByStatus('Shipped', @total);
SELECT @total;

-- To get orders in process:

CALL GetOrderCountByStatus('In Process', @total_in_process);
SELECT @total_in_process AS 'Orders in Process';


-- INOUT parameter example:

DELIMITER //

CREATE PROCEDURE SetCounter(
	INOUT counter INT,
    IN inc INT
)
BEGIN
	SET counter := counter + inc;
END//

DELIMITER ;

-- How to use:

SET @counter = 1;

CALL SetCounter(@counter, 1);
SELECT @counter; -- @counter = 2;

CALL SetCounter(@counter, 5);
SELECT @counter; -- @counter = 7;

CALL SetCounter(@counter, 10);
SELECT @counter; -- @counter = 17;
