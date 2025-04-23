USE mysql_sample_db;


-- Note: The LIMIT clause constrains the number of rows returned by a query;

/** Syntax:
SELECT
    select_list
FROM
    table_name
LIMIT [offset,] row_count;
**/

/** Note: The 'offset' of the first row is 0, not 1. Therefore, these two clauses are equivalent:
LIMIT row_count;
-- and
LIMIT 0, row_count;
**/

-- Note: The 'row_count' specifies the maximum number of rows to return;

/** Alternative Syntax: 
SELECT
    select_list
FROM
    table_name
LIMIT row_count OFFSET offset;
**/

-- Note: Using LIMIT without ORDER BY in a SELECT query returns rows in an unpredictable order;

/** To ensure the LIMIT clause returns an expected output, you should always use it with an ORDER BY clause like this:
SELECT
    select_list
FROM
    table_name
ORDER BY
    sort_expression
LIMIT offset, row_count;
**/

-- Execution order: FROM -> WHERE -> SELECT -> DISTINCT -> ORDER BY -> LIMIT;


-- Examples:

-- Highest & Lowest rows:

SELECT
    customerNumber,
    customerName,
    creditLimit
FROM
    customers
ORDER BY creditLimit DESC
LIMIT 5;

SELECT
    customerNumber,
    customerName,
    creditLimit
FROM
    customers
ORDER BY creditLimit
LIMIT 5;


-- Table pagination:

-- Query to count rows:
SELECT
    COUNT(*)
FROM
    customers;

-- First page:
SELECT
    customerNumber,
    customerName
FROM
    customers
ORDER BY customerName
LIMIT 10;

-- Next page:
SELECT
    customerNumber,
    customerName
FROM
    customers
ORDER BY customerName
LIMIT 10, 10;


-- Highest & Lowest nth value:

/** Syntax:
SELECT select_list
FROM table_name
ORDER BY sort_expression
LIMIT n-1, 1;
**/

-- Note: The clause LIMIT n-1, 1 returns 1 row starting at the row n;

-- Query to retrieve the second-highest credit:
SELECT
    customerName,
    creditLimit
FROM
    customers
ORDER BY creditLimit DESC
LIMIT 1, 1;

-- Check:
SELECT
    customerName,
    creditLimit
FROM
    customers
ORDER BY creditLimit DESC;


-- LIMIT & DISTINCT:

SELECT DISTINCT
    state
FROM
    customers
WHERE
    state IS NOT NULL
LIMIT 5;

-- Note: Use the LIMIT clause with the DISTINCT clause to return the first unique values;

-- The End)