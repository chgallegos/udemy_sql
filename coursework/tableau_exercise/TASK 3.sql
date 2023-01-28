SELECT
	e.gender,
    d.dept_name,
    ROUND(AVG(s.salary),2) AS salary,
    YEAR(s.from_date) AS calendar_year
FROM
	t_salaries s
		JOIN
	t_employees e ON e.emp_no = s.emp_no	
        JOIN
	t_dept_emp de ON de.emp_no = e.emp_no
		JOIN
	t_departments d ON de.dept_no = d.dept_no
GROUP BY
	e.gender AND d.dept_name AND calendar_year
HAVING calendar_year <= 2002;

SELECT *
FROM t_salaries;

-- Solution 
SELECT 
    e.gender,
    d.dept_name,
    ROUND(AVG(s.salary), 2) AS salary,
    YEAR(s.from_date) AS calendar_year
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no , e.gender , calendar_year
HAVING calendar_year <= 2002
ORDER BY d.dept_no;