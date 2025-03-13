-- `parks_and_recreation`

CREATE TEMPORARY TABLE salary_over_45k(
	SELECT
		first_name,
        last_name,
        salary
	FROM
		employee_salary
	WHERE
		salary > 45000
);

SELECT *
FROM
	salary_over_45k;
    
CREATE TEMPORARY TABLE favourite_movie(
	first_name VARCHAR(50),
    last_name VARCHAR(50),
	fv_movie VARCHAR(50)
);

SELECT *
FROM favourite_movie;

INSERT INTO favourite_movie
VALUES('Dima', 'Klymcuk', 'Fight Club');

SELECT *
FROM favourite_movie;

CREATE TEMPORARY TABLE salary_under_50k
SELECT *
FROM
	employee_salary
WHERE
	salary <= 50000;
    
SELECT *
FROM salary_under_50k;


-- `mysql_sample_db`

CREATE TEMPORARY TABLE temp_table(
SELECT * FROM customers
LIMIT 0);

SELECT *
FROM temp_table;
    
