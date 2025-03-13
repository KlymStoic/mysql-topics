-- parks and recreation

SELECT
	gender, AVG(salary) AS avg_salary
FROM
	employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id
GROUP BY gender;


SELECT
	gender, AVG(salary) OVER() avg_salary
FROM
	employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id;


SELECT
	dem.first_name,
    dem.last_name, 
    gender, 
    AVG(salary) OVER(PARTITION BY gender) avg_salary
FROM
	employee_demographics dem
		INNER JOIN 
	employee_salary sal ON dem.employee_id = sal.employee_id;
    

SELECT
	dem.first_name,
    dem.last_name, 
    gender, 
    SUM(salary) OVER(PARTITION BY gender)
FROM
	employee_demographics dem
		INNER JOIN 
	employee_salary sal ON dem.employee_id = sal.employee_id;
    
    
SELECT
	dem.first_name,
    dem.last_name, 
    gender,
    salary,
    SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS rolling_total
FROM
	employee_demographics dem
		INNER JOIN 
	employee_salary sal ON dem.employee_id = sal.employee_id;
    

SELECT
	dem.employee_id,
	dem.first_name,
    dem.last_name, 
    gender,
    salary,
    ROW_NUMBER() OVER(PARTITION BY gender) AS row_num,
    RANK() OVER(PARTITION BY gender ORDER BY salary) AS rank_num,
    DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary) AS dense_rank_num
FROM
	employee_demographics dem
		INNER JOIN 
	employee_salary sal ON dem.employee_id = sal.employee_id;
    
    
SELECT
	dem.employee_id,
	dem.first_name,
    dem.last_name, 
    gender,
    salary,
    ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
    RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM
	employee_demographics dem
		INNER JOIN 
	employee_salary sal ON dem.employee_id = sal.employee_id;
    
    
SELECT
	dem.employee_id,
	dem.first_name,
    dem.last_name, 
    gender,
    salary,
    ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary ASC) AS row_num,
    RANK() OVER(PARTITION BY gender ORDER BY salary ASC) AS rank_num,
    DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary ASC) AS dense_rank_num
FROM
	employee_demographics dem
		INNER JOIN 
	employee_salary sal ON dem.employee_id = sal.employee_id;