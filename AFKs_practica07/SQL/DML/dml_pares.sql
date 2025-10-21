-- ===============================================================================================
-- CONSULTA 2: Obtener el título de las canciones con más de 5 minutos de duración
-- Tablas utilizadas: cancion
-- ===============================================================================================
-- Implementamos esta consulta seleccionando de la tabla cancion y filtrando en WHERE.
-- Convertimos el campo duracion (VARCHAR formato MM:SS) a tipo interval mediante casting
-- para compararlo con '05:00' y aprovechar las capacidades de PostgreSQL para intervalos.
SELECT cod, titulo, duracion FROM cancion
WHERE concat(duracion)::interval > '05:00'::interval;

-- ===============================================================================================
-- CONSULTA 4: Seleccionar el nombre y el lugar de origen de los clubes con más de 500 fans
-- Tablas utilizadas: club
-- ===============================================================================================
-- Implementamos una consulta directa sobre la tabla club aplicando un filtro sobre numfans.
-- Utilizamos el operador > para obtener únicamente clubes con más de 500 fans.
SELECT nombre, lugarorigen FROM club
WHERE numfans > 500;


-- ===============================================================================================
-- CONSULTA 6: Obtener el nombre de los discos que contienen alguna canción que dure más de 5
-- minutos y decir cuántas canciones del disco cumplen esto
-- Tablas utilizadas: esta, cancion
-- ===============================================================================================
-- Implementamos esta consulta con INNER JOIN entre esta y cancion, relacionándolas por código.
-- Aplicamos el filtro de duración convirtiendo a interval, agrupamos por disco y usamos
-- COUNT(*) para contar canciones que cumplen la condición. Ordenamos por cantidad descendente.
SELECT numref, album, COUNT(*) as canciones_mayor_5min FROM esta rel
INNER JOIN cancion ON cancion.cod = rel.codcan
WHERE concat(cancion.duracion)::interval > '05:00'::interval
GROUP BY numref, album
ORDER BY canciones_mayor_5min DESC;


-- ===============================================================================================
-- CONSULTA 8: Obtener los nombres de las disqueras y direcciones de aquellas compañías disqueras
-- que han grabado algún disco que empiece con 'T'
-- Tablas utilizadas: disquera, disco
-- ===============================================================================================
-- Implementamos esta consulta con INNER JOIN entre disquera y disco, relacionándolas por nombre.
-- Aplicamos LIKE 'T%' para filtrar discos que comienzan con T, obteniendo así las disqueras
-- que han producido al menos un disco con estas características.
SELECT disquera.disquera,disquera.direccion, disco.album FROM disquera
INNER JOIN disco ON disco.disquera = disquera.disquera
AND disco.origen_disquera = disquera.origen_disquera
WHERE disco.album LIKE 'T%';


-- ===============================================================================================
-- CONSULTA 10: Seleccionar todos los pares de artistas españoles distintos tales que el primero
-- sea voz y el segundo guitarra
-- Tablas utilizadas: artista, pertenece, interprete
-- ===============================================================================================
-- Implementamos esta consulta con dos subconsultas que filtran artistas españoles: una para
-- vocalistas y otra para guitarristas. Aplicamos CROSS JOIN entre ambos conjuntos para generar
-- todas las combinaciones posibles de pares (vocalista, guitarrista).
SELECT
    vocalistas.nombre as vocalistas,
    guitarristas.nombre as guitarristas
FROM (SELECT *
FROM artista
INNER JOIN pertenece ON artista.curp = pertenece.curp
INNER JOIN interprete ON interprete.nombreint = pertenece.nombreint
WHERE interprete.pais = 'España' AND pertenece.funcion = 'Voz') vocalistas
CROSS JOIN
(SELECT *
FROM artista
INNER JOIN pertenece ON artista.curp = pertenece.curp
INNER JOIN interprete ON interprete.nombreint = pertenece.nombreint
WHERE interprete.pais = 'España' AND pertenece.funcion = 'Guitarra'
) guitarristas;




