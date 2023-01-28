USE employees;

SELECT DISTINCT
	emp_no, salary, ROW_NUMBER() OVER w AS row_num
FROM 
	salaries
WHERE emp_no = 10001
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);


SELECT
	emp_no, (COUNT(salary) - COUNT(DISTINCT salary)) as diff
FROM
	salaries
GROUP BY emp_no
HAVING diff > 0
ORDER BY emp_no;


SELECT 
	emp_no, salary, DENSE_RANK() OVER w AS rank_num
FROM
	salaries
WHERE emp_no = 11839
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

SELECT 
	emp_no, salary, RANK() OVER w AS rank_num
FROM
	salaries
WHERE emp_no = 11839
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

-- Exercise #1:

-- Write a query containing a window function to obtain all salary values 
-- that employee number 10560 has ever signed a contract for.

-- Order and display the obtained salary values from highest to lowest.

SELECT 
	emp_no, salary, RANK() OVER w AS rank_num
FROM
	salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

-- Solution #1:

SELECT
emp_no,
salary,
ROW_NUMBER() OVER w AS row_num
FROM
salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

-- Exercise #2:

-- Write a query that upon execution, displays the number of 
-- salary contracts that each manager has ever signed while 
-- working in the company.

SELECT 
	dm.emp_no, s.salary, RANK() OVER w AS rank_num
FROM
	salaries s
		JOIN
	dept_manager dm ON s.emp_no = dm.emp_no
WINDOW w AS (PARTITION BY dm.emp_no ORDER BY s.salary DESC);


-- Solution #2:

SELECT
    dm.emp_no, (COUNT(salary)) AS no_of_salary_contracts
FROM
    dept_manager dm
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY emp_no
ORDER BY emp_no;


-- Exercise #3:

-- Write a query that upon execution retrieves a result set containing all salary 
-- values that employee 10560 has ever signed a contract for. Use a window function 
-- to rank all salary values from highest to lowest in a way that equal salary values 
-- bear the same rank and that gaps in the obtained ranks for subsequent rows are allowed.

SELECT 
emp_no, salary, 
DENSE_RANK() OVER w AS rank_num 
FROM 
salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

-- Solution #3:

SELECT
emp_no,
salary,
RANK() OVER w AS rank_num
FROM
salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

-- Exercise #4:

-- Write a query that upon execution retrieves a result set containing all salary values 
-- that employee 10560 has ever signed a contract for. Use a window function to rank all 
-- salary values from highest to lowest in a way that equal salary values bear the same 
-- rank and that gaps in the obtained ranks for subsequent rows are not allowed.

-- Solution #4:

SELECT
emp_no,
salary,
DENSE_RANK() OVER w AS rank_num
FROM
salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);


-- RANKING WINDOW FUNCTIONS AND JOINS TOGETHER

SELECT
	d.dept_no,
    d.dept_name,
    de.emp_no,
    RANK() OVER w AS department_salary_ranking,
    s.salary,
    s.from_date AS salary_from_date,
    s.to_date AS salary_to_date,
    de.from_date AS department_manager_from_date,
    de.to_date AS department_manager_to_date
FROM
	dept_manager de
		JOIN
	salaries s ON s.emp_no = de.emp_no
		AND s.from_date BETWEEN de.from_date AND de.to_date
        AND s.to_date BETWEEN de.from_date AND de.to_date
		JOIN
	departments d ON d.dept_no = de.dept_no
WINDOW w AS (PARTITION BY de.dept_no ORDER BY s.salary DESC);



-- Working with MySQL Ranking Window Functions and Joins Together - Exercise
-- Exercise #1:

-- Write a query that ranks the salary values in descending order of all 
-- contracts signed by employees numbered between 10500 and 10600 inclusive. 
-- Let equal salary values for one and the same employee bear the same rank. 
-- Also, allow gaps in the ranks obtained for their subsequent rows.

-- Use a join on the “employees” and “salaries” tables to obtain the desired result.

SELECT
	d.dept_no,
    d.dept_name,
    e.emp_no,
    RANK() OVER w AS employee_salary_ranking,
    s.salary
    
FROM
	employees e
		JOIN
	salaries s ON e.emp_no = s.emp_no
    AND s.emp_no BETWEEN 10500 AND 10600
		JOIN
	dept_emp de ON e.emp_no = de.emp_no
		JOIN
	departments d ON de.dept_no = d.dept_no
WINDOW w AS (PARTITION BY e.emp_no ORDER BY s.salary DESC);


-- Solution

