USE employees;

#SELECT * FROM employees 
#	WHERE first_name IN ('Irena', 'Vidya', 'Maya');

SELECT first_name, last_name, gender FROM employees 
	WHERE (first_name = 'Irena'
	OR first_name = 'Vidya' 
	OR first_name = 'Maya')
	AND gender = 'M'
	ORDER BY last_name DESC , first_name DESC ;

SELECT first_name, last_name FROM employees WHERE last_name LIKE 'E%';

SELECT first_name, last_name, hire_date FROM employees 
	WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

SELECT first_name, last_name, birth_date FROM employees WHERE birth_date LIKE '%-12-25';

SELECT first_name, last_name FROM employees WHERE last_name LIKE '%q%';

SELECT first_name, last_name FROM employees 
	WHERE last_name LIKE 'E%'
	OR last_name LIKE '%e';
	
SELECT emp_no, first_name, last_name, UPPER(concat(first_name, ' ', last_name)) AS full_name
	FROM employees 
	WHERE last_name LIKE 'E%e'
	ORDER BY emp_no DESC;
	
SELECT first_name, last_name, birth_date, hire_date, datediff(NOW(),hire_date) AS days_worked
	FROM employees 
	WHERE birth_date LIKE '%-12-25'
	AND hire_date LIKE '199%'
	ORDER BY birth_date, hire_date DESC ;

SELECT first_name, last_name FROM employees 
	WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%';
	
SELECT
	min(salary) AS smallest,
	max(salary) AS largest
	FROM salaries;
	
SELECT lower(concat(
		LEFT(first_name,1),
		LEFT(last_name,4),
		"_",
		SUBSTR(birth_date,6,2),
		RIGHT(YEAR(birth_date),2)
		)) AS username,
	first_name, 
	last_name, 
	birth_date
	FROM employees
	LIMIT 10;
	