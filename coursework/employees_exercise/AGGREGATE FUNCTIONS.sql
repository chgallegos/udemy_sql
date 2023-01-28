-- COUNT

SELECT *
FROM 
	salaries
ORDER BY salary DESC;
 
SELECT 
	COUNT(salary)
FROM
	salaries;
    
SELECT 
	COUNT(from_date)
FROM
	salaries;
    
SELECT 
	COUNT(DISTINCT from_date)
FROM
	salaries;

-- Aggregate functions typically ignore null values. 
-- If you want to include them, you can either indicate a 
-- specific column name or use COUNT(*)

SELECT 
	COUNT(*)
FROM
	salaries;
    
-- COUNT() - exercise
-- How many departments are there in the “employees” database? Use the
-- ‘dept_emp’ table to answer the question.

SELECT
	COUNT(DISTINCT dept_no)
FROM
	dept_emp;
    
-- SUM

SELECT 
	SUM(salary)
FROM
	salaries;
    
SELECT 
	SUM(*)
FROM
	salaries;

-- * doesnt work well with SUM

-- SUM() - exercise
-- What is the total amount of money spent on salaries for all contracts
--  starting after the 1st of January 1997?

SELECT 
	SUM(salary)
FROM 
	salaries
WHERE
	from_date > '1997-01-01';
    
-- MAX and MIN

SELECT 
	MAX(salary)
FROM
	salaries;

SELECT 
	MIN(salary)
FROM
	salaries;

-- MIN() and MAX() - exercise
-- 1. Which is the lowest employee number in the database?

-- 2. Which is the highest employee number in the database?

SELECT
	MIN(emp_no)
FROM employees;

SELECT
	MAX(emp_no)
FROM employees;

-- AVERAGE

SELECT
	AVG(salary)
FROM
	salaries;
    
-- AVG() - exercise
-- What is the average annual salary paid to employees who 
-- started after the 1st of January 1997?

SELECT
	AVG(salary)
FROM 
	salaries
WHERE
	from_date > '1997-01-01';
    
-- ROUND


SELECT
	ROUND(AVG(salary))
FROM
	salaries;
    
SELECT
	ROUND(AVG(salary),2)
FROM
	salaries;

-- ROUND() - exercise
-- Round the average amount of money spent on salaries for all contracts that started 
-- after the 1st of January 1997 to a precision of cents.

SELECT
	ROUND(AVG(salary),2)
FROM 
	salaries
WHERE
	from_date > '1997-01-01';
    
-- IFNULL and COALESCE

SELECT 
    *
FROM
    departments_dup;
    
ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;
    
INSERT INTO departments_dup(dept_no) VALUES ('d010'),('d011');

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no ASC;

ALTER TABLE employees.departments_dup
ADD COLUMN dept_manager VARCHAR(255) NULL AFTER dept_name;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no ASC;

COMMIT;
    
SELECT 
    dept_no,
    IFNULL(dept_name,
			'Department name not provided') AS dept_name,
	IFNULL(dept_manager,
	'Department manager not provided') AS dept_manager
	
FROM 
    departments_dup;
    
SELECT 
    dept_no,
    COALESCE(dept_name,
			'Department name not provided') AS dept_name,
	COALESCE(dept_manager,
	'Department manager not provided') AS dept_manager
    


SELECT *
FROM departments_dup
ORDER BY dept_no;

SELECT
	dept_no,
    dept_name,
    COALESCE(dept_manager, dept_name, 'N/A') AS dept_manager
FROM 
	departments_dup
ORDER BY dept_no ASC;


SELECT
	dept_no,
    dept_name,
    COALESCE('department manager name') AS fake_col
FROM
	departments_dup;
    
-- Another example of using COALESCE() - exercise 1
-- Select the department number and name from the ‘departments_dup’ 
-- table and add a third column where you name the department number 
-- (‘dept_no’) as ‘dept_info’. If ‘dept_no’ does not have a value, use 
-- ‘dept_name’.

SELECT
	dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM departments_dup
ORDER BY dept_no ASC;

-- Another example of using COALESCE() - exercise 2
-- Modify the code obtained from the previous exercise in the following way. 
-- Apply the IFNULL() function to the values from the first and second column, 
-- so that ‘N/A’ is displayed whenever a department number has no value, 
-- and ‘Department name not provided’ is shown if there is no value for ‘dept_name’.

SELECT
	IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name, 'N/A') AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM departments_dup
ORDER BY dept_no ASC;

-- Solution

SELECT
	IFNULL(dept_no, 'N/A') as dept_no,
	IFNULL(dept_name, 'Department name not provided') AS dept_name,
	COALESCE(dept_no, dept_name) AS dept_info
FROM
	departments_dup
ORDER BY dept_no ASC;

