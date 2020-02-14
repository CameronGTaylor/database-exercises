USE curie_951;

#1
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100
;

SELECT * FROM employees_with_departments;
DELETE FROM employees_with_departments;
DROP TABLE employees_with_departments;

#1a
ALTER TABLE employees_with_departments 
ADD full_name VARCHAR(100)
;

#1b
UPDATE employees_with_departments
SET full_name = concat(first_name, " ", last_name)
;

#1c
ALTER TABLE employees_with_departments
DROP COLUMN first_name,
DROP COLUMN last_name
;

#1d
#The concat could be run at the intial table creation instead of selecting first and last name columns 

SHOW CREATE TABLE employees.employees;
SHOW COLUMNS FROM employees.employees;
SHOW COLUMNS FROM employees.employees
WHERE `TYPE` LIKE "%VARCHAR%" ;


#2
CREATE TEMPORARY TABLE my_pay AS
	SELECT * FROM sakila.payment;

SELECT * FROM my_pay;
#DROP TABLE my_pay;
#DESCRIBE my_pay;

ALTER TABLE my_pay
MODIFY COLUMN amount FLOAT;
UPDATE my_pay
SET amount = amount*100;
ALTER TABLE my_pay
MODIFY COLUMN amount INT;


#3

# Z = (X-M)/STD
DROP TABLE my_emps;

CREATE TEMPORARY TABLE my_emps AS 
SELECT emp_no, first_name, last_name, dept_no, dept_name, salary
FROM employees.employees e
JOIN employees.dept_emp de USING(emp_no)
JOIN employees.departments d USING(dept_no)
JOIN employees.salaries s USING(emp_no)
WHERE s.to_date > now()
	AND de.to_date > now();


SELECT * FROM my_emps;

CREATE TEMPORARY TABLE ave AS
SELECT AVG(salary) sal_ave
FROM employees.salaries
WHERE to_date > now();

CREATE TEMPORARY TABLE dev AS
SELECT std(salary) sal_dev
FROM employees.salaries
WHERE to_date > now();
	

SELECT 
	dept_name, 
	AVG(salary) AS average, 
	(AVG(salary) - (SELECT sal_ave FROM ave)) / (SELECT sal_dev FROM dev)
		AS salary_z_score
FROM my_emps
GROUP BY dept_name;


#testing purposes
CREATE TABLE ave_dev AS
SELECT 
	AVG(salary) AS sal_ave,
	std(salary) AS sal_dev
FROM employees.salaries
WHERE to_date > now();

SELECT * FROM ave_dev;

SELECT 
	dept_name, 
	AVG(salary) AS average, 
	(SELECT sal_ave FROM ave_dev) AS total_av,
	(SELECT sal_dev FROM ave_dev) AS deviation,
	(AVG(salary) - (SELECT sal_ave FROM ave_dev)) / (SELECT sal_dev FROM ave_dev)
		AS salary_z_score
FROM my_emps
GROUP BY dept_name;