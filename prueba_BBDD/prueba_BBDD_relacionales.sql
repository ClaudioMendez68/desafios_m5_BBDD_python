CREATE DATABASE prueba_bbdd;

-- 1. Crea el modelo (revisa bien cuál es el tipo de relación antes de crearlo), 
-- respeta las claves primarias, foráneas y tipos de datos. (1 punto)
CREATE TABLE peliculas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    anno INTEGER NOT NULL
);
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    tag VARCHAR(32) NOT NULL
);
CREATE TABLE peliculas_tags (
    id SERIAL PRIMARY KEY,
    pelicula_id INTEGER REFERENCES peliculas(id),
    tag_id INTEGER REFERENCES tags(id)
);

-- 2. Inserta 5 películas y 5 tags, la primera película tiene que tener 3 tags asociados, 
-- la segunda película debe tener dos tags asociados. (1 punto)
INSERT INTO peliculas(nombre, anno)
VALUES
    ('Interestelar', 2014),
    ('Oppenheimer', 2023),
    ('El Orígen', 2010),
    ('Dunkerque', 2017),
    ('Memento', 2000);

INSERT INTO tags(tag)
VALUES
    ('Ciencia Ficción'),
    ('Drama'),
    ('Aventuras'),
    ('Histórico'),
    ('Thriller');

INSERT INTO peliculas_tags (pelicula_id, tag_id)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 4),
    (2, 5);

SELECT peliculas.nombre, tags.tag FROM peliculas
INNER JOIN peliculas_tags ON peliculas.id = peliculas_tags.pelicula_id
INNER JOIN tags ON peliculas_tags.tag_id = tags.id;

-- 3. Cuenta la cantidad de tags que tiene cada película. 
-- Si una película no tiene tags debe mostrar 0. (1 punto)
SELECT peliculas.nombre AS pelicula, COUNT(peliculas_tags.tag_id) AS cantidad FROM peliculas
LEFT JOIN peliculas_tags ON peliculas.id = peliculas_tags.pelicula_id
GROUP BY pelicula ORDER BY cantidad DESC;

-- 4. Crea las tablas respetando los nombres, tipos, claves primarias y foráneas y tipos de datos. (1 punto)
CREATE TABLE preguntas (
    id SERIAL PRIMARY KEY,
    pregunta VARCHAR(255),
    respuesta_correcta VARCHAR
);
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    edad INTEGER
);
CREATE TABLE respuestas (
    id SERIAL PRIMARY KEY,
    respuesta VARCHAR(255),
    usuario_id INTEGER REFERENCES usuarios(id),
    pregunta_id INTEGER REFERENCES preguntas(id)
);

-- 5. Agrega 5 registros a la tabla preguntas, de los cuales: (1 punto)
    -- a. 1. La primera pregunta debe ser contestada correctamente por dos usuarios distintos
    -- b. 2. La pregunta 2 debe ser contestada correctamente por un usuario.
    -- c. 3. Los otros dos registros deben ser respuestas incorrectas.
INSERT INTO usuarios (nombre, edad)
VALUES
    ('Alan Brito', 23),
    ('Zacarías Flores', 34),
    ('Armando Casas', 45);

INSERT INTO preguntas (pregunta, respuesta_correcta)
VALUES
    ('¿Cuál fue el primer animal en orbitar la Tierra?', 'La perrita Laika'),
    ('¿En qué convirtió el agua Jesús?', 'En vino'),
    ('¿Por qué América se llama América?', 'Por Americo Vespucio'),
    ('¿Quién fue la emperatriz más poderosa del mundo?', 'La Emperatriz Cixi'),
    ('¿Para qué sirve la trigonometría?', 'Para medir triangulos');

INSERT INTO respuestas (respuesta, usuario_id, pregunta_id)
VALUES
    ('El mapache Pedro', 1, 1),
    ('La perrita Laika', 2, 1),
    ('La perrita Laika', 3, 1),
    ('En vino', 1, 2),
    ('En un melvin', 2, 2),
    ('En whiskey', 3, 2),
    ('Por Donald Trump', 1, 3),
    ('Por el Capitán América', 2, 3),
    ('Por la Copa América', 3, 3),
    ('Taylor Swift', 1, 4),
    ('Lady Gaga', 2, 4),
    ('Kim Kardashian', 3, 4);

-- 6. Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la pregunta). (1 punto)

SELECT usuarios.nombre, respuestas.respuesta FROM usuarios
LEFT JOIN respuestas ON usuarios.id = respuestas.usuario_id
INNER JOIN preguntas ON respuestas.pregunta_id = preguntas.id
AND respuestas.respuesta = preguntas.respuesta_correcta;

SELECT usuarios.nombre AS usuario, COUNT(respuestas.usuario_id) AS cantidad_respuestas FROM usuarios
LEFT JOIN respuestas ON usuarios.id = respuestas.usuario_id
AND respuestas.respuesta = (SELECT respuesta_correcta FROM preguntas WHERE id = respuestas.pregunta_id)
GROUP BY usuario ORDER BY cantidad_respuestas DESC;
-- 7. Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios tuvieron la respuesta correcta. (1 punto)

SELECT preguntas.pregunta, COUNT(respuestas.usuario_id) FROM preguntas
LEFT JOIN respuestas ON preguntas.id = respuestas.pregunta_id
AND respuestas.respuesta = preguntas.respuesta_correcta
GROUP BY preguntas.pregunta;

SELECT preguntas.pregunta AS pregunta, COUNT(respuestas.usuario_id) AS cantidad_usuarios FROM preguntas
LEFT JOIN respuestas ON preguntas.id = respuestas.pregunta_id
AND preguntas.respuesta_correcta = respuestas.respuesta
GROUP BY pregunta ORDER BY cantidad_usuarios DESC;

-- 8. Implementa borrado en cascada de las respuestas al borrar un usuario
-- y borrar el primer usuario para probar la implementación. (1 punto)
ALTER TABLE respuestas
DROP CONSTRAINT respuestas_usuario_id_fkey;

ALTER TABLE respuestas
ADD FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE;

DELETE FROM usuarios WHERE id = 1;

-- 9. Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos. (1 punto)
ALTER TABLE usuarios
ADD CHECK (edad >= 18);

INSERT INTO usuarios (id, nombre, edad)
VALUES (1, 'Alan Brito', 23);

-- 10. Altera la tabla existente de usuarios agregando el campo email con la restricción de único. (1 punto)
ALTER TABLE usuarios
ADD COLUMN email VARCHAR(255) UNIQUE;

INSERT INTO usuarios (nombre, edad, email)
VALUES ('Elba Surero', 37, 'elbasur@gmail.com');

INSERT INTO usuarios (nombre, edad)
VALUES ('Elba Surero', 37);