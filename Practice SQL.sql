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



