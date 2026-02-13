USE mysql_sample_db;


-- Note: By definition, a 'view' is a named query stored in the database catalog;

-- Example tables:

SELECT *
FROM customers;

SELECT *
FROM payments;

-- This example query returns data from both the `customers` and `payments` tables using an `INNER JOIN`:

SELECT 
    customerName,
    customerNumber,
    paymentDate,
    amount
FROM
    customers
        INNER JOIN
    payments USING (customerNumber);

/** Note: To reuse the same query (customer name, check number, payment date, amount), you can save it in a `.txt/.sql` file,
        but it’s better to save it on the server as a named query. This named query is called a 'database view', or simply a 'view';
**/


-- Note: To create a new 'view' you use the `CREATE VIEW` statement;

/** Syntax:
CREATE
    [OR REPLACE]
    [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    [DEFINER = user]
    [SQL SECURITY { DEFINER | INVOKER }]
    VIEW view_name [(column_list)]
    AS select_statement
    [WITH [CASCADED | LOCAL] CHECK OPTION]


Note: The `CREATE VIEW` statement creates a new 'view', or replaces an existing 'view' if the `OR REPLACE` clause is given. If the 'view' does 
    not exist, `CREATE OR REPLACE VIEW` is the same as `CREATE VIEW`. If the 'view' does exist, `CREATE OR REPLACE VIEW` replaces it;
**/


-- CREATE VIEW Example:

CREATE VIEW customerPayments AS
    SELECT 
        customerName,
        customerNumber,
        paymentDate,
        amount
    FROM
        customers
            INNER JOIN
        payments USING (customerNumber);
        
SELECT * FROM customerPayments;


/** Note: MySQL can also create a view without referencing any tables (rare in practice), e.g., a `daysofweek` view
    that returns the 7 days of the week;
**/

-- Example:

CREATE VIEW daysofweek (day) AS
    SELECT 'Mon' 
    UNION SELECT 'Tue' 
    UNION SELECT 'Web' 
    UNION SELECT 'Thu' 
    UNION SELECT 'Fri' 
    UNION SELECT 'Sat' 
    UNION SELECT 'Sun';

SELECT * FROM daysofweek;


-- Advantages of MySQL Views:

/** Advantage 1: Simplify complex queries - create a 'view' for a frequently used complex query so you can reuse it with a
        simple `SELECT` instead of rewriting the full query each time;
**/

/** Advantage 2: Keep business logic consistent - put repeated formulas or complex logic into a 'view' so every query uses the 
        same calculation while hiding the complexity;
**/

/** Advantage 3: Add an extra security layer - use views plus privileges to expose only needed columns/rows (e.g., share an `employees`
        view with name and gender for General Administration (GA) department, while keeping SSN/address accessible only to HR);
**/

/** Advantage 4: Enable backward compatibility - after restructuring tables, you can keep old apps working by replacing the old table 
        with a view (drop the table first, then create a view with that same name) that presents the new schema like the original;
**/


-- ThE eNd :)
