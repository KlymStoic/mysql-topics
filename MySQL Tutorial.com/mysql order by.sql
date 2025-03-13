USE mysql_sample_db;


/** Syntax:
SELECT
	select_list
FROM
	table_name
ORDER BY
	column1 [ASC|DESC],
    column2 [ASC|DESC],
    ...;
**/

-- Note: 'ASC' stands for ascending, and 'DESC' stands for descending;

-- Note: MySQL execution order: 'FROM' -> 'SELECT' -> 'ORDER BY';


-- Examples:

SELECT
	contactLastname,
    contactFirstname
FROM
	customers
ORDER BY
	contactLastName;

SELECT
	contactLastname,
    contactFirstname
FROM
	customers
ORDER BY
	contactLastName DESC;
    
SELECT
	contactLastname,
    contactFirstname
FROM
	customers
ORDER BY
	contactLastname DESC,
    contactFirstname ASC;
    
-- Note: MySQL uses the 'ASC' parameter by default;


-- Expression example:

SELECT
	orderNumber,
    orderLineNumber,
    quantityOrdered * priceEach
FROM
	orderdetails
ORDER BY
	quantityOrdered * priceEach DESC;

-- Note: To make the query more readable, use a column alias;
    
SELECT
	orderNumber,
    orderLineNumber,
    quantityOrdered * priceEach AS subTotal
FROM
	orderdetails
ORDER BY
	subTotal DESC;


-- FIELD Function:

-- Note: The FIELD function returns the index(position) of a value within the list of values;

/** Syntax: FIELD(value, value1, value2, ...);

In this syntax:
	'value': The value for which you want to find the position.
	'value1, value2, ...': A list of values against which you want to
						   compare the specified value;
**/

-- Examples:

SELECT FIELD('A', 'A', 'B', 'C');

SELECT FIELD('B', 'A', 'B', 'C');

SELECT 
    orderNumber,
    `status`
FROM
    orders
ORDER BY FIELD(`status`,
        'In Process',
        'On Hold',
        'Cancelled',
        'Resolved',
        'Disputed',
        'Shipped');


-- ORDER BY & NULL:

-- Note: In MySQL, NULL comes first before non-NULL values;

SELECT
	firstName,
    lastName,
    reportsTo
FROM
	employees
ORDER BY
	reportsTo;
    
-- Note: However, with the DESC option, NULL appears last in the result set;

SELECT
	firstName,
    lastName,
    reportsTo
FROM
	employees
ORDER BY
	reportsTo DESC;
    
-- The end '-_-';