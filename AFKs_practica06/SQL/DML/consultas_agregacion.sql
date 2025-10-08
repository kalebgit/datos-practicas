-- Tarea por AFKs

-- CONSULTA 1: Contar cuántos vuelos salen de cada ciudad
-- Tablas: vuelo
-- Columnas: ciudad_salida
-- Función de agregación: COUNT(*) - Cuenta el número total de vuelos por ciudad de origen
-- Agrupa los vuelos según la ciudad desde donde parten
SELECT ciudad_salida, COUNT(*) AS numero_vuelos FROM vuelo
GROUP BY ciudad_salida;

-- CONSULTA 2: Calcular la duración promedio de los vuelos por aerolínea
-- Tablas: vuelo, avion, aerolineas
-- Columnas: duracion, razon_social
-- Función de agregación: AVG() - Calcula el promedio de duración de vuelos
-- Se realiza JOIN entre vuelo->avion->aerolineas para asociar cada vuelo con su aerolínea
SELECT ar.aerolinea_id, ar.razon_social, AVG(v.duracion::interval)::time as duracion_promedio FROM vuelo v
INNER JOIN avion av ON v.matricula_avion = av.matricula_avion
INNER JOIN aerolineas ar ON av.aerolinea_id = ar.aerolinea_id
GROUP BY ar.aerolinea_id, ar.razon_social;

-- CONSULTA 3: Obtener el vuelo más largo y el más corto por ciudad de origen
-- Tablas: vuelo
-- Columnas: numero_vuelo, ciudad_salida, duracion
-- Funciones de agregación: MAX() y MIN() - Obtienen las duraciones máxima y mínima
-- Utiliza subconsultas para encontrar los vuelos con duración máxima y mínima por cada ciudad
-- La condición IN permite seleccionar ambos extremos (vuelo más largo y más corto)
SELECT vuelo.numero_vuelo, vuelo.ciudad_salida, vuelo.duracion FROM vuelo
WHERE (ciudad_salida, duracion) IN (SELECT ciudad_salida, max(duracion)
                                        FROM vuelo
                                        GROUP BY ciudad_salida
                                        )
OR (ciudad_salida, duracion) IN (SELECT ciudad_salida, min(duracion)
                                        FROM vuelo
                                        GROUP BY ciudad_salida
                                        )
ORDER BY ciudad_salida;


-- CONSULTA 4: Mostrar cuántos vuelos hay por mes
-- Tablas: vuelo
-- Columnas: fecha_salida
-- Función de agregación: COUNT(*) - Cuenta vuelos por mes
-- DATE_TRUNC agrupa las fechas por mes, permitiendo contar vuelos mensuales
SELECT DATE_TRUNC('month', fecha_salida) as mes, COUNT(*) cantidad_vuelos  FROM vuelo
GROUP BY mes
ORDER BY mes ASC;


-- CONSULTA 5: Listar aerolíneas con más de 10 vuelos registrados
-- Tablas: vuelo, avion, aerolineas
-- Columnas: razon_social
-- Función de agregación: COUNT(*) - Cuenta el número de vuelos por aerolínea
-- HAVING filtra solo aerolíneas con más de 10 vuelos
-- Identifica las aerolíneas más activas en el sistema
SELECT ar.aerolinea_id, ar.razon_social, COUNT(*) as numero_vuelos
FROM vuelo v
INNER JOIN avion av ON v.matricula_avion = av.matricula_avion
INNER JOIN aerolineas ar ON ar.aerolinea_id = av.aerolinea_id
GROUP BY ar.aerolinea_id, ar.razon_social
HAVING COUNT(*) > 10;


-- CONSULTA 6: Obtener el destino con mayor suma de duración total de vuelos
-- Tablas: vuelo
-- Columnas: ciudad_llegada, duracion
-- Función de agregación: SUM() - Suma todas las duraciones de vuelos hacia cada destino
-- Identifica qué ciudad acumula más tiempo de vuelo como destino
-- LIMIT 1 selecciona solo el destino con mayor duración acumulada
SELECT ciudad_llegada, SUM(duracion::interval)::time total_duracion FROM vuelo
GROUP BY ciudad_llegada
ORDER BY total_duracion DESC
LIMIT 1;

