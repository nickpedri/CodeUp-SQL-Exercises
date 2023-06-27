-- 1.Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. What is the employee number of the top three results?
USE employees;
SHOW TABLES;
SELECT * FROM employees;
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');
#employee numbers 10200 10397 10610

-- 2.Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. What is the employee number of the top three results? Does it match the previous question?
SELECT * FROM employees WHERE first_name = 'Irena' 
OR first_name = 'Vidya' 
OR first_name= 'Maya';
#employee numbers 10200,10397,10610. The employee numbers are the same!

-- 3.Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. What is the employee number of the top three results.
SELECT * FROM employees WHERE gender = 'M' AND (first_name = 'Irena' 
OR first_name = 'Vidya' 
OR first_name= 'Maya');
#employee numbers 10200,10397,10821. The employee numbers are different.

-- 4.Find all unique last names that start with 'E'.
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE 'e%';

-- 5.Find all unique last names that start or end with 'E'.
SELECT DISTINCT last_name FROM employees WHERE (last_name LIKE '%e' OR last_name LIKE 'e%');

-- 6.Find all unique last names that end with E, but does not start with E?
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE '%e' AND last_name NOT LIKE 'e%';

-- 7.Find all unique last names that start and end with 'E'.
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE '%e' AND last_name LIKE 'e%';

-- 8.Find all current or previous employees hired in the 90s. Enter a comment with top three employee numbers.
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
SELECT * FROM employees WHERE hire_date LIKE '199%';
#emp # 11454, 10082, 10155

-- 9.Find all current or previous employees born on Christmas. Enter a comment with top three employee numbers.
SELECT * FROM employees WHERE birth_date LIKE '%12-25';
# emp # 10078, 10115, 10261

-- 10.Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with top three employee numbers.
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%12-25';
#emp # 10261 10438 10681

-- 11.Find all unique last names that have a 'q' in their last name.
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE '%q%';


-- 12.Find all unique last names that have a 'q' in their last name but not 'qu'.
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE '%q%' 
AND last_name NOT LIKE '%qu%';


