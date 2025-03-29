USE mysql_sample_db;


/** Note: Typically, you use a SELECT statement to select data from a table in the database, like this:

SELECT select_list
FROM table_name;

But in MySQL, the SELECT statement doesn't require the FROM clause;
**/


/** Syntax: 
SELECT select_list;
**/


-- Example:

SELECT 1 + 1;

-- Note: MySQL includes built-in string, date, and math functions that you can execute using the SELECT statement.

SELECT NOW();

SELECT CONCAT('John', ' ', 'Doe');

-- Note: To change a column name of the result set, you can use a column alias

/** Syntax:
SELECT expression [AS] alias;
**/

SELECT CONCAT('John', ' ', 'Doe') AS name;

-- OR

SELECT CONCAT('John', ' ', 'Doe') name;

-- If the column alias contains spaces, you need to place it inside quotes like this:

SELECT CONCAT('John', ' ', 'Doe') AS 'Full name';

-- End <-_->