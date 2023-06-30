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

-- ------------------ MySQL Functions --------------------------

#Numerical functions
-- AVG: the mean
SELECT AVG(salary) FROM salaries;

-- MIN: for finding the minimum value
SELECT MIN(salary) FROM salaries;

-- MAX: for finding the maximum value
SELECT MAX(salary) FROM salaries;

SELECT CONCAT('Hello ', 'Codeup', '!');

SELECT CONCAT(first_name,' ',last_name) AS Full_Name,gender FROM employees;
#CONCAT strings together two separate strings into one as such.

#SUBSTR(string, start_index, length)
# substrings in SQL start at 1 not 0 like python
#if no length is set then SUBSTR will default to the very end of the string

SELECT SUBSTR('abcdefghijklmnopqrstuvwxyz', 14); #begins at 14th character until the end
SELECT SUBSTR('abcdefghijklmnopqrstuvwxyz',1,13); #INCLUSIVE command. Will include index 1. and go for 13 characters
SELECT RIGHT('abcdefghijklmnopqrstuvwxyz',6); #starts from the right side
SELECT SUBSTR('abcdefghijklmnopqrstuvwxyz',-9); #substring can be negative

# Case Conversion

SELECT UPPER('abcde'), LOWER('ABCDE');

# REPLACE(subject, search, replacement)
/* subject is the string that will be worked on.
search is the part of the string that is being searched for to be replaced
the replacement is the replacement duh*/

SELECT REPLACE('abcdefg', 'abc', '123');
SELECT REPLACE('caaaaaa', 'ca', 'c');



###Date and Time Functions
SELECT NOW();
SELECT CURDATE();
SELECT CURTIME();
#shows zulu time

SELECT CONVERT_TZ(NOW(),'+00:00','-05:00');



##### UNIX_TIMESTAMP() & UNIX_TIMESTAMP(date)

/*
The UNIX_TIMESTAMP() function is used to represent time as an integer. 
It will return the number of seconds since midnight January 1st, 1970. 
If you pass a date time value to UNIX_TIMESTAMP(), it will give you the number of
 seconds from the unix epoch to that date.
*/
SELECT CONCAT(
    'Teaching people to code for ',
    UNIX_TIMESTAMP() - UNIX_TIMESTAMP('2014-02-04'),
    ' seconds'
);


SELECT
    1 + '4',
    '3' - 1,
    CONCAT('Here is a number: ', 123);

#Casting

#To cast a number or string as a different data type use the cast function

#CAST(DATA as NEW_DATA) Example below

SELECT
    CAST(123 as CHAR),
    CAST('123' as UNSIGNED);
    
    
   # DATEDIFF(x,y) where x and y are dates. This will return x-y.
   SELECT CONCAT('I am ',DATEDIFF(CURDATE(),'1997-08-10'),' days old!') AS 'Age in days:';


-- --------------GROUP BY

SELECT first_name
FROM employees
GROUP BY first_name;

SELECT first_name
FROM employees
GROUP BY first_name 
ORDER BY first_name DESC;


SELECT first_name, COUNT(first_name)
FROM employees
WHERE first_name NOT LIKE '%a%'
GROUP BY first_name;

SELECT hire_date,COUNT(hire_date) FROM employees GROUP BY hire_date 
ORDER BY COUNT(hire_date) DESC LIMIT 10;


#_#_#_#_#__#_#_#_#_#_#_#_#_#_#_#_#_#_#

#29 JUN 2023
 -- Are WHERE and HAVING clauses interchangeable? Difference?
 
 /*They are similar but not interchangeable. Where is used in the main body of 
 the query and having is used in conjuction with the GROUP BY function. 
 The where clause will be performed first and then the 
 having clause is performed. */
 
 
 
 #Characteristics of primary keys:
 # They are unique, no duplicates in a table
 #they make the query run faster
 #There is only one per table
 #PK cannot be null
 
 
 SELECT * FROM employees;
 SELECT * FROM titles;

 
 SELECT E.emp_no,CONCAT(first_name,' ',last_name) AS Employee,title FROM employees as E 
 JOIN titles as T ON E.emp_no = T.emp_no;
 
 
 
 
 ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- 
 
#SUBQUERIES

#This quesry will find the average salary
SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE();

#This query will find the employee numbers of employees who make more than the average salary
#by referencing a query that shows the average salary

SELECT emp_no, salary
FROM salaries
WHERE salary > (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE())
AND to_date > CURDATE();

SELECT emp_no, salary
FROM salaries
WHERE salary > 2 * (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE())
AND to_date > CURDATE();

#THis query uses a subquery to produce a list of the managers employee numbers so that the
#main query can use that list in the WHERE clause.
SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_manager
)
LIMIT 10;

sELECT emp_no FROM dept_manager;

SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no = (
    SELECT emp_no
    FROM employees
    WHERE emp_no = 101010
);



#This query returns the bith date, name, and employee number
# from a table created by another query
SELECT g.birth_date, g.emp_no, g.first_name from
(
    SELECT *
    FROM employees
    WHERE first_name like 'Geor%'
) as g;

#Why is a subquery a good? What are the advantages?
#You can create more complex queries with simpler code.
# Allows you to reference multiple queries without joining them.

