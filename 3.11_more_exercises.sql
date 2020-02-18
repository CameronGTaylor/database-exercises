USE employees;

#1
SELECT 
	ave_sals.dept_name,
	emp_no, 
	salary, 
	ave_sals.ave AS ave_sal,
	salary - (ave_sals.ave) AS difference
FROM salaries s
JOIN dept_emp de USING (emp_no)
JOIN 
	(SELECT 
		dept_name,
		dept_no,
		AVG(salary) AS ave
	FROM salaries s
	JOIN dept_emp de USING (emp_no)
	JOIN departments d USING (dept_no)
	WHERE s.to_date > now()
		AND de.to_date > now()
	GROUP BY dept_name) AS ave_sals ON de.dept_no = ave_sals.dept_no
WHERE emp_no IN
	(SELECT emp_no
	FROM dept_manager
	WHERE to_date > now())
AND s.to_date > now()
ORDER BY difference DESC;

#2
;
USE world;

#a
SELECT LANGUAGE, Percentage
FROM countrylanguage cl
JOIN country co ON  cl.CountryCode = co.code
JOIN city ci USING (CountryCode)
WHERE ci.name = "Santa Monica"
ORDER BY Percentage;

#b
SELECT Region, count(NAME) AS num_countries
FROM country
GROUP BY Region
ORDER BY num_countries;

#c
SELECT Region, sum(population) AS population
FROM country
GROUP BY Region
ORDER BY population DESC;

#d
SELECT Continent, sum(population) AS population
FROM country
GROUP BY Continent
ORDER BY population DESC;

#e
SELECT AVG(LifeExpectancy)
FROM country;

#f
SELECT Continent, AVG(LifeExpectancy) AS life_expectancy
FROM country
GROUP BY Continent
ORDER BY life_expectancy;

SELECT Region, AVG(LifeExpectancy) AS life_expectancy
FROM country
GROUP BY Region
ORDER BY life_expectancy;

#Bonuses
SELECT NAME, LocalName
FROM country
WHERE NAME != LocalName;

SELECT NAME, LifeExpectancy
FROM country
WHERE LifeExpectancy < 50
ORDER BY LifeExpectancy;

#Sakila
;
USE sakila;

#1
SELECT lower(first_name), lower(last_name)
FROM actor;

#2 
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe";

#3
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%gen%";

#4
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%li%"
ORDER BY last_name, first_name;

#5
SELECT country_id, country
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

#6
SELECT last_name, count(last_name)
FROM actor
GROUP BY last_name;

#7
SELECT last_name, count(last_name) 
FROM actor
GROUP BY last_name
HAVING count(last_name) > 1;

#8
SHOW CREATE TABLE address;

#9
SELECT first_name, last_name, address
FROM staff s
JOIN address ad USING (address_id);

#10
SELECT first_name, last_name, sum(amount)
FROM staff s
JOIN payment p USING (staff_id)
WHERE payment_date LIKE "2005-08%"
GROUP BY staff_id;

#11
SELECT title, count(actor_id)
FROM film f
JOIN film_actor fm USING (film_id)
GROUP BY title;

#12
SELECT count(film_id) 
FROM film
JOIN inventory USING (film_id)
WHERE title = "Hunchback Impossible";

#13
SELECT title 
FROM film
WHERE language_id IN ( 
	SELECT language_id
	FROM `language`
	WHERE `name` = "English");

#14
SELECT first_name, last_name 
FROM actor
WHERE actor_id IN (
	SELECT actor_id
	FROM film_actor
	WHERE film_id = (
		SELECT film_id
		FROM film
		WHERE title = "Alone Trip"
	)
);

#15
SELECT first_name, last_name, email
FROM customer
JOIN address a USING (address_id)
JOIN city ci USING (city_id)
JOIN country co USING (country_id)
WHERE country = "Canada";

#16
SELECT title
FROM film
JOIN film_category USING (film_id)
JOIN category c USING (category_id)
WHERE c.name = "Family";

#17
SELECT store_id, sum(amount)
FROM staff s
JOIN payment p USING (staff_id)
GROUP BY staff_id;

#18
SELECT store_id, city, country
FROM store
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id);


#19
SELECT sum(p.amount) AS `Revenue`, ca.name AS `Category`
FROM payment p
JOIN rental r USING (rental_id)
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id)
JOIN film_category fc USING (film_id)
JOIN category ca USING (category_id)
GROUP BY `Category`
ORDER BY `Revenue` DESC
LIMIT 5;

#1
SELECT * FROM actor;
SELECT last_name FROM actor;
SELECT * FROM film;

#2
SELECT DISTINCT last_name FROM actor;
SELECT DISTINCT postal_code FROM address; 
SELECT DISTINCT rating FROM film;

#3
SELECT title, description, rating, length
FROM film WHERE (length/60) > 3;

SELECT payment_id, amount, payment_date
FROM payment WHERE payment_date >= "2005-05-27";

SELECT payment_id AS "Primary Key", amount, payment_date
FROM payment WHERE payment_date LIKE "2005-05-27%";

SELECT * FROM customer
WHERE last_name LIKE "S%" AND first_name LIKE "%n";

SELECT * FROM customer
WHERE active = 0 OR last_name LIKE "M%";

