-- REQUERIMIENTOS --
-- Trabajando con DBeaver --

-- 1. Crear una base de datos llamada películas. (OPCIONAL)
create database peliculas;
-- 2. Cargar ambos archivos a su tabla correspondiente. (OPCIONAL)
truncate peliculas;
truncate reparto;

copy peliculas from 'C:\Workspaces\Bootcamp\Fullstack_Python_G7\Desafios_m5\desafio_BBDD_3\peliculas.csv' 
delimiter ','
csv header;

copy reparto from 'C:\Workspaces\Bootcamp\Fullstack_Python_G7\Desafios_m5\desafio_BBDD_3\reparto.csv'
delimiter ','
csv header;

-- 3. Obtener el ID de la película “Titanic”. (1 Punto)
select id as "Id de la Película" from peliculas where titulo  = 'Titanic';

-- 4. Listar a todos los actores que aparecen en la película "Titanic". (1 Punto)
select reparto.actor as actores from reparto
inner join peliculas on reparto.id_pelicula = peliculas.id
where peliculas.titulo = 'Titanic';

-- 5. Consultar en cuántas películas del top 100 participa Harrison Ford. (2 Puntos)
select count(id_pelicula) as "Cantidad de Películas" from reparto
where actor = 'Harrison Ford';

-- 6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente. (1 punto)
select titulo as "Título", estreno as "Año de Estreno" from peliculas
where estreno between 1990 and 1999 order by titulo; -- order by ya ordena de forma ascendente por defecto

-- 7. Hacer una consulta SQL que muestre los títulos con su longitud, 
-- la longitud debe ser nombrado para la consulta como “longitud_titulo”. (1 punto)
select titulo, length(titulo) as longitud_titulo from peliculas;

-- 8. Consultar cual es la longitud más grande entre todos los títulos de las películas. (2 punto)
select max(length(titulo)) as "Mayor Longitud" from peliculas;
