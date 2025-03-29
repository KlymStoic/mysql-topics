USE mysql_sample_db;


-- Note: The WHERE clause allows you to specify a search condition for the rows returned by a query;

/** Syntax:
SELECT
    select_list
FROM
    table_name
WHERE
    search_condition;
**/

/** Note: The search_condition is a combination of one or more expressions using the logical operator AND, OR and NOT.
    In MySQL, a predicate is a Boolean expression that evaluates to TRUE, FALSE, or UNKNOWN.
    The SELECT statement will include any row that satisfies the search_condition in the result set;
**/

/** Note: Besides the SELECT statement, you can use the WHERE clause in the UPDATE or DELETE
    statement to specify which rows to update or delete;
**/

-- Execution order: FROM -> WHERE -> SELECT -> ORDER BY;


-- Examples:

SELECT
    lastName,
    firstName,
    jobTitle
FROM
    employees
WHERE
    jobTitle = 'Sales Rep';
    
SELECT
    lastName,
    firstName,
    jobTitle,
    officeCode
FROM
    employees
WHERE
    jobTitle = 'Sales Rep' AND
    officeCode = 1;

SELECT
    lastName,
    firstName,
    jobTitle,
    officeCode
FROM
    employees
WHERE
    jobTitle = 'Sales Rep' OR
    officeCode = 1
ORDER BY
    officeCode,
    jobTitle;
    

-- BETWEEN Syntax: expression BETWEEN low AND high;

SELECT
    lastName,
    firstName,
    officeCode
FROM
    employees
WHERE
    officeCode BETWEEN 1 AND 3
ORDER BY officeCode;

SELECT
    firstName,
    lastName
FROM
    employees
WHERE
    lastName LIKE '%son'
ORDER BY firstName;


-- IN Syntax: value IN (value1, value2, ...);

SELECT
    firstName,
    lastName,
    officeCode
FROM
    employees
WHERE
    officeCode IN (1, 2, 3)
ORDER BY 
    officeCode;
    

-- IS NULL Syntax: value IS NULL;

SELECT
    lastName,
    firstName,
    reportsTo
FROM
    employees
WHERE
    reportsTo IS NULL;
    
-- Note: In the database world, NULL is a marker that indicates that a value is missing or unknown;


/** The following shows the comparison operators that you can use to form the expression in the WHERE clause:
Operator | Description
=	Equal to. You can use it with almost any data type.
<> 	Not equal to. Also can be typed as !=
<	Less than. You typically use it with numeric and date/time data types.
>	Greater than.
<=	Less than or equal to
>=	Greater than or equal to;
**/

SELECT
    firstName,
    lastName,
    jobTitle
FROM
    employees
WHERE
    jobTitle <> 'Sales Rep';
    
SELECT 
    lastname, 
    firstname, 
    officeCode
FROM
    employees
WHERE 
    officecode > 5;
    
SELECT 
    lastname, 
    firstname, 
    officeCode
FROM
    employees
WHERE 
    officecode <= 4;
    
-- The End !-!