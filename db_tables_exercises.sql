-- 1. Open MySQL Workbench and login to the database server
-- 2. Save your work in a file named db_tables_exercises.sql
-- 3. List all the databases


SHOW DATABASES;


-- 4. Write the SQL code necessary to use the albums_db database

USE albums_db;


-- 5. Show the currently selected database

SELECT database();


-- 6. List all tables in the database

SHOW TABLES;


-- 7. Write the SQL code to switch the employees database

USE employees;


-- 8. Show the currently selected database

SELECT database();


-- 9. List all the tables in the database

SHOW TABLES;


-- 10. Explore the employees table. What different data types are present on this table?

SHOW CREATE TABLE employees;
-- The present types of data in this table 'int' 'date' 'varchar' 'enum' 


-- 11. Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment) 

SHOW TABLES;
-- Salaries is the most likely one to contain a numeric type column, as well as employees and titles for maybe an employee number.


-- 12. Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)

-- I believe all tables most likely contain some form of string value


-- 13. Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)

-- Every table except the departments table has a date type column.


-- 14. What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)

-- The individual tables do not have any form of relationship on their own. None of the information on them overlaps, however
-- the dept_emp table contains both emp_no and dept_no which IS in the two indibidual tables and this seems to tie together
-- the other two tables by showing what employee worked in what department from what dates.


-- 15. Show the SQL that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.

SHOW CREATE TABLE dept_manager;