SELECT MIN(salary) FROM t_salaries;
SELECT MAX(salary) FROM t_salaries;

DROP PROCEDURE IF EXISTS procedure_1;

DELIMITER $$
CREATE PROCEDURE procedure_1  (IN min_range INT, IN max_range INT)

BEGIN
SELECT
	e.gender,
    d.dept_name,
    s.salary
FROM
	t_employees e
		JOIN
    t_salaries s ON e.emp_no = s.emp_no
		JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no    
	WHERE AVG(s.salary)	BETWEEN 50000 AND 160000
GROUP BY d.dept_no, e.gender;
END $$

DELIMITER ;


-- Solution

DROP PROCEDURE IF EXISTS filter_salary;

DELIMITER $$
CREATE PROCEDURE filter_salary (IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN
SELECT 
    e.gender, d.dept_name, AVG(s.salary) as avg_salary
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
    WHERE s.salary BETWEEN p_min_salary AND p_max_salary
GROUP BY d.dept_no, e.gender;
END$$

DELIMITER ;

CALL filter_salary(50000, 90000);