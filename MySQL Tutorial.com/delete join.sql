USE mysql_sample_db;

/** Syntax:
DELETE t1, t2
FROM t1
INNER JOIN t2 ON t1.key = t2.key
WHERE condition;
**/

/** Note: After the DELETE statement, if you omit t1 table THE DELETE statement only
		affects t2 table and vice versa;
**/


-- Preparation:

DROP TABLE IF EXISTS t1, t2;

CREATE TABLE t1 (
	id INT AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE t2 (
    id VARCHAR(20) PRIMARY KEY,
    ref INT NOT NULL
);

INSERT INTO t1 VALUES (1), (2), (3);

INSERT INTO t2 (id, ref)
VALUES
	('A', 1),
    ('B', 2),
    ('C', 3);
    

-- INNER JOIN Example:

DELETE t1, t2 FROM t1
		INNER JOIN
    t2 ON t2.ref = t1.id
WHERE t1.id = 1;

-- Output: 2 row(s) affected

-- Check:
SELECT * FROM t1;
SELECT * FROM t2;


-- LEFT JOIN:

/** Syntax:
DELETE t1
FROM t1
		LEFT JOIN
	t2 ON t1.key = t2.key
WHERE
	t2.key IS NULL;
**/

-- Note: LEFT JOIN DELETE removes rows from t1 that have no matching record in the t2 table;

/** Alternative syntax:
DELETE FROM t1
WHERE NOT EXISTS (
	SELECT 1 FROM t2 where t2.key = t1.key
);
**/

SELECT
	c.customerNumber,
    c.customerName,
    orderNumber
FROM
	customers c
		LEFT JOIN
	orders o ON c.customerNumber = o.customerNumber
WHERE
	orderNumber IS NULL;
    
DELETE customers
FROM customers
		LEFT JOIN
	orders ON customers.customerNumber = orders.customerNumber
WHERE
	orderNumber IS NULL;
    
-- Note: Query above removes customers who have not placed any orders;

-- The end !^_^!