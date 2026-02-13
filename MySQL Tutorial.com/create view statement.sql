USE mysql_sample_db;


-- Note: The `CREATE VIEW` statement creates a new 'view' in the database;

/** Syntax:
CREATE [OR REPLACE] VIEW [db_name.]view_name [(column_list)]
AS
  select-statement;
**/ 

/** Note: First, after `CREATE VIEW`, choose a database-unique view name that doesn’t match any existing table name.
        Second, use `OR REPLACE` to overwrite the view if it already exists; if it doesn’t, it does nothing.
        Third, specify the view’s columns, by default they come from the `SELECT` list, or you can list them explicitly in parentheses
        after the view name.
        Finish with a `SELECT` that defines the 'view' (from tables or views); `ORDER BY` in the view is allowed in MySQL but is ignored if
        the outer query has its own `ORDER BY`;

**/

-- Note: The `CREATE VIEW` uses the current database by default, or you can create it in a specific database by qualifying the view name with the database name.


-- Example Tables:

SELECT *
FROM orderdetails;

SELECT *
FROM orders;

SELECT *
FROM customers;


-- Examples:

SELECT
    orderNumber,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orderdetails
GROUP BY
    orderNumber
ORDER BY
    total DESC;
    
CREATE VIEW salesPerOrder AS
    SELECT 
        orderNumber,
        SUM(quantityOrdered * priceEach) AS total
    FROM
        orderdetails
    GROUP BY orderNumber
    ORDER BY total DESC;
    
SELECT * FROM salesPerOrder;


-- Note: In MySQL, `SHOW TABLES` lists views too - so 'view' `salesPerOrder` will appear alongside tables in the `classicmodels` database;

SHOW TABLES;


-- Note: To know which object is a 'view' or 'table', you use the `SHOW FULL TABLES` command;

SHOW FULL TABLES;


-- Note: MySQL allows you to create a 'view' based on another 'view';

-- Example:

SELECT *
FROM
    salesPerOrder
WHERE
    total > 60000;

CREATE VIEW bigSalesOrder AS
    SELECT *
    FROM
        salesPerOrder
    WHERE
        total > 60000;

SELECT 
    orderNumber,
    total
FROM
    bigSalesOrder;
    

-- JOIN Example:

SELECT
    orderNumber,
    customerName,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orderdetails
        INNER JOIN
    orders USING (orderNumber)
        INNER JOIN
    customers USING (customerNumber)
GROUP BY
    orderNumber,
    customerName;
    
CREATE OR REPLACE VIEW customerOrders AS 
    SELECT
        orderNumber,
        customerName,
        SUM(quantityOrdered * priceEach) AS total
    FROM
        orderdetails
            INNER JOIN
        orders USING (orderNumber)
            INNER JOIN
        customers USING (customerNumber)
    GROUP BY
        orderNumber,
        customerName;
        
SELECT * FROM customerOrders
ORDER BY total DESC;


-- Subquery Example:

SELECT 
    productCode,
    productName,
    buyPrice
FROM
    products
WHERE
    buyPrice > (
        SELECT 
            AVG(buyPrice)
        FROM
            products)
ORDER BY buyPrice DESC;

CREATE VIEW aboveAvgProducts AS
    SELECT 
        productCode,
        productName,
        buyPrice
    FROM
        products
    WHERE
        buyPrice > (
            SELECT 
                AVG(buyPrice)
            FROM
                products)
    ORDER BY buyPrice DESC;

-- The view contains products whose buy prices are higher than the average price of all products:

SELECT *
FROM aboveAvgProducts;


-- Explicit Columns Example:

SELECT
    customerName,
    COUNT(orderNumber)
FROM
    customers
        INNER JOIN
    orders USING (customerNumber)
GROUP BY
    customerName;
    
CREATE VIEW customerOrderStats (
    customerName,
    orderCount
) 
AS
    SELECT 
        customerName,
        COUNT(orderNumber)
    FROM
        customers
            INNER JOIN
        orders USING (customerNumber)
    GROUP BY customerName;
    
SELECT 
    customerName,
    orderCount
FROM
    customerOrderStats
ORDER BY 
	orderCount, 
    customerName;
    

-- EnD :P