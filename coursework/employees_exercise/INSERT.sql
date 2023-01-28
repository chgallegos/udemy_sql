-- INSERT

SELECT *
FROM employees
ORDER BY emp_no DESC;

INSERT INTO employees 
(	
	emp_no, 
    birth_date, 
    first_name, 
    last_name, 
    gender, 
    hire_date
) VALUES 
(
	999901,
	'1986-04-21',
	'John', 
	'Smith', 
	'M', 
	'2011-01-01'
);


-- The INSERT statement - exercise 1

-- Select ten records from the “titles” table to get a better idea about its content.

-- Then, in the same table, insert information about employee number 999903. 
-- State that he/she is a “Senior Engineer”, who has started working in this 
-- position on October 1st, 1997.

INSERT INTO titles
(
	emp_no,
	title,
    from_date
)
VALUES
(
	999903,
    'Senior Engineer',
    '1997-10-01'
);

SELECT *
FROM titles
ORDER BY emp_no DESC;



-- At the end, sort the records from the “titles” table in descending 
-- order to check if you have successfully inserted the new record.

-- Hint: To solve this exercise, you’ll need to insert data in only 3 columns!
-- Don’t forget, we assume that, apart from the code related to the exercises,
-- you always execute all code provided in the lectures. This is particularly 
-- important for this exercise. If you have not run the code from the previous
-- lecture, called ‘The INSERT Statement – Part II’, where you have to insert 
-- information about employee 999903, you might have trouble solving this exercise!

INSERT INTO employees
VALUES
(
    999903,
    '1977-09-14',
    'Johnathan',
    'Creek',
    'M',
    '1999-01-01'
);

SELECT *
FROM titles
LIMIT 10;

-- INSERTING DATA INTO A NEW TABLE

SELECT *
FROM departments
LIMIT 10;

CREATE TABLE departments_dup
(
	dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

INSERT INTO departments_dup
(
	dept_no,
    dept_name
)
SELECT *
FROM departments;

SELECT * 
FROM departments_dup;

-- Inserting Data INTO a New Table - exercise

-- Create a new department called “Business Analysis”.
-- Register it under number ‘d010’.

-- Hint: To solve this exercise, use the “departments” table.

SELECT *
FROM departments;

INSERT INTO departments
VALUES
(
	'd010',
    'Business Analysis'
);


-- THE UPDATE STATEMENT I

UPDATE employees
SET
	first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
	emp_no = 999901;
    
SELECT *
FROM employees
ORDER BY emp_no DESC;

-- UPDATE STATEMENT II

SELECT *
FROM departments_dup
ORDER BY dept_no;

COMMIT;

UPDATE departments_dup
SET
	dept_no = 'd011',
    dept_name = 'Quality Control';
    
SELECT *
FROM departments_dup;

ROLLBACK;

SELECT *
FROM departments_dup;

COMMIT;

-- The UPDATE Statement – Part II - exercise
-- Change the “Business Analysis” department name to “Data Analysis”.

-- Hint: To solve this exercise, use the “departments” table.

SELECT *
FROM departments;

UPDATE departments
SET 
	dept_name = 'Data Analysis'
WHERE
    dept_no = 'd010';
    
SELECT *
FROM departments;


-- DELETE STATEMENT

SELECT *
FROM titles
WHERE emp_no = 999903;

DELETE from employees
WHERE 
	emp_no = 999903;

SELECT *
FROM titles
WHERE
    emp_no = 999903;

ROLLBACK;

-- DELETE STATEMENT II

SELECT *
FROM 
	departments_dup
ORDER BY dept_no;

DELETE FROM departments_dup;

SELECT *
FROM 
	departments_dup
ORDER BY dept_no;

ROLLBACK;

SELECT *
FROM 
	departments_dup
ORDER BY dept_no;

-- The DELETE Statement – Part II - exercise
-- Remove the department number 10 record from the “departments” table.

SELECT *
FROM departments;

DELETE FROM departments
WHERE
	dept_no = 'd010';
    
SELECT *
FROM departments;





