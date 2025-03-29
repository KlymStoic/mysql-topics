USE mysql_sample_db;


-- Note: Every derived table must have its own alias;

/** Syntax:
SELECT
	select_list
FROM
	(SELECT
		select_list
	FROM
		table_1) derived_table
WHERE
	derived_table.c1 > 0;
**/


-- Simple example:

SELECT
	productCode,
    ROUND(SUM(priceEach * quantityOrdered)) AS sales
FROM
	orderdetails
		INNER JOIN
	orders USING (orderNumber)
WHERE
	YEAR(shippedDate) = 2003
GROUP BY
	productCode
ORDER BY
	sales DESC
LIMIT 5;

SELECT
	productName,
    sales
FROM
	(SELECT
		productCode,
		ROUND(SUM(priceEach * quantityOrdered)) AS sales
	FROM
		orderdetails
			INNER JOIN
		orders USING (orderNumber)
	WHERE
		YEAR(shippedDate) = 2003
	GROUP BY
		productCode
	ORDER BY
		sales DESC
	LIMIT 5) top5_products_2003
		JOIN
	products USING (productCode);
    
    
-- Complex example:

SELECT 
    customerNumber,
    ROUND(SUM(quantityOrdered * priceEach)) sales,
    (CASE
        WHEN SUM(quantityOrdered * priceEach) < 10000 THEN 'Silver'
        WHEN SUM(quantityOrdered * priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
        WHEN SUM(quantityOrdered * priceEach) > 100000 THEN 'Platinum'
    END) customerGroup
FROM
    orderdetails
        INNER JOIN
    orders USING (orderNumber)
WHERE
    YEAR(shippedDate) = 2003
GROUP BY customerNumber;

SELECT
	customerGroup,
    COUNT(cg.customerGroup) as groupCount
FROM
	(SELECT 
		customerNumber,
		ROUND(SUM(quantityOrdered * priceEach)) sales,
		(CASE
			WHEN SUM(quantityOrdered * priceEach) < 10000 THEN 'Silver'
			WHEN SUM(quantityOrdered * priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
			WHEN SUM(quantityOrdered * priceEach) > 100000 THEN 'Platinum'
		END) customerGroup
	FROM
		orderdetails
			INNER JOIN
		orders USING (orderNumber)
	WHERE
		YEAR(shippedDate) = 2003
	GROUP BY customerNumber) cg
GROUP BY cg.customerGroup;

-- Note: Derived tables are subqueries in the FROM clause to simplify queries;