-- CONSULTA 7: Contar cuántos empleados hay registrados en cada aerolínea, desglosados por puesto
-- Tablas: aerolineas, contratar_aerolinea, controlador_de_vuelos, controlador_de_abordaje,
--         mecanico, sobrecargo, piloto
-- Columnas: razon_social, empleado_id
-- Función de agregación: COUNT(*) - Cuenta empleados por aerolínea y tipo
-- Usa LEFT JOIN para verificar qué tipo de empleado es cada uno
-- CASE clasifica el tipo de empleado según en qué tabla especializada aparezca
SELECT aerolineas.aerolinea_id, aerolineas.razon_social,
       CASE
           WHEN cv.empleado_id IS NOT NULL THEN 'Controlador de vuelos'
           WHEN ca.empleado_id IS NOT NULL THEN 'Controlador de abordaje'
           WHEN m.empleado_id IS NOT NULL THEN 'Mecanico'
           WHEN s.empleado_id IS NOT NULL THEN 'Sobrecargo'
           WHEN p.empleado_id IS NOT NULL THEN 'Piloto'
           ELSE 'Sin especializacion'
           END as Tipo_empleado,
        COUNT(*) as total_trabajdores
FROM aerolineas
INNER JOIN contratar_aerolinea ON aerolineas.aerolinea_id = contratar_aerolinea.aerolinea_id
LEFT JOIN controlador_de_vuelos cv ON cv.empleado_id = contratar_aerolinea.empleado_id
LEFT JOIN controlador_de_abordaje ca ON ca.empleado_id = contratar_aerolinea.empleado_id
LEFT JOIN mecanico m ON m.empleado_id = contratar_aerolinea.empleado_id
LEFT JOIN sobrecargo s ON s.empleado_id = contratar_aerolinea.empleado_id
LEFT JOIN piloto p ON p.empleado_id = contratar_aerolinea.empleado_id
GROUP BY aerolineas.aerolinea_id, aerolineas.razon_social, Tipo_empleado
ORDER BY aerolineas.aerolinea_id;





-- CONSULTA 8: Contar cuántos empleados trabajan en cada aeropuerto, desglosados por puesto
-- Tablas: aeropuerto, contratar_aeropuerto, controlador_de_vuelos, controlador_de_abordaje,
--         mecanico, sobrecargo, piloto
-- Columnas: nombre (aeropuerto), empleado_id
-- Función de agregación: COUNT(*) - Cuenta empleados por aeropuerto y tipo
-- Similar a consulta 7 pero para aeropuertos en lugar de aerolíneas
-- Permite ver la distribución de personal por instalación aeroportuaria
SELECT aeropuerto.aeropuerto_id, aeropuerto.nombre,
       CASE
           WHEN cv.empleado_id IS NOT NULL THEN 'Controlador de vuelos'
           WHEN ca.empleado_id IS NOT NULL THEN 'Controlador de abordaje'
           WHEN m.empleado_id IS NOT NULL THEN 'Mecanico'
           WHEN s.empleado_id IS NOT NULL THEN 'Sobrecargo'
           WHEN p.empleado_id IS NOT NULL THEN 'Piloto'
           ELSE 'Sin especializacion'
           END as Tipo_empleado,
       COUNT(*) as total_trabajdores
