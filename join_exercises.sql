-- 1. Use the employees database.
USE employees;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
SELECT * FROM dept_manager WHERE to_date = '9999-01-01';

SELECT 	dept_name AS 'Department Name' ,
		CONCAT(first_name,' ',last_name) AS 'Department Manager'
FROM dept_manager AS D
JOIN employees AS E
	ON D.emp_no = E.emp_no
JOIN departments AS DEP
	ON DEP.dept_no = D.dept_no
WHERE to_date = '9999-01-01' ORDER BY dept_name ASC;



-- 3. Find the name of all departments currently managed by women.
SELECT dept_name AS 'Department Name' ,CONCAT(first_name,' ',last_name) AS 'Department Manager',gender
FROM dept_manager AS D
JOIN employees AS E
	ON D.emp_no = E.emp_no 
JOIN departments AS DEP
	ON DEP.dept_no = D.dept_no 
WHERE to_date = '9999-01-01'AND gender = 'F' ORDER BY dept_name ASC;


-- 4. Find the current titles of employees currently working in the Customer Service department.  Title,employees, departments
SELECT * FROM titles;

SELECT title,COUNT(title) FROM titles 
JOIN dept_emp AS D
	ON titles.emp_no = D.emp_no
JOIN departments AS dep
	ON dep.dept_no = D.dept_no
WHERE titles.to_date = '9999-01-01' AND dept_name = 'Customer Service' 
GROUP BY title ORDER BY title ASC;


-- 5. Find the current salary of all current managers.
#dept_manager 
SELECT * FROM dept_manager;

SELECT  dept_name AS 'Department Name' ,
		CONCAT(first_name,' ',last_name) AS 'Department Manager',
        salary
FROM dept_manager AS D
JOIN employees AS E
	ON D.emp_no = E.emp_no 
JOIN departments AS DEP
	ON DEP.dept_no = D.dept_no 
JOIN salaries AS S
	ON S.emp_no = E.emp_no
WHERE D.to_date = '9999-01-01' AND S.to_date = '9999-01-01' ORDER BY dept_name ASC;

-- 6. Find the number of current employees in each department.
SELECT D.dept_no,dept_name AS 'Department Name', COUNT(dept_name) AS Employee_count
FROM dept_emp AS D
JOIN departments AS Dep
	ON D.dept_no = Dep.dept_no
JOIN employees as E
	ON D.emp_no = E.emp_no
WHERE D.to_date = '9999-01-01'
GROUP BY D.dept_no,'Department Name' ORDER BY D.dept_no;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.department/salaries and deptemp
SELECT dept_name, AVG(salary) FROM salaries AS S
JOIN dept_emp AS emp
	ON S.emp_no = emp.emp_no
JOIN departments AS D
	ON D.dept_no = emp.dept_no
WHERE S.to_date = '9999-01-01' GROUP BY dept_name ORDER BY AVG(salary) DESC LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?
SELECT CONCAT(first_name,' ',last_name) AS Name, salary
FROM employees AS E
JOIN dept_emp AS D
	ON E.emp_no = D.emp_no
JOIN departments AS DEP
	ON DEP.dept_no = D.dept_no
JOIN salaries AS S
	ON S.emp_no = E.emp_no
WHERE dept_name = 'Marketing'
ORDER BY salary DESC LIMIT 1;

-- 9. Which current department manager has the highest salary?
SELECT dept_name AS 'Department Name' ,CONCAT(first_name,' ',last_name) AS 'Department Manager',salary
FROM dept_manager AS D
JOIN employees AS E
ON D.emp_no = E.emp_no JOIN departments AS DEP
ON DEP.dept_no = D.dept_no 
JOIN salaries AS S
	ON S.emp_no = E.emp_no
    WHERE D.to_date = '9999-01-01' AND S.to_date = '9999-01-01' ORDER BY salary DESC LIMIT 1;


-- 10. Determine the average salary for each department. Use all salary information and round your results.
SELECT dept_name, ROUND(AVG(salary),0) FROM salaries AS S
JOIN dept_emp AS emp
	ON S.emp_no = emp.emp_no
JOIN departments AS D
	ON D.dept_no = emp.dept_no
GROUP BY dept_name ORDER BY AVG(salary) DESC;

-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name.
			
SELECT 	* FROM employees AS E
JOIN dept_emp AS DEP
	ON E.emp_no = DEP.emp_no
JOIN departments AS D
	ON D.dept_no = DEP.dept_no WHERE DEP.to_date = '9999-01-01' ;
    
    
    
    
    
SELECT 	CONCAT(first_name,' ',last_name) AS 'Employee Name',
		dept_name AS 'Department Name',
        DM
FROM employees AS E
JOIN dept_emp AS DEP
	ON E.emp_no = DEP.emp_no
JOIN departments AS D
	ON D.dept_no = DEP.dept_no
JOIN (SELECT dept_name AS DN ,CONCAT(first_name,' ',last_name) AS DM 
FROM dept_manager AS D
JOIN employees AS E
ON D.emp_no = E.emp_no JOIN departments AS DEP
ON DEP.dept_no = D.dept_no WHERE to_date = '9999-01-01' ORDER BY dept_name ASC)
AS M
ON DN = dept_name
WHERE DEP.to_date = '9999-01-01';




SELECT 	* FROM employees AS E
JOIN dept_emp AS DEP
	ON E.emp_no = DEP.emp_no
JOIN departments AS D
	ON D.dept_no = DEP.dept_no WHERE DEP.to_date = '9999-01-01' ;
    
    
#DEP MANAGERS CURRENT

SELECT dept_name AS 'Department Name' ,CONCAT(first_name,' ',last_name) AS 'Department Manager' 
FROM dept_manager AS D
JOIN employees AS E
ON D.emp_no = E.emp_no JOIN departments AS DEP
ON DEP.dept_no = D.dept_no WHERE to_date = '9999-01-01' ORDER BY dept_name ASC;


