/**
To create user-defined variable u need to use '@'
Example: @variable_name 
**/

-- NOTE: @id = @ID, case-insensitive


-- Create using SET statement:

SET @variable_name = 'value';

-- OR

SET @variable_name := 'some value';


-- Select statement:

SELECT 14 INTO @variable_name;


-- For check u need to use:

SELECT @variable_name;


USE mysql_sample_db;

-- Some real work example:

SELECT
	MAX(MSRP) INTO @msrp
FROM
	products;
    
-- Check:

SELECT @msrp;


SELECT
	productCode,
    productName,
    productLine,
    MSRP
FROM
	products
WHERE
	MSRP = @msrp;
    
    
-- Multiple line output will raise an error

SELECT
	buyPrice INTO @buy_price
FROM
	products
WHERE
	buyPrice > 95
ORDER BY
	buyPrice;
    
-- Even with error we can still have result in user-def variable

SELECT @buy_price;

-- It only stores first value