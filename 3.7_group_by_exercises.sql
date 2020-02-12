USE employees;

#2
SELECT DISTINCT title
FROM titles;

#3 & 4
SELECT  
	last_name,
	first_name 
FROM employees 
WHERE last_name LIKE 'E%e'
GROUP BY last_name, first_name;

#5 & 6
SELECT
	last_name,
	count(*)
FROM employees 
WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY count(*) DESC ;

#7
SELECT count(*), gender
FROM employees 
	WHERE (first_name = 'Irena'
	OR first_name = 'Vidya' 
	OR first_name = 'Maya')
GROUP BY gender;

#8
SELECT lower(concat(
		LEFT(first_name,1),
		LEFT(last_name,4),
		"_",
		SUBSTR(birth_date,6,2),
		RIGHT(YEAR(birth_date),2)
		)) AS username,
		count(*)
FROM employees
GROUP BY username
HAVING count(username) > 1
ORDER BY count(*);

#8 Bonus
SELECT SUM(end_users) - count(end_users)
FROM
	(SELECT lower(concat(
			LEFT(first_name,1),
			LEFT(last_name,4),
			"_",
			SUBSTR(birth_date,6,2),
			RIGHT(YEAR(birth_date),2)
			)) AS username,
			count(*) AS end_users
	FROM employees
	GROUP BY username
	HAVING count(username) > 1
	ORDER BY count(*)
	)  AS total_count;