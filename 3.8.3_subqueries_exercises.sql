USE employees;

#1
SELECT emp_no, hire_date
FROM employees 
WHERE hire_date IN (
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010
	);

#2
SELECT count(*)#, title
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees e
	WHERE first_name = "Aamod");
#GROUP BY title;

#3
SELECT count(emp_no)
FROM employees
WHERE emp_no IN (
	SELECT emp_no 
	FROM dept_emp
	WHERE to_date < now()
);

#4
SELECT first_name, last_name 
FROM employees 
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_manager
	WHERE to_date > now()
	) AND gender = "F";

#5
SELECT first_name, last_name, sals.salary AS "salary"
FROM employees e
JOIN  
	(	
	SELECT emp_no, salary
	FROM salaries
	WHERE salary > 	(
		SELECT AVG(salary)
		FROM salaries )
	AND to_date > now()
	) sals
	ON e.emp_no = sals.emp_no
;

#6
SELECT 
	count(*) AS total, 
	(SELECT count(*) FROM salaries) AS all_sals,
	count(*) / (SELECT count(*) FROM salaries) * 100 AS percentage
FROM salaries
WHERE salary >
	(SELECT max(salary) - STD(salary)
	FROM salaries)
	AND to_date > now()
;

#Bonus 1
SELECT dept_name
FROM departments
WHERE dept_no IN
	(SELECT dept_no
	FROM dept_emp
	WHERE emp_no IN
		(
		SELECT emp_no
		FROM employees e
		WHERE e.emp_no IN 
			(
			SELECT emp_no
			FROM dept_manager
			WHERE to_date > now()
			)
		AND gender = "F"
		)
	)
;

#Bonus 2
SELECT first_name, last_name
FROM employees 
WHERE emp_no IN 
	(
	SELECT emp_no
	FROM salaries
	WHERE salary = 
		(SELECT max(salary)
		FROM salaries
		WHERE to_date > now()
		ORDER BY salary DESC #This would take 10s otherwise?
		)
	)
;