-- ===============================================================================================
-- CONSULTA 12: Obtener el nombre del club con mayor número de fans indicando ese número
-- Tablas utilizadas: club
-- ===============================================================================================
-- Implementamos dos soluciones alternativas. La primera usa subconsulta con MAX() para
-- encontrar el valor máximo y luego filtra ese registro. La segunda ordena descendentemente
-- y usa LIMIT 1. La segunda solución es más eficiente en términos de ejecución.
SELECT nombre, numfans as max_fans FROM club
WHERE numfans = (SELECT MAX(numfans) FROM club);

-- o
SELECT nombre, numfans as max_fans FROM club
ORDER BY numfans desc
limit 1;



-- ===============================================================================================
-- CONSULTA 14: Obtener el número de discos de cada intérprete
-- Tablas utilizadas: disco, interprete
-- ===============================================================================================
-- Implementamos esta consulta con INNER JOIN entre disco e interprete por nombreint.
-- Agrupamos por nombreint y aplicamos COUNT(*) para contar discos de cada intérprete.
-- Ordenamos descendentemente para mostrar primero los más prolíficos.
SELECT interprete.nombreint, count(*) as numero_discos FROM disco
INNER JOIN interprete ON disco.nombreint = interprete.nombreint
GROUP BY interprete.nombreint
ORDER BY numero_discos DESC;



-- ===============================================================================================
-- CONSULTA 16: Obtener los nombres de los artistas de grupos con clubes de fans de más de 500
-- personas y que el grupo sea de Inglaterra
-- Tablas utilizadas: artista, pertenece, club, interprete
-- ===============================================================================================
-- Implementamos esta consulta con INNER JOIN entre artista y pertenece, filtrando con una
-- subconsulta usando IN. La subconsulta obtiene intérpretes con club de fans >500 y que sean
-- de Inglaterra. Esta estructura filtra eficientemente los artistas que cumplen ambos criterios.
SELECT artista.nombre, funcion, nombreint FROM artista
INNER JOIN pertenece ON artista.curp = pertenece.curp
WHERE pertenece.nombreint IN (SELECT club.nombreint
                             FROM club
                                      INNER JOIN interprete ON club.nombreint = interprete.nombreint
                             WHERE interprete.pais = 'Inglaterra'
                               AND numfans > 500)
ORDER BY nombreint;


-- ===============================================================================================
-- CONSULTA 18: Obtener el décimo club con mayor número de fans indicando ese número
-- Tablas utilizadas: club
-- ===============================================================================================
-- Implementamos esta consulta ordenando los clubes descendentemente por numfans con ORDER BY.
-- Utilizamos LIMIT 1 para un solo registro y OFFSET 9 para saltar los primeros 9, obteniendo
-- así el décimo club (OFFSET cuenta desde cero).
SELECT * FROM club
ORDER BY numfans DESC
LIMIT 1
OFFSET 9;



-- ===============================================================================================
-- CONSULTA 20: Indicar el nombre del compositor que más canciones ha creado y el título de estas
-- Tablas utilizadas: compositor, cancion
-- ===============================================================================================
-- Implementamos esta consulta con subconsultas anidadas. La más interna hace JOIN entre
-- compositor y cancion, agrupa por compositor, cuenta con COUNT(*), ordena descendentemente
-- y usa LIMIT 1. Luego hacemos JOIN con cancion para obtener todos los títulos de ese compositor.
SELECT nombrec, titulo, duracion FROM cancion
INNER JOIN (
SELECT curpc, nombrec FROM (SELECT compositor.curpc, compositor.nombrec, COUNT(*) as num_canciones
FROM compositor
INNER JOIN cancion ON cancion.curpc = compositor.curpc
GROUP BY compositor.curpc, compositor.nombrec
ORDER BY num_canciones DESC
LIMIT 1)) maxi ON cancion.curpc = maxi.curpc



