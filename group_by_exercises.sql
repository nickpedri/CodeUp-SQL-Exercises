-- 1. Create a new file named group_by_exercises.sql
USE employees;
SELECT * FROM titles;

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT DISTINCT title FROM titles;
#There are 7 unique titles


-- 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name FROM employees GROUP BY last_name HAVING last_name LIKE 'e%e';
SELECT last_name FROM employees WHERE last_name LIKE 'e%e'GROUP BY last_name;


-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT first_name,last_name FROM employees
 WHERE last_name LIKE 'e%e'
 GROUP BY first_name,last_name;

-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT last_name FROM employees 
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
# The names are: Chleq, Lindqvist and Qiwen


-- 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT last_name,COUNT(last_name) FROM employees 
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
# Chleq (198), Lindqvist 190 and Qiwen 168

-- 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT first_name,gender,COUNT(*) FROM employees 
WHERE first_name IN ('Irena', 'Vidya','Maya')
GROUP BY first_name,gender;


-- 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username.
SELECT LOWER(
		CONCAT(
			SUBSTR(first_name,1,1),
            SUBSTR(last_name,1,4),
            '_',
            SUBSTR(birth_date,6,2),
            SUBSTR(birth_date,3,2))) AS Username, 
	   COUNT(*) AS 'Number of Usernames'
FROM employees GROUP BY Username;

-- 9. From your previous query, are there any duplicate usernames? What is the higest number of times a username shows up? Bonus: How many duplicate usernames are there from your previous query?
SELECT LOWER(
		CONCAT(
			SUBSTR(first_name,1,1),
            SUBSTR(last_name,1,4),
            '_',
            SUBSTR(birth_date,6,2),
            SUBSTR(birth_date,3,2))) AS Username, 
	   COUNT(*) AS 'Username Count'
FROM employees GROUP BY Username ORDER BY COUNT(*) DESC;
#The highest number of times a username shows up is 6.


#BONUS 9 How many duplicate usernames are there from your previous query?

SELECT LOWER(
		CONCAT(
			SUBSTR(first_name,1,1),
            SUBSTR(last_name,1,4),
            '_',
            SUBSTR(birth_date,6,2),
            SUBSTR(birth_date,3,2))) AS Username,
	   COUNT(*) AS duplicates
FROM employees GROUP BY Username HAVING COUNT(*) > 1 ORDER BY COUNT(*) ASC;
#13251 Duplicte usernames





-- ######################################Bonus

#Bonus: More practice with aggregate functions:

-- Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.


SELECT emp_no,AVG(salary) FROM salaries GROUP BY emp_no;


-- Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
SELECT dept_no,COUNT(emp_no) FROM dept_emp GROUP BY dept_no;


-- Determine how many different salaries each employee has had. This includes both historic and current.

SELECT emp_no,COUNT(salary) FROM salaries GROUP BY emp_no;

-- Find the maximum salary for each employee.
SELECT emp_no,MAX(salary) FROM salaries GROUP BY emp_no;

-- Find the minimum salary for each employee.
SELECT emp_no,MIN(salary) FROM salaries GROUP BY emp_no;


-- Find the standard deviation of salaries for each employee.
SELECT emp_no,STDDEV(salary) AS 'Standard Deviation' FROM salaries GROUP BY emp_no;

-- Now find the max salary for each employee where that max salary is greater than $150,000.
SELECT emp_no,MAX(salary) FROM salaries GROUP BY emp_no HAVING MAX(salary) > 150000;

SELECT emp_no,MAX(salary) FROM salaries WHERE salary > 150000 GROUP BY emp_no;


-- Find the average salary for each employee where that average salary is between $80k and $90k.

SELECT emp_no,AVG(salary) FROM salaries GROUP BY emp_no HAVING AVG(salary) BETWEEN 80000 AND 90000;

