USE employees;
DROP procedure IF EXISTS emp_avg_salary;

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
SELECT
	e.first_name, e.last_name, s.salary, s.from_date, s.to_date
FROM employees e
		JOIN
	 salaries s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;
END$$

DELIMITER ;

call emp_salary(11300);

USE employees;
DROP procedure IF EXISTS emp_avg_salary;

DELIMITER $$

USE employees $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
SELECT
	e.first_name, e.last_name, AVG(s.salary)
FROM employees e
		JOIN
	 salaries s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no
GROUP BY e.first_name, e.last_name;
END$$

DELIMITER ;

call emp_avg_salary(11300);

USE employees $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
SELECT
	e.first_name, e.last_name, AVG(s.salary)
FROM employees e
		JOIN
	 salaries s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no
GROUP BY e.first_name, e.last_name;
END$$

DELIMITER ;

call emp_avg_salary(11300);


USE EMPLOYEES;
DROP procedure IF EXISTS emp_avg_salary_out;
DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER, out p_avg_salary DECIMAL(10,2))
BEGIN
SELECT
	AVG(s.salary)
INTO p_avg_salary FROM 
	employees e
		JOIN
	 salaries s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;
END$$

DELIMITER ;



-- Stored procedures with an output parameter - exercise
-- Create a procedure called ‘emp_info’ that uses as parameters 
-- the first and the last name of an individual, and returns their employee number.

DELIMITER $$

CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), 
out p_emp_no integer)

BEGIN
SELECT e.emp_no
INTO p_emp_no FROM employees e
WHERE e.first_name = p_first_name
AND e.last_name = p_last_name;

END$$

DELIMITER ;

-- VARIABLES

SET @v_avg_salary = 0;
CALL employees.emp_avg_salary_out(11300, @v_avg_salary);
SELECT @v_avg_salary;

-- Variables - exercise
-- Create a variable, called ‘v_emp_no’, where you will store 
-- the output of the procedure you created in the last exercise.

-- Call the same procedure, inserting the values ‘Aruna’ 
-- and ‘Journel’ as a first and last name respectively.

-- Finally, select the obtained output.

SET @v_emp_no = 0;
CALL employees.emp_info('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;

-- Variables - solution

SET @v_emp_no = 0;
CALL emp_info('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;

-- USER DEFINED FUNCTIONS


USE employees;
DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
-- DETERMINISTIC NO SQL READS SQL DATA

BEGIN
DECLARE v_avg_salary DECIMAL(10,2);
SELECT
	AVG(s.salary)
INTO v_avg_salary FROM
	employees e
		JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;

RETURN v_avg_salary;
END$$

DELIMITER ; 

SELECT f_emp_avg_salary(11300);

SET @@global.log_bin_trust_function_creators := 1; -- this code is to fix error 1418

-- User-defined functions in MySQL - exercise
-- Create a function called ‘emp_info’ that takes for parameters the 
-- first and last name of an employee, and returns the salary from the 
-- newest contract of that employee.

-- Hint: In the BEGIN-END block of this program, you need to declare and use 
-- two variables – v_max_from_date that will be of the DATE type, 
-- and v_salary, that will be of the DECIMAL (10,2) type.

-- Finally, select this function.

-- solution


DELIMITER $$

CREATE FUNCTION emp_info(p_first_name varchar(255), 
p_last_name varchar(255)) RETURNS decimal(10,2)

BEGIN
DECLARE v_max_from_date date;
DECLARE v_salary decimal(10,2);
SELECT
MAX(from_date)
INTO v_max_from_date FROM employees e
JOIN
salaries s ON e.emp_no = s.emp_no
WHERE
e.first_name = p_first_name
AND e.last_name = p_last_name;
SELECT s.salary
INTO v_salary FROM
employees e
JOIN
salaries s ON e.emp_no = s.emp_no
WHERE
e.first_name = p_first_name
AND e.last_name = p_last_name
AND s.from_date = v_max_from_date;
RETURN v_salary;
END$$
DELIMITER ;

SELECT EMP_INFO('Aruna', 'Journel');

-- Conclusion

SET @v_emp_no = 11300;
SELECT
	emp_no,
    first_name,
	last_name,
    f_emp_avg_salary(@v_emp_no) AS avg_salary
FROM 
	employees
WHERE
	emp_no = @v_emp_no;

USE employees;