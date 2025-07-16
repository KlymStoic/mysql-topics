USE mysql_sample_db;


-- Column Aliases:

-- Note: In MySQL, you use column aliases to assign a temporary name to a column in the query’s result set;

/** Syntax:
SELECT
    [column | expression] AS descriptive_name
FROM table_name;
**/

/** If the alias contains spaces, you must enclose it in quotes as follows:
SELECT
    [column | expression] AS `descriptive name`
FROM table_name;
**/

-- Note: The `AS` keyword is optional, you can omit it in the statement, you can also assign an expression an alias;


-- Example:

SELECT
    CONCAT_WS(', ', lastName, firstName)
FROM
    employees;
    
/** Note: The column heading can be challenging to read. To address this issue, 
        you can assign a column alias to the output column;
**/

SELECT
    CONCAT_WS(', ', lastName, firstName) AS `Full name`
FROM
    employees;
    
-- Note: In MySQL, you can use the column alias in the ORDER BY, GROUP BY and HAVING clauses to reference the column;

SELECT
    CONCAT_WS(', ', lastName, firstName) AS `Full name`
FROM
    employees
ORDER BY 
    `Full name`;
    
-- Note: Always use backticks (`) to surround aliases that contain spaces;

SELECT
    orderNumber `Order no.`,
    SUM(priceEach * quantityOrdered) Total
FROM
    orderdetails
GROUP BY
    `Order no.`
HAVING
    Total > 60000;

-- Note: You cannot use a column alias in the `WHERE` clause because MySQL evaluates `WHERE` before `SELECT`, so aliases aren't yet defined;


-- Table Aliases:

/** Syntax:
SELECT *
FROM
    table_name AS table_alias;
**/

-- Note: In this syntax, the `AS` keyword is optional, so you can choose to omit it;

-- Example:
SELECT * FROM employees as e;

/** Note: Once you assign an alias to a table, you can reference a table column using the table alias like this:
        table_alias.column_name
**/

-- Example:

SELECT
    e.firstName,
    e.lastName
FROM
    employees e
ORDER BY e.firstName;

-- Note: In practice, you often use table aliases in statements that contain `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN` clauses or in subqueries.

SELECT
    customerName,
    COUNT(o.orderNumber) totalOrders
FROM
    customers c
INNER JOIN orders o ON o.customerNumber = c.customerNumber
GROUP BY customerName
ORDER BY
    totalOrders DESC;
    
-- Note: The query above selects the customer name and the number of orders from the `customers` and `orders` tables;

-- Note: Without the alias, you must use the full table name for columns, making the query more verbose;

-- Example without alias:

SELECT
	customers.customerName,
	COUNT(orders.orderNumber) total
FROM
	customers
INNER JOIN orders ON customers.customerNumber = orders.customerNumber
GROUP BY
	customerName
ORDER BY
	total DESC;
    
-- End (T_T;)