USE mysql_sample_db;


/** Note: Aggregate functions calculate a result from multiple values and return a 
        single value (e.g., `AVG()` returns the average of several numbers);
**/

/** Syntax:
function_name([DISTINCT | ALL] expression)
**/

/** Note: Use `DISTINCT` to calculate using only unique values, or `ALL` (default) to include
        duplicates, and specify an expression (a column or a column-based arithmetic expression);
**/

/** Note: The aggregate functions are often used with the `GROUP BY` clause to calculate an aggregate value
        for each group (e.g., the average value (`AVG`) by the group or the sum (`SUM`) of values in each group);
**/


-- Aggregate functions table set:

CREATE TABLE mysql_aggregate_functions (
  function_name VARCHAR(50) NOT NULL PRIMARY KEY,
  `description`   VARCHAR(255) NOT NULL
);

INSERT INTO mysql_aggregate_functions (function_name, `description`) 
VALUES
('AVG()', 'Return the summation of all non-NULL values in a set.'),
('BIT_AND()', 'Perform a bitwise AND of values in a column of a table.'),
('BIT_OR()', 'Perform a bitwise OR of values in a column of a table.'),
('BIT_XOR()', 'Perform a bitwise XOR of values in a column of a table.'),
('COUNT()', 'Return the number of rows in a group, including rows with NULL values.'),
('COUNT(DISTINCT)', 'Count the number of unique values of a column in a table.'),
('COUNT(IF)', 'Count the number of values that meet a specified condition.'),
('GROUP_CONCAT()', 'Return a concatenated string.'),
('JSON_ARRAYAGG()', 'Return result set as a single JSON array.'),
('JSON_OBJECTAGG()', 'Return result set as a single JSON object.'),
('MAX()', 'Return the highest value (maximum) in a set of non-NULL values.'),
('MIN()', 'Return the lowest value (minimum) in a set of non-NULL values.'),
('STDEV()', 'Return the summation of all non-NULL values in a set.'),
('STDDEV_POP()', 'Return the population standard deviation.'),
('STDDEV_SAMP()', 'Return the sample standard deviation.'),
('SUM()', 'Return the summation of all non-NULL values a set.'),
('SUM(IF)', 'Perform conditional summation using the SUM and IF functions.'),
('VAR_POP()', 'Return the summation of all non-NULL values in a set.'),
('VAR_SAMP()', 'Return the sample variance of values in a column of a table.'),
('VARIANCE()', 'Return the population standard variance of all non-NULL values in a set.');


-- Note: MySQL supports the following aggregate functions:

SELECT *
FROM mysql_aggregate_functions;

-- Note: Use the `HELP` statement to retrieve information about a function from the MySQL Reference Manual;

HELP 'count';


-- Tables for examples:

SELECT *
FROM products;

SELECT *
FROM orderdetails;


-- The `AVG` function examples:

-- Syntax: AVG(expression)

-- Note: The `AVG()` function calculates the average value of a set of values. It ignores `NULL` in the calculation;

-- Example without `GROUP BY`:

SELECT
    AVG(buyPrice) AS avg_buy_price
FROM
    products;
    
-- For each product line:

SELECT
    productLine,
    AVG(buyPrice) AS avg_buy_price
FROM
    products
GROUP BY
    productLine
ORDER BY
    productLine;
    

-- The `COUNT` function examples:

-- Note: The `COUNT()` function returns the number of the values in a set;

-- For example, you can use the `COUNT()` function to get the number of `products` in the `products` table:

SELECT
    COUNT(*) AS total
FROM
    products;
    
-- The number of products for each product line:

SELECT
    productLine,
    COUNT(*) AS total_of_products
FROM
    products
GROUP BY
    productLine
ORDER BY
    total_of_products DESC;
    

-- The `SUM` function examples:

/** Note: The `SUM()` function returns the sum of values in a set. The `SUM()` function ignores `NULL`.
        If no matching row is found, the `SUM()` function returns `NULL`;
**/

-- The total order value of each product:

SELECT 
    productCode,
    productName,
    SUM(priceEach * quantityOrdered) AS total
FROM
    orderdetails
        INNER JOIN
    products USING (productCode)
GROUP BY productCode
ORDER BY total DESC;

/** Note: `productCode` is the PK, `GROUP BY productCode` is enough: each group corresponds to exactly one product,
        so `productName` is unambiguous (functionally dependent on the PK);
**/

-- The total quantity of stock of each product line:

SELECT 
    productLine, SUM(quantityInStock) AS totalInStock
FROM
    products
GROUP BY productLine
ORDER BY totalInStock DESC;


-- The `MAX` function examples:

-- Note: The `MAX()` function returns the maximum value in a set;

-- Syntax: MAX(expression);

-- The highest buy price from the `products`:

SELECT 
    MAX(buyPrice) highestPrice
FROM
    products;

-- The highest buy price of each product line:

SELECT 
    productLine, 
    MAX(buyPrice)
FROM
    products
GROUP BY productLine
ORDER BY `MAX(buyPrice)` DESC;


-- The `MIN` function examples:

-- Note: The `MIN()` function returns the minimum value in a set of values;

-- Syntax: MIN(expression);

-- The lowest buy price from the `products`:

SELECT 
    MIN(buyPrice) lowestPrice
FROM
    products;
    
-- The lowest buy price per product line:

SELECT
    productLine,
    MIN(buyPrice) AS lowestPrice
FROM
    products
GROUP BY
    productLine
ORDER BY
    lowestPrice;
    

-- The `GROUP_CONCAT` function example:

-- Note: The `GROUP_CONCAT()` concatenates a set of strings and returns the concatenated string;

-- Tables for example:

SELECT *
FROM employees;

SELECT *
FROM customers;

-- The sales staff and list of customers that each sales staff is in charge of:

SELECT 
    firstName,
    lastName,
    GROUP_CONCAT(DISTINCT customerName
        ORDER BY customerName
        SEPARATOR '; ') customers
FROM
    employees
        INNER JOIN
    customers c ON c.salesRepEmployeeNumber = employeeNumber
GROUP BY employeeNumber
ORDER BY firstName , lastname;


-- The EnD :D