USE employees;

#SELECT * FROM employees 
#	WHERE first_name IN ('Irena', 'Vidya', 'Maya');

SELECT first_name, last_name, gender FROM employees 
	WHERE (first_name = 'Irena'
	OR first_name = 'Vidya' 
	OR first_name = 'Maya')
	AND gender = 'M';

SELECT first_name, last_name FROM employees WHERE last_name LIKE 'E%';

SELECT first_name, last_name, hire_date FROM employees 
	WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

SELECT first_name, last_name, birth_date FROM employees WHERE birth_date LIKE '%-12-25';

SELECT first_name, last_name FROM employees WHERE last_name LIKE '%q%';

SELECT first_name, last_name FROM employees 
	WHERE last_name LIKE 'E%'
	OR last_name LIKE '%e';
	
SELECT first_name, last_name FROM employees 
	WHERE last_name LIKE 'E%e';
	
SELECT first_name, last_name, birth_date, hire_date FROM employees 
	WHERE birth_date LIKE '%-12-25'
	AND hire_date BETWEEN '1990-01-01' AND '1999-12-31';

SELECT first_name, last_name FROM employees 
	WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%';