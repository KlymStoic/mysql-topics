USE mysql_sample_db;


-- Simple CASE statement:

/** Syntax:
CASE case_value
    WHEN when_value1 THEN statements
    WHEN when_value2 THEN statements
    ...
    [ELSE else_statements]
END CASE;
**/

/** Note: If a `CASE` statement has no `ELSE` clause and none of the `WHEN` conditions match,
        it throws the error: "Case not found for CASE statement.";
**/

/** To avoid the error when the `case_value` does not equal any `when_value`, you can use an empty `BEGIN...END` block in the `ELSE` clause:
CASE case_value
    WHEN when_value1 THEN statements
    WHEN when_value2 THEN statements
    ...
    ELSE
        BEGIN
        END;
END CASE;
**/


-- Example:

