SELECT
	CONCAT(first_name, ' ', last_name) AS full_name,
    LENGTH(email) AS email_length,
    REPLACE(phone_number, '.', '-') AS phone,
	SUBSTRING(hire_date, 1, 4) AS hire_year,
    SUBSTRING(hire_date, 6, 2) AS hire_month,
    SUBSTRING(hire_date, -2) AS hire_day
FROM
	employees;
    
    
SELECT
	CONCAT(first_name, ' ', last_name) AS full_name,
    LENGTH(email) AS email_length,
    REPLACE(phone_number, '.', '-') AS phone,
    LEFT(hire_date, 4) AS hire_year,
    SUBSTRING(hire_date, 6, 2) AS hire_month,
    RIGHT(hire_date, 2) AS hire_day
FROM
	employees;
    

SELECT
	country_name,
    UPPER(country_name),
    LOWER(country_name),
    country_id,
    LOCATE('A', country_id)
FROM
	countries;