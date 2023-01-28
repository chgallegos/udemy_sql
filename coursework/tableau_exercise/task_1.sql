USE employees_mod;
SELECT 
    YEAR(de.from_date) AS calendar_year,
    e.gender AS gender,
    COUNT(e.emp_no) AS number_of_employees
FROM
	t_employees e
		JOIN
	t_dept_emp de ON de.emp_no = e.emp_no

WHERE de.from_date > 1990-01-01
GROUP BY
	YEAR(de.from_date);

-- solution

SELECT 
    YEAR(d.from_date) AS calendar_year,
    e.gender AS gender,
    COUNT(e.emp_no) AS number_of_employees
FROM
	t_employees e
		JOIN
	t_dept_emp d ON d.emp_no = e.emp_no
GROUP BY
	calendar_year, e.gender
HAVING calendar_year >= 1990-01-01;

