SHOW DATABASES;

USE employees;

SHOW TABLES;
#INT, DATE, VARCHAR, ENUM
#Numeric types: 'salaries' has a column with real numbers, employee id is an INT but it is the primary key 
#String types: 'departments' has department name, 'employees' has first & last names, and 'titles' has title name string types
#Date types: 'employees' has date hired and birth date, 'titles' and 'salaries' has from and to, 'dept_emp' has from and to
#'Employees' has an id of employee number, the 'department' has an id of department number, the table 'dept_emp' ties each employee number to a department number

SHOW CREATE TABLE `dept_manager`;