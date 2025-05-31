USE  mysql_sample_db;


-- Preparation:

CREATE TABLE product_sales
SELECT
    productLine,
    YEAR(orderDate) as orderYear,
    SUM(quantityOrdered * priceEach) as orderValue
FROM
    orderdetails
        INNER JOIN
    orders USING (orderNumber)
        INNER JOIN
    products USING (productCode)
GROUP BY
    productLine,
    YEAR(orderDate);
    
-- Check:

SELECT * FROM product_sales;


-- ROLLUP Overview:

-- Query to create a grouping set:
SELECT
    productLine,
    SUM(orderValue) totalOrderValue
FROM
    product_sales
GROUP BY
    productLine
ORDER BY
    totalOrderValue DESC;
    
SELECT
    SUM(orderValue) totalOrderValue
FROM
    product_sales;
    

-- Query for two or more grouping sets together:

SELECT
    productline,
    SUM(orderValue) totalOrderValue
FROM
    product_sales
GROUP BY
    productLine
UNION ALL
SELECT
    NULL,
    SUM(orderValue) totalOrderValue
FROM
    product_sales;
    
-- Note: Since `UNION ALL` requires the same number of columns, we added `NULL` to the second query's select list to match;

/** Note: This query calculates total order values by product lines and includes a grand total row, but it has two issues:
        - It's quite long.
        - It may perform poorly, as the database must run two queries and merge the results;
**/

-- Note: To fix these issues, you can use the ROLLUP clause;

/** Syntax:
SELECT
    select_list
FROM
    table_name
GROUP BY
    c1, c2, c3 WITH ROLLUP;
**/

-- Note: The ROLLUP generates multiple grouping sets based on the columns or expressions specified in the GROUP BY clause;


-- Examples:

SELECT
    productLine,
    SUM(orderValue) totalOrderValue
FROM
    product_sales
GROUP BY
    productLine WITH ROLLUP;
    
-- Note: The ROLLUP clause generates not only the subtotals but also the grand total of the order values;

/** Note: With multiple `GROUP BY` columns, `ROLLUP` treats them hierarchically. For example:
    GROUP BY c1, c2, c3 WITH ROLLUP;

The ROLLUP assumes that there is the following hierarchy:
    c1 > c2 > c3;

It generates the following grouping sets:
    (c1, c2, c3)
    (c1, c2)
    (c1)
    ();
**/

/** Note: If you have two columns specified in the GROUP BY clause:
    GROUP BY c1, c2 WITH ROLLUP

Then the ROLLUP generates the following grouping sets:
    (c1, c2)
    (c1)
    ();
**/

-- Example:

SELECT
    productLine,
    orderYear,
    SUM(orderValue) as totalOrderValue
FROM
    product_sales
GROUP BY
    productLine,
    orderYear
WITH ROLLUP;

-- Note: The hierarchy in this case is "productLine" > "orderYear";

-- Query with reversed hierarchy:
SELECT
    orderYear,
    productLine,
    SUM(orderValue) as totalOrderValue
FROM
    product_sales
GROUP BY
    orderYear,
    productLine
WITH ROLLUP;


-- The GROUPING function:

/** Note: The GROUPING function returns 1 for super-aggregate rows (e.g. subtotals or grand totals with NULLs)
    and 0 otherwise, and can be used in SELECT, HAVING, and ORDER BY (from MySQL 8.0.12);
**/

SELECT
    orderYear,
    productLine,
    SUM(orderValue) totalOrderValue,
    GROUPING(orderYear),
    GROUPING(productLine)
FROM
    product_sales
GROUP BY
    orderYear,
    productLine
WITH ROLLUP;

/** Note: The GROUPING function helps identify super-aggregate NULLs (returning 1) in columns like 'orderYear'
    or 'productLine', allowing substitution with meaningful labels instead of displaying NULL; 
**/

-- IF() with GROUPING():

SELECT
    IF(GROUPING(orderYear),
        'All Years',
        orderYear) orderYear,
    IF(GROUPING(productLine),
        'All Product Lines',
        productLine) productLine,
    SUM(orderValue) totalOrderValue
FROM
    product_sales
GROUP BY
    orderYear,
    productLine
WITH ROLLUP;

/** Note: This example uses 'IF()' with 'GROUPING()' to replace super-aggregate NULLs in 'orderYear'
    and 'productLine' with labels like 'All Years' and 'All Product Lines' in a 'ROLLUP' query;
**/

-- End (!_!)