USE mysql_sample_db;


-- Note: The DISTINCT clause allows you to remove duplicates from the data you retrieve;

/** Syntax:
SELECT DISTINCT
    select_list
FROM
    table_name
WHERE
    search_condition
ORDER BY
    sort_expression;
**/

/** Note: The DISTINCT clause checks row uniqueness based on one column if specified, or on the combination
        of values when multiple columns are listed;
**/

-- Execution order: FROM -> WHERE -> SELECT -> DISTINCT -> ORDER BY;


-- Examples:

SELECT
    lastName
FROM
    employees
ORDER BY
    lastName;
-- Action Ouput: 23 row(s) returned;

SELECT DISTINCT
    lastName
FROM
    employees
ORDER BY
    lastName;
-- Action Output: 20 row(s) returned;


-- DISTINCT and NULL values:

SELECT state
FROM customers;
-- Action Output: 98 row(s) returned;
    
SELECT DISTINCT state
FROM customers;
-- Action Output: 17 row(s) returned;

-- Note: The DISTINCT clause will keep only one NULL value because it considers all NULL values are the same;


-- Multiple columns:

SELECT
    state,
    city
FROM
    customers
WHERE
    state IS NOT NULL
ORDER BY
    state,
    city;
-- Action Output: 46 row(s) returned;

SELECT DISTINCT
    state,
    city
FROM
    customers
WHERE
    state IS NOT NULL
ORDER BY
    state,
    city;
-- Action Output: 35 row(s) returned;

-- Note: The DISTINCT clause keeps rows unique based on all the columns you list;


-- End ;)
