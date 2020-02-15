-- 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, 
-- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
SELECT emp_no, dept_no, from_date, to_date,
		IF(to_date > now(),1,0) AS is_current_employee
	FROM dept_emp;

-- 2. Write a query that returns all employee names, and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
-- depending on the first letter of their last name.
SELECT first_name, last_name,
	CASE 
		WHEN last_name < 'I%' THEN 'A-H'
		WHEN last_name < 'R%' THEN 'I-Q'
		WHEN last_name > 'R%' THEN 'R-Z'
		ELSE 'other'
	END AS alpha_group
FROM employees;

-- 3. How many employees were born in each decade?
SELECT count(*),
	(CASE 
		WHEN birth_date > '199%' THEN '90s'
		WHEN birth_date > '198%' THEN '80s'
		WHEN birth_date > '197%' THEN '70s'
		WHEN birth_date > '196%' THEN '60s'
		WHEN birth_date > '195%' THEN '50s'
		WHEN birth_date > '194%' THEN '40s'
		ELSE 'other'
	END )AS decades
FROM employees
GROUP BY decades;

182886	50s
117138	60s

-- Bonus: What is the average salary for each of the following department groups: 
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT AVG(salary) AS 'average_salary',
        CASE 
            WHEN dept_name IN ('research', 'development') THEN 'R&D'
            WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
            WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
            WHEN dept_name IN ('finance', 'human resources') THEN 'Finance & HR'
            ELSE dept_name
            END AS dept_group
FROM employees.departments
JOIN dept_emp USING (dept_no)
JOIN salaries USING (emp_no)
GROUP BY dept_group;


58770.3665	Customer Service
62960.5156	Finance & HR
59101.7450	Prod & QM
59515.8784	R&D
78235.8136	Sales & Marketing
