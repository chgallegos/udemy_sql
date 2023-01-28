-- Intro to JOINs - exercise 1
-- If you currently have the ‘departments_dup’ table set up, use DROP COLUMN to remove 
-- the ‘dept_manager’ column from the ‘departments_dup’ table.

-- Then, use CHANGE COLUMN to change the ‘dept_no’ and ‘dept_name’ columns to NULL.

-- (If you don’t currently have the ‘departments_dup’ table set up, create it. 
-- Let it contain two columns: dept_no and dept_name. Let the data type of 
-- dept_no be CHAR of 4, and the data type of dept_name be VARCHAR of 40. 
-- Both columns are allowed to have null values. Finally, insert the 
-- information contained in ‘departments’ into ‘departments_dup’.)

-- Then, insert a record whose department name is “Public Relations”.

-- Delete the record(s) related to department number two.

-- Insert two new records in the “departments_dup” table. Let their values in 
-- the “dept_no” column be “d010” and “d011”.

SELECT *
FROM departments_dup;

ALTER TABLE departments_dup
DROP COLUMN dept_manager;

-- DELETE FROM departments_dup 
-- WHERE
--     dept_name = 'Public Relations';

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

INSERT INTO departments_dup
(
	dept_name
)VALUES
(
	'Public Relations'
);

SELECT *
FROM departments_dup;

DELETE
FROM departments_dup
WHERE
	dept_no = 'd002';

-- Intro to JOINs - exercise 2
-- Create and fill in the ‘dept_manager_dup’ table, using the following code:


DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup 
(
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
);

INSERT INTO dept_manager_dup
SELECT * from dept_manager;

 INSERT INTO dept_manager_dup (emp_no, from_date)

VALUES                
	(999904, '2017-01-01'),
	(999905, '2017-01-01'),
	(999906, '2017-01-01'),
	(999907, '2017-01-01');
	 
DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';

INSERT INTO departments_dup (dept_name)
VALUES                
('Public Relations');

DELETE FROM departments_dup
WHERE
    dept_name = 'd002'; 
    
SELECT
	*
FROM 
	dept_manager_dup
ORDER BY dept_no;

SELECT *
FROM
	departments_dup
ORDER BY dept_no;

-- SELECT
-- 	t1.dept_no, t2_dup.dept_no
-- FROM
-- 	departments_dup AS t1
-- JOIN 
-- 	dep_manager_dup AS t2 on 

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- INNER JOIN - Part II - exercise
-- Extract a list containing information about all managers’ employee number,
-- first and last name, department number, and hire date. 

SELECT e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date 
FROM employees e
INNER JOIN dept_manager m ON e.emp_no = m.emp_no
ORDER BY e.emp_no;
    
SELECT 
    m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM
    dept_manager_dup m
INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;


-- DUPLICATE ROWS

INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup 
VALUES('d009', 'Customer Service');

SELECT *
FROM dept_manager_dup
ORDER BY dept_no ASC;

SELECT *
FROM departments_dup
ORDER BY dept_no ASC;

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
JOIN departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no;

-- remove duplicates by grouping by field that differs most amongst records

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY m.dept_no;

-- LEFT JOIN

DELETE FROM dept_manager_dup
WHERE emp_no = '110228';

DELETE FROM departments_dup
WHERE dept_no = 'd009';

INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup 
VALUES('d009', 'Customer Service');

SELECT *
FROM dept_manager_dup
ORDER BY emp_no ASC;

SELECT *  
FROM departments_dup
ORDER BY dept_no;

SELECT
	m.dept_no, m.emp_no, d.dept_name
FROM 
	dept_manager_dup m
LEFT JOIN departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- swap tables and its the same as making a right join

SELECT
	d.dept_no, m.emp_no, d.dept_name
FROM 
	departments_dup d 
LEFT JOIN dept_manager_dup m ON m.dept_no = d.dept_no
ORDER BY d.dept_no;

SELECT m.dept_no, m.emp_no, d.dept_name
FROM
	dept_manager_dup m
		LEFT JOIN
	departments_dup d ON m.dept_no = d.dept_no
    WHERE dept_name IS NULL
ORDER BY m.dept_no;