-- ===============================================================================================
-- CONSULTA 22: Obtener para cada grupo con más de dos integrantes, el nombre y el número de
-- componentes del grupo
-- Tablas utilizadas: pertenece
-- ===============================================================================================
-- Implementamos esta consulta agrupando los registros de pertenece por nombreint y usando
-- COUNT(*) para contar artistas por grupo. HAVING filtra solo grupos con más de 2 integrantes,
-- aplicando la condición después de la agregación. Ordenamos descendentemente por tamaño.
SELECT nombreint, COUNT(*) as num_integrantes FROM pertenece
GROUP BY pertenece.nombreint
HAVING COUNT(*) > 2
ORDER BY num_integrantes DESC;



-- ===============================================================================================
-- CONSULTA 24: Obtener para cada compositor la canción que aparece más veces en distintos álbumes
-- Tablas utilizadas: compositor, cancion, esta
-- ===============================================================================================
-- Implementamos esta consulta con múltiples subconsultas. La primera (canciones_rep) cuenta
-- apariciones de cada canción agrupando por código y compositor. La segunda anidada primero
-- cuenta apariciones y luego aplica MAX() para el máximo por compositor. Hacemos JOIN con
-- compositor filtrando canciones cuyas apariciones coinciden con el máximo de su compositor.
--NOTA IMPORTANTE: si hay un empate salen todas las canciones que tienen el mismo maximo
SELECT
    compositor.curpc,
    compositor.nombrec,
    canciones_rep.cod AS codigo_cancion,
    canciones_rep.titulo,
    canciones_rep.num_de_apariciones
FROM compositor
INNER JOIN (
    SELECT
        cancion.cod,
        cancion.titulo,
        cancion.curpc,
        COUNT(*) as num_de_apariciones
    FROM cancion
    INNER JOIN esta ON cancion.cod = esta.codcan
    GROUP BY cancion.cod, cancion.titulo, cancion.curpc
) canciones_rep ON compositor.curpc = canciones_rep.curpc
INNER JOIN (
    SELECT
        curpc,
        MAX(numero_de_apariciones) as max_apariciones
    FROM (
        SELECT
            cancion.curpc,
            cancion.cod,
            COUNT(*) as numero_de_apariciones
        FROM cancion
        INNER JOIN esta ON cancion.cod = esta.codcan
        GROUP BY cancion.curpc, cancion.cod
    ) conteo
    GROUP BY curpc
) max_por_compositor
    ON canciones_rep.curpc = max_por_compositor.curpc
    AND canciones_rep.num_de_apariciones = max_por_compositor.max_apariciones
ORDER BY canciones_rep.num_de_apariciones DESC, compositor.nombrec;



-- ===============================================================================================
-- CONSULTA 26: Listar las funciones que desempeñan los artistas y cuántos hay por cada una
-- Tablas utilizadas: pertenece
-- ===============================================================================================
-- Implementamos esta consulta agrupando los registros de pertenece por el atributo funcion.
-- Aplicamos COUNT(*) para contar artistas que desempeñan cada función y ordenamos
-- descendentemente para mostrar primero las funciones más comunes en los grupos musicales.
SELECT funcion, COUNT(*) num_artistas FROM pertenece
GROUP BY funcion
ORDER BY num_artistas DESC;



-- ===============================================================================================
-- CONSULTA 28: Para cada disco, el total de canciones que tiene y la duración de la más larga
-- Tablas utilizadas: disco, esta, cancion
-- ===============================================================================================
-- Implementamos esta consulta con INNER JOIN entre disco, esta y cancion, relacionándolas
-- por sus claves. Agrupamos por disco y aplicamos COUNT(*) para el total de canciones y
-- MAX(cancion.duracion) para la duración más larga, obteniendo información resumida por disco.
SELECT disco.numref, disco.album, COUNT(*) as num_canciones, MAX(cancion.duracion) duracion_mas_larga FROM disco
INNER JOIN esta ON disco.numref = esta.numref
INNER JOIN cancion ON cancion.cod = esta.codcan
GROUP BY disco.numref, disco.album






