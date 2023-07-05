-- 1. Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
-- dept_no, emp name and number, start date(hire date), end date (to_date), and is_current_employee

USE employees;
SELECT * FROM employees;


SELECT dept_no, E.emp_no, first_name, last_name, from_date,to_date,
IF(to_date > CURDATE(),True,False) AS is_currently_employee
FROM employees AS E
JOIN dept_emp AS DE
 ON DE.emp_no = E.emp_no;



-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT first_name, last_name,
	CASE 
		WHEN SUBSTR(last_name,1,1) BETWEEN 'A' AND 'H' THEN 'A-H'
        WHEN SUBSTR(last_name,1,1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
        ELSE 'R-Z'
	END AS alpha_group
FROM employees;


-- 3. How many employees (current or previous) were born in each decade?
SELECT * FROM employees ORDER BY birth_date DESC;  #1952 oldest 1965 youngest

SELECT COUNT(*) FROM employees;  #300024 total

SELECT COUNT(*),
	CASE 
		WHEN birth_date LIKE '195%' THEN '50s'
		WHEN birth_date LIKE '196%' THEN '60s'
        END AS decade
FROM employees
GROUP BY decade;

#182886 born in 50s
#117138 born in 60s


-- 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
# depeartment, AVG salary

SELECT * FROM departments AS D
JOIN dept_emp AS DE
	ON DE.dept_no = D.dept_no
JOIN salaries AS S
	ON DE.emp_no = S.emp_no
WHERE DE.to_date > CURDATE() AND S.to_date > CURDATE();   #every branch and the average current salaries from current employees of that branch

SELECT *,
   CASE
       WHEN dept_name IN ('research', 'development') THEN 'R&D'
       WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       WHEN dept_name In ('Finance','Human Resources') THEN 'Finance & HR'
       ELSE dept_name
   END AS dept_group
FROM departments;


SELECT dept_group, AVG(salary) FROM departments AS D
JOIN dept_emp AS DE
	ON DE.dept_no = D.dept_no
JOIN salaries AS S
	ON DE.emp_no = S.emp_no
    JOIN (SELECT *,
   CASE
       WHEN dept_name IN ('research', 'development') THEN 'R&D'
       WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       WHEN dept_name In ('Finance','Human Resources') THEN 'Finance & HR'
       ELSE dept_name
   END AS dept_group
FROM departments) AS G
	ON G.dept_no = DE.dept_no
WHERE DE.to_date > CURDATE() AND S.to_date > CURDATE()
GROUP BY dept_group;

-- SELECT dept_group,AVG(average) FROM (SELECT *,
--    CASE
--        WHEN dept_name IN ('research', 'development') THEN 'R&D'
--        WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
--        WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
--        WHEN dept_name In ('Finance','Human Resources') THEN 'Finance & HR'
--        ELSE dept_name
--    END AS dept_group
-- FROM 
-- (SELECT dept_name, AVG(salary) AS average FROM departments AS D
-- JOIN dept_emp AS DE
-- 	ON DE.dept_no = D.dept_no
-- JOIN salaries AS S
-- 	ON DE.emp_no = S.emp_no
-- WHERE DE.to_date > CURDATE() AND S.to_date > CURDATE()
-- GROUP BY dept_name) AS A) AS B
-- GROUP BY dept_group;


-- BONUS

-- Remove duplicate employees from exercise 1.

SELECT dept_no, E.emp_no, first_name, last_name, hire_date,to_date,
IF(to_date > CURDATE(),True,False) AS is_currently_employee
FROM employees AS E
JOIN dept_emp AS DE
 ON DE.emp_no = E.emp_no; #code for exercise 1
 
 SELECT * FROM dept_emp WHERE emp_no = 11092 OR emp_no = 15499; #test for emp_no to see what could cause double entries

 
 SELECT E.emp_no, COUNT(E.emp_no)
FROM employees AS E
 GROUP BY emp_no
 ORDER BY COUNT(E.emp_no) DESC
 ; # check if employees table is correct. only one entry for each employee number. YES

SELECT E.emp_no, COUNT(E.emp_no)
FROM employees AS E
JOIN dept_emp AS DE
 ON DE.emp_no = E.emp_no 
 GROUP BY emp_no
 ORDER BY COUNT(E.emp_no) DESC;  # count for joined tables. THIS TABLE HAS DUPLICATES.
 
  SELECT E.emp_no, COUNT(E.emp_no)
FROM employees AS E
JOIN dept_emp AS DE
	ON DE.emp_no = E.emp_no
WHERE to_date > CURDATE()
GROUP BY emp_no
ORDER BY COUNT(E.emp_no) DESC;    #count for joined tables. WHERE it only shows the employee once for the current branch they work in.
 
 SELECT dept_no, E.emp_no, first_name, last_name, hire_date,to_date,
IF(to_date > CURDATE(),True,False) AS is_currently_employee
FROM employees AS E
JOIN dept_emp AS DE
 ON DE.emp_no = E.emp_no
 WHERE to_date > CURDATE();   #will filter out all old employees and leaves only current employees therefore removing duplicates.