USE mysql_sample_db;

-- Note: MySQL supports window func since 8.0 version;


-- Preparations:

CREATE TABLE sales(
	sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14, 2) NOT NULL,
    PRIMARY KEY(sales_employee, fiscal_year)
);

INSERT INTO sales(sales_employee, fiscal_year, sale)
VALUES
	('Bob', 2016, 100),
    ('Bob', 2017, 150),
    ('Bob', 2018, 200),
    ('Alice', 2016, 200),
    ('Alice', 2017, 100),
    ('Alice', 2018, 150),
    ('John', 2016, 200),
    ('John', 2017, 150),
    ('John', 2018, 250);
    
SELECT * FROM sales;


-- Example:

SELECT
	SUM(sale)
FROM
	sales;
    
SELECT
	fiscal_year,
	SUM(sale) AS total_sales
FROM
	sales
GROUP BY
	fiscal_year;
    
-- Note: Aggregate functions need GROUP BY clause to work;

SELECT
	fiscal_year,
    sales_employee,
    sale,
    SUM(sale) OVER (PARTITION BY fiscal_year) AS total_sales
FROM
	sales;
    
    
/** Note: The window funcs are performed on the result set after all JOIN, WHERE, GROUP BY and HAVING clauses
		  and before the ORDER BY, LIMIT and SELECT DISTINCT;
**/


/** Syntax:
window_func_name(expression) OVER (
	[partition_definition]
    [order_definition]
    [frame_definition]
)
**/

/** Note: Parentheses after OVER clause are mandatory, even without an expression, for example:
-- window_function_name(expression) OVER()
**/


/** partition_clause syntax:
PARTITION BY <expression>[{,<expression>...}]
**/


/** order_by_clause syntax:
ORDER BY <expression> [ASC|DESC], [{,<expression>...}]
**/

-- Note: ORDER BY clause should be used only for order-sensitive window functions;


/** frame_clause syntax:
frame_unit {<frame_start>|<frame_between>}

-- Detail explanation:

frame_between:
	BETWEEN frame_start AND frame_end
    
frame_start, frame_end: {
	CURRENT ROW
	| UNBOUNDED PRECEDING
    | UNBOUNDED FOLLOWING
    | <expression> PRECEDING
    | <expression> FOLLOWING
}	
**/

-- Note: A frame is a subset of the current partition;

/** Note: frame_unit can be ROWS or RANGE;
		Both of them need order_by_clause for precise results;
		'ROWS' considers all of order_by_clause elements, 'RANGE' only the first one;
**/

/** Note: If u omit frame_definition MySQL will use that as default:
-- RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
**/

-- Note: Use 'ROWS' for strict control over row positions;

-- Note: Use 'RANGE' for logical calculations based on value ranges;

/** Advance Note: 'RANGE' depends on unique values of the first ORDER BY column.
		If values is not unique, 'RANGE' may include multiple rows for a single offset;
**/


/** Examples:

-- ROWS:

AVG(salary) OVER (
    ORDER BY hire_date
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) AS local_avg_salary

-- Window func to retrieve info about avg wage for an employee and his closest colleagues;


-- RANGE:

SELECT
	sale_id,
    sale_amount,
    SUM(sale_amount) OVER(
		ORDER BY sale_amount
        RANGE BETWEEN 100 PRECEDING AND 100 FOLLOWING
	) AS range_sum
FROM sales;

-- Query to analyse nearest values in the range;

**/


-- WINDOW clause:

SELECT
	sales_employee,
    fiscal_year,
    SUM(sale) OVER fiscal_window AS total_sales,
    ROW_NUMBER() OVER fiscal_window AS row_num
FROM
	sales
WINDOW fiscal_window AS (
	PARTITION BY fiscal_year
    ORDER BY sale
);

/** Note: WINDOW clause is used for creating multiple windows for window functions in the same query.
		It avoids duplication of PARTITION BY and ORDER BY clauses;
**/

-- Note: ROW_NUMBER() assigns a unique rank to each row within the fiscal_year partition, ordered by sale;