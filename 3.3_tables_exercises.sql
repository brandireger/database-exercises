SHOW DATABASES;

USE employees;

SHOW TABLES;

DESCRIBE employees;

DESCRIBE departments;

DESCRIBE `employees_with_departments`;

DESCRIBE `dept_emp`;

#INT, DATE, VARCHAR, ENUM
#Numeric types: 'salaries' has a column with real numbers, emp_no is an INT in many tables but it is the primary key 
#String types: 'departments' has department name, 'employees' has first & last names, and 'titles' has title name string types
#Date types: 'employees' has date hired and birth date, 'titles' and 'salaries' has from and to, 'dept_emp' has from and to
#'Employees' has an id of employee number, the 'department' has an id of department number, the table 'dept_emp' ties each employee number to a department number and dept_manager has employee id tied to department number

SHOW CREATE TABLE `dept_manager`;

/* CREATE TABLE `dept_manager` (
  `emp_no` int(11) NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1*/