SELECT
    e.emp_no,
    RANK() OVER w as employee_salary_ranking,
    s.salary
FROM
employees e
JOIN
    salaries s ON s.emp_no = e.emp_no
WHERE e.emp_no BETWEEN 10500 AND 10600
WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);



    

-- Exercise #2:

-- Write a query that ranks the salary values in descending order of the following 
-- contracts from the "employees" database:

-- - contracts that have been signed by employees numbered between 10500 and 
-- 10600 inclusive.

-- - contracts that have been signed at least 4 full-years after the date when 
-- the given employee was hired in the company for the first time.

-- In addition, let equal salary values of a certain employee bear the same rank. 
-- Do not allow gaps in the ranks obtained for their subsequent rows.

-- Use a join on the “employees” and “salaries” tables to obtain the desired result.

-- Solution #2:

SELECT
    e.emp_no,
    DENSE_RANK() OVER w as employee_salary_ranking,
    s.salary,
    e.hire_date,
    s.from_date,
    (YEAR(s.from_date) - YEAR(e.hire_date)) AS years_from_start
FROM
employees e
JOIN
    salaries s ON s.emp_no = e.emp_no
    AND YEAR(s.from_date) - YEAR(e.hire_date) >= 5
WHERE e.emp_no BETWEEN 10500 AND 10600
WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);


-- LAG and LEAD

SELECT 
	emp_no,
    salary,
    LAG(salary) OVER w AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    salary - LAG(salary) OVER w AS diff_salary_current_previous,
    LEAD(salary) OVER w - salary AS diff_salary_next_current
FROM
	salaries
WHERE emp_no = 10001
WINDOW w AS (ORDER BY salary);

-- The LAG() and LEAD() Value Window Functions - Exercise
-- Exercise #1:

-- Write a query that can extract the following information 
-- from the "employees" database:
-- - the salary values (in ascending order) of the contracts 
-- signed by all employees numbered between 10500 and 10600 inclusive
-- - a column showing the previous salary from the given ordered list
-- - a column showing the subsequent salary from the given ordered list
-- - a column displaying the difference between the current salary 
-- of a certain employee and their previous salary
-- - a column displaying the difference between the next salary of a 
-- certain employee and their current salary
-- Limit the output to salary values higher than $80,000 only.
-- Also, to obtain a meaningful result, partition the data by employee number.

SELECT
	emp_no,
    salary,
    LAG(salary) OVER w AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    salary - LAG(salary) OVER w AS diff_salary_current_previous,
    LEAD(salary) OVER w - salary AS diff_salary_next_current
    
FROM salaries
WHERE emp_no BETWEEN 10500 AND 10600 AND salary > 80000
WINDOW w AS (PARTITION BY emp_no ORDER BY salary ASC);

-- Solution #1:

SELECT
emp_no,
    salary,
    LAG(salary) OVER w AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    salary - LAG(salary) OVER w AS diff_salary_current_previous,
	LEAD(salary) OVER w - salary AS diff_salary_next_current
FROM
salaries
    WHERE salary > 80000 AND emp_no BETWEEN 10500 AND 10600
	WINDOW w AS (PARTITION BY emp_no ORDER BY salary);

-- Exercise #2:

-- The MySQL LAG() and LEAD() value window functions can have a second argument, 
-- designating how many rows/steps back (for LAG()) or forth (for LEAD()) 
-- we'd like to refer to with respect to a given record.
-- With that in mind, create a query whose result set contains data 
-- arranged by the salary values associated to each employee number 
-- (in ascending order). Let the output contain the following six columns:
-- - the employee number
-- - the salary value of an employee's contract (i.e. which we’ll consider 
-- as the employee's current salary)
-- - the employee's previous salary
-- - the employee's contract salary value preceding their previous salary
-- - the employee's next salary
-- - the employee's contract salary value subsequent to their next salary
-- Restrict the output to the first 1000 records you can obtain.

SELECT
	emp_no,
    salary AS current_salary,
    LAG(salary) OVER w AS previous_salary,
    LAG(salary, 2) OVER w AS salary_preceding_previous_salary,
    LEAD(salary) OVER w AS next_salary,
    LEAD(salary, 2) OVER w AS salary_subsequent_next_salary
FROM salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary ASC)
LIMIT 1000;


-- Solution #2:

SELECT
	emp_no,
    salary,
    LAG(salary) OVER w AS previous_salary,
	LAG(salary, 2) OVER w AS 1_before_previous_salary,
	LEAD(salary) OVER w AS next_salary,
    LEAD(salary, 2) OVER w AS 1_after_next_salary
FROM
salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary)
LIMIT 1000;


-- MySQL Aggregate Functions in the Context of Window Functions - Part I-Exercise
-- Exercise #1:

-- Create a query that upon execution returns a result set containing the 
-- employee numbers, contract salary values, start, and end dates of the first 
-- ever contracts that each employee signed for the company.

-- To obtain the desired output, refer to the data stored in the "salaries" table.
SELECT
	s1.emp_no,
	s.salary,
    s.from_date,
	s.to_date
FROM
	salaries s
		JOIN
	(SELECT
		emp_no, MIN(from_date) AS from_date
	FROM
		salaries
	GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
	s.to_date > SYSDATE()
		AND s.from_date = s1.from_date;

-- solution 
SELECT
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT
        emp_no, MIN(from_date) AS from_date
    FROM
        salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.from_date = s1.from_date;
    
    
-- MySQL Aggregate Functions in the Context of Window Functions - Part II-Exercise
-- Exercise #1:

-- Consider the employees' contracts that have been signed after the 1st of January 2000 
-- and terminated before the 1st of January 2002 (as registered in the "dept_emp" table).

-- Create a MySQL query that will extract the following information about these employees:
-- - Their employee number

-- - The salary values of the latest contracts they have signed during the suggested time period

-- - The department they have been working in (as specified in the latest contract they've signed 
-- during the suggested time period)

-- - Use a window function to create a fourth field containing the average salary paid in the 
-- department the employee was last working in during the suggested time period. Name that field "average_salary_per_department".

-- Note1: This exercise is not related neither to the query you created nor to the output 
-- you obtained while solving the exercises after the previous lecture.

-- Note2: Now we are asking you to practically create the same query as the one we worked on 
-- during the video lecture; the only difference being to refer to 
-- contracts that have been valid within the period between the 1st of January 2000 and the 1st of January 2002.

-- Note3: We invite you solve this task after assuming that the "to_date" values stored in the 
-- "salaries" and "dept_emp" tables are greater than the "from_date" values stored in these same tables. 
-- If you doubt that, you could include a couple of lines in your code to ensure that 
-- this is the case anyway!

-- Hint: If you've worked correctly, you should obtain an output containing 200 rows.


SELECT
	de2.emp_no, d.dept_name, s2.salary, AVG(s2.salary) OVER w AS average_salary_per_department
FROM
	(SELECT
	de.emp_no, de.dept_no, de.from_date, de.to_date
FROM
	dept_emp de
		JOIN
	(SELECT
		emp_no, MAX(from_date) AS from_date
	FROM
		dept_emp
	GROUP BY emp_no) de1 ON de1.emp_no = de.emp_no
WHERE
	de.to_date BETWEEN 2000-01-01 AND 2002-01-01
		AND de.from_date = de1.from_date) de2
		JOIN
	(SELECT
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
	salaries s
		JOIN
	(SELECT
		emp_no, MAX(from_date) AS from_date
	FROM
		salaries 
	GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
	s.to_date BETWEEN 2000-01-01 AND 2002-01-01
		AND s.from_date = s1.from_date) s2 ON s2.emp_no = de2.emp_no
			JOIN
	departments d ON d.dept_no = de2.dept_no
GROUP BY de2.emp_no, d.dept_name
WINDOW w AS (PARTITION BY de2.dept_no)
ORDER BY de2.emp_no;
    
-- Solution #1:

SELECT
    de2.emp_no, d.dept_name, s2.salary, AVG(s2.salary) OVER w AS average_salary_per_department
FROM
    (SELECT
    de.emp_no, de.dept_no, de.from_date, de.to_date
FROM
    dept_emp de
        JOIN
(SELECT
emp_no, MAX(from_date) AS from_date
FROM
dept_emp
GROUP BY emp_no) de1 ON de1.emp_no = de.emp_no
WHERE
    de.to_date < '2002-01-01'
AND de.from_date > '2000-01-01'
AND de.from_date = de1.from_date) de2
JOIN
    (SELECT
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
    JOIN
    (SELECT
emp_no, MAX(from_date) AS from_date
FROM
salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.to_date < '2002-01-01'
AND s.from_date > '2000-01-01'
AND s.from_date = s1.from_date) s2 ON s2.emp_no = de2.emp_no
JOIN
    departments d ON d.dept_no = de2.dept_no
GROUP BY de2.emp_no, d.dept_name
WINDOW w AS (PARTITION BY de2.dept_no)
ORDER BY de2.emp_no, salary;
    
    
    
    
    
    
    
    
