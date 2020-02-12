USE join_example_db;

SELECT * FROM roles;
SELECT * FROM users;

SELECT roles.name AS role_name, COUNT(users.name) AS number_of_users
FROM users
RIGHT JOIN roles ON users.role_id = roles.id
GROUP BY role_name;

USE employees;

#2
SELECT d.`dept_name` AS `Department Name`, 
	CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'
FROM departments AS d
JOIN dept_manager AS dm
	ON dm.`dept_no` = d.`dept_no`
JOIN employees AS e
	ON dm.`emp_no` = e.`emp_no`
WHERE dm.`to_date` LIKE '9999%'
ORDER BY `Department NAME` ASC;

#3	
SELECT d.`dept_name` AS `Department NAME`, 
	CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'
FROM departments AS d
JOIN dept_manager AS dm
	ON dm.`dept_no` = d.`dept_no`
JOIN employees AS e
	ON dm.`emp_no` = e.`emp_no`
WHERE dm.`to_date` LIKE '9999%'
	AND e.`gender` = 'F'
ORDER BY `Department NAME` ASC;

#4
SELECT title AS `Title`, COUNT(t.emp_no) AS `Count`
FROM departments AS d
JOIN dept_emp AS de ON d.`dept_no` = de.`dept_no`
JOIN titles AS t	ON de.`emp_no` = t.`emp_no`
WHERE dept_name LIKE  "Customer%"
	AND t.`to_date` LIKE '9999%'
	AND de.`to_date` LIKE '9999%'
GROUP BY `Title`;

#5
SELECT dept_name AS `Department Name`, 
	CONCAT(e.first_name, ' ', e.last_name) AS `Name`,
	salary AS `Salary`
FROM departments AS d
JOIN dept_manager AS dm
	ON d.`dept_no` = dm.`dept_no`
JOIN employees AS e
	ON dm.`emp_no` = e.`emp_no`
JOIN salaries AS s
	ON e.`emp_no` = s.`emp_no`
WHERE dm.`to_date` LIKE '9999%'
	AND s.`to_date` LIKE '9999%'
ORDER BY `Department Name`;

#6
SELECT d.`dept_no` AS dept_no,
	d.`dept_name` AS dept_name,
	count(de.emp_no) AS num_employees
FROM departments AS d
JOIN dept_emp AS de
	ON d.`dept_no` = de.`dept_no`
WHERE de.`to_date` LIKE '9999%'
GROUP BY dept_no;

#7
SELECT dept_name,
	AVG(s.salary) AS average_salary
FROM departments AS d
JOIN dept_emp AS de
	ON d.`dept_no` = de.`dept_no`
JOIN salaries AS s
	ON de.`emp_no` = s.`emp_no`
WHERE de.`to_date` LIKE '9999%'
	AND s.`to_date` LIKE '9999%'
GROUP BY dept_name
ORDER BY average_salary DESC 
LIMIT 1;

#8
SELECT e.first_name AS first_name, 
	e.last_name AS last_name
FROM employees e
JOIN dept_emp de USING (emp_no)
JOIN departments d USING (dept_no)
JOIN salaries s USING (emp_no)
WHERE d.`dept_name` = "Marketing"
	AND de.`to_date` LIKE '9999%'
	AND s.`to_date` LIKE '9999%'
ORDER BY salary DESC
LIMIT 1 ;

#9
SELECT first_name, 
	last_name,
	salary,
	dept_name
FROM employees e
JOIN dept_manager dm USING (emp_no)
JOIN departments d USING (dept_no)
JOIN salaries s USING (emp_no)
WHERE dm.`to_date` > now() # or CURDATE()
	AND s.`to_date` > now() # or CURDATE()
ORDER BY salary DESC
LIMIT 1 ;

#10
SELECT CONCAT(e.first_name, ' ', e.last_name) AS `Employee Name`,
	d.dept_name AS `Department Name`,
	CONCAT(me.first_name, ' ', me.last_name) AS `Manager Name`
FROM `employees` e
JOIN dept_emp de ON de.`emp_no` = e.`emp_no`
JOIN departments d ON de.`dept_no` = d.`dept_no`
JOIN dept_manager dm ON dm.`dept_no` = de.`dept_no`
JOIN `employees` me ON me.`emp_no` = dm.`emp_no`
WHERE de.`to_date` LIKE '9999%'
	AND dm.`to_date` LIKE '9999%'
ORDER BY `Department Name`;

#11
SELECT
	d.dept_name AS `Department Name`,
 	MAX(s.salary) AS maxSal
FROM salaries AS s
JOIN dept_emp AS de ON de.emp_no = s.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
JOIN (
	SELECT CONCAT(e.first_name, ' ', e.last_name) AS `Employee Name`,
		d.dept_name AS `Department Name`,
		s.salary AS `Salary`
	FROM `employees` e
	JOIN dept_emp de 
		ON de.`emp_no` = e.`emp_no`
	JOIN departments d 
		ON de.`dept_no` = d.`dept_no`
	JOIN `employees` me 
		ON me.`emp_no` = de.`emp_no`
	JOIN salaries s
		ON de.`emp_no` = s.`emp_no`
	WHERE de.`to_date` LIKE '9999%'
		AND s.`to_date` LIKE '9999%'
	ORDER BY `Department Name`
	) AS emp_names 
		ON d.dept_name = emp_names.`Department Name`
		AND max(s.salary) = emp_names.`Salary`
GROUP BY d.dept_name;




SELECT 
	CONCAT(e.first_name, ' ', e.last_name) AS `Employee Name`,
	d.dept_name AS "Department Name",
	s.salary AS "Salary"
FROM `employees` e
JOIN dept_emp de ON de.`emp_no` = e.`emp_no`
JOIN departments d ON de.`dept_no` = d.`dept_no`
JOIN salaries s	ON de.`emp_no` = s.`emp_no`
JOIN (
	SELECT
 		MAX(s.salary) AS maxSal,
 		d.dept_name AS d_name
	FROM salaries AS s
	JOIN dept_emp AS de ON de.emp_no = s.emp_no
	JOIN departments AS d ON d.dept_no = de.dept_no
	GROUP BY d_name
	) AS maxSals 
		ON maxSals.maxSal = s.salary
		AND maxSals.d_name = d.dept_name
WHERE de.`to_date` LIKE '9999%'
	AND s.`to_date` LIKE '9999%'
ORDER BY `Department Name`;