SELECT * FROM category
WHERE category_id > 4 AND `name` REGEXP "^C|^S|^T";

SELECT 
	staff_id, first_name, last_name, address_id, picture, email,
	store_id, active, username, last_update
FROM staff
WHERE `password` IS NOT NULL;

SELECT 
	staff_id, first_name, last_name, address_id, picture, email,
	store_id, active, username, last_update
FROM staff
WHERE `password` IS NULL;

#4
SELECT phone, district FROM address
WHERE district IN ("California", "England", "Taipei", "West Java");

SELECT payment_id, amount, payment_date FROM payment
WHERE DATE(payment_date) IN ("2005-05-25", "2005-05-27", "2005-05-29");

SELECT * FROM film
WHERE rating IN ("G", "PG-13", "NC-17");

#5
SELECT * FROM payment 
WHERE payment_date BETWEEN "2005-05-25" AND "2005-05-27";

SELECT 
	title,
	rental_duration * rental_rate AS total_rental_cost,
	length(description)
FROM film
WHERE length(description) BETWEEN 100 AND 120;

#6
SELECT title, description FROM film 
WHERE description LIKE "a thoughtful%";

SELECT title, description FROM film
WHERE description LIKE "%boat";

SELECT title, length, description FROM film
WHERE description LIKE "%database%" AND length > 180;

#7
SELECT * FROM payment LIMIT 20;

SELECT payment_date, amount, payment_id FROM payment
WHERE amount > 5 LIMIT 1001 OFFSET 999;

SELECT * FROM customer LIMIT 100 OFFSET 100;

#8
SELECT * FROM film ORDER BY length;
SELECT DISTINCT rating FROM film ORDER BY rating DESC;
SELECT payment_date, amount FROM payment ORDER BY amount DESC LIMIT 20;
SELECT title, description, special_features, length, rental_duration FROM film
WHERE special_features LIKE "%behind the scenes%"
	AND length < 120 AND rental_duration BETWEEN 5 AND 8
ORDER BY length DESC LIMIT 10;

#9
SELECT 
	c.first_name AS "customer_first_name", 
	 c.last_name AS "customer_last_name",
	a.first_name AS "actor_first_name",
	a.last_name AS "actor_last_name"
FROM customer c
LEFT JOIN actor a ON c.last_name = a.last_name;
###########################
#Returns too many

SELECT 
	c.first_name AS "customer_first_name", 
	 c.last_name AS "customer_last_name",
	a.first_name AS "actor_first_name",
	a.last_name AS "actor_last_name"
FROM customer c
RIGHT JOIN actor a ON c.last_name = a.last_name;

SELECT 
	c.first_name AS "customer_first_name", 
	 c.last_name AS "customer_last_name",
	a.first_name AS "actor_first_name",
	a.last_name AS "actor_last_name"
FROM customer c
INNER JOIN actor a ON c.last_name = a.last_name;

SELECT city, country FROM city
LEFT JOIN country USING (country_id);

SELECT title, description, release_year, l.name AS "Language"
FROM film LEFT JOIN `LANGUAGE` l USING (language_id);

SELECT first_name, last_name, address, address2, city, district, postal_code
FROM staff LEFT JOIN address USING (address_id)
LEFT JOIN city USING (city_id);

#1
SELECT AVG(replacement_cost) FROM film;
SELECT rating, AVG(replacement_cost) FROM film GROUP BY rating;

#2
SELECT c.name AS `NAME`, count(*) AS count
FROM film JOIN film_category USING (film_id)
JOIN category c USING (category_id)
GROUP BY `NAME`;

#3
SELECT title, count(*) AS "total" FROM film
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
GROUP BY title ORDER BY `total` DESC LIMIT 5;

#4
SELECT title, sum(amount) AS "total" FROM film
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN payment USING (rental_id)
GROUP BY title ORDER BY `total` DESC LIMIT 5;

#5
SELECT upper(concat(last_name, ", ", first_name)) AS `NAME`, sum(amount) AS `total`
FROM customer JOIN payment USING (customer_id) GROUP BY `NAME`
ORDER BY `total` DESC LIMIT 1;

#6
SELECT upper(concat(last_name, ", ", first_name)) AS actor_name, count(film_id) AS `total`
FROM actor JOIN film_actor USING (actor_id)
GROUP BY actor_id ORDER BY `total` DESC LIMIT 5;

#7
SELECT 
	concat(YEAR(payment_date), "-", MONTH(payment_date)) AS months, 
	store_id, 
	sum(amount)
FROM payment p
JOIN rental USING (rental_id)
JOIN inventory USING (inventory_id)
WHERE YEAR(payment_date) = 2005
GROUP BY months, store_id;

SELECT 
	concat(YEAR(payment_date), "-", MONTH(payment_date)) AS months, 
	store_id, 
	sum(amount)
FROM payment p
JOIN staff USING (staff_id)
JOIN store USING (store_id)
WHERE YEAR(payment_date) = 2005
GROUP BY months, store_id;

#8
SELECT title, 
	upper(concat(last_name, ", ", first_name)) AS customer_name,
	phone
FROM film 
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN customer USING (customer_id)
JOIN address USING (address_id)
WHERE return_date IS NULL; 
