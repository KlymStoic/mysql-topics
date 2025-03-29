USE mysql_sample_db;


-- Note: The RANK() numbers each row as one plus the count of rows that come before it;

/** Syntax:
RANK() OVER(
	PARTITION BY <expression>[{,<expression>...}]
    ORDER BY <expression> [ASC|DESC], [{,<expression>...}] 
)
**/

-- Note: Unlike the ROW_NUMBER() function, the RANK() does not always return consecutive integers;

CREATE TABLE t (
	val INT
);

INSERT INTO t(val)
VALUES (1), (2), (2), (3), (3), (3), (4), (4), (5);

SELECT
	val,
    RANK() OVER(
		ORDER BY val
        ) AS `rank`
FROM t;


-- Preparation:

CREATE TABLE IF NOT EXISTS sales(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);
 
INSERT INTO sales(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);
 
SELECT * FROM sales;


-- Example:

SELECT
	sales_employee, 
    fiscal_year,
    sale,
    RANK() OVER(
		PARTITION BY fiscal_year
        ORDER BY sale DESC
        ) AS sales_rank
FROM
	sales;
    
    
-- Common Table Expression(CTE) Example:

WITH order_values AS (
	SELECT
		orderNumber,
		YEAR(orderDate) AS order_year,
        priceEach * quantityOrdered AS order_value,
        RANK() OVER(
			PARTITION BY YEAR(orderDate)
            ORDER BY priceEach * quantityOrdered DESC
            ) AS order_value_rank
	FROM orders
	INNER JOIN orderdetails USING(orderNumber)
)
SELECT *
FROM order_values
WHERE order_value_rank <= 3;

-- Summary: Use the MySQL RANK() function to assign a rank to each row in a result set;

-- The end <3!