SELECT
	emp_no,
    first_name,
    last_name,
	CASE
		WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
	END AS gender
FROM
	employees;

-- Other way

SELECT
	emp_no,
    first_name,
    last_name,
	CASE gender
		WHEN 'M' THEN 'Male'
        ELSE 'Female'
	END AS gender
FROM
	employees;
    
-- another example

SELECT 
	e.emp_no,
    e.first_name,
    e.last_name,
    CASE
		WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
	END AS is_manager
FROM
	employees e
		LEFT JOIN
	dept_manager dm ON dm.emp_no = e.emp_no
WHERE
	e.emp_no > 109990;
    
-- sometimes it wont work to put column name next to CASE

SELECT 
	e.emp_no,
    e.first_name,
    e.last_name,
    CASE dm.emp_no
		WHEN NOT NULL THEN 'Manager'
        ELSE 'Employee'
	END AS is_manager
FROM
	employees e
		LEFT JOIN
	dept_manager dm ON dm.emp_no = e.emp_no
WHERE
	e.emp_no > 109990;
    
-- other example IF

SELECT
	emp_no,
    first_name,
    last_name,
    IF(gender = 'M', 'Male', 'Female') AS gender
FROM
	employees;
    
-- IF has limitations, CASE can use multiple conditions

SELECT
	dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
		WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'Salary was raised by more than $20,000 but less than $30,000'
        
        ELSE 'Salary was raised by less than $20,000'
    END AS salary_increase
FROM 
	dept_manager dm
		JOIN
	employees e ON e.emp_no = dm.emp_no
		JOIN
	salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

-- The CASE Statement - exercise 1
-- Similar to the exercises done in the lecture,
--  obtain a result set containing the employee number, 
--  first name, and last name of all employees with a number 
--  higher than 109990. Create a fourth column in the query, 
--  indicating whether this employee is also a manager, 
--  according to the data provided in the dept_manager table, 
--  or a regular employee. 

SELECT 
	e.emp_no,
    e.first_name,
    e.last_name,
    CASE
		WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
	END AS is_manager
FROM
	employees e
		LEFT JOIN
	dept_manager dm ON dm.emp_no = e.emp_no
WHERE
	e.emp_no > 109990;		

-- The CASE Statement - exercise 2
-- Extract a dataset containing the following information about the 
-- managers: employee number, first name, and last name. 
-- Add two columns at the end – one showing the difference between 
-- the maximum and minimum salary of that employee, and another one saying 
-- whether this salary raise was higher than $30,000 or NOT.

-- If possible, provide more than one solution.

SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
	CASE 
		WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary raise was higher than 30K'
        WHEN MAX(s.salary) - MIN(s.salary) < 30000 THEN 'Salary raise wasnt higher than 30k'
	END AS salary_increase
FROM dept_manager dm
		JOIN
	employees e ON e.emp_no = dm.emp_no
		JOIN
	salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

-- Solution 1

SELECT

    dm.emp_no,  

    e.first_name,  

    e.last_name,  

    MAX(s.salary) - MIN(s.salary) AS salary_difference,  

    CASE  

        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'  

        ELSE 'Salary was NOT raised by more then $30,000'  

    END AS salary_raise  

FROM  

    dept_manager dm  

        JOIN  

    employees e ON e.emp_no = dm.emp_no  

        JOIN  

    salaries s ON s.emp_no = dm.emp_no  

GROUP BY s.emp_no;  

-- Solution 2   

SELECT  

    dm.emp_no,  

    e.first_name,  

    e.last_name,  

    MAX(s.salary) - MIN(s.salary) AS salary_difference,  

    IF(MAX(s.salary) - MIN(s.salary) > 30000, 'Salary was raised by more then $30,000', 'Salary was NOT raised by more then $30,000') AS salary_increase  

FROM  

    dept_manager dm  

        JOIN  

    employees e ON e.emp_no = dm.emp_no  

        JOIN  

    salaries s ON s.emp_no = dm.emp_no  

GROUP BY s.emp_no;

-- The CASE Statement - exercise 3
-- Extract the employee number, first name, and last name of the 
-- first 100 employees, and add a fourth column, called “current_employee” 
-- saying “Is still employed” if the employee is still working in the company, 
-- or “Not an employee anymore” if they aren’t.

-- Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ 
-- table to solve this exercise. 

SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    dm.to_date,
	IF(dm.to_date > sysdate(), 'Is still employed', 'Not an employee anymore') AS current_employee
FROM
	dept_emp dm
		JOIN
	employees e ON e.emp_no = dm.emp_no
GROUP BY dm.emp_no;
    

-- The CASE Statement - solution 3
SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;
    








