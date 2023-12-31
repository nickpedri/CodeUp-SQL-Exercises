-- 1. Copy the order by exercise and save it as functions_exercises.sql.
USE employees;
SELECT * FROM employees;
-- 2. Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
SELECT CONCAT(first_name,' ',last_name) AS Full_Name FROM employees WHERE last_name LIKE 'e%e';

-- 3. Convert the names produced in your last query to all uppercase.
SELECT UPPER(CONCAT(first_name,' ',last_name)) AS Full_Name FROM employees WHERE last_name LIKE 'e%e';

-- 4. Use a function to determine how many results were returned from your previous query.
SELECT COUNT(UPPER(CONCAT(first_name,' ',last_name))) AS Full_Name FROM employees WHERE last_name LIKE 'e%e';
#899

-- 5. Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),
SELECT DATEDIFF(CURDATE(),hire_date) FROM employees WHERE  birth_date LIKE '%12-25' AND hire_date LIKE '199%';


-- 6. Find the smallest and largest current salary from the salaries table.
SELECT MAX(salary) FROM salaries;
SELECT MIN(salary) FROM salaries;


-- 7. Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:
SELECT LOWER(
		CONCAT(
			SUBSTR(first_name,1,1),
            SUBSTR(last_name,1,4),
            '_',
            SUBSTR(birth_date,6,2),
            SUBSTR(birth_date,3,2))) AS Username,
            first_name,last_name,birth_date
FROM employees LIMIT 10;