FROM aeropuerto
         INNER JOIN contratar_aeropuerto ON aeropuerto.aeropuerto_id = contratar_aeropuerto.aeropuerto_id
         LEFT JOIN controlador_de_vuelos cv ON cv.empleado_id = contratar_aeropuerto.empleado_id
         LEFT JOIN controlador_de_abordaje ca ON ca.empleado_id = contratar_aeropuerto.empleado_id
         LEFT JOIN mecanico m ON m.empleado_id = contratar_aeropuerto.empleado_id
         LEFT JOIN sobrecargo s ON s.empleado_id = contratar_aeropuerto.empleado_id
         LEFT JOIN piloto p ON p.empleado_id = contratar_aeropuerto.empleado_id
GROUP BY aeropuerto.aeropuerto_id, aeropuerto.nombre, Tipo_empleado
ORDER BY aeropuerto.aeropuerto_id;



-- CONSULTA 9: Obtener el costo promedio de boleto por cada vuelo
-- Tablas: boleto, vuelo
-- Columnas: numero_vuelo, precio, ciudad_salida, ciudad_llegada
-- Función de agregación: AVG() - Calcula el precio promedio de boletos por vuelo
-- ROUND redondea a 2 decimales para presentación monetaria
SELECT boleto.numero_vuelo, ciudad_salida, ciudad_llegada, ROUND(AVG(boleto.precio),2)
FROM boleto
         INNER JOIN vuelo v ON v.numero_vuelo = boleto.numero_vuelo
GROUP BY boleto.numero_vuelo, ciudad_salida, ciudad_llegada;


-- CONSULTA 10: Obtener el costo total generado por cada vuelo (suma de todos sus boletos vendidos)
-- Tablas: boleto, vuelo
-- Columnas: numero_vuelo, precio, ciudad_salida, ciudad_llegada
-- Función de agregación: SUM() - Suma todos los precios de boletos por vuelo
-- Permite analizar qué vuelos generan mayor ingreso total
SELECT boleto.numero_vuelo, ciudad_salida, ciudad_llegada, ROUND(SUM(boleto.precio),2)
FROM boleto
         INNER JOIN vuelo v ON v.numero_vuelo = boleto.numero_vuelo
GROUP BY boleto.numero_vuelo, ciudad_salida, ciudad_llegada;

-- CONSULTA 11: Calcular el número total de vuelos por cada aerolínea
-- Tablas: vuelo, avion, aerolineas
-- Columnas: razon_social
-- Función de agregación: COUNT(*) - Cuenta el total de vuelos operados por cada aerolínea
-- JOIN entre vuelo->avion->aerolineas conecta cada vuelo con su aerolínea operadora
SELECT ar.aerolinea_id, ar.razon_social, COUNT(*) total_vuelos
FROM vuelo v
INNER JOIN avion av ON av.matricula_avion = v.matricula_avion
INNER JOIN aerolineas ar ON ar.aerolinea_id = av.aerolinea_id
GROUP BY ar.aerolinea_id, ar.razon_social;

-- CONSULTA 12: Calcular el número de pilotos certificados agrupados por tipo de licencia
-- Tablas: piloto, certificacion_tipo_aeronave
-- Columnas: licencia
-- Función de agregación: COUNT(*) - Cuenta pilotos por tipo de licencia
-- JOIN con certificacion_tipo_aeronave asegura contar solo pilotos con certificaciones
SELECT piloto.licencia, COUNT(*) as total FROM piloto
INNER JOIN certificacion_tipo_aeronave cert ON cert.piloto_id = piloto.piloto_id
GROUP BY piloto.licencia;


-- CONSULTA 13: Obtener el costo promedio de boletos por aerolínea
-- Tablas: boleto, vuelo, avion, aerolineas
-- Columnas: razon_social, precio
-- Función de agregación: AVG() - Calcula el precio promedio de todos los boletos por aerolínea
-- Conecta boletos con aerolíneas a través de vuelo y avion
-- Permite comparar estrategias de precio entre aerolíneas
SELECT ar.aerolinea_id, ar.razon_social, ROUND(AVG(b.precio),2 ) AS precio_promedio
FROM boleto b
INNER JOIN vuelo v ON v.numero_vuelo = b.numero_vuelo
INNER JOIN avion av ON av.matricula_avion = v.matricula_avion
INNER JOIN aerolineas ar ON ar.aerolinea_id = av.aerolinea_id
GROUP BY ar.aerolinea_id, ar.razon_social;


