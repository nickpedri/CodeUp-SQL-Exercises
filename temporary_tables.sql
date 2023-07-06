-- 1 Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
USE employees;
#My database name is `somerville_2275`
/*
SELECT first_name,last_name,dept_name FROM employees as E
JOIN dept_emp AS DE
	ON DE.emp_no = E.emp_no
JOIN departments AS D
	ON D.dept_no = DE.dept_no
WHERE DE.to_date > CURDATE();
*/

SET SQL_SAFE_UPDATES=0;

CREATE TEMPORARY TABLE somerville_2275.employees_with_departments AS
SELECT first_name,last_name,dept_name FROM employees as E
JOIN dept_emp AS DE
	ON DE.emp_no = E.emp_no
JOIN departments AS D
	ON D.dept_no = DE.dept_no
WHERE DE.to_date > CURDATE();

SELECT * FROM somerville_2275.employees_with_departments;

-- a Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.

ALTER TABLE somerville_2275.employees_with_departments ADD full_name VARCHAR(100);

-- b Update the table so that the full_name column contains the correct data.

UPDATE somerville_2275.employees_with_departments SET full_name = CONCAT(first_name, ' ',last_name);

-- c Remove the first_name and last_name columns from the table.
ALTER TABLE somerville_2275.employees_with_departments DROP COLUMN first_name;
ALTER TABLE somerville_2275.employees_with_departments DROP COLUMN last_name;


-- d What is another way you could have ended up with this same table?
#Manually! OR creating this table in a query and the creatign the temporary table using that query.




-- 2.Create a temporary table based on the payment table from the sakila database.
USE sakila;
SHOW TABLES;
SELECT * FROM payment;
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
CREATE TEMPORARY TABLE somerville_2275.sakila_payment AS 
SELECT * FROM payment;

SELECT * FROM somerville_2275.sakila_payment;

ALTER TABLE somerville_2275.sakila_payment MODIFY COLUMN amount FLOAT; #change data to float so i can multiply by 100
UPDATE somerville_2275.sakila_payment SET amount = amount * 100;  # multiply by 100 so it equals cents
ALTER TABLE somerville_2275.sakila_payment MODIFY COLUMN amount INT; #change to integer


-- 3. Go back to the employees database. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the best department right now to work for? The worst?

USE employees;

SELECT AVG(salary) FROM salaries
WHERE to_date > CURDATE();   #average current salary for whole company

SELECT dept_name, AVG(salary) AS averages FROM dept_emp AS DE
JOIN departments AS D
	ON D.dept_no = DE.dept_no
JOIN salaries AS S
	ON S.emp_no = DE.emp_no
WHERE DE.to_date > CURDATE() AND S.to_date > CURDATE()
GROUP BY dept_name
ORDER BY dept_name ASC;   #AVERAGE current salary per department for all current employees


SELECT salary,
	(salary - (SELECT AVG(salary) FROM salaries where to_date > CURDATE()))  /  (SELECT stddev(salary) FROM salaries where to_date > CURDATE()) AS zscore
FROM salaries
WHERE to_date > now();   #this query calculates Z-score


SELECT dept_name, averages, (averages - (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE()))  /  
									   (SELECT stddev(salary) FROM salaries WHERE to_date > CURDATE()) AS zscore
FROM (
SELECT dept_name, AVG(salary) AS averages FROM dept_emp AS DE
JOIN departments AS D
	ON D.dept_no = DE.dept_no
JOIN salaries AS S
	ON S.emp_no = DE.emp_no
WHERE DE.to_date > CURDATE() AND S.to_date > CURDATE()
GROUP BY dept_name
ORDER BY dept_name ASC
) AS A
ORDER BY zscore ASC;

#The best department to work at is sales with a score of almost 1 and the worst department to work in is HR with a score of about -0.47