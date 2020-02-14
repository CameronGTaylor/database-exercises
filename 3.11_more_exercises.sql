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

