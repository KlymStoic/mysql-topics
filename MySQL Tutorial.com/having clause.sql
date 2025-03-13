USE mysql_sample_db;

-- Note: without GROUP BY, HAVING = WHERE clause;
SELECT *
FROM
	customers
HAVING
	creditLimit > 45000
ORDER BY
	creditLimit DESC;
    
-- Note: WHERE > GROUP BY > HAVING;

SELECT 
    orderNumber,
    SUM(quantityOrdered) AS itemCount,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orderdetails
GROUP BY orderNumber;

SELECT 
    orderNumber,
    SUM(quantityOrdered) AS itemCount,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orderdetails
GROUP BY 
	orderNumber
HAVING
	total > 10000;
    
    
SELECT 
    orderNumber,
    SUM(quantityOrdered) AS itemCount,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orderdetails
GROUP BY orderNumber
HAVING 
	total > 10000 AND 
	itemCount > 600;
    
    
-- Join through USING clause
SELECT *
FROM
	orderdetails
JOIN orders USING(orderNumber);


SELECT
	orderNumber,
    status,
    SUM(priceEach * quantityOrdered) total
FROM
	orderdetails
		INNER JOIN
	orders USING (orderNumber)
GROUP BY
	orderNumber,
    status
HAVING
	status = 'Shipped' AND
	total > 1000;
    
-- version without USING clause

SELECT
	a.orderNumber,
    status,
    SUM(quantityOrdered * priceEach) AS total
FROM
	orderdetails a
		JOIN
	orders b ON a.orderNumber = b.orderNumber
GROUP BY
	a.orderNumber,
    status
HAVING
	status != 'Shipped' AND
    total < 50000;