-- CONSULTA 14: Mostrar el vuelo más caro y el vuelo más barato según el precio de boletos
-- Tablas: boleto, vuelo
-- Columnas: precio, numero_vuelo, ciudad_salida, ciudad_llegada
-- Funciones de agregación: MAX() y MIN() - Encuentran los precios extremos
-- Usa subconsultas para identificar el precio máximo y mínimo en todo el sistema
SELECT *
FROM boleto b
INNER JOIN vuelo v ON v.numero_vuelo = b.numero_vuelo
WHERE b.precio = (SELECT MAX(precio) FROM boleto) OR b.precio = (SELECT MIN(precio) FROM boleto);


-- CONSULTA 15: Contar el número de aviones registrados en cada aerolínea
-- Tablas: avion, aerolineas
-- Columnas: razon_social
-- Función de agregación: COUNT(*) - Cuenta la cantidad de aviones por aerolínea
-- Métrica simple pero importante para conocer el tamaño de cada flota
SELECT ar.aerolinea_id, ar.razon_social, COUNT(*) as aviones
FROM avion av
INNER JOIN aerolineas ar ON av.aerolinea_id = ar.aerolinea_id
GROUP BY ar.aerolinea_id, ar.razon_social;


-- CONSULTA 16: Calcular el número de vuelos que salen de cada aeropuerto, ordenando de mayor a menor
-- Tablas: vuelo, aeropuerto
-- Columnas: nombre (aeropuerto), aeropuerto_salida_id
-- Función de agregación: COUNT(*) - Cuenta vuelos de salida por aeropuerto
-- ORDER BY DESC muestra primero los aeropuertos más activos
SELECT ar.aeropuerto_id, ar.nombre, COUNT(*) vuelos_salida
FROM vuelo v
INNER JOIN aeropuerto ar ON v.aeropuerto_salida_id = ar.aeropuerto_id
GROUP BY ar.aeropuerto_id, ar.nombre
ORDER BY vuelos_salida DESC;

-- CONSULTA 17: Calcular la capacidad total de pasajeros por vuelo y mostrar sólo vuelos con capacidad > 50
-- Tablas: vuelo, avion
-- Columnas: numero_vuelo, ciudad_salida, ciudad_llegada, capacidad_pasajeros
-- JOIN con avion obtiene la capacidad del avión asignado a cada vuelo
-- WHERE filtra solo vuelos con capacidad mayor a 50 pasajeros
-- No requiere función de agregación ya que es una relación 1:1 entre vuelo y avión
SELECT numero_vuelo, ciudad_salida, ciudad_llegada, capacidad_pasajeros
FROM vuelo v
INNER JOIN avion av ON av.matricula_avion = v.matricula_avion
WHERE capacidad_pasajeros > 50
GROUP BY v.numero_vuelo, v.ciudad_salida, v.ciudad_llegada, av.capacidad_pasajeros;





-- CONSULTA 18: Identificar los vuelos con más del 50% de ocupación
-- Tablas: comprar, boleto, vuelo, avion
-- Columnas: numero_vuelo, ciudad_salida, ciudad_llegada, capacidad_pasajeros
-- Función de agregación: COUNT(*) - Cuenta boletos vendidos por vuelo
-- Compara boletos vendidos contra la mitad de la capacidad del avión
-- CASE evalúa si la ocupación supera el 50% para clasificar cada vuelo
-- Subconsulta externa filtra solo vuelos con ocupación mayor al 50%
SELECT * FROM (SELECT v.numero_vuelo, v.ciudad_salida, v.ciudad_llegada, COUNT(*) as boletos_vendidos,
       av.capacidad_pasajeros,
       CASE
           WHEN COUNT(*) > ROUND(av.capacidad_pasajeros)/2 THEN 'capacidad mas del 50%'
            ELSE 'capacidad menos del 50%'
        END AS capacidad_mitad
FROM comprar
INNER JOIN boleto b ON b.boleto_id = comprar.boleto_id
INNER JOIN vuelo v ON v.numero_vuelo = b.numero_vuelo
INNER JOIN avion av ON av.matricula_avion = v.matricula_avion
GROUP BY v.numero_vuelo, v.ciudad_salida, v.ciudad_llegada, av.capacidad_pasajeros
) boletos_vendidos_totales
WHERE capacidad_mitad = 'capacidad mas del 50%';


