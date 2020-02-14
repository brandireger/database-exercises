-- Notes and sample code:
CREATE TEMPORARY TABLE animals (
	NAME VARCHAR(256) NOT NULL
	);
	
SELECT *FROM animals;

INSERT INTO animals (NAME) VALUES ('Bat');
INSERT INTO animals (NAME) VALUES 
('Green Alligator'), ('Long Neck Geese'), ('Chimps'), ('Unicorn');

CREATE TEMPORARY TABLE fruits (
	NAME VARCHAR(256)
	quantity INT UNSIGNED
);

INSERT INTO fruits (NAME, quantity)
VALUES 
('kiwi', 25),
('mango', 17),
('blueberries', 942);

-- 1. Using the example from the lesson, re-create the employees_with_departments table.
CREATE TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

--    Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

-- Update the table so that full name column contains the correct data
UPDATE employees_with_departments 
SET full_name = CONCAT(first_name, '_', last_name);

-- Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;

-- What is another way you could have ended up with this same table?

-- 2. Create a temporary table based on the payment table from the sakila database.
CREATE TEMPORARY TABLE payment AS
SELECT *
FROM sakila.payment;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
-- For example, 1.99 should become 199.
ALTER TABLE payment MODIFY amount DECIMAL(10,2);

UPDATE payment SET amount = amount * 100;

ALTER TABLE payment MODIFY amount INTEGER;

-- 3. Find out how the average pay in each department compares to the overall average pay. 
-- In order to make the comparison easier, you should use the Z-score for salaries. 
-- In terms of salary, what is the best department to work for? The worst?


-- scratch:
CREATE TABLE salary_compare AS 
SELECT emp_no, salary, dept_name
FROM employees.salaries
#JOIN employees.employees USING (emp_no)
JOIN employees.dept_emp USING (emp_no)
JOIN employees.departments USING (dept_no)
WHERE salaries.to_date > NOW();

SELECT * FROM salary_compare;

ALTER TABLE salary_compare ADD salary_z_score FLOAT(36);

ALTER TABLE salary_compare ADD row_x_minus_mean FLOAT(36);

UPDATE salary_compare SET row_x_minus_mean = (salary - (SELECT AVG(salary)));


UPDATE salary_compare SET salary_z_score = 
		(SELECT AVG(salary) AS mean FROM salary_compare)
		(SELECT STD(salary) AS sd FROM salary_compare)
		(SELECT (salary - mean) / sd FROM salary_compare)




