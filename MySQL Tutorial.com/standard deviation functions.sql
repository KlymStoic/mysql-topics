USE mysql_sample_db;


/** Note: Standard deviation measures how spread out the values in a data set are — it shows how much the values vary from the average (mean).
        A low standard deviation means the data values are close to the mean, while a high standard deviation means 
        the values are spread out over a wider range;
**/

-- Note: A standard deviation is a square root of the variance, showing how spread out a set of values is around the mean;

/** Note: "Population standard deviation" uses all values in the dataset, while "sample standard deviation"
        uses only a subset/sample of the values;
**/

-- Note: A sigma letter (σ) represents the standard deviation;

/** Note: "Sample standard deviation" differs from "population standard deviation" because "sample variance" is calculated by
        dividing by 'N−1' (instead of 'N'), where 'N' is the number of values;
**/


-- Standard deviation functions:

/** Note: To calculate "population standard deviation", you use one of the following functions:
        `STD(expression)` – returns the "population standard deviation" of the expression. Returns `NULL` if there is no matching row.
        `STDDEV(expression)` – is equivalent to the `STD` function. It is provided to be compatible with Oracle Database only.
        `STDEV_POP(expression)` – is equivalent to the `STD` function;
**/

-- Note: To calculate the "sample standard deviation", you use the `STDDEV_SAMP(expression)` function;

/** Note: MySQL also provides some functions for "population variance" and "sample variance" calculation:
        `VAR_POP(expression)` – calculates the "population standard variance" of the expression.
        `VARIANCE(expression)` – is equivalent to the `VAR_POP` function.
        `VAR_SAMP(expression)` – calculates the "sample standard variance" of the expression;
**/


-- Table for examples:

SELECT *
FROM orders;


-- Population standard deviation example:

-- First, the following query returns the customer numbers and the number of orders from the `orders` table:

SELECT 
    customerNumber,
    COUNT(*) orderCount
FROM
    orders
WHERE
    `status` = 'Shipped'
GROUP BY 
    customerNumber;
    
-- Second, the following statement calculates the population standard deviation of the number of orders of the customers:

SELECT
    FORMAT(STD(orderCount), 2)
FROM
    (SELECT 
        customerNumber,
        COUNT(*) orderCount
    FROM
        orders
    WHERE
        `status` = 'Shipped'
    GROUP BY 
        customerNumber) derived_table;

-- Note: The result is a decimal with many places. To format it, use the `FORMAT()` function;


-- Sample standard deviation example:

SELECT 
    customerNumber,
    COUNT(*) orderCount
FROM
    orders
WHERE
    `status` = 'Shipped'
GROUP BY 
    customerNumber;
    
SELECT
    FORMAT(STDDEV_SAMP(orderCount), 2)
FROM
    (SELECT 
        customerNumber,
        COUNT(*) orderCount
    FROM
        orders
    WHERE
        `status` = 'Shipped'
    GROUP BY 
        customerNumber) derived_table;


-- The end &_&;