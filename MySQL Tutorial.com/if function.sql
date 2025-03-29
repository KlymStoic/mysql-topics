USE mysql_sample_db;


/** Syntax:
IF(expr, if_true_expr, if_false_expr)
**/

/** Note: expr = expression;
If 'expr' IS NOT NULL and 'expr' != 0 THEN 
func returns 'if_true_expr', otherwise 'if_false_expr';
**/


-- Simple examples:

SELECT IF(1 = 2, 'true', 'false'); -- false;

SELECT IF(1 < 2, 'TRUE', 'FALSE'); -- TRUE;


-- GOAL: Displaying N/A instead of NULL:

SELECT
	customerNumber,
    customerName,
    country,
    state
FROM
	customers;
    
-- With IF func:

SELECT 
    customerNumber,
    customerName,
    country,
    IF(state IS NULL, 'N/A', state) AS state
FROM
    customers;
    
    
-- IF func with aggregate funcs:

-- IF + SUM:

SELECT
	SUM(IF(status = 'Shipped', 1, 0)) AS total_shipped,
    SUM(IF(status = 'Cancelled', 1, 0)) total_cancelled
FROM
	orders;
    

-- IF + COUNT:

SELECT DISTINCT
	status
FROM
	orders
ORDER BY
	status;
    
SELECT 
    COUNT(IF(status = 'Cancelled', 1, NULL)) Cancelled,
    COUNT(IF(status = 'Disputed', 1, NULL)) Disputed,
    COUNT(IF(status = 'In Process', 1, NULL)) 'In Process',
    COUNT(IF(status = 'On Hold', 1, NULL)) 'On Hold',
    COUNT(IF(status = 'Resolved', 1, NULL)) 'Resolved',
    COUNT(IF(status = 'Shipped', 1, NULL)) Shipped
FROM
    orders;

    
-- Same result but with Group By:

SELECT 
    status, COUNT(status)
FROM
    orders
GROUP BY status
ORDER BY status;


-- Note: they are a little bit different, but the info numbers we get are the same