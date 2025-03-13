USE mysql_sample_db;

/** Note: A NULL value is different from 0 or ''. It is not equal
		to anything, even itself;
**/

/** Note: Generally, you use the NULL value to indicate that the data is 
		missing, unknown, or not applicable;
**/


-- Example:

DROP TABLE IF EXISTS leads;

CREATE TABLE leads (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    `source` VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(25)
);

-- Note: The primary key column does not accept any NULL value;

INSERT INTO leads (first_name, last_name, `source`, email, phone)
VALUE ('John', 'Doe', 'Web Search', 'john.doe@acme.com', NULL);

-- Note: We don't have John's phone number, so we use a NULL value instead;

INSERT INTO leads (first_name, last_name, `source`, phone)
VALUES
	('Lily', 'Bush', 'Cold Calling', '(408)-555-1234'),
    ('David', 'William', 'Web Search', '(408)-555-4321');
    
-- Note: If we omit the 'email' column in INSERT INTO, by default, it will be a NULL value;

-- Check:
SELECT * FROM leads;


-- SET NULL in UPDATE statement:

UPDATE leads 
SET 
    phone = NULL
WHERE
    id = 3;
    
-- Check:
SELECT * FROM leads;


-- ORDER BY NULL:

SELECT *
FROM leads
ORDER BY phone;

-- Note: NULL values are lower than other values, therefore, it presents the NULL values first;

SELECT *
FROM leads
ORDER BY phone DESC;


-- To test for NULL in a query:

SELECT *
FROM leads
WHERE email IS NULL;

SELECT *
FROM leads
WHERE email IS NOT NULL;


-- GROUP BY:

SELECT email
FROM leads
GROUP BY email;

-- Note: Even though the NULL is not equal to NULL, two NULL values are equal in the GROUP by clause;


-- CREATE INDEX:

CREATE UNIQUE INDEX idx_phone ON leads(phone);

/** Note: MySQL allows multiple NULL values in a UNIQUE index.
		Except with the BDB engine, where NULL values are considered equal;
**/


-- NULL Functions:

-- IFNULL:
SELECT
	id,
    CONCAT_WS(' ', first_name, last_name) full_name,
    IFNULL(phone, 'N/A') phone
FROM
	leads;
    
/** Note: The IFNULL function accepts two parameters and returns the first argument if it is not NULL,
		otherwise, it returns the second argument;
**/


-- COALESCE:
SELECT
	id,
    first_name,
    last_name,
    COALESCE(phone, email, 'N/A') contact
FROM
	leads;
    
-- Note: The COALESCE function accepts a list of arguments and returns the first non-NULL argument;


-- NULLIF:

INSERT INTO leads (first_name, last_name, `source`, email, phone)
VALUE ('Thierry', 'Henry', 'Web Search', 'thierry.henry@acme.com', '');

-- Now, the query won't work as planned:
SELECT
	id,
    first_name,
    last_name,
    COALESCE(phone, email, 'N/A') contact
FROM
	leads;
    
-- Solution with NULLIF:
SELECT
	id,
    first_name,
    last_name,
    COALESCE(NULLIF(phone, ''), email, 'N/A') contact
FROM
	leads;

-- Note: The NULLIF function compares two arguments, and if they are equal, it returns NULL;

-- End ;)