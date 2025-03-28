-- SUPRESSION --

DROP TABLE tb_boxoffice;
DROP TABLE tb_movie;

-- CREATION --

CREATE TABLE tb_movie(
id SERIAL PRIMARY KEY, 
title VARCHAR(30) NOT NULL, 
release_year INT NOT NULL
);

COPY tb_movie (id, title, release_year)
FROM 'C:\Users\paula\Desktop\General\5. HEIG-VD\Semestre 2\InfraDon\movies_db\movies.csv'
(FORMAT CSV, HEADER)
;

CREATE TABLE tb_boxoffice (
id SERIAL PRIMARY KEY, 
movie_id integer REFERENCES tb_movie(id), 
rating decimal(1) NOT NULL,
domestic_sales bigint NOT NULL, 
international_sales bigint NOT NULL
);

COPY tb_boxoffice (movie_id, rating, domestic_sales, international_sales)
FROM 'C:\Users\paula\Desktop\General\5. HEIG-VD\Semestre 2\InfraDon\movies_db\boxoffice.csv'
(FORMAT CSV, HEADER)
;

-- MODIFICATION --

ALTER TABLE tb_movie
ADD COLUMN category varchar(30)
;

UPDATE tb_movie
SET category = 'Animation'
;

-- LECTURE --

SELECT *
FROM tb_movie tm
;

SELECT *
FROM tb_boxoffice tb 
;

SELECT id, title
FROM tb_movie tm 
;

-- CHALLENGE --

SELECT *
FROM tb_movie
WHERE release_year > 2000
;

SELECT *
FROM tb_movie
WHERE title LIKE 'Toy Story%'
;

DELETE FROM tb_movie
WHERE release_year < 2000
;

--

ALTER TABLE tb_movie 
ADD COLUMN epoque varchar(4);

UPDATE tb_movie 
SET epoque = '90''s'
WHERE tb_movie.release_year < 2000
;

UPDATE tb_movie 
SET epoque = '00''s'
WHERE tb_movie.release_year BETWEEN 2000 AND 2009
;

UPDATE tb_movie 
SET epoque = '10''s'
WHERE tb_movie.release_year BETWEEN 2010 AND 2019
;

SELECT epoque, COUNT(*) AS films
FROM tb_movie 
GROUP BY epoque
;

-- 

SELECT *
FROM tb_movie
ORDER BY release_year DESC 
;

SELECT epoque, COUNT(*) AS films
FROM tb_movie 
GROUP BY epoque 
ORDER BY films DESC
;

--

SELECT m.title, b.international_sales
FROM tb_movie m
INNER JOIN tb_boxoffice b ON b.movie_id = m.id
;








