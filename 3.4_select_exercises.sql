USE albums_db;

DESCRIBE albums;

SELECT * FROM albums WHERE artist = 'Pink Floyd';
SELECT release_date FROM albums WHERE NAME = 'Sgt. Pepper\'s Lonely Hearts Club Band';
SELECT genre FROM albums WHERE NAME = 'Nevermind';
SELECT NAME, release_date FROM albums WHERE release_date BETWEEN 1990 AND 1999;
SELECT NAME, sales FROM albums WHERE sales < 20;
SELECT NAME, genre FROM albums WHERE genre = 'Rock'; #Because "=" a string does not mean the same thing as containing that string