-- 1. How much do the current managers of each department get paid, relative to the average salary for the department? 
-- Is there any department where the department manager gets paid less than the average salary?
-----------------------------------------------------------------------------------------------------
-- First I made a table holding the average salary of each department
CREATE TABLE average_dept_salary AS
SELECT g.dept_name AS 'dept_name', AVG(h.salary) AS average_salary
FROM employees.employees AS e
JOIN employees.dept_emp AS f ON f.emp_no = e.emp_no
JOIN employees.departments AS g ON g.dept_no = f.dept_no
JOIN employees.salaries AS h ON h.emp_no = e.emp_no
WHERE f.to_date = '9999-01-01' AND h.to_date = '9999-01-01'
GROUP BY g.dept_name;

-- then I joined that table onto the table we made with each manager's salary from a previous exercise
-- and added an IF statement creating a new column with whether or not that manager made less than that department's average
SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Manager Name', salary, average_salary, 
	IF(salary < average_salary,1,0) AS less_than_average
FROM employees.salaries
JOIN employees.dept_manager USING (emp_no)
JOIN employees.employees USING(emp_no)
JOIN employees.departments USING(dept_no)
JOIN average_dept_salary USING(dept_name)
WHERE salaries.to_date > NOW() AND dept_manager.to_date > NOW();

-- 2 managers make less than their department's average salary

-----------------------------------------------------------------------------------------------------

-- Use the world database for the questions below.
-- 2. What languages are spoken in Santa Monica?
SELECT `Language`, `Percentage` 
FROM countrylanguage AS a 
JOIN country AS b ON b.Code = a.CountryCode
JOIN city AS c USING(CountryCode)
WHERE c.name = 'Santa Monica';

-----------------------------------------------------------------------------------------------------

-- 3. How many different countries are in each region?
SELECT Region, count(*)
FROM country 
GROUP BY Region
ORDER BY count(*) ASC;

-----------------------------------------------------------------------------------------------------

-- 4. What is the population for each region?
SELECT Region, sum(Population)
FROM country 
GROUP BY Region;

-----------------------------------------------------------------------------------------------------

-- 5. What is the population for each continent?
SELECT continent, sum(Population)
FROM country 
GROUP BY continent
ORDER BY sum(Population) DESC;

-----------------------------------------------------------------------------------------------------

-- 6. What is the average life expectancy globally?
SELECT AVG(LifeExpectancy)
FROM country;

-----------------------------------------------------------------------------------------------------

-- 7. What is the average life expectancy for each region, each continent? Sort the results from shortest to longest


-----------------------------------------------------------------------------------------------------

-- 8. Bonus: Find all the countries whose local name is different from the official name


-- 9. Bonus: How many countries have a life expectancy less than x?


-- 10. Bonus: What state is city x located in?

-- 11. Bonus: What region of the world is city x located in?

-- 12. Bonus: What country (use the human readable name) city x located in?

