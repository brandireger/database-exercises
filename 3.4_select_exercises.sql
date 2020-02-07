SHOW DATABASES;

USE `albums_db`;

SHOW TABLES;

DESCRIBE albums;

SELECT NAME FROM albums WHERE artist = 'Pink Floyd';

SELECT release_date FROM albums WHERE NAME = 'Sgt. Pepper\'s Lonely Hearts Club Band';

SELECT genre FROM albums WHERE NAME = 'Nevermind';

SELECT NAME FROM albums WHERE release_date BETWEEN 1990 AND 1999;

SELECT NAME FROM albums WHERE sales < 20;

SELECT NAME FROM albums WHERE genre = 'Rock';