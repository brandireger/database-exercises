SELECT first_name, last_name
FROM employees
WHERE last_name IN ('Vidya', 'Maya', 'Irena')

-- SAMPLE
SELECT column_a, column_b, column_c
FROM table_a
WHERE column_a IN (
    SELECT column_a
    FROM table_b
    WHERE column_b = true
);

SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_manager
)
LIMIT 10;

SELECT emp_no
FROM salaries
WHERE salary BETWEEN 67000 AND 70000;

SELECT title, count(*)
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM salaries
	WHERE salary BETWEEN 67000 AND 70000
	AND to_date > NOW()
)
AND to_date > NOW()
GROUP BY title;

-- 1. Find all the employees with the same hire date as employee 101010 using a sub-query.
SELECT CONCAT(first_name, ' ', last_name) AS 'Employee Name', hire_date
FROM employees
WHERE hire_date IN (
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010);

-- 2. Find all the titles held by all employees with the first name Aamod.
-- Results in 314 total titles
SELECT title
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod');

-- Results in 6 unique titles
SELECT title, count(*)
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod')
GROUP BY title;

-- 3. How many people in the employees table are no longer working for the company?
SELECT COUNT(emp_no)
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date < NOW());

-- 4. Find all the current department managers that are female.
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_manager
	WHERE to_date > NOW())
AND gender = 'F';

-- 5. Find all the employees that currently have a higher than average salary.
SELECT first_name, last_name, salary
FROM employees
JOIN salaries USING(emp_no)
WHERE emp_no IN (
	SELECT emp_no
	FROM salaries
	WHERE salary > (SELECT AVG(salary) FROM salaries)
	AND to_date > NOW())
	AND salaries.to_date > NOW()
;

-- 6. How many current salaries are within 1 standard deviation of the highest salary?
SELECT *
FROM salaries
WHERE salary > (SELECT MAX(salary) - STD(salary)
	FROM salaries)
	AND to_date > NOW();

-- BONUS 1. Find all the department names that currently have female managers.
SELECT dept_name
FROM departments
RIGHT JOIN (
	SELECT dept_no FROM dept_manager
	WHERE emp_no IN 
		(SELECT emp_no FROM employees
		WHERE gender = 'F' AND to_date > NOW()
		)) AS fem_mans USING(dept_no)
ORDER BY dept_name;

-- Bonus 2. Find the first and last name of the employee with the highest salary.

-- Bonus 3. Find the department name that the employee with the highest salary works in.


