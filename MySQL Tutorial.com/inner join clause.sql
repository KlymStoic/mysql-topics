USE mysql_sample_db;


/** Note: The `INNER JOIN` matches each row in one table with every row in other tables and allows 
        querying rows that contain columns from both tables;
**/

-- Note: It is an optional clause of the `SELECT` statement and appears immediately after the `FROM` clause;

/** Syntax:
SELECT
    column_list
FROM 
    t1
INNER JOIN t2 ON join_condition1
[INNER JOIN t3 ON join_condition2]
...;
**/

/** Note: An `INNER JOIN` returns combined rows from both tables only when the join condition evaluates to TRUE.
        Otherwise, the `INNER JOIN` just ignores the rows;
**/

-- Note: If no row between tables causes the join condition to be evaluated to TRUE, the `INNER JOIN` returns an empty result set;


-- INNER JOIN Example:

SELECT
    productCode,
    productName,
    textDescription
FROM
    products t1
        INNER JOIN
    productlines t2 ON t1.productLine = t2.productLine;

-- Because the joined columns of both tables have the same name `productLine`, you can use the `USING` syntax:

SELECT
    productCode,
    productName,
    textDescription
FROM
    products
INNER JOIN productlines USING (productLine);

-- Note: The query returns the same result set. However, the `USING` syntax is much shorter and cleaner;


-- INNER JOIN with GROUP BY clause Example:

SELECT
    t1.orderNumber,
    t1.status,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orders t1
INNER JOIN orderdetails t2
    ON t1.orderNumber = t2.orderNumber
GROUP BY
    t1.orderNumber;
    
-- Similarly, the following query uses the `INNER JOIN` with the `USING` syntax:

SELECT
    orderNumber,
    status,
    SUM(quantityOrdered * priceEach) total
FROM
    orders
INNER JOIN orderdetails USING (orderNumber)
GROUP BY orderNumber;


-- INNER JOIN – Three tables Example:

SELECT
    orderNumber,
    orderDate,
    orderLineNumber,
    productName,
    productLine,
    quantityOrdered,
    priceEach
FROM
    orderdetails
INNER JOIN
    orders USING (orderNumber)
INNER JOIN
    products USING (productCode)
ORDER BY
    orderNumber,
    orderLineNumber;
    
    
-- INNER JOIN – Four tables Example:

SELECT
    orderNumber,
    orderDate,
    customerName,
    orderLineNumber,
    productName,
    quantityOrdered,
    priceEach
FROM
    orders
INNER JOIN
    orderdetails USING (orderNumber)
INNER JOIN
    products USING (productCode)
INNER JOIN
    customers USING (customerNumber)
ORDER BY
    orderNumber,
    orderLineNumber;
    
    
-- INNER JOIN using other operators:

/** Note: In addition to the equal operator (`=`), you can use other operators such as greater than (`>`),
        less than (`<`), and not-equal (`<>`) operator to form the join condition;
**/

/** The following query uses a less-than (`<`) join to find the sales price of the product whose code is `S10_1678`
        that is less than the manufacturer’s suggested retail price (MSRP) for that product:
**/

SELECT
    orderNumber,
    productName,
    msrp,
    priceEach
FROM
    products p
INNER JOIN
    orderdetails o ON p.productCode = o.productCode
    AND p.MSRP > o.priceEach
WHERE p.productCode = 'S10_1678';

-- End `=_=`