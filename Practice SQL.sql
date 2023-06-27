#comment
-- also comment, the '--' must have a space after it

SELECT 'Test';

/* This 
is
a
multiple line
comment
*/

SELECT 'TEST' as ALIAS;
#Alias will temporarily replace the name of a column to the assigned value.

#The DISTINCT keyword will not retrieve duplicate results. It will retrieve the FIRST result only!

USE chipotle;

SELECT * from orders;

SELECT * from orders WHERE quantity >= 2 AND item_name = 'Canned Soda' AND order_ID BETWEEN 75 AND 1000;

USE albums_db;
SELECT * FROM albums;

SELECT * FROM albums WHERE release_date BETWEEN 1990 AND 1999;


-- -----------------------------------------------------------------

#JUN 27 2023 new lesson

USE albums_db;
SELECT * FROM albums;

SELECT * FROM albums WHERE artist LIKE '%ee%';
#the code will find artists whose names contain the letters 'ee'

USE employees;
SELECT * FROM employees;

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name IN ('Herber', 'Dredge', 'Lipner', 'Baek');

#code will find the features for the employees whose last names are in the list provided after the IN keyword.

/* 
IS NULL = this keyworkd checks if a value is null
IS NOT NULL = checks if value is not null
*/

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name IN ('Herber','Baek')
  AND emp_no < 20000;

#WE can combine clauses with AND & OR keywords.

SELECT * FROM employees WHERE first_name LIKE '%e';

# The WILDCARD % symbol, allows you to search for certain characters within a string. The % represents anything. So %E means that
# it is searching for string containing an "E" or "e" (not case sensitive) that can be preceded by anything but is followed up by nothing.

USE chipotle;
SELECT * FROM orders WHERE quantity > 2 
AND (item_name LIKE 'Steak%' OR item_name LIKE 'Chicken%' ) 
AND order_id BETWEEN 50 AND 250;

-- --------- ORDER BY AND LIMIT

USE employees;
SELECT * FROM employees ORDER BY last_name;

/* The ORDER BY keyword will organize the results alphabetically either descending or ascending. 
It can also organize numerically. The modifier DESC and ASC can be used to change order.

*/ 

SELECT * FROM employees LIMIT 10 OFFSET 5;

# LIMIT is used to change the number of results. A limit of 10 will return only 10 results.alter
#OFFSET will change which row the results will begin at. An OFFSET of 10 will ignore the first 10 results and start
# from the 11th result.


SELECT * FROM employees WHERE  birth_date LIKE '%12-25' AND hire_date LIKE '199%'
 ORDER BY hire_date ASC LIMIT 5 OFFSET 2;







