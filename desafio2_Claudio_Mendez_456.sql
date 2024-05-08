-- Desafío - Manipulación de datos y transaccionalidad en las operaciones.

-- Para este desafío se debe crear una base de datos llamada desafio2-tuNombre-tuApellido-3digitos donde los 3 dígitos
-- son escogidos por ti al azar
CREATE DATABASE "desafio2-Claudio-Mendez-456";
-- Utilizando el siguiente set de datos:
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 99, '01/08/2021', 'Página' );

-- 1. ¿Cuántos registros hay?
-- QUERY:
SELECT COUNT(*) AS cantidad_registros FROM INSCRITOS;
REPORTE:
 cantidad_registros
--------------------
                 16

-- 2. ¿Cuántos inscritos hay en total?
-- QUERY:
SELECT SUM(cantidad) AS total_inscritos FROM INSCRITOS;
REPORTE:
 total_inscritos
-----------------
             774

-- 3. ¿Cuál o cuáles son los registros de mayor antigüedad?
-- Probando Subconsulta:
-- SELECT MIN(fecha) FROM INSCRITOS;
-- QUERY:
SELECT * FROM INSCRITOS WHERE fecha = (SELECT MIN(fecha) FROM INSCRITOS);
REPORTE:
 cantidad |   fecha    | fuente
----------+------------+--------
       56 | 2021-01-01 | Página
       44 | 2021-01-01 | Blog

-- 4. ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante)
-- QUERY:
SELECT fecha, SUM(cantidad) AS inscritos_por_dia FROM INSCRITOS WHERE fecha < NOW() GROUP BY fecha ORDER BY fecha;
REPORTE:
   fecha    | inscritos_por_dia
------------+-------------------
 2021-01-01 |               100
 2021-02-01 |               120
 2021-03-01 |               103
 2021-04-01 |                93
 2021-05-01 |                88
 2021-06-01 |                30
 2021-07-01 |                58
 2021-08-01 |               182

-- 5. ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se inscribieron en ese día?
-- QUERY:
SELECT fecha, SUM(cantidad) AS inscritos_dia FROM INSCRITOS GROUP BY fecha ORDER BY inscritos_dia DESC LIMIT 1;
REPORTE:
   fecha    | inscritos_dia
------------+---------------
 2021-08-01 |           182