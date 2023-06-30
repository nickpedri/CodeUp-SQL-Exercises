-- 1 Find all the current employees with the same hire date as employee 101010 using a subquery.

SELECT hire_date FROM employees WHERE emp_no = 101010; # emp 101010 hire date

SELECT emp_no FROM dept_emp WHERE to_date > CURDATE(); # list of current employee

SELECT CONCAT(first_name, ' ', last_name) AS Name, hire_date FROM employees
WHERE emp_no IN (SELECT emp_no FROM dept_emp WHERE to_date > CURDATE()) 
AND hire_date = (SELECT hire_date FROM employees WHERE emp_no = 101010);


-- 2 Find all the titles ever held by all current employees with the first name Aamod.
SELECT emp_no FROM dept_emp WHERE to_date > CURDATE() ; # list of current employees
SELECT emp_no FROM employees WHERE first_name = 'Aamod'; #List of emp #s of all Aamods ever

SELECT * FROM titles 
WHERE emp_no IN (SELECT emp_no FROM dept_emp WHERE to_date > CURDATE()) 
AND emp_no IN (SELECT emp_no FROM employees WHERE first_name = 'Aamod');


-- 3 How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT emp_no FROM dept_emp WHERE to_date > CURDATE(); #employee numbers of people in companny

SELECT COUNT(*) FROM employees 
WHERE emp_no NOT IN #check what employees are not in the list of current employees
		(SELECT emp_no FROM dept_emp WHERE to_date > CURDATE());
#59900 employees are no longer working for company


-- 4 Find all the current department managers that are female. List their names in a comment in your code.
SELECT emp_no FROM employees WHERE gender = 'F'; #List of all female employees emp_no
SELECT emp_no FROM dept_emp WHERE to_date > CURDATE(); # current employees #S

SELECT * FROM dept_manager AS M
JOIN employees AS E
	ON E.emp_no = M.emp_no
WHERE M.emp_no IN 
			(SELECT emp_no FROM employees WHERE gender = 'F')
AND M.emp_no IN (SELECT emp_no FROM dept_emp WHERE to_date > CURDATE())
AND M.to_date > CURDATE();
#isamu legleitner, karsten sigstam, leon dassarma, hilary kambil


-- 5 Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT AVG(salary) FROM salaries; #AVG salary for company #63810.7448
SELECT emp_no,salary FROM salaries WHERE to_date > CURDATE(); #Current salaries for all employees by emp_no.  emp_no/salary

SELECT * FROM employees AS E
JOIN (SELECT emp_no,salary FROM salaries WHERE to_date > CURDATE()) AS ES
	ON ES.emp_no = E.emp_no
WHERE salary > (SELECT AVG(salary) FROM salaries) ORDER BY salary ASC;
#154543 employees


-- 6 How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?   
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.

SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE(); #current highest salary
SELECT STDDEV(salary) FROM salaries WHERE to_date > CURDATE(); # standard deviation of salaries    17309.95933634675

SELECT emp_no FROM dept_emp WHERE to_date > CURDATE(); # list of current employee employee numbers

SELECT S.emp_no,salary FROM employees AS E
JOIN salaries AS S
	ON S.emp_no = E.emp_no
WHERE S.to_date > CURDATE() AND E.emp_no IN (SELECT emp_no FROM dept_emp WHERE to_date > CURDATE());  #TABLE of current employess & their current salaries


SELECT COUNT(*) FROM (
	SELECT S.emp_no,salary FROM employees AS E
	JOIN salaries AS S
		ON S.emp_no = E.emp_no
	WHERE S.to_date > CURDATE() AND E.emp_no IN (SELECT emp_no FROM dept_emp WHERE to_date > CURDATE())) AS SS
WHERE salary > ((SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE())-(SELECT STDDEV(salary) FROM salaries WHERE to_date > CURDATE())); #83 salaries are within 1 standard deviation of the highest salary. 

SELECT COUNT(salary) FROM employees AS E
JOIN salaries AS S
	ON S.emp_no = E.emp_no
WHERE S.to_date > CURDATE() AND E.emp_no IN (SELECT emp_no FROM dept_emp WHERE to_date > CURDATE());  #TOtal number of current salaries 240124

SELECT (83/240124); #.03456%

# .03456% of all current employees are within one standart deviation of the highest current salary


-- BONUS

-- 1 Find all the department names that currently have female managers.
SELECT emp_no,gender FROM employees WHERE gender = 'F'; #TABLE OF EMPLOyee numbers and their gender
SELECT * FROM dept_manager
WHERE to_date > CURDATE(); #TABLE OF current managers

SELECT dept_no FROM (SELECT * FROM dept_manager
WHERE to_date > CURDATE()) AS M
JOIN (SELECT emp_no,gender FROM employees WHERE gender = 'F') AS G
ON G.emp_no = M.emp_no;  # list of all current female managers dept nubers

SELECT dept_name FROM departments
WHERE dept_no IN (SELECT dept_no FROM (SELECT * FROM dept_manager
WHERE to_date > CURDATE()) AS M
JOIN (SELECT emp_no,gender FROM employees WHERE gender = 'F') AS G
ON G.emp_no = M.emp_no);

-- 2 Find the first and last name of the employee with the highest salary.
SELECT MAX(salary) FROM salaries; #max salary (ever)
SELECT emp_no from salaries WHERE salary = (SELECT MAX(salary) FROM salaries); # employee number of employee with highest salary

SELECT * FROM employees WHERE emp_no = (SELECT emp_no from salaries WHERE salary = (SELECT MAX(salary) FROM salaries));


SELECT * FROM salaries WHERE emp_no = 43624;
-- 3 Find the department name that the employee with the highest salary works in.
SELECT * FROM dept_emp WHERE emp_no = (SELECT emp_no from salaries WHERE salary = (SELECT MAX(salary) FROM salaries));
SELECT dept_no FROM dept_emp WHERE emp_no = (SELECT emp_no from salaries WHERE salary = (SELECT MAX(salary) FROM salaries)); # department number of highest payed employee

SELECT * FROM departments WHERE dept_no = (SELECT dept_no FROM dept_emp WHERE emp_no = (SELECT emp_no from salaries WHERE salary = (SELECT MAX(salary) FROM salaries)));
-- 4 Who is the highest paid employee within each department.

#name/salary/department














SELECT D.dept_no,DE.emp_no,salary FROM departments AS D
JOIN dept_emp as DE
	ON DE.dept_no = D.dept_no
JOIN salaries as S
	ON S.emp_no = DE.emp_no;   # TABLE of department, employees and salaries

SELECT MAX(salary) AS MAX_SAL FROM departments AS D
JOIN dept_emp as DE
	ON DE.dept_no = D.dept_no
JOIN salaries as S
	ON S.emp_no = DE.emp_no
GROUP BY D.dept_no;     # LIST of max salaries

SELECT emp_no,salary FROM salaries WHERE salary IN 
(SELECT MAX(salary) AS MAX_SAL FROM departments AS D
JOIN dept_emp as DE
	ON DE.dept_no = D.dept_no
JOIN salaries as S
	ON S.emp_no = DE.emp_no
GROUP BY D.dept_no);   # TABLE of salaries and employee numbers

SELECT * FROM employees AS E 
JOIN (SELECT emp_no,salary FROM salaries WHERE salary IN 
(SELECT MAX(salary) AS MAX_SAL FROM departments AS D
JOIN dept_emp as DE
	ON DE.dept_no = D.dept_no
JOIN salaries as S
	ON S.emp_no = DE.emp_no
GROUP BY D.dept_no)) AS S
	ON S.emp_no = E.emp_no;
    
SELECT D.dept_no,DE.emp_no,salary,first_name, last_name FROM departments AS D
JOIN dept_emp as DE
	ON DE.dept_no = D.dept_no
JOIN salaries as S
	ON S.emp_no = DE.emp_no
JOIN employees AS E
	ON E.emp_no = DE.emp_no; 
    
    

SELECT * FROM (SELECT D.dept_no,DE.emp_no,salary,first_name, last_name FROM departments AS D
JOIN dept_emp as DE
	ON DE.dept_no = D.dept_no
JOIN salaries as S
	ON S.emp_no = DE.emp_no
JOIN employees AS E
	ON E.emp_no = DE.emp_no) AS EMPS 
    WHERE salary IN 
    (SELECT MAX(salary) AS MAX_SAL FROM departments AS D
JOIN dept_emp as DE
	ON DE.dept_no = D.dept_no
JOIN salaries as S
	ON S.emp_no = DE.emp_no
GROUP BY D.dept_no);
    
    