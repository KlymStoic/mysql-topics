USE mysql_sample_db;


-- Note: CTE accessible at MySQL after 8.0 version;

/** Syntax:
WITH cte_name [(column_list)] AS (
	-- query
)

SELECT * FROM cte_name;
**/

/** Note: If u omit 'column_list' the CTE will inherit the column names from
		  the result of the query;
**/


-- Example:

WITH customers_from_usa AS (
	SELECT
		customerName,
        state
	FROM
		customers
	WHERE 
		country = 'USA'
)

SELECT *
FROM
	customers_from_usa
WHERE
	state = 'CA'
ORDER BY
	customerName;
    

/** Note: CTE only for current query. 
		  You can't retrieve info from them in another queries;
**/

SELECT *
FROM customers_from_usa;

-- Or you'll get an error;
