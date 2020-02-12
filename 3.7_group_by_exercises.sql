-- In your script, use DISTINCT to find the unique titles in the titles table.

SELECT DISTINCT title
FROM titles;

-- Find your query for employees whose last names start and end with 'E'. 
-- UPDATE the QUERY find just the UNIQUE LAST NAMES that START AND END WITH 'E' USING GROUP BY.

SELECT last_name 
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;

-- Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'.

SELECT first_name, last_name 
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY first_name, last_name;

-- Find the unique last names with a 'q' but not 'qu'.
SELECT last_name 
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

-- Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.

SELECT last_name, COUNT(*) AS 'count' 
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY COUNT(*);

-- Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. 
SELECT gender, COUNT(*) 
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender
ORDER BY COUNT(*) DESC;

-- Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames? yes there are 13,251 usernames with more than one user

SELECT lower(concat(
				LEFT(first_name, 1),
				LEFT(last_name, 4),
				'-',
				LPAD(MONTH(birth_date), 2, 0),	#alt: right(left(birth_date, 7), 2) = month
				RIGHT(YEAR(birth_date), 2)		#alt: right(left(birth_date, 4), 2) = year
			)) AS username,
		count(*)
FROM employees
GROUP BY username 
HAVING count(*) > 1;