-- 1. Use the albums_db database.
USE albums_db;

-- 2. What is the primary key for the albums table?
#The primary key is the 'id'


-- 3. What does the column named 'name' represent?
#The column represets the name of the album 


-- 4. What do you think the sales column represents?
#The sales column represents the number of album sales in millions


-- 5. Find the name of all albums by Pink Floyd.
SELECT name FROM albums WHERE artist = 'Pink Floyd';

-- 6. What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
#SELECT * FROM albums;
SELECT release_date FROM albums WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';
#1967

-- 7. What is the genre for the album Nevermind?
SELECT genre FROM albums WHERE name = 'Nevermind';
#Grunge, Alternative rock

-- 8. Which albums were released in the 1990s?
SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 1999;

-- 9. Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SELECT name AS low_selling_albums FROM albums WHERE sales < 20;
