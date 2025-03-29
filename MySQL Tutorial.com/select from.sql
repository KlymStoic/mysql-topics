USE mysql_sample_db;


/** Syntax:
SELECT select_list
FROM table_name;
**/

-- Note: MySQL evaluates the FROM clause before the SELECT clause;


-- Examples:

-- 1) Single column:

SELECT lastName
FROM employees;


-- 2) Multiple columns:

SELECT
	lastName,
    firstName,
    jobTitle
FROM
	employees;
    

-- 3) All columns:

SELECT
	employeeNumber,
    lastName,
    firstName,
    extension,
    email,
    officeCode,
    reportsTo,
    jobTitle
FROM
	employees;

-- OR

SELECT *
FROM employees;

-- Note: The "SELECT *" is often called "select star" or "select all" since it selects data from all columns;

-- End ;-_-;