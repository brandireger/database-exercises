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
SELECT region, AVG(LifeExpectancy)
FROM country
GROUP BY region
ORDER BY AVG(LifeExpectancy);

SELECT continent, AVG(LifeExpectancy)
FROM country
GROUP BY continent
ORDER BY AVG(LifeExpectancy);

-----------------------------------------------------------------------------------------------------
-- 8. Bonus: Find all the countries whose local name is different from the official name
SELECT `Name`
FROM country
WHERE `Name` NOT IN 
	(SELECT `LocalName` FROM country);

-----------------------------------------------------------------------------------------------------
-- 9. Bonus: How many countries have a life expectancy less than x?
-----------------------------------------------------------------------------------------------------
-- 10. Bonus: What state is city x located in?
-----------------------------------------------------------------------------------------------------
-- 11. Bonus: What region of the world is city x located in?
-----------------------------------------------------------------------------------------------------
-- 12. Bonus: What country (use the human readable name) city x located in?
-----------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------
-- 1. Display the first and last names in all lowercase of all the actors.
SELECT LOWER(CONCAT(first_name, ' ', last_name)) AS actor_name
FROM actor;

-----------------------------------------------------------------------------------------------------
-- 2. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
-- What is one query would you could use to obtain this information?
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name IN ('Joe');

-----------------------------------------------------------------------------------------------------
-- 3. Find all actors whose last name contain the letters "gen":
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE ('%gen%');

-----------------------------------------------------------------------------------------------------
-- 4. Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE ('%li%')
ORDER BY last_name, first_name;

-----------------------------------------------------------------------------------------------------
-- 5. Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan','Bangladesh','China');

-----------------------------------------------------------------------------------------------------
-- 6. List the last names of all the actors, as well as how many actors have that last name.
SELECT DISTINCT(last_name), count(*)
FROM actor
GROUP BY last_name;

-----------------------------------------------------------------------------------------------------
-- 7. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT DISTINCT(last_name), count(*)
FROM actor
GROUP BY last_name
HAVING count(*) > 1;

-----------------------------------------------------------------------------------------------------
-- 8. You cannot locate the schema of the address table. Which query would you use to re-create it?

-----------------------------------------------------------------------------------------------------
-- 9. Use JOIN to display the first and last names, as well as the address, of each staff member.
SELECT first_name, last_name, address
FROM staff
JOIN address USING(address_id);

-----------------------------------------------------------------------------------------------------
-- 10. Use JOIN to display the total amount rung up by each staff member in August of 2005.
SELECT CONCAT(first_name,' ', last_name) AS staff_name, sum(amount)
FROM staff
JOIN payment USING (staff_id)
WHERE payment_date LIKE ('2005-08%')
GROUP BY staff_name;

-----------------------------------------------------------------------------------------------------
-- 11. List each film and the number of actors who are listed for that film.
SELECT title, count(DISTINCT(actor_id))
FROM film
JOIN film_actor USING (film_id)
GROUP BY title;

-----------------------------------------------------------------------------------------------------
-- 12. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT title, count(film_id)
FROM film
JOIN inventory USING (film_id)
WHERE title = 'Hunchback Impossible'
GROUP BY title;

-----------------------------------------------------------------------------------------------------
-- 13. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
-- As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
SELECT title
FROM film
WHERE language_id IN (
	SELECT language_id FROM sakila.language
	WHERE NAME = 'English')
	AND title LIKE ('k%')
	OR title LIKE ('q%');

-----------------------------------------------------------------------------------------------------
-- 14. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT CONCAT(first_name,'_', last_name)
FROM actor
WHERE actor_id IN (
	SELECT actor_id FROM film_actor
	WHERE film_id = (
		SELECT film_id FROM film
		WHERE title = 'Alone Trip'));

-----------------------------------------------------------------------------------------------------
-- 15. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN
	(SELECT address_id FROM address
	WHERE city_id IN
		(SELECT city_id FROM city
		WHERE country_id IN 
			(SELECT country_id FROM country
			WHERE country = 'Canada')));

-----------------------------------------------------------------------------------------------------
-- 16. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as famiy films.
SELECT title FROM film
WHERE film_id IN 	
	(SELECT film_id FROM film_category
	WHERE category_id IN 
		(SELECT category_id FROM category
		WHERE NAME = 'Family'));
-----------------------------------------------------------------------------------------------------
-- 17. Write a query to display how much business, in dollars, each store brought in.
SELECT staff_id, CONCAT('$',sum(amount))
FROM payment
WHERE staff_id IN 
	(SELECT staff_id FROM store)
GROUP BY staff_id;

-----------------------------------------------------------------------------------------------------
-- 18. Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country
FROM store
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id);

-----------------------------------------------------------------------------------------------------
-- 19. List the top five genres in gross revenue in descending order. 
-- (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT `name`, sum(amount) 
FROM category
JOIN film_category USING (category_id)
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN payment USING (rental_id)
GROUP BY `name`
ORDER BY sum(amount) DESC
LIMIT 5;

-----------------------------------------------------------------------------------------------------
-- Select all columns from the actor table.
SELECT *
FROM actor;

-----------------------------------------------------------------------------------------------------
-- Select only the last_name column from the actor table.
SELECT last_name
FROM actor;

-----------------------------------------------------------------------------------------------------
-- Select all distinct (different) last names from the actor table.
SELECT DISTINCT(last_name)
FROM actor;

-----------------------------------------------------------------------------------------------------
-- Select all distinct (different) postal codes from the address table.
SELECT DISTINCT(postal_code)
FROM address;

-----------------------------------------------------------------------------------------------------
-- Select all distinct (different) ratings from the film table.
SELECT DISTINCT(rating)
FROM film;

-----------------------------------------------------------------------------------------------------
-- Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
SELECT title, description, rating, length
FROM film 
WHERE length > 180;

-----------------------------------------------------------------------------------------------------
-- Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >= '2005-05-27';

-----------------------------------------------------------------------------------------------------
-- Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
primary key is the payment_id
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >= '2005-05-27';

-----------------------------------------------------------------------------------------------------
-- Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
SELECT *
FROM customer
WHERE last_name LIKE ('s%')
	AND FIRST_name LIKE ('%n');

-----------------------------------------------------------------------------------------------------
-- Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
SELECT *
FROM customer
WHERE active = '0'
	OR last_name LIKE ('m%');

-----------------------------------------------------------------------------------------------------
-- Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
SELECT *
FROM category
WHERE category_id > 4
	AND (`name` LIKE ('c%') OR `name` LIKE ('s%') OR `name` LIKE ('t%'));

-----------------------------------------------------------------------------------------------------
-- Select all columns minus the password column from the staff table for rows that contain a password.


-----------------------------------------------------------------------------------------------------
-- Select all columns minus the password column from the staff table for rows that do not contain a password.
