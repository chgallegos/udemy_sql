SELECT *
FROM
	dept_manager;
    
# select the first and last name from the "Employees" table for 
# the same employee numbers that can be found in the "Department Manager" table   
    
    
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);
            
SELECT dm.emp_no
FROM
dept_manager dm;

-- SQL Subqueries with IN nested inside WHERE - exercise
-- Extract the information about all department managers who 
-- were hired between the 1st of January 1990 and the 1st of January 1995.

SELECT *
FROM employees e
WHERE e.emp_no IN (SELECT 
				emp_no dm
			FROM
				dept_manager dm
			WHERE
				from_date BETWEEN '1990-01-01' AND '1995-01-01');

-- solution

SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');
		
-- EXISTS AND NOT EXISTS IN WHERE

-- EXISTS IS BETTER FOR LARGE DATA
-- IN IS BETTER FOR SMALLER SETS

SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no);
            
-- Add ORDER BY

SELECT e.first_name, e.last_name
FROM employees e
WHERE 
	EXISTS( SELECT *
		FROM
			dept_manager dm
		WHERE 
			dm.emp_no = e.emp_no
            ORDER BY emp_no);
            
-- its more professional to add order by to the OUTER QUERY

SELECT e.first_name, e.last_name
FROM employees e
WHERE 
	EXISTS( SELECT *
		FROM
			dept_manager dm
		WHERE 
			dm.emp_no = e.emp_no
            )
ORDER BY emp_no;

-- SQL Subqueries with EXISTS-NOT EXISTS 
-- nested inside WHERE - exercise

-- Select the entire information for all employees 
-- whose job title is “Assistant Engineer”. 

-- Hint: To solve this exercise, use the 'employees' table.

SELECT e.*
FROM employees e
WHERE
	EXISTS( SELECT *
		FROM titles t
			WHERE e.emp_no = t.emp_no AND t.title = 'Assistant Engineer');
            
-- Solution 

SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.emp_no = e.emp_no
                AND title = 'Assistant Engineer');
                
-- SUBQUERIES IN SELECT AND FROM

SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;
    
-- SQL Subqueries nested in SELECT and FROM - exercise 1
-- Starting your code with “DROP TABLE”, 
-- create a table called “emp_manager” (emp_no – integer of 11, not null; dept_no – 
-- CHAR of 4, null; manager_no – integer of 11, not null). 

DROP TABLE IF EXISTS emp_manager;
CREATE TABLE emp_manager
(
	emp_no INT(11) NOT NULL,
    dept_no CHAR (4) NOT NULL,
    manager_no INT (11) NOT NULL
);

-- SQL Subqueries nested in SELECT and FROM - exercise 2

-- Fill emp_manager with data about employees, the number of the department 
-- they are working in, and their managers.

-- Your query skeleton must be:

-- U.*

-- FROM

--                  (A)

-- UNION (B) UNION (C) UNION (D) AS U;

-- A and B should be the same subsets used in the last lecture 
-- (SQL Subqueries Nested in SELECT and FROM). In other words, 
-- assign employee number 110022 as a manager to all employees 
-- from 10001 to 10020 (this must be subset A), and employee 
-- number 110039 as a manager to all employees from 10021 to 
-- 10040 (this must be subset B).

-- Use the structure of subset A to create subset C, where you 
-- must assign employee number 110039 as a manager to employee 110022.

-- Following the same logic, create subset D. Here you must 
-- do the opposite - assign employee 110022 as a manager to employee 110039.

-- Your output must contain 42 rows.

-- Good luck!

Insert INTO emp_manager SELECT 
U.*
FROM
(SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B
    
    UNION SELECT 
    C.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS C
    UNION SELECT 
    D.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS D) AS U;




