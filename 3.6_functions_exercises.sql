-- Update your queries for employees whose names start and end with 'E'. 
-- USE concat() TO combine their FIRST AND LAST NAME together AS a single COLUMN named full_name.

SELECT CONCAT(first_name, last_name) AS full_name 
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no DESC;

-- Convert the names produced in your last query to all uppercase.

SELECT UPPER(CONCAT(first_name, last_name)) AS full_name 
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no DESC;

-- For your query of employees born on Christmas and hired in the 90s 
-- USE datediff() TO find how many days they have been working AT the company 
-- (Hint: You will also need TO USE NOW() OR CURDATE())

SELECT *,
	DATEDIFF(NOW(),hire_date) AS days_working
FROM employees
WHERE hire_date LIKE '199%' AND birth_date LIKE '%12-25'
ORDER BY birth_date, hire_date DESC;

-- Find the smallest and largest salary from the salaries table.

SELECT
	min(salary), 
	max(salary)
FROM salaries;

-- Use your knowledge of built in SQL functions to generate a username for all of the employees.
-- A username should be ALL lowercase, 
-- AND consist of the FIRST CHARACTER of the employees FIRST NAME, 
-- the FIRST 4 characters of the employees LAST NAME, 
-- an underscore, 
-- the MONTH the employee was born, 
-- AND the LAST two digits of the YEAR that they were born.

SELECT 
	first_name, last_name, birth_date,
	lower(
		concat(
				LEFT(first_name, 1),
				LEFT(last_name, 4),
				'-',
				LPAD(MONTH(birth_date), 2, 0),	#alt: right(left(birth_date, 7), 2) = month
				RIGHT(YEAR(birth_date), 2)		#alt: right(left(birth_date, 4), 2) = year
			)) AS username
FROM employees
LIMIT 10;

-- Find the number of years each employee has been with the company, not just the number of days. *Bonus* do this without the DATEDIFF function (hint: YEAR)

SELECT *,
	(YEAR(CURDATE()) - YEAR(hire_date)) AS years_working
FROM employees
WHERE hire_date LIKE '199%' AND birth_date LIKE '%12-25'
ORDER BY birth_date, hire_date DESC;

SELECT *,
	YEAR(hire_date) - YEAR(birth_date) AS how_old_hired
FROM employees
LIMIT 10;

SELECT max(hire_date)
FROM employees;




