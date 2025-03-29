USE mysql_sample_db;


SELECT * FROM employees;

/** Note: In employees table column 'reportsTo' is self-referencing FK;
		Also it can be called as recursive foreign key;
**/


/**Syntax:
[CONSTRAINT constraint_name]
FOREIGN KEY [foreign_key_name] (column_name, ...)
REFERENCES parent_table(column_name, ...)
[ON DELETE reference_action]
[ON UPDATE reference_action]
**/


/** There are 5 reference options: CASCADE, SET NULL, RESTRICT, NO ACTION, SET DEFAULT;
1. CASCADE = DELETE + UPDATE;
2. SET NULL = SET NULL;
3, 4. RESTRICT = NO ACTION;
5. SET DEFAULT = sets something default;
**/

-- Note: if u omit reference option mysql will choose the default option, usually RESTRICT;

-- Foreign key examples:

CREATE DATABASE fkdemo;

USE fkdemo;

-- Note: 'fk' in 'fkdemo' means foreign key;

CREATE TABLE categories(
	categoryId INT AUTO_INCREMENT PRIMARY KEY,
    categoryName VARCHAR(255)
) ENGINE = INNODB;

CREATE TABLE products (
    productId INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(100) NOT NULL,
    categoryId INT,
    CONSTRAINT fk_category FOREIGN KEY (categoryId)
						   REFERENCES categories (categoryId)
) ENGINE = INNODB;


-- RESTRICT & NO ACTION action:

INSERT INTO categories(categoryName)
VALUES 
	('Smartphone'),
    ('Smartwatch');
    
SELECT * FROM categories;

INSERT INTO products(productName, categoryId)
VALUES
	('iPhone', 1),
    ('MiBand', 2);
    
SELECT * FROM products;

-- That's how it work:

INSERT INTO products(productName, categoryId)
VALUES 
	('iPad', 3);
    
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails...

-- Note: It even automatically works on parent table;

UPDATE categories
SET categoryId = 100
WHERE categoryId = 1;

-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails...


-- CASCADE action:

DROP TABLE products;

CREATE TABLE products(
	productId INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(100) NOT NULL,
    categoryId INT NOT NULL,
    CONSTRAINT fk_category
    FOREIGN KEY (categoryId)
    REFERENCES categories(categoryId)
		ON UPDATE CASCADE
		ON DELETE CASCADE
) ENGINE=INNODB;

INSERT INTO products(productName, categoryId)
VALUES
	('iPhone', 1),
    ('Galaxy Note', 1),
    ('Apple Watch', 2),
    ('Samsung Galaxy Watch', 2);
    
SELECT * FROM products;

UPDATE categories
SET categoryId = 100
WHERE categoryId = 1;

SELECT * FROM categories;
SELECT * FROM products;

-- Note: It make changes in both tables;

DELETE FROM categories
WHERE categoryId = 2;

SELECT * FROM products;

-- Note: It can cause pretty bizarre changes;


-- SET NULL action:

-- First, preparations:

DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;

/** Note: Funny, you can't delete 'categories' before 'products';
Error Code: 3730. Cannot drop table 'categories' referenced by a foreign key 
			constraint 'fk_category' on table 'products'.
**/

CREATE TABLE categories(
    categoryId INT AUTO_INCREMENT PRIMARY KEY,
    categoryName VARCHAR(100) NOT NULL
) ENGINE=INNODB;

CREATE TABLE products(
	productId INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(100) NOT NULL,
    categoryId INT,
    CONSTRAINT fk_category
    FOREIGN KEY (categoryId)
    REFERENCES categories(categoryId)
		ON UPDATE SET NULL
        ON DELETE SET NULL
) ENGINE=INNODB;

INSERT INTO categories(categoryName)
VALUES
	('Smartphone'),
    ('Smartwatch');
    
INSERT INTO products(productName, categoryId)
VALUES
	('iPhone', 1),
    ('Galaxy Note', 1),
    ('Apple Watch', 2),
    ('Samsung Galaxy Watch', 2);
    
-- Testing time!

UPDATE categories
SET categoryId = 100
WHERE categoryId = 1;

SELECT * FROM categories;
SELECT * FROM products;

-- Note: Phones that was at 'products' table now have NULL in 'categoryId' column;

DELETE FROM categories
WHERE categoryId = 2;

SELECT * FROM products;


-- How to drop foreign key constaints:

/** Syntax:
ALTER TABLE table_name
DROP FOREIGN KEY constraint_name;
**/

-- Note: If u omit naming your constraint, then u need to input this query to see it's generated name:

/** Syntax:
SHOW CREATE TABLE table_name;
**/

-- Example:
SHOW CREATE TABLE products;

-- Note: Use 'Toggle wrapping of cell contents';

ALTER TABLE products
DROP FOREIGN KEY products_ibfk_1; -- auto generated FK

-- Note: For curiosity I created table without naming the constraint;

SHOW CREATE TABLE products;


-- How to disable foreign key checks:

-- OFF:
SET foreign_key_checks = 0;

-- ON:
SET foreign_key_checks = 1;

-- Note: If u disable the FK checks, u can load data into tables in any order;