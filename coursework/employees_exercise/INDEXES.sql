SELECT *
FROM employees
WHERE hire_date > '2000-01-01';

CREATE INDEX i_hire_date ON employees(hire_date);

SELECT *
FROM employees
WHERE
	first_name = 'Georgi'
		AND last_name = 'Facello';

CREATE INDEX i_composite ON employees(first_name, last_name);

-- MySQL Indexes - exercise 1
-- Drop the ‘i_hire_date’ index.

DROP INDEX i_hire_date ON employees;

-- MySQL Indexes - solution 1
-- ALTER TABLE employees

-- DROP INDEX i_hire_date;

-- MySQL Indexes - exercise 2
-- Select all records from the ‘salaries’ table of people whose salary is higher 
-- than $89,000 per annum.

-- Then, create an index on the ‘salary’ column of that table, 
-- and check if it has sped up the search of the same SELECT statement.

SELECT *
FROM salaries
WHERE salary > 80000;

CREATE INDEX i_salary_over_80k ON salaries(salary);

-- No speed increase in Query!!


