USE mysql_sample_db;


-- Note: Table must have either zero or one primary key

/** Note: Primary key can be in the beginning or in the end of list of colums:
CREATE TABLE table_name(
	column1 datatype PRIMARY KEY,
    column2 datatype,
    ...
);

-- OR

CREATE TABLE table_name(
	column1 datatype,
    column2 datatype,
    ...,
    column datatype PRIMARY KEY
);
**/


/** Syntax for multi-column primary key:
CREATE TABLE table_name(
	column1 datatype,
    column2 datatype,
    column3 datatype,
    ...,
    PRIMARY KEY(column1, column2)
);
**/


/** Query to add primary key to existing table:
ALTER TABLE table_name
ADD PRIMARY KEY(column1, column2, ...);
**/


/** Query to remove PK:
ALTER TABLE table_name
DROP PRIMARY KEY;
**/

-- Note: in practice u very rarely remove primary key;


-- Examples:

CREATE TABLE products_example(
	id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

INSERT INTO products_example(id, name)
VALUES
	(1, 'Smartphone'),
    (2, 'Laptop'),
    (3, 'Wireless Headphones');
    
SELECT *
FROM products_example;
    
-- Because of restriction PK provides we get this error when try to insert data with same PK:

INSERT INTO products_example(id, name)
VALUES
	(1, 'Bluetooth Speaker');
    
-- Error Code: 1062. Duplicate entry '1' for key 'products_example.PRIMARY'


DROP TABLE products_example;


-- Note: To exclude this type of error we usually use AUTO_INCREMENT attribute;

CREATE TABLE products_example(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL);
    
INSERT INTO products_example(name)
VALUES
	('Smartphone'),
    ('Laptop'),
    ('Bluetooth Speaker');
    
SELECT *
FROM products_example;

-- MySQL automatically generate id column when new rows inserted;


-- Defining multi-column primary key example:

CREATE TABLE customers_example(
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE favorites_example(
	customer_id INT,
    product_id INT,
    favorite_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(customer_id, product_id)
);


-- How to add PRIMARY KEY to already existing table:

CREATE TABLE tags_example(
	id INT,
    name VARCHAR(25) NOT NULL
);

ALTER TABLE tags_example
ADD PRIMARY KEY(id);

-- And how to remove PK:

ALTER TABLE tags_example
DROP PRIMARY KEY;


-- Removing all tables:

DROP TABLE customers_example;
DROP TABLE favorites_example;
DROP TABLE products_example;
DROP TABLE tags_example;