-- CONSULTA 19: Contar cuántos vuelos de pasajeros y cuántos vuelos de carga salen de cada aeropuerto
-- Tablas: vuelo, tipo_vuelo, aeropuerto
-- Columnas: nombre (aeropuerto), nombre (tipo_vuelo)
-- Función de agregación: COUNT(*) - Cuenta vuelos por aeropuerto y tipo
-- GROUP BY aeropuerto y tipo_vuelo clasifica los vuelos en categorías
-- Diferencia entre vuelos de pasajeros y de carga según tipo_vuelo
SELECT ar.aeropuerto_id, ar.nombre, tipo_vuelo.nombre,COUNT(*) numero_de_vuelos
FROM vuelo
INNER JOIN tipo_vuelo ON vuelo.tipo_vuelo_id = tipo_vuelo.tipo_vuelo_id
INNER JOIN aeropuerto ar ON vuelo.aeropuerto_salida_id = ar.aeropuerto_id
GROUP BY tipo_vuelo.nombre, ar.aeropuerto_id, ar.nombre
HAVING COUNT(*) > 10
ORDER BY aeropuerto_id;




-- CONSULTA 20: Calcular duración promedio y número de vuelos de carga por aerolínea (top 5)
-- Tablas: vuelo, avion, aerolineas
-- Columnas: razon_social, duracion, tipo_vuelo_id
-- Funciones de agregación: AVG() para duración promedio, COUNT(*) para total de vuelos
-- WHERE tipo_vuelo_id = 2 filtra solo vuelos de carga
-- LIMIT 5 muestra las 5 aerolíneas con mayor actividad de carga
-- ORDER BY DESC ordena por volumen de actividad
SELECT ar.aerolinea_id, ar.razon_social, AVG(v.duracion), COUNT(*) total_vuelos_carga
FROM vuelo v
INNER JOIN avion av ON v.matricula_avion = av.matricula_avion
INNER JOIN aerolineas ar ON av.aerolinea_id = ar.aerolinea_id
WHERE v.tipo_vuelo_id = 2
GROUP BY ar.aerolinea_id, ar.razon_social
ORDER BY total_vuelos_carga DESC
LIMIT 5;

-- ============================================
-- CONSULTAS PROPIAS (4) - ENFOCADAS EN AVIONES
-- ============================================

-- CONSULTA PROPIA 1: Capacidad total de pasajeros por aerolínea (filtrado > 500)
-- Tablas: avion, aerolineas
-- Columnas: razon_social, capacidad_pasajeros
-- Función de agregación: SUM() - Suma la capacidad de todos los aviones de cada aerolínea
-- HAVING filtra solo aerolíneas cuya capacidad total supere 500 pasajeros
-- Métrica importante para evaluar el tamaño y potencial operativo de cada aerolínea
-- Permite identificar las aerolíneas con mayor capacidad de transporte
SELECT ar.aerolinea_id, ar.razon_social, SUM(av.capacidad_pasajeros) total_pasajeros
FROM avion av
INNER JOIN aerolineas ar  ON av.aerolinea_id = ar.aerolinea_id
GROUP BY ar.aerolinea_id, ar.razon_social
HAVING SUM(av.capacidad_pasajeros) > 500;


