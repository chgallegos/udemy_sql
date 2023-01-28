USE employees_mod;

SELECT
	d.dept_name,
    ee.gender,
    dm.emp_no,
    dm.from_date,
    dm.to_date,
    e.calendar_year,
    CASE
		WHEN dm.to_date < e.calendar_year < dm.from_date THEN 1
        ELSE 0
	END AS active
FROM
	(SELECT
		emp_no,
        gender,
        hire_date,
        YEAR(t_employees.hire_date) AS calendar_year
	FROM
	t_employees) e
    CROSS JOIN
    t_dept_manager dm ON e.emp_no = dm.emp_no
    JOIN
    t_departments d ON dm.dept_no = d.dept_no
    JOIN
    t_employees ee ON ee.emp_no = dm.emp_no
ORDER BY ee.emp_no AND e.calendar_year;

SELECT *
FROM dept_manager
GROUP BY emp_no;


-- Solution

SELECT 
    d.dept_name,
    ee.gender,
    dm.emp_no,
    dm.from_date,
    dm.to_date,
    e.calendar_year,
    CASE
        WHEN YEAR(dm.to_date) >= e.calendar_year AND YEAR(dm.from_date) <= e.calendar_year THEN 1
        ELSE 0
    END AS active
FROM
    (SELECT 
        YEAR(hire_date) AS calendar_year
    FROM
        t_employees
    GROUP BY calendar_year) e
        CROSS JOIN
    t_dept_manager dm
        JOIN
    t_departments d ON dm.dept_no = d.dept_no
        JOIN 
    t_employees ee ON dm.emp_no = ee.emp_no
ORDER BY dm.emp_no, calendar_year;