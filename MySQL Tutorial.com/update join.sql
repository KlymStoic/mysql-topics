USE mysql_sample_db;

-- Note: 'UPDATE JOIN' statement used to perform the cross-table update;

/** Syntax:
UPDATE t1
[INNER | LEFT] JOIN t2 ON t1.c1 = t2.c1
SET t1.c2 = t2.c2,
	t2.c3 = expr
WHERE condition;
**/

-- Note: 't1' = table1, 'c1' = column1;

/**Example of implicit JOIN in WHERE clause(Not Recommended):
UPDATE t1
SET t1.c2 = t2.c2,
	t2.c3 = expr
WHERE
	t1.c1 = t2.c1 AND condition;
**/

-- Note: Works, but less readable. Not optimal for perfomance;

/**Example of explicit INNER JOIN(Recommended):
UPDATE t1
INNER JOIN t2 ON t1.c1 = t2.c1
SET t1.c2 = t2.c2,
	t2.c3 = expr
WHERE condition;
**/

-- Note: More readable & structured. Better optimization for MySQL;

-- Preparation:

USE sample_tables;

CREATE TABLE customers (
	id INT AUTO_INCREMENT,
    name VARCHAR(100),
    balance INT,
    PRIMARY KEY(id)
) ENGINE=INNODB;

INSERT INTO customers(name, balance)
VALUES
	('Bob', 500),
    ('Alice', 700);

CREATE TABLE payments (
	customer_id INT PRIMARY KEY,
    amount INT,
    status VARCHAR(25)
) ENGINE=INNODB;

INSERT INTO payments(customer_id, amount, status)
VALUES
	(1, 100, 'pending'),
    (2, 200, 'pending');
    
-- Checking:
SELECT *
FROM customers;

SELECT *
FROM payments;

-- Example:

UPDATE customers c
INNER JOIN payments p ON c.id = p.customer_id
SET
	c.balance = c.balance - p.amount,
    p.status = 'completed'
WHERE p.status = 'pending';

-- Check:
SELECT *
FROM payments;


/** More UPDATE JOIN examples
	... and more preparations! :)
**/

CREATE DATABASE IF NOT EXISTS mysql_hr;

USE mysql_hr;

CREATE TABLE merits (
	performance INT PRIMARY KEY,
    percentage DECIMAL(11, 2) NOT NULL
);

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(255) NOT NULL,
    performance INT DEFAULT NULL,
    salary DEC(11, 2) DEFAULT NULL,
    FOREIGN KEY (performance) REFERENCES merits (performance)
);

INSERT INTO merits(performance, percentage)
VALUES
	(1, 0),
    (2, 0.01),
    (3, 0.03),
    (4, 0.05),
    (5, 0.08);

INSERT INTO employees(emp_name, performance, salary)
VALUES
	('Mary Doe', 1, 50000),
    ('Cindy Smith', 3, 65000),
	('Sue Greenspan', 4, 75000), 
	('Grace Dell', 5, 125000), 
	('Nancy Johnson', 3, 85000), 
	('John Doe', 2, 45000), 
	('Lily Bush', 3, 55000);

    
-- INNER JOIN Examples:

UPDATE employees
INNER JOIN merits ON employees.performance = merits.performance
SET salary = salary + salary * percentage;

-- Note: You can use aliases for tables instead of full names;

-- Check:
SELECT * FROM employees;


-- LEFT JOIN Example:

TRUNCATE TABLE employees;

/** Note: TRUNCATE statement removes all data like DELETE, but retains table structure,
		saves columns setting, and indexes. However, it resets the auto-increment 
        counter(if applicable) and cannot be rolled back in most databases;
**/

INSERT INTO employees(emp_name, performance, salary) 
VALUES 
  ('Mary Doe', 1, 50000), 
  ('Cindy Smith', 3, 65000), 
  ('Sue Greenspan', 4, 75000), 
  ('Grace Dell', 5, 125000), 
  ('Nancy Johnson', 3, 85000), 
  ('John Doe', 2, 45000), 
  ('Lily Bush', 3, 55000),
  ('Jack William', NULL, 43000), 
  ('Ricky Bond', NULL, 52000);
  
-- Note: Added two new employees with NULL performances;

SELECT * FROM employees;

UPDATE employees e
LEFT JOIN merits m ON e.performance = m.performance
SET salary = salary + salary * IFNULL(percentage, 0.015);

-- Note: IFNULL function picks the first of the two expressions that is NOT NULL;

/** Note: Instead of the IFNULL function, you can use COALESCE.
		It works similarly but supports more than two expressions;
**/

-- Check:
SELECT * FROM employees;

-- The end! \(^-^)/