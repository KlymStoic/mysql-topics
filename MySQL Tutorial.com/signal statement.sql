USE mysql_sample_db;


/** Syntax:
SIGNAL condition_value
[SET signal_information_item,
	 signal_information_item,...];
**/

/** Note: 'condition_value' indicates the value error that you wanna rise;
	It can be either SQLSTATE or named condition;
**/

/** Note: Generic SQLSTATE value is '45000'. Value should not start with '00',
	because it doesn't not indicate an error;
    '45000' indicates an 'unhandled user-defined exception';
	Named condition is defined with DECLARE ... CONDITION statement;
**/

-- Note: signal_information_item = simple_value_specification;


-- MySQL SIGNAL statement example:

-- Create a sample db and switch to it:
CREATE DATABASE IF NOT EXISTS hr;
USE hr;

-- Create a sample employee table:
CREATE TABLE employees(
	id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

-- Insert some sample data into it:
INSERT INTO employees
VALUES
	(1, 'John Doe', 75000),
    (2, 'Jane Smith', 50000),
    (3, 'Bob Johnson', 90000);
    