-- CONSULTA PROPIA 2: aerolíneas con más de 5 modelos diferentes
-- Tablas: avion, aerolineas
-- Columnas: razon_social, modelo
-- Función de agregación: COUNT(DISTINCT) - Cuenta modelos únicos de avión por aerolínea
-- HAVING filtra aerolíneas con más de 5 modelos diferentes
-- Una flota diversificada indica flexibilidad operativa y adaptabilidad a diferentes rutas
SELECT ar.aerolinea_id, ar.razon_social, COUNT(DISTINCT av.modelo) modelos_adquiridos
FROM avion av
INNER JOIN aerolineas ar  ON av.aerolinea_id = ar.aerolinea_id
GROUP BY ar.aerolinea_id, ar.razon_social
HAVING count(distinct av.modelo) > 5;



-- CONSULTA PROPIA 3: Modelos de avión más rentables en vuelos de pasajeros
-- Tablas: avion, vuelo, boleto, comprar
-- Columnas: modelo, precio, numero_vuelo, capacidad_pasajeros
-- Funciones de agregación: SUM() para ingresos totales, COUNT() para vuelos y boletos, AVG() para capacidad
-- Calcula múltiples métricas de rentabilidad por modelo de avión:
--   - Total generado: suma de todos los precios de boletos vendidos
--   - Tasa de ocupación: porcentaje de asientos ocupados vs disponibles en todos los vuelos
--   - Vuelos realizados: número de vuelos completados con ese modelo
--   - Ingreso promedio por vuelo: ingreso total dividido entre número de vuelos
-- Solo considera boletos comprados (JOIN con tabla comprar)
-- ORDER BY total_generado DESC muestra los modelos más lucrativos primero
-- Esta consulta es clave para decisiones de inversión en aviones etc.
SELECT av.modelo,
       SUM(b.precio) as total_generado,
       CONCAT(
               ROUND(
                       (COUNT(b.boleto_id)::numeric
                            /( COUNT(DISTINCT v.numero_vuelo) *AVG(av.capacidad_pasajeros))) * 100, 2), '%') as tasa_ocupacion,
        --numero de vuelos realizados
            COUNT(DISTINCT b.numero_vuelo) as vuelos_realizados,
        --ingreso promedio por vuelo
            ROUND(SUM(b.precio)/COUNT(DISTINCT v.numero_vuelo), 2) as ingreso_promedio_por_vuelo
FROM avion av
INNER JOIN vuelo v ON v.matricula_avion = av.matricula_avion
INNER JOIN boleto b ON b.numero_vuelo = v.numero_vuelo
INNER JOIN comprar com ON com.boleto_id = b.boleto_id
GROUP BY av.modelo
ORDER BY total_generado DESC;



-- CONSULTA PROPIA 4: Modelos de avión con mayor actividad en vuelos internacionales
-- Tablas: vuelo, avion
-- Columnas: modelo, pais_salida, pais_llegada, duracion
-- Funciones de agregación: COUNT(*) para vuelos, COUNT(DISTINCT) para países, SUM() para duración
-- WHERE filtra solo vuelos internacionales (país_salida ≠ país_llegada)
-- Métricas calculadas:
--   - Vuelos realizados: total de vuelos internacionales por modelo
--   - Países visitados: número de países únicos a los que ha volado cada modelo
--   - Tiempo total volando: suma acumulada de duración de todos los vuelos internacionales
-- ORDER BY vuelos_realizados DESC muestra los modelos más utilizados en rutas internacionales
-- Útil para identificar qué modelos son preferidos para operaciones de largo alcance
SELECT av.modelo, COUNT(*) vuelos_realizados, COUNT(distinct pais_llegada) paises_diferentes_visitados,
       SUM(duracion)::interval tiempo_total_volando_intern
FROM vuelo v
INNER JOIN avion av ON v.matricula_avion = av.matricula_avion
WHERE v.pais_salida != v.pais_llegada
GROUP BY av.modelo
ORDER BY vuelos_realizados DESC;




