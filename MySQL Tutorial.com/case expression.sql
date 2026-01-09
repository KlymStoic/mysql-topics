USE mysql_sample_db;


/** Note: MySQL `CASE` expression adds if-else logic inside a query and can be used anywhere an expression 
        is valid (e.g., `SELECT`, `WHERE`, `ORDER BY`). The `CASE` expression has two forms: simple `CASE` and searched `CASE`;
**/

-- Note: MySQL also has a `CASE` statement used only in stored programs (procedures, functions, events, triggers);


-- Simple CASE expression:

/** Syntax:
CASE value
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ...
    [ELSE else_result]
END;
**/

/** Note: `CASE` checks each `WHEN` condition; when one is true it returns its `THEN` result, otherwise
        it returns `ELSE` (or `NULL` if `ELSE` isn’t provided);
**/

/** Note: A `CASE` expression’s return data type depends on where it’s used: string context returns text,
        numeric context returns a numeric value (integer/decimal/real);
**/


-- SELECT clause example:

SELECT 
    customerName, 
    COUNT(*) orderCount
FROM
    customers
        INNER JOIN
    orders USING (customerNumber)
GROUP BY customerName
ORDER BY orderCount;

WITH cte AS (
    SELECT 
        customerName, 
        COUNT(*) orderCount
    FROM
        customers
            INNER JOIN
        orders USING (customerNumber)
    GROUP BY customerName
    ORDER BY orderCount
)
SELECT
    customerName,
    orderCount,
    CASE orderCount
        WHEN 1 THEN 'One-Time Customer'
        WHEN 2 THEN 'Repeated Customer'
        WHEN 3 THEN 'Frequent Customer'
        ELSE 'Loyal Customer'
    END AS customerType
FROM
    cte
ORDER BY 
    customerName;

-- Note: Use an alias for each `CASE` expression in the `SELECT` statement;


-- ORDER BY clause example:

SELECT 
    customerName, state, country
FROM
    customers
ORDER BY (CASE
    WHEN state IS NULL 
        THEN country
    ELSE state
END);

-- This example sorts customers by state if it’s not NULL; otherwise, it sorts by country.


-- Aggregate Function example:

SELECT DISTINCT `status`
FROM orders;

SELECT
    SUM(CASE
            WHEN `status` = 'Shipped' THEN 1
            ELSE 0
        END) AS Shipped,
    SUM(CASE
            WHEN `status` = 'Resolved' THEN 1
            ELSE 0
        END) AS Resolved,
    SUM(CASE
            WHEN `status` = 'Cancelled' THEN 1
            ELSE 0
        END) AS Cancelled,
    SUM(CASE
            WHEN `status` = 'On Hold' THEN 1
            ELSE 0
        END) AS `On Hold`,
    SUM(CASE
            WHEN `status` = 'Disputed' THEN 1
            ELSE 0
        END) AS Disputed,
    SUM(CASE
            WHEN `status` = 'In Process' THEN 1
            ELSE 0
        END) AS `In Process`,
    COUNT(*) AS Total
FROM
    orders;
    
-- This example uses the CASE expression with the SUM() function to count sales orders by order status.


-- The End '#_#';