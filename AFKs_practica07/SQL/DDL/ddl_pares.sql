SELECT cod, titulo, duracion FROM cancion
WHERE concat(duracion)::interval > '05:00'::interval;

SELECT nombre, lugarorigen FROM club
WHERE numfans > 500;


SELECT numref, album, COUNT(*) as canciones_mayor_5min FROM esta rel
INNER JOIN cancion ON cancion.cod = rel.codcan
WHERE concat(cancion.duracion)::interval > '05:00'::interval
GROUP BY numref, album
ORDER BY canciones_mayor_5min DESC;

--QUITAR ALBUM
--FALTAN REGISTRSO ============================================================================
--p===============================================================================================
--p===============================================================================================
--p===============================================================================================
SELECT disquera.disquera,disquera.direccion, disco.album FROM disquera
INNER JOIN disco ON disco.disquera = disquera.disquera
WHERE disco.album LIKE 'T%'


-- EL EJERCICIO SE COMPLICA EN ESTE PUNTO
--agregamos el like en el nombre pues la llave primaria no era curp sino el nombre  y en algunas tablas
-- no estaba el nombre igual
SELECT
    vocalistas.nombre as vocalistas,
    guitarristas.nombre as guitarristas
FROM (SELECT *
FROM artista
INNER JOIN interprete ON artista.nombre LIKE concat('%', interprete.nombreint, '%')
INNER JOIN pertenece ON artista.curp = pertenece.curp
WHERE interprete.pais = 'España') vocalistas
CROSS JOIN
(SELECT *
FROM artista
INNER JOIN interprete ON artista.nombre = interprete.nombreint
INNER JOIN pertenece ON artista.curp = pertenece.curp
WHERE interprete.pais = 'España'
) guitarristas





SELECT nombre, numfans as max_fans FROM club
WHERE numfans = (SELECT MAX(numfans) FROM club)

-- o
SELECT nombre, numfans as max_fans FROM club
ORDER BY numfans desc
limit 1;



--agregar mas discos al ddl para que varie un poco
SELECT interprete.nombreint, count(*) as numero_discos FROM disco
INNER JOIN interprete ON disco.nombreint = interprete.nombreint
GROUP BY interprete.nombreint;


--notamos que la tabla interprete pone al os grupos, arista es el solitoario (con curp)
-- y pertenece relacinoa a los aristas con los interpretes o bandas
SELECT artista.nombre, funcion, nombreint FROM artista
INNER JOIN pertenece ON artista.curp = pertenece.curp
WHERE pertenece.nombreint IN (SELECT club.nombreint
                             FROM club
                                      INNER JOIN interprete ON club.nombreint = interprete.nombreint
                             WHERE interprete.pais = 'Inglaterra'
                               AND numfans > 500)
ORDER BY nombreint


SELECT * FROM club
ORDER BY numfans DESC
LIMIT 1
OFFSET 9



-- tenemos que eliminar un registro que dice o l o
SELECT nombrec, titulo, duracion FROM cancion
INNER JOIN (
SELECT curpc, nombrec FROM (SELECT compositor.curpc, compositor.nombrec, COUNT(*) as num_canciones
FROM compositor
INNER JOIN cancion ON cancion.curpc = compositor.curpc
GROUP BY compositor.curpc, compositor.nombrec
ORDER BY num_canciones DESC
LIMIT 1)) maxi ON cancion.curpc = maxi.curpc


SELECT nombreint, COUNT(*) as num_integrantes FROM pertenece
GROUP BY pertenece.nombreint
HAVING COUNT(*) > 2
ORDER BY num_integrantes DESC


--agregar canciones a albumes para que aparezcan mas veces
--p===============================================================================================
--p===============================================================================================
--p===============================================================================================
SELECT cancion.cod, COUNT(*) as numero_de_apariciones FROM cancion
INNER JOIN esta ON cancion.cod = esta.codcan
GROUP BY cancion.cod
ORDER BY numero_de_apariciones DESC


SELECT funcion, COUNT(*) num_artistas FROM pertenece
GROUP BY funcion
ORDER BY num_artistas DESC



SELECT disco.numref, disco.album, COUNT(*) as num_canciones, MAX(cancion.duracion) duracion_mas_larga FROM disco
INNER JOIN esta ON disco.numref = esta.numref
INNER JOIN cancion ON cancion.cod = esta.codcan
GROUP BY disco.numref, disco.album








