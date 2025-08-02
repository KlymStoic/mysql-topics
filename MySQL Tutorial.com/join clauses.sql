USE mysql_sample_db;


/** Note: A join is a method of linking data between one (self-join) or more tables
        based on the values of the common column between the tables;
**/

/** Note: To join tables, you use the `CROSS JOIN`, `INNER JOIN`, `LEFT JOIN`, or `RIGHT JOIN` clause.
        The `JOIN` clause is used in the `SELECT` statement appeared after the `FROM` clause;
**/

-- Note: MySQL hasn’t supported the `FULL OUTER JOIN` yet;


-- Setting up sample tables:

CREATE TABLE members (
    member_id INT AUTO_INCREMENT,
    `name` VARCHAR(100),
    PRIMARY KEY (member_id)
);

CREATE TABLE committees (
    committee_id INT AUTO_INCREMENT,
    `name` VARCHAR(100),
    PRIMARY KEY (committee_id)
);

INSERT INTO members(name)
VALUES('John'),('Jane'),('Mary'),('David'),('Amelia');

INSERT INTO committees(name)
VALUES('John'),('Mary'),('Amelia'),('Joe');

-- Check:

SELECT *
FROM members;

SELECT *
FROM committees;


-- INNER JOIN clause:

/** Syntax:
SELECT column_list
FROM table1
INNER JOIN table2 ON join_condition;    
**/

/** Note: An inner join returns only the rows with matching values in both tables based on a join predicate, 
        which is the condition used to compare rows;
**/

/** Note: If the join condition uses the equality operator (`=`) and the matching column names are the same in both tables,
        you can simplify the syntax by using the `USING` clause;
**/

/** Syntax:
SELECT column_list
FROM table1
INNER JOIN table2 USING (column_name);
**/

-- INNER JOIN Example:

SELECT 
    m.member_id,
    m.name AS member,
    c.committee_id,
    c.name AS committee
FROM
    members AS m
        INNER JOIN
    committees AS c ON c.name = m.name;
    
/** Note: In this example, the `INNER JOIN` clause matches rows from the `members` and `committees`
        tables using the values in their shared `name` columns;
**/

-- Note: Because both tables use the same column (`name`) to match, you can simplify the query by using the `USING` clause, as shown below:

SELECT 
    m.member_id,
    m.name AS member,
    c.committee_id,
    c.name AS committee
FROM
    members AS m
        INNER JOIN
    committees AS c USING (name);
    

-- LEFT JOIN clause:

/** Note: `LEFT JOIN` returns all rows from the left table and matching rows from the right. If no match,
        right-side columns are `NULL`;
**/

/** Syntax:
SELECT column_list
FROM table1
LEFT JOIN table2 ON join_condition;
**/

-- Note: The `LEFT JOIN` also supports the `USING` clause if the column used for matching in both tables is the same:

/** Syntax:
SELECT column_list
FROM table1
LEFT JOIN table2 USING (column_name);
**/

-- LEFT JOIN Example:

SELECT 
    m.member_id,
    m.name AS member,
    c.committee_id,
    c.name AS committee
FROM
    members m
        LEFT JOIN
    committees c ON c.name = m.name;
    
-- This statement uses the `LEFT JOIN` clause with the `USING` syntax:

SELECT 
    m.member_id,
    m.name AS member,
    c.committee_id,
    c.name AS committee
FROM
    members m
        LEFT JOIN
    committees c USING (name);
    
-- Note: To find members who are not the committee members, you add a `WHERE` clause and `IS NULL` operator as follows:

SELECT 
    m.member_id,
    m.name AS member,
    c.committee_id,
    c.name AS committee
FROM
    members m
        LEFT JOIN
    committees c USING (name)
WHERE committee_id IS NULL;


-- RIGHT JOIN clause:

/** Note: `RIGHT JOIN` works like `LEFT JOIN` but starts with the right table, returning all
        its rows and matching rows from the left; unmatched left-side columns are `NULL`;
**/

/** Syntax:
SELECT column_list
FROM table1
RIGHT JOIN table2 ON join_condition;
**/

-- Note: Similar to the `LEFT JOIN` clause, the `RIGHT JOIN` clause also supports the `USING` syntax:

/** Syntax:
SELECT column_list
FROM table1
RIGHT JOIN table2 USING (column_name);
**/

/** Note: To find rows in the right table that do not have corresponding rows in the left table,
        you also use a `WHERE` clause with the `IS NULL` operator:
**/

/** Syntax:
SELECT column_list 
FROM table_1 
RIGHT JOIN table_2 USING (column_name)
WHERE column_table_1 IS NULL;
**/

-- RIGHT JOIN Example:

SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
        RIGHT JOIN
    committees c ON c.name = m.name;
    
-- Note: The following statement uses the `RIGHT JOIN` clause with the `USING` syntax:

SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
RIGHT JOIN committees c USING(name);

-- Note: To find the committee members who are not in the `members` table, you use this query:

SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
RIGHT JOIN committees c USING(name)
WHERE m.member_id IS NULL;


-- CROSS JOIN clause:

-- Note: Unlike the `INNER JOIN`, `LEFT JOIN`, and `RIGHT JOIN`, the `CROSS JOIN` clause does not have a join condition;

/** Note: `CROSS JOIN` returns a Cartesian product of two tables, combining each row from the first table
        with every row from the second. It returns `n x m` rows;
**/

-- Note: A Cartesian product is the set of all possible combinations of rows from two tables;

/** Syntax:
SELECT column_list
FROM table1
CROSS JOIN table2;
**/

-- CROSS JOIN Example:

SELECT 
    m.member_id,
    m.name AS member,
    c.committee_id,
    c.name AS committee
FROM
    members m
        CROSS JOIN
    committees c;


/** Note: The `CROSS JOIN` is useful for generating planning data. For example, you can carry the
        sales planning by using the `CROSS JOIN` of customers, products, and years;
**/

-- The End 3_3;