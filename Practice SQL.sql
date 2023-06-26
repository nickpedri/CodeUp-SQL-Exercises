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