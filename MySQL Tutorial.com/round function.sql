USE mysql_sample_db;


-- Note: The `ROUND()` is a mathematical function that allows you to round a number to a specified number of decimal places;

-- Syntax: ROUND(number, [decimal_places]);

-- Note: The number of decimal places (`decimal_places`) is optional. It defaults to zero (0) if you skip it;

-- The following statements are equivalent:

SELECT ROUND(20.5);
-- Output: 21

SELECT ROUND(20.5, 0);
-- Output: 21


/** Note: The `decimal_places` can be positive or negative.
        If positive, the `number` is rounded to that many digits after the decimal point.
        If negative, the `number` is rounded to that many digits before the decimal point (e.g., -1 rounds to tens, -2 to hundreds);
**/

-- Example:

SELECT ROUND(123.2, -2);
-- Output: 100


-- Note: The `ROUND()` function returns a number that has the same data type as the `number` to be rounded;


-- Rounding "exact-value number" rules:

/** Note: When `number` is an "exact-value number", the `ROUND()` function applies the "round to nearest" rule: it rounds to the
        closest integer, and when the fractional part is 0.5 or greater it rounds "away from zero" — so 'positive' values
        "round up" to the next integer (e.g., 2.5 → 3), while 'negative' values "round down" to the next integer (e.g., −2.5 → −3);
**/

-- Examples:

-- For Positive Values:

SELECT ROUND(10.5);
-- Output: 11

SELECT ROUND(10.6);
-- Output: 11


-- For Negative Values:

SELECT ROUND(-10.5);
-- Output: -11

SELECT ROUND(-10.6);
-- Output: -11


/** Note: The value of the fractional part less than .5 is "rounded down" to the next integer if 'positive',
        or "rounded up" to the next integer if 'negative';
**/

-- Example:
SELECT ROUND(10.4);
-- Output: 10

SELECT ROUND(-10.4);
-- Output: -10


-- Rounding "approximate-value number" rules:

/** Note: When rounding an "approximate-value number", the result of the `ROUND()` function depends on the 'C library'.
        Typically, it uses the "round to nearest even" rule i.e., it rounds a value with a fractional part exactly
        halfway between two integers to the nearest even integer;
**/

-- Examples:

SELECT ROUND(2.5E0);
-- Output: 2

SELECT ROUND(-2.5E0);
-- Output: -2


SELECT ROUND(3.5E0);
-- Output: 4

SELECT ROUND(-3.5E0);
-- Output: -4


-- Table for examples:

SELECT *
FROM orderdetails;


-- `ROUND()` function examples:

SELECT
    productCode,
    AVG(quantityOrdered * priceEach) AS avgOrderValue
FROM
    orderdetails
GROUP BY
    productCode;
    
-- Average order values are hard to read due to many decimal places, so use `ROUND()` to round them to 0 decimals (as in the query below):

SELECT
    productCode,
    ROUND(AVG(quantityOrdered * priceEach)) AS avgOrderValue
FROM
    orderdetails
GROUP BY
    productCode;


-- end 8_8;