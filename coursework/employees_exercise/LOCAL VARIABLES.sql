-- Local Variables

SET @v_avg_salary = 0;
CALL employees.emp_avg_salary_out(11300, @v_avg_salary);
SELECT @v_avg_salary;

DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$

CREATE FUNCTION f_emp_avg_salary (p_emp_no INT) RETURNS DECIMAL (10,2)
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

SELECT v_avg_salary;

-- another exercise

DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INT) RETURNS DECIMAL (10,2)
BEGIN

DECLARE v_avg_salary DECIMAL(10,2);

BEGIN
	DECLARE v_avg_salary_2 DECIMAL(10,2);
END;

SELECT
	AVG(s.salary)
INTO v_avg_salary_2 FROM
	employees e
		JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;
RETURN v_avg_salary_2;
END$$

DELIMITER ;


