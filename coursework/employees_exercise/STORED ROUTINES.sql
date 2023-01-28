-- Proceedure 1

USE employees;
DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
	SELECT *
	FROM employees
    LIMIT 1000;

END $$

DELIMITER ;

-- PROCEDURE CREATED! --

-- 2 Ways to invoque procedures:
CALL employees.select_employees();
CALL select_employees();


-- Stored procedures - Example - Part II - exercise
-- Create a procedure that will provide the average salary
-- of all employees.

-- Then, call the procedure.




DELIMITER $$
CREATE PROCEDURE total_average_salary()
BEGIN
	SELECT ROUND(AVG(salary),2)
	FROM employees e
		JOIN salaries s ON e.emp_no = s.emp_no;
END$$

DELIMITER ;

CALL total_average_salary();

-- solution 

-- Stored procedures - Example - Part II - solution

DROP PROCEDURE IF EXISTS avg_salary();

DELIMITER $$

CREATE PROCEDURE avg_salary()
BEGIN
	SELECT AVG(salary)
	FROM salaries;
END$$

DELIMITER ;

CALL avg_salary;
CALL employees.avg_salary;







