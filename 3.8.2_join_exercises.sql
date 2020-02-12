USE join_example_db;
SELECT * FROM users;
SELECT * FROM roles;

SELECT * FROM users u
JOIN roles r ON u.role_id = r.id;

SELECT 
	r.name AS role_name, 
	count(*) AS count_all, 		--counts each row
	count(u.id) AS count_users	--counts each user
FROM roles r
LEFT JOIN users u ON u.role_id = r.id
GROUP BY r.name;


USE employees;

-- WRITE a QUERY that shows EACH department along WITH the NAME of the current manager FOR that department.
SELECT h.dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM employees AS e
JOIN dept_manager AS f ON f.emp_no = e.emp_no  
JOIN dept_emp AS g ON g.emp_no = e.emp_no
JOIN departments AS h ON h.dept_no = g.dept_no
WHERE f.to_date = '9999-01-01'
ORDER BY h.dept_name;

-- Alternate solution from class:
SELECT *
FROM departments d
JOIN dept_manager dm ON dm.dept_no = d.dept_no
JOIN employees e ON e.emp_no = dm.emp_no
WHERE dm.to_date > NOW();

-- Find the NAME of ALL departments currently managed BY women.
SELECT h.dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Manager Name'
FROM employees AS e
JOIN dept_manager AS f ON f.emp_no = e.emp_no  
JOIN dept_emp AS g ON g.emp_no = e.emp_no
JOIN departments AS h ON h.dept_no = g.dept_no
WHERE e.gender = 'F' AND f.to_date = '9999-01-01'
ORDER BY h.dept_name;

-- Find the current titles of employees currently working in the Customer Service department.
SELECT g.title AS 'Title', count(*) AS 'Count'
FROM employees AS e
JOIN dept_emp AS f ON f.emp_no = e.emp_no
JOIN titles AS g ON g.emp_no = e.emp_no
WHERE f.dept_no = 'd009' AND f.to_date = '9999-01-01' AND g.to_date = '9999-01-01'
GROUP BY Title
ORDER BY Title;

-- Find the current salary of all current managers.
SELECT g.dept_name AS 'Department Name', CONCAT(e.first_name, ' ', e.last_name) AS 'Name', h.salary AS 'Salary'
FROM employees AS e
JOIN dept_manager AS f ON f.emp_no = e.emp_no
JOIN departments AS g ON g.dept_no = f.dept_no
JOIN salaries AS h ON h.emp_no = e.emp_no
WHERE f.to_date = '9999-01-01' AND h.to_date = '9999-01-01'
ORDER BY g.dept_name;

-- Find the number of employees in each department.
SELECT f.dept_no, g.dept_name, count(*) AS 'num_employees'
FROM employees AS e
JOIN dept_emp AS f ON f.emp_no = e.emp_no
JOIN departments AS g ON g.dept_no = f.dept_no
WHERE f.to_date = '9999-01-01'
GROUP BY g.dept_no
ORDER BY g.dept_no;

-- Which department has the highest average salary?
SELECT g.dept_name AS 'dept_name', AVG(h.salary) AS average_salary
FROM employees AS e
JOIN dept_emp AS f ON f.emp_no = e.emp_no
JOIN departments AS g ON g.dept_no = f.dept_no
JOIN salaries AS h ON h.emp_no = e.emp_no
WHERE f.to_date = '9999-01-01' AND h.to_date = '9999-01-01'
GROUP BY g.dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- Who is the highest paid employee in the Marketing department?
SELECT e.first_name, e.last_name
FROM employees AS e
JOIN dept_emp AS f ON f.emp_no = e.emp_no
JOIN departments AS g ON g.dept_no = f.dept_no
JOIN salaries AS h ON h.emp_no = e.emp_no
WHERE g.dept_no ='d001' AND h.to_date = '9999-01-01'
ORDER BY h.salary DESC
LIMIT 1;

-- Which current department manager has the highest salary?
SELECT e.first_name, e.last_name, h.salary, g.dept_name
FROM employees AS e
JOIN dept_manager AS f ON f.emp_no = e.emp_no
JOIN departments AS g ON g.dept_no = f.dept_no
JOIN salaries AS h ON h.emp_no = e.emp_no
WHERE f.to_date = '9999-01-01' AND h.to_date = '9999-01-01'
ORDER BY h.salary DESC
LIMIT 1;

-- Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT 
	CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', 
	g.dept_name AS 'Department Name',
	CONCAT(man_e.first_name, ' ', man_e.last_name) AS 'Manager Name'
FROM employees AS e
JOIN dept_emp AS f ON f.emp_no = e.emp_no
JOIN departments AS g ON g.dept_no = f.dept_no
JOIN dept_manager AS h ON h.dept_no = f.dept_no
JOIN employees AS man_e ON man_e.emp_no = h.emp_no
WHERE f.to_date = '9999-01-01' AND h.to_date = '9999-01-01'
ORDER BY g.dept_name, e.emp_no;

-- Bonus Find the highest paid employee in each department.
SELECT d.dept_name AS 'Department Name', () as 'Highest Salary'
FROM departments AS d
JOIN employees_with_departments AS e ON e.dept_no = d.dept_no
JOIN salaries AS f ON f.emp_no = e.emp_no
