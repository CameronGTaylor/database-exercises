USE employees; 

#1
SELECT emp_no, dept_no, from_date, to_date,
	CASE 
		WHEN to_date > now() THEN 1
		ELSE 0
	END is_current_employee
FROM dept_emp;

#2
SELECT concat(first_name, " ", last_name) AS "Employee Name",
	CASE last_name
		WHEN last_name >= "I" THEN "A-H"
		WHEN last_name >= "R"  THEN "I-Q"
		WHEN last_name >= "Z%" THEN "R-Z"
		WHEN last_name = "Z" THEN "R-Z"
		ELSE "Other"
	END alpha_group
FROM employees;

#3
SELECT 
	sum(CASE 
			WHEN birth_date BETWEEN "1950-01-01" AND "1959-12-31" THEN 1
			ELSE 0
		END) "1950s",
	sum(CASE
			WHEN birth_date BETWEEN "1960-01-01" AND "1969-12-31" THEN 1
			ELSE 0
		END) "1960s"
FROM employees;

#Bonus
SELECT 
	DISTINCT CASE 
		WHEN d.dept_name IN ("Finance", "Human Resources") THEN "Finance & HR"
		WHEN d.dept_name IN ("Sales", "Marketing") THEN "Sales & Marketing"
		WHEN d.dept_name IN ("Production", "Quality Management") THEN "Prod & QM"
		WHEN d.dept_name IN ("Research", "Development") THEN "R&D"
		ELSE d.dept_name
	END dept_group,
	AVG(salary)
FROM departments d
JOIN dept_emp de USING (dept_no)
JOIN salaries s USING (emp_no)
GROUP BY dept_group;