-- LEFT JOIN - Part II - exercise
-- Join the 'employees' and the 'dept_manager' tables to return a 
-- subset of all the employees whose last name is Markovitch. See if 
-- the output contains a manager with that name.  

-- Hint: Create an output containing information corresponding 
-- to the following fields: ‘emp_no’, ‘first_name’, ‘last_name’, 
-- ‘dept_no’, ‘from_date’. Order by 'dept_no' descending, and then by 'emp_no'.

SELECT e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
FROM employees e
LEFT JOIN dept_manager m ON e.emp_no = m.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY m.dept_no DESC, e.emp_no DESC;

-- RIGHT JOIN

SELECT 
	m.dept_no, m.emp_no, d.dept_name
FROM
	dept_manager_dup m
		RIGHT JOIN
	departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no;

-- The new and the old join syntax - exercise
-- Extract a list containing information about all managers’ 
-- employee number, first and last name, department number, 
-- and hire date. Use the old type of join syntax to obtain the result.

SELECT dm.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM dept_manager_dup dm, employees e
WHERE dm.emp_no = e.emp_no;

-- Solution

SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM employees e, dept_manager dm
WHERE e.emp_no = dm.emp_no;

-- JOIN AND WHERE USED TOGETHER

SELECT
	e.emp_no, e.first_name, e.last_name, s.salary
FROM
	employees e
		JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE
	s.salary > 145000;

-- JOIN and WHERE Used Together - exercise
-- Select the first and last name, the hire date, and the job title of all employees 
-- whose first name is “Margareta” and have the last name “Markovitch”.

SELECT e.first_name, e.last_name, e.hire_date, t.title
FROM employees e
JOIN titles t ON e.hire_date = t.from_date
WHERE e.first_name = 'Margareta' AND e.last_name = 'Markovitch';

-- solution

SELECT e.first_name, e.last_name, e.hire_date, t.title
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
WHERE e.first_name = 'Margareta' AND e.last_name = 'Markovitch'
ORDER BY e.emp_no;

-- CROSS JOIN

SELECT dm.*, d.*
FROM
	dept_manager dm
		CROSS JOIN
	departments d
ORDER BY dm.emp_no, d.dept_no;

-- old syntax

SELECT dm.*, d.*
FROM
	dept_manager dm,
	departments d
ORDER BY dm.emp_no, d.dept_no;

-- remove CROSS

SELECT dm.*, d.*
FROM
	dept_manager dm
		JOIN
	departments d
ORDER BY dm.emp_no, d.dept_no;

-- WRITING A INNER JOIN WITHOUT THE KEYWORD "ON" IS NOT CONSIDERED BEST PRACTICE,
-- SO ITS IMPORTANT TO WRITE CROSS JOIN WHEN THAT IS THE INTENTION

SELECT dm.*, d.*
FROM
	dept_manager dm
		CROSS JOIN
	departments d
ORDER BY dm.emp_no, d.dept_no;

-- to remove the current department that the manager is managing

SELECT dm.*, d.*
FROM
	dept_manager dm
		CROSS JOIN
	departments d
WHERE d.dept_no <> dm.dept_no
ORDER BY dm.emp_no, d.dept_no;

-- CROSS JOIN AND JOIN

SELECT e.*, d.*
FROM
	dept_manager dm
		CROSS JOIN
	departments d
		JOIN
	employees e ON dm.emp_no = e.emp_no
WHERE d.dept_no <> dm.dept_no
ORDER BY dm.emp_no, d.dept_no;


-- CROSS JOIN - exercise 1
-- Use a CROSS JOIN to return a list with all possible 
-- combinations between managers from the dept_manager 
-- table and department number 9.

SELECT dm.*, d.*
FROM dept_manager dm
CROSS JOIN departments d
WHERE d.dept_no = 'd009'; 

-- solution

SELECT dm.*, d.*
FROM departments d
CROSS JOIN dept_manager dm
WHERE d.dept_no = 'd009'
ORDER BY d.dept_no; 

-- CROSS JOIN - exercise 2
-- Return a list with the first 10 employees with all the departments 
-- they can be assigned to.

-- Hint: Don’t use LIMIT; use a WHERE clause.

-- solution

SELECT e.*, d.*
FROM employees e
	CROSS JOIN
departments d
WHERE
e.emp_no < 10011
ORDER BY e.emp_no, d.dept_name;

-- USING AGGREGATE VALUES WITH JOINS

USE employees;


SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT e.gender, AVG(s.salary) AS average_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

SELECT
	e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
	employees e
		JOIN
	dept_manager m ON e.emp_no = m.emp_no
		JOIN
	departments d ON m.dept_no = d.dept_no
;

SELECT
	e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
	departments d
		JOIN
	dept_manager m ON d.dept_no = m.dept_no
		JOIN
	employees e ON m.emp_no = e.emp_no
    ;
    
-- Join more than two tables in SQL - exercise
-- Select all managers’ first and last name, hire date, 
-- job title, start date, and department name.

SELECT 
	e.first_name,
    e.last_name,
    e.hire_date,
	t.title,
    dm.from_date AS start_date,
    d.dept_name
FROM 
	employees e
		JOIN titles t ON e.emp_no = t.emp_no
		JOIN dept_manager dm ON t.emp_no = dm.emp_no
		JOIN departments d ON dm.dept_no = d.dept_no

WHERE title = 'Manager'
ORDER BY e.emp_no;

-- solution
SELECT

    e.first_name,

    e.last_name,

    e.hire_date,

    t.title,

    m.from_date,

    d.dept_name

FROM

    employees e

        JOIN

    dept_manager m ON e.emp_no = m.emp_no

        JOIN

    departments d ON m.dept_no = d.dept_no

        JOIN

    titles t ON e.emp_no = t.emp_no

WHERE t.title = 'Manager'

ORDER BY e.emp_no;


-- JOINS TIPS AND TRICKS

SELECT 
	d.dept_no, d.dept_name, AVG(salary) AS average_salary
FROM
	departments d
		JOIN
	dept_manager m ON d.dept_no = m.dept_no
		JOIN
	salaries s ON m.emp_no = s.emp_no
    GROUP BY d.dept_name
    ORDER BY d.dept_no
    ;
    
SELECT 
	d.dept_no, d.dept_name, AVG(salary) AS average_salary
FROM
	departments d
		JOIN
	dept_manager m ON d.dept_no = m.dept_no
		JOIN
	salaries s ON m.emp_no = s.emp_no
    GROUP BY d.dept_name
    ORDER BY AVG(salary) DESC;
    
SELECT 
	d.dept_no, d.dept_name, AVG(salary) AS average_salary
FROM
	departments d
		JOIN
	dept_manager m ON d.dept_no = m.dept_no
		JOIN
	salaries s ON m.emp_no = s.emp_no
    GROUP BY d.dept_name
    HAVING average_salary > 60000
    ORDER BY average_salary DESC;

-- Tips and tricks for joins - exercise
-- How many male and how many female managers do we have in the 
-- ‘employees’ database?

SELECT COUNT(DISTINCT e.emp_no) AS employee_count, e.gender
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;

-- solution

SELECT
    e.gender, COUNT(dm.emp_no)
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;


-- UNION VS/UNION ALL

DROP TABlE IF EXISTS employees_dup;
CREATE TABLE employees_dup (
	emp_no INT(11),
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    gender ENUM('M','F'),
    hire_date DATE
    );
    
INSERT INTO employees_dup
SELECT
	e.*
FROM 
	employees e
LIMIT 20;

SELECT *
FROM employees_dup
ORDER BY emp_no ASC;

INSERT INTO employees_dup VALUES
('10001','1953-09-02','Georgi','Facello','M','1986-06-26');

SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
	employees_dup e
WHERE
	e.emp_no = 10001
UNION ALL SELECT
	NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
	m.dept_no,
    m.from_date
FROM 
	dept_manager m;

-- UNION displays only distinct values, UNION ALL IS FASTER but it will display also duplicate values

SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
	employees_dup e
WHERE
	e.emp_no = 10001
UNION SELECT
	NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
	m.dept_no,
    m.from_date
FROM 
	dept_manager m;

-- UNION vs UNION ALL - exercise
-- Go forward to the solution and execute the query. What do you 
-- think is the meaning of the minus sign before subset A in 
-- the last row (ORDER BY -a.emp_no DESC)? 

SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' 
		UNION 
	SELECT 
			NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY - a.emp_no DESC;


	
    



