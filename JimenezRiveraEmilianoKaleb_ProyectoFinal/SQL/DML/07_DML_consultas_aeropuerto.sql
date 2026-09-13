
\echo ''
\echo '╔══════════════════════════════════════════════════════════════════════════════╗'
\echo '║              CONSULTAS                                                      ║'
\echo '╚══════════════════════════════════════════════════════════════════════════════╝'
\echo ''


-- ========================================
-- CONSULTA: ANÁLISIS DE OCUPACIÓN Y RENTABILIDAD POR AEROLÍNEA
-- ========================================

-- Esta consulta genera un análisis completo del rendimiento de cada aerolínea,
-- mostrando métricas clave como el número total de vuelos realizados, la flota
-- disponible, el porcentaje promedio de ocupación y los ingresos generados.
-- Utiliza las funciones personalizadas calcular_ocupacion_vuelo() y obtener_ingresos_vuelo()
-- para obtener datos precisos en tiempo real. Solo considera vuelos no cancelados
-- y agrupa los resultados ordenándolos por ingresos totales descendentes para
-- identificar las aerolíneas más rentables del sistema.

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Análisis de Ocupación y Rentabilidad por Aerolínea'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    a.razon_social AS "Aerolínea",
    COUNT(DISTINCT v.numero_vuelo) AS "Total Vuelos",
    COUNT(DISTINCT av.matricula_avion) AS "Flota",
    ROUND(AVG(calcular_ocupacion_vuelo(v.numero_vuelo)), 2) AS "Ocupación Promedio %",
    SUM(obtener_ingresos_vuelo(v.numero_vuelo))::MONEY AS "Ingresos Totales",
    ROUND(AVG(v.duracion_minutos), 0) AS "Duración Promedio (min)",
    ROUND(SUM(obtener_ingresos_vuelo(v.numero_vuelo)) /
          NULLIF(COUNT(DISTINCT v.numero_vuelo), 0), 2)::MONEY AS "Ingreso Promedio por Vuelo"
FROM aerolineas a
JOIN avion av ON a.aerolinea_id = av.aerolinea_id
JOIN vuelo v ON av.matricula_avion = v.matricula_avion
WHERE v.estado_vuelo != 'cancelado'
GROUP BY a.aerolinea_id, a.razon_social
HAVING COUNT(DISTINCT v.numero_vuelo) > 0
ORDER BY SUM(obtener_ingresos_vuelo(v.numero_vuelo)) DESC;

\echo ''


-- ========================================
-- CONSULTA: CLIENTES FRECUENTES CON MAYOR GASTO
-- ========================================

-- Esta consulta identifica a los clientes más valiosos del sistema, aquellos que han
-- gastado más de 1000 unidades monetarias en boletos. Combina información personal
-- del cliente (usando la función formatear_info_cliente y calcular_edad_cliente) con
-- métricas de compra como el número total de boletos adquiridos, el gasto total y promedio,
-- y los créditos disponibles. Adicionalmente, utiliza una subconsulta correlacionada para
-- contar cuántos de sus vuelos ya han sido completados (aterrizados). Los resultados se
-- limitan a los 10 clientes con mayor gasto total, ordenados descendentemente.

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Clientes Frecuentes con Mayor Gasto'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    c.cliente_id,
    formatear_info_cliente(c.cliente_id) AS "Información Cliente",
    calcular_edad_cliente(c.cliente_id) AS "Edad",
    COUNT(DISTINCT co.boleto_id) AS "Boletos Comprados",
    SUM(b.precio)::MONEY AS "Gasto Total",
    ROUND(AVG(b.precio), 2)::MONEY AS "Gasto Promedio por Boleto",
    calcular_creditos_disponibles(c.cliente_id)::MONEY AS "Créditos Disponibles",
    (
        SELECT COUNT(DISTINCT v.numero_vuelo)
        FROM vuelo v
        JOIN boleto b2 ON v.numero_vuelo = b2.numero_vuelo
        JOIN comprar co2 ON b2.boleto_id = co2.boleto_id
        WHERE co2.cliente_id = c.cliente_id
        AND v.estado_vuelo = 'aterrizado'
    ) AS "Vuelos Completados"
FROM cliente c
JOIN comprar co ON c.cliente_id = co.cliente_id
JOIN boleto b ON co.boleto_id = b.boleto_id
GROUP BY c.cliente_id
HAVING SUM(b.precio) > 1000
ORDER BY SUM(b.precio) DESC
LIMIT 10;

\echo ''












-- ========================================
-- CONSULTA: RUTAS MÁS RENTABLES
-- ========================================

-- Esta consulta analiza el rendimiento financiero de las diferentes rutas aéreas disponibles,
-- considerando pares origen-destino específicos. Para cada ruta muestra información detallada
-- de los aeropuertos involucrados, las ciudades y países, el número de vuelos realizados,
-- la duración promedio, el porcentaje de ocupación y los ingresos totales generados.
-- Utiliza una subconsulta correlacionada para contar los boletos vendidos en cada ruta.
-- Solo incluye rutas con al menos 2 vuelos realizados y las ordena por ingresos totales
-- descendentes, limitando el resultado a las 10 rutas más rentables del sistema.

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Rutas Más Rentables (Análisis Origen-Destino)'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    ao.nombre AS "Aeropuerto Origen",
    ad.nombre AS "Aeropuerto Destino",
    dir_o.ciudad || ', ' || dir_o.pais AS "Ciudad Origen",
    dir_d.ciudad || ', ' || dir_d.pais AS "Ciudad Destino",
    COUNT(v.numero_vuelo) AS "Vuelos Realizados",
    ROUND(AVG(v.duracion_minutos), 0) AS "Duración Promedio (min)",
    ROUND(AVG(calcular_ocupacion_vuelo(v.numero_vuelo)), 2) AS "Ocupación Promedio %",
    SUM(obtener_ingresos_vuelo(v.numero_vuelo))::MONEY AS "Ingresos Totales",
    (
        SELECT COUNT(DISTINCT b.boleto_id)
        FROM boleto b
        JOIN comprar c ON b.boleto_id = c.boleto_id
        WHERE b.numero_vuelo IN (
            SELECT numero_vuelo
            FROM vuelo
            WHERE aeropuerto_salida_id = ao.aeropuerto_id
            AND aeropuerto_llegada_id = ad.aeropuerto_id
        )
    ) AS "Boletos Vendidos"
FROM vuelo v
JOIN aeropuerto ao ON v.aeropuerto_salida_id = ao.aeropuerto_id
JOIN aeropuerto ad ON v.aeropuerto_llegada_id = ad.aeropuerto_id
JOIN direccion dir_o ON ao.direccion_id = dir_o.direccion_id
JOIN direccion dir_d ON ad.direccion_id = dir_d.direccion_id
WHERE v.estado_vuelo != 'cancelado'
GROUP BY ao.aeropuerto_id, ad.aeropuerto_id, ao.nombre, ad.nombre,
         dir_o.ciudad, dir_o.pais, dir_d.ciudad, dir_d.pais
HAVING COUNT(v.numero_vuelo) >= 2
ORDER BY SUM(obtener_ingresos_vuelo(v.numero_vuelo)) DESC
LIMIT 10;

\echo ''


-- ========================================
-- CONSULTA: ANÁLISIS DE PILOTOS Y SU RENDIMIENTO
-- ========================================

-- Esta consulta evalúa el desempeño y experiencia de los pilotos en el sistema.
-- Para cada piloto muestra información personal completa (nombre concatenado),
-- las horas totales de vuelo calculadas mediante la función calcular_horas_vuelo_piloto,
-- información de licencia y fecha de vencimiento, número de vuelos asignados,
-- cantidad de certificaciones obtenidas y los modelos de avión que ha operado.
-- Utiliza subconsultas correlacionadas para obtener las certificaciones y modelos,
-- y un CASE statement para clasificar a los pilotos en niveles según su experiencia
-- (Principiante, Junior, Experimentado, Senior). Los resultados se ordenan por
-- horas de vuelo descendentes y se limitan a los 10 pilotos más experimentados.

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Análisis de Pilotos y su Rendimiento'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    p.piloto_id,
    e.nombres || ' ' || e.apellido_paterno || ' ' || COALESCE(e.apellido_materno, '') AS "Piloto",
    calcular_horas_vuelo_piloto(p.piloto_id) AS "Horas de Vuelo",
    p.licencia AS "Licencia",
    p.fecha_vencimiento_licencia AS "Vencimiento Licencia",
    COUNT(DISTINCT pv.numero_vuelo) AS "Vuelos Asignados",
    (
        SELECT COUNT(DISTINCT cta.nombre)
        FROM certificacion_tipo_aeronave cta
        WHERE cta.piloto_id = p.piloto_id
    ) AS "Certificaciones",
    (
        SELECT STRING_AGG(DISTINCT av.modelo, ', ')
        FROM piloto_vuelo pv2
        JOIN vuelo v2 ON pv2.numero_vuelo = v2.numero_vuelo
        JOIN avion av ON v2.matricula_avion = av.matricula_avion
        WHERE pv2.piloto_id = p.piloto_id
    ) AS "Modelos Operados",
    CASE
        WHEN calcular_horas_vuelo_piloto(p.piloto_id) > 5000 THEN 'Senior'
        WHEN calcular_horas_vuelo_piloto(p.piloto_id) > 2000 THEN 'Experimentado'
        WHEN calcular_horas_vuelo_piloto(p.piloto_id) > 500 THEN 'Junior'
        ELSE 'Principiante'
    END AS "Nivel"
FROM piloto p
JOIN empleado e ON p.empleado_id = e.empleado_id
LEFT JOIN piloto_vuelo pv ON p.piloto_id = pv.piloto_id
GROUP BY p.piloto_id, e.nombres, e.apellido_paterno, e.apellido_materno,
         p.licencia, p.fecha_vencimiento_licencia
ORDER BY calcular_horas_vuelo_piloto(p.piloto_id) DESC
LIMIT 10;

\echo ''


-- ========================================
-- CONSULTA: VUELOS CON MAYOR DEMANDA
-- ========================================

-- Esta consulta identifica los vuelos con alta ocupación (mayor al 70%) que han tenido
-- lugar en los últimos 60 días. Para cada vuelo muestra información completa incluyendo
-- la aerolínea operadora, aeropuertos de origen y destino, fecha y hora de salida,
-- el modelo de avión utilizado, capacidad total, asientos disponibles (usando la función
-- obtener_asientos_disponibles), el porcentaje exacto de ocupación calculado en tiempo real,
-- los ingresos generados y el estado actual del vuelo. Los resultados se ordenan por
-- porcentaje de ocupación descendente y se limitan a 15 vuelos para identificar los
-- más demandados, lo cual es útil para análisis de rutas populares y planificación futura.

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Vuelos con Mayor Demanda (Ocupación > 70%)'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    v.numero_vuelo AS "Vuelo",
    a.razon_social AS "Aerolínea",
    ao.nombre AS "Origen",
    ad.nombre AS "Destino",
    v.fecha_salida AS "Fecha",
    v.hora_salida AS "Hora",
    av.modelo AS "Avión",
    av.capacidad_pasajeros AS "Capacidad",
    obtener_asientos_disponibles(v.numero_vuelo) AS "Asientos Disponibles",
    calcular_ocupacion_vuelo(v.numero_vuelo)::NUMERIC(5,2) AS "Ocupación %",
    obtener_ingresos_vuelo(v.numero_vuelo)::MONEY AS "Ingresos",
    v.estado_vuelo AS "Estado"
FROM vuelo v
JOIN avion av ON v.matricula_avion = av.matricula_avion
JOIN aerolineas a ON av.aerolinea_id = a.aerolinea_id
JOIN aeropuerto ao ON v.aeropuerto_salida_id = ao.aeropuerto_id
JOIN aeropuerto ad ON v.aeropuerto_llegada_id = ad.aeropuerto_id
WHERE calcular_ocupacion_vuelo(v.numero_vuelo) > 70
AND v.fecha_salida >= CURRENT_DATE - 60
ORDER BY calcular_ocupacion_vuelo(v.numero_vuelo) DESC
LIMIT 15;

\echo ''


-- ========================================
-- CONSULTA: ANÁLISIS DE CRÉDITOS Y COMPENSACIONES
-- ========================================

-- Esta consulta examina el sistema de créditos y compensaciones otorgados a los clientes.
-- Para cada cliente que tiene créditos registrados, muestra el número total de créditos,
-- el monto disponible (créditos no usados), el monto ya utilizado, y el total generado.
-- Utiliza CASE statements dentro de SUM para segregar los créditos según su estado de uso.
-- Además, emplea subconsultas correlacionadas para clasificar los créditos por origen,
-- distinguiendo entre aquellos generados por cancelación de vuelos y los otorgados como
-- compensación. Los resultados se ordenan por créditos disponibles descendentes y se
-- limitan a los 10 clientes con mayor saldo disponible, útil para identificar clientes
-- que podrían necesitar atención especial o incentivos para usar sus créditos.

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Análisis de Créditos y Compensaciones por Cliente'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    c.cliente_id,
    c.nombres || ' ' || c.apellido_paterno AS "Cliente",
    COUNT(DISTINCT cr.credito_id) AS "Créditos",
    SUM(CASE WHEN cr.usado = FALSE THEN cr.monto ELSE 0 END)::MONEY AS "Disponibles",
    SUM(CASE WHEN cr.usado = TRUE THEN cr.monto ELSE 0 END)::MONEY AS "Usados",
    SUM(cr.monto)::MONEY AS "Total Generado",
    (
        SELECT COUNT(*)
        FROM creditos cr2
        WHERE cr2.cliente_id = c.cliente_id
        AND cr2.origen = 'cancelacion_vuelo'
    ) AS "Por Cancelación",
    (
        SELECT COUNT(*)
        FROM creditos cr2
        WHERE cr2.cliente_id = c.cliente_id
        AND cr2.origen = 'compensacion'
    ) AS "Por Compensación",
    MAX(cr.fecha_emision) AS "Último Crédito"
FROM cliente c
JOIN creditos cr ON c.cliente_id = cr.cliente_id
GROUP BY c.cliente_id, c.nombres, c.apellido_paterno
HAVING COUNT(DISTINCT cr.credito_id) > 0
ORDER BY SUM(CASE WHEN cr.usado = FALSE THEN cr.monto ELSE 0 END) DESC
LIMIT 10;

\echo ''


-- ========================================
-- CONSULTA: EMPLEADOS MULTITAREA
-- ========================================

-- Esta consulta identifica empleados que desempeñan roles en múltiples organizaciones,
-- trabajando simultáneamente tanto en aerolíneas como en aeropuertos. Utiliza dos
-- subconsultas LEFT JOIN para obtener información agregada de cada tipo de empleo,
-- contando el número de aerolíneas y aeropuertos donde cada empleado está activo
-- (considerando solo contratos sin fecha de egreso). Usa STRING_AGG para concatenar
-- los nombres de las empresas y aeropuertos en listas separadas por comas. Solo incluye
-- empleados que tienen al menos un empleo activo en cada categoría (aerolíneas y aeropuertos).
-- Los resultados se ordenan por salario descendente para identificar a los empleados
-- multitarea mejor remunerados del sistema.

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Empleados que Trabajan en Aerolínea y Aeropuerto'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    e.empleado_id,
    e.nombres || ' ' || e.apellido_paterno AS "Empleado",
    e.salario::MONEY AS "Salario",
    COALESCE(aerolineas.cantidad, 0) AS "Aerolíneas",
    COALESCE(aeropuertos.cantidad, 0) AS "Aeropuertos",
    STRING_AGG(DISTINCT aerolineas.empresas, ', ') AS "Trabaja en Aerolíneas",
    STRING_AGG(DISTINCT aeropuertos.lugares, ', ') AS "Trabaja en Aeropuertos"
FROM empleado e
LEFT JOIN (
    SELECT
        ca.empleado_id,
        COUNT(DISTINCT ca.aerolinea_id) AS cantidad,
        STRING_AGG(DISTINCT a.razon_social, ', ') AS empresas
    FROM contratar_aerolinea ca
    JOIN aerolineas a ON ca.aerolinea_id = a.aerolinea_id
    WHERE ca.fecha_egreso IS NULL
    GROUP BY ca.empleado_id
) aerolineas ON e.empleado_id = aerolineas.empleado_id
LEFT JOIN (
    SELECT
        cap.empleado_id,
        COUNT(DISTINCT cap.aeropuerto_id) AS cantidad,
        STRING_AGG(DISTINCT ap.nombre, ', ') AS lugares
    FROM contratar_aeropuerto cap
    JOIN aeropuerto ap ON cap.aeropuerto_id = ap.aeropuerto_id
    WHERE cap.fecha_egreso IS NULL
    GROUP BY cap.empleado_id
) aeropuertos ON e.empleado_id = aeropuertos.empleado_id
WHERE aerolineas.cantidad > 0 AND aeropuertos.cantidad > 0 AND e.salario >= 0
GROUP BY e.empleado_id, e.nombres, e.apellido_paterno, e.salario,
         aerolineas.cantidad, aeropuertos.cantidad
ORDER BY e.salario DESC;

\echo ''


-- ========================================
-- CONSULTA: ANÁLISIS DE PRECIOS POR CLASE Y AEROLÍNEA
-- ========================================

-- Esta consulta analiza la estructura de precios de boletos segmentada por clase de servicio
-- y aerolínea. Para cada combinación aerolínea-clase muestra estadísticas detalladas incluyendo
-- el número de boletos vendidos, precio promedio, mínimo y máximo, e ingresos totales generados.
-- Utiliza una window function (OVER PARTITION BY) para calcular el porcentaje que representa
-- cada clase dentro del total de boletos vendidos por aerolínea. Solo considera boletos activos
-- o usados, excluyendo los cancelados. Los resultados se ordenan primero por aerolínea y luego
-- por clase (Primera, Ejecutiva, Económica) usando un CASE statement, permitiendo comparar
-- fácilmente las estrategias de pricing entre diferentes aerolíneas y clases de servicio.

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Análisis de Precios por Clase y Aerolínea'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    a.razon_social AS "Aerolínea",
    b.clase AS "Clase",
    COUNT(DISTINCT b.boleto_id) AS "Boletos Vendidos",
    ROUND(AVG(b.precio), 2)::MONEY AS "Precio Promedio",
    MIN(b.precio)::MONEY AS "Precio Mínimo",
    MAX(b.precio)::MONEY AS "Precio Máximo",
    SUM(b.precio)::MONEY AS "Ingresos por Clase",
    ROUND(100.0 * COUNT(b.boleto_id) / SUM(COUNT(b.boleto_id)) OVER (PARTITION BY a.aerolinea_id), 2) AS "% del Total"
FROM boleto b
JOIN vuelo v ON b.numero_vuelo = v.numero_vuelo
JOIN avion av ON v.matricula_avion = av.matricula_avion
JOIN aerolineas a ON av.aerolinea_id = a.aerolinea_id
JOIN comprar c ON b.boleto_id = c.boleto_id
WHERE b.estado_boleto = 'activo' OR b.estado_boleto = 'usado'
GROUP BY a.aerolinea_id, a.razon_social, b.clase
ORDER BY a.razon_social,
         CASE b.clase
             WHEN 'Primera' THEN 1
             WHEN 'Ejecutiva' THEN 2
             WHEN 'Economica' THEN 3
         END;

\echo ''


-- ========================================
-- CONSULTA: BOLETOS CON HISTORIAL DE CAMBIOS DE PRECIO
-- ========================================

-- Esta consulta analiza el historial de cambios de precio en los boletos del sistema.
-- Para cada boleto que ha experimentado al menos un cambio de precio, muestra información
-- detallada del vuelo y aerolínea, junto con métricas del historial de precios obtenidas
-- mediante subconsultas correlacionadas. Cuenta el número total de cambios, identifica el
-- precio inicial (mínimo histórico), el precio actual, calcula la diferencia monetaria
-- y muestra la fecha del último cambio registrado. Utiliza EXISTS para filtrar únicamente
-- boletos con historial de cambios registrados en la tabla historial_precios_boleto.
-- Los resultados se ordenan por número de cambios descendente y se limitan a 10 registros,
-- permitiendo identificar los boletos con mayor volatilidad de precios.

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Boletos con Historial de Cambios de Precio'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    b.boleto_id,
    b.numero_vuelo AS "Vuelo",
    a.razon_social AS "Aerolínea",
    b.numero_asiento AS "Asiento",
    b.clase AS "Clase",
    (
        SELECT COUNT(*)
        FROM historial_precios_boleto hpb
        WHERE hpb.boleto_id = b.boleto_id
    ) AS "Cambios",
    (
        SELECT MIN(hpb.precio_anterior)
        FROM historial_precios_boleto hpb
        WHERE hpb.boleto_id = b.boleto_id
    )::MONEY AS "Precio Inicial",
    b.precio::MONEY AS "Precio Actual",
    (
        b.precio - (
            SELECT MIN(hpb.precio_anterior)
            FROM historial_precios_boleto hpb
            WHERE hpb.boleto_id = b.boleto_id
        )
    )::MONEY AS "Diferencia",
    (
        SELECT MAX(hpb.fecha_cambio)
        FROM historial_precios_boleto hpb
        WHERE hpb.boleto_id = b.boleto_id
    ) AS "Último Cambio"
FROM boleto b
JOIN vuelo v ON b.numero_vuelo = v.numero_vuelo
JOIN avion av ON v.matricula_avion = av.matricula_avion
JOIN aerolineas a ON av.aerolinea_id = a.aerolinea_id
WHERE EXISTS (
    SELECT 1
    FROM historial_precios_boleto hpb
    WHERE hpb.boleto_id = b.boleto_id
)
ORDER BY (
    SELECT COUNT(*)
    FROM historial_precios_boleto hpb
    WHERE hpb.boleto_id = b.boleto_id
) DESC
LIMIT 10;

\echo ''


-- ========================================
-- CONSULTA: AEROPUERTOS CON MAYOR TRÁFICO
-- ========================================

-- Esta consulta identifica los aeropuertos más activos del sistema analizando tanto
-- vuelos de salida como de llegada. Utiliza dos CTEs (Common Table Expressions) para
-- calcular por separado el tráfico de salidas y llegadas, luego combina esta información
-- mediante LEFT JOINs para obtener el tráfico total de cada aeropuerto. Además, incluye
-- una subconsulta correlacionada que cuenta el número de empleados activos en cada aeropuerto
-- (aquellos sin fecha de egreso). Solo considera vuelos no cancelados para el cálculo.
-- Los resultados se ordenan por tráfico total descendente y se limitan a 10 aeropuertos,
-- mostrando también la ubicación completa (ciudad y país) para facilitar su identificación.

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Aeropuertos con Mayor Tráfico (Salidas + Llegadas)'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

WITH trafico_salidas AS (
    SELECT
        aeropuerto_salida_id AS aeropuerto_id,
        COUNT(*) AS vuelos
    FROM vuelo
    WHERE estado_vuelo != 'cancelado'
    GROUP BY aeropuerto_salida_id
),
trafico_llegadas AS (
    SELECT
        aeropuerto_llegada_id AS aeropuerto_id,
        COUNT(*) AS vuelos
    FROM vuelo
    WHERE estado_vuelo != 'cancelado'
    GROUP BY aeropuerto_llegada_id
)
SELECT
    ap.nombre AS "Aeropuerto",
    d.ciudad || ', ' || d.pais AS "Ubicación",
    COALESCE(ts.vuelos, 0) AS "Salidas",
    COALESCE(tl.vuelos, 0) AS "Llegadas",
    COALESCE(ts.vuelos, 0) + COALESCE(tl.vuelos, 0) AS "Tráfico Total",
    (
        SELECT COUNT(DISTINCT ca.empleado_id)
        FROM contratar_aeropuerto ca
        WHERE ca.aeropuerto_id = ap.aeropuerto_id
        AND ca.fecha_egreso IS NULL
    ) AS "Empleados Activos"
FROM aeropuerto ap
JOIN direccion d ON ap.direccion_id = d.direccion_id
LEFT JOIN trafico_salidas ts ON ap.aeropuerto_id = ts.aeropuerto_id
LEFT JOIN trafico_llegadas tl ON ap.aeropuerto_id = tl.aeropuerto_id
WHERE COALESCE(ts.vuelos, 0) + COALESCE(tl.vuelos, 0) > 0
ORDER BY COALESCE(ts.vuelos, 0) + COALESCE(tl.vuelos, 0) DESC
LIMIT 10;

\echo ''


-- ========================================
-- CONSULTA: ANÁLISIS DE ESTADOS DE VUELOS POR MES
-- ========================================

-- Esta consulta genera un reporte temporal agregado por año y mes, mostrando la distribución
-- de estados de vuelos en cada periodo. Utiliza la función EXTRACT para obtener el año y mes
-- de la fecha de salida, y múltiples CASE statements dentro de SUM para contar vuelos en cada
-- estado posible (programado, en vuelo, aterrizado, retrasado, cancelado). Calcula también
-- los porcentajes de cancelación y retraso respecto al total de vuelos del mes, métricas clave
-- para evaluar la confiabilidad operacional. Adicionalmente suma los ingresos totales generados
-- en cada periodo usando la función obtener_ingresos_vuelo. Los resultados se ordenan por año
-- y mes descendentes para mostrar primero los periodos más recientes, permitiendo identificar
-- tendencias y patrones estacionales en la operación.

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Análisis de Estados de Vuelos por Mes'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    EXTRACT(YEAR FROM v.fecha_salida) AS "Año",
    EXTRACT(MONTH FROM v.fecha_salida) AS "Mes",
    COUNT(*) AS "Total Vuelos",
    SUM(CASE WHEN v.estado_vuelo = 'programado' THEN 1 ELSE 0 END) AS "Programados",
    SUM(CASE WHEN v.estado_vuelo = 'en_vuelo' THEN 1 ELSE 0 END) AS "En Vuelo",
    SUM(CASE WHEN v.estado_vuelo = 'aterrizado' THEN 1 ELSE 0 END) AS "Aterrizados",
    SUM(CASE WHEN v.estado_vuelo = 'retrasado' THEN 1 ELSE 0 END) AS "Retrasados",
    SUM(CASE WHEN v.estado_vuelo = 'cancelado' THEN 1 ELSE 0 END) AS "Cancelados",
    ROUND(100.0 * SUM(CASE WHEN v.estado_vuelo = 'cancelado' THEN 1 ELSE 0 END) / COUNT(*), 2) AS "% Cancelación",
    ROUND(100.0 * SUM(CASE WHEN v.estado_vuelo = 'retrasado' THEN 1 ELSE 0 END) / COUNT(*), 2) AS "% Retraso",
    SUM(obtener_ingresos_vuelo(v.numero_vuelo))::MONEY AS "Ingresos Totales"
FROM vuelo v
GROUP BY EXTRACT(YEAR FROM v.fecha_salida), EXTRACT(MONTH FROM v.fecha_salida)
ORDER BY "Año" DESC, "Mes" DESC;

\echo ''


-- ========================================
-- CONSULTA: AVIONES MÁS UTILIZADOS Y ESTADO DE MANTENIMIENTO
-- ========================================

-- Esta consulta analiza el uso y estado de mantenimiento de la flota de aviones.
-- Para cada avión que ha realizado al menos un vuelo, muestra información detallada
-- incluyendo matrícula, modelo, aerolínea propietaria, capacidad y estadísticas de uso
-- (número de vuelos, minutos y horas totales acumuladas). Calcula también los ingresos
-- totales generados por cada avión. La parte crítica es la evaluación del estado de
-- mantenimiento mediante un CASE statement que clasifica cada avión como 'Sin Registro',
-- 'Urgente' (más de 180 días), 'Necesario' (más de 90 días) u 'OK', basándose en la
-- fecha del último mantenimiento. Los resultados se ordenan por número de vuelos realizados
-- descendentemente y se limitan a 10 aviones, identificando aquellos más utilizados que
-- podrían requerir atención prioritaria de mantenimiento.

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Aviones Más Utilizados y Estado de Mantenimiento'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    av.matricula_avion AS "Matrícula",
    av.modelo AS "Modelo",
    a.razon_social AS "Aerolínea",
    av.capacidad_pasajeros AS "Capacidad",
    COUNT(DISTINCT v.numero_vuelo) AS "Vuelos Realizados",
    SUM(v.duracion_minutos) AS "Minutos Totales",
    ROUND(SUM(v.duracion_minutos) / 60.0, 2) AS "Horas Totales",
    SUM(obtener_ingresos_vuelo(v.numero_vuelo))::MONEY AS "Ingresos Generados",
    av.fecha_ultimo_mantenimiento AS "Último Mantenimiento",
    CASE
        WHEN av.fecha_ultimo_mantenimiento IS NULL THEN 'Sin Registro'
        WHEN av.fecha_ultimo_mantenimiento < CURRENT_DATE - 180 THEN 'Urgente'
        WHEN av.fecha_ultimo_mantenimiento < CURRENT_DATE - 90 THEN 'Necesario'
        ELSE 'OK'
    END AS "Estado Mantenimiento",
    CURRENT_DATE - av.fecha_ultimo_mantenimiento AS "Días desde Último"
FROM avion av
JOIN aerolineas a ON av.aerolinea_id = a.aerolinea_id
LEFT JOIN vuelo v ON av.matricula_avion = v.matricula_avion
WHERE v.numero_vuelo IS NOT NULL
GROUP BY av.matricula_avion, av.modelo, a.razon_social, av.capacidad_pasajeros,
         av.fecha_ultimo_mantenimiento
HAVING COUNT(DISTINCT v.numero_vuelo) > 0
ORDER BY COUNT(DISTINCT v.numero_vuelo) DESC
LIMIT 10;

\echo ''


-- ========================================
-- CONSULTA: CLIENTES SIN ACTIVIDAD RECIENTE
-- ========================================

-- Esta consulta identifica clientes en riesgo de abandono al detectar aquellos que,
-- habiendo realizado compras en el pasado, no han tenido actividad en los últimos 60 días.
-- Utiliza EXISTS para verificar que el cliente tiene historial de compras, y NOT EXISTS
-- para confirmar la ausencia de compras recientes. Para cada cliente identificado, muestra
-- información personal formateada, edad calculada, número total de compras históricas,
-- fecha de la última compra, días transcurridos desde entonces, créditos disponibles y
-- el gasto total histórico acumulado. Todas estas métricas se obtienen mediante subconsultas
-- correlacionadas. Los resultados se ordenan por fecha de última compra descendente y se
-- limitan a 10 clientes, permitiendo priorizar esfuerzos de reactivación en clientes
-- valiosos que han dejado de comprar recientemente.

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Clientes sin Actividad en los Últimos 60 Días'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    c.cliente_id,
    formatear_info_cliente(c.cliente_id) AS "Cliente",
    calcular_edad_cliente(c.cliente_id) AS "Edad",
    (
        SELECT COUNT(*)
        FROM comprar co
        WHERE co.cliente_id = c.cliente_id
    ) AS "Total Compras Históricas",
    (
        SELECT MAX(co.fecha_compra)
        FROM comprar co
        WHERE co.cliente_id = c.cliente_id
    ) AS "Última Compra",
    CURRENT_DATE - (
        SELECT MAX(co.fecha_compra)
        FROM comprar co
        WHERE co.cliente_id = c.cliente_id
    ) AS "Días Inactivo",
    calcular_creditos_disponibles(c.cliente_id)::MONEY AS "Créditos Disponibles",
    (
        SELECT SUM(b.precio)
        FROM comprar co
        JOIN boleto b ON co.boleto_id = b.boleto_id
        WHERE co.cliente_id = c.cliente_id
    )::MONEY AS "Gasto Total Histórico"
FROM cliente c
WHERE EXISTS (
    SELECT 1
    FROM comprar co
    WHERE co.cliente_id = c.cliente_id
)
AND NOT EXISTS (
    SELECT 1
    FROM comprar co
    WHERE co.cliente_id = c.cliente_id
    AND co.fecha_compra > CURRENT_DATE - 60
)
ORDER BY (
    SELECT MAX(co.fecha_compra)
    FROM comprar co
    WHERE co.cliente_id = c.cliente_id
) DESC
LIMIT 10;

\echo ''


-- ========================================
-- CONSULTA: RENDIMIENTO DE VUELOS POR TIPO
-- ========================================

-- Esta consulta analiza el desempeño de los diferentes tipos de vuelo definidos en el sistema
-- (nacional, internacional, regional, carga, etc.). Para cada tipo de vuelo muestra su nombre
-- y descripción, junto con métricas operacionales y financieras agregadas: número total de vuelos,
-- duración promedio, porcentaje de ocupación promedio (usando calcular_ocupacion_vuelo), ingresos
-- totales y promedio por vuelo. Además, utiliza CASE statements para segregar los vuelos por estado,
-- contando cuántos han sido cancelados, retrasados y completados exitosamente. Calcula también
-- el porcentaje de éxito (vuelos aterrizados sobre total). Los resultados se ordenan por ingresos
-- totales descendentes, permitiendo identificar qué tipos de vuelo son más rentables y tienen
-- mejor desempeño operacional, información valiosa para la planificación estratégica.

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Análisis de Rendimiento por Tipo de Vuelo'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    tv.nombre AS "Tipo de Vuelo",
    tv.descripcion AS "Descripción",
    COUNT(DISTINCT v.numero_vuelo) AS "Vuelos",
    ROUND(AVG(v.duracion_minutos), 0) AS "Duración Promedio (min)",
    ROUND(AVG(calcular_ocupacion_vuelo(v.numero_vuelo)), 2) AS "Ocupación Promedio %",
    SUM(obtener_ingresos_vuelo(v.numero_vuelo))::MONEY AS "Ingresos Totales",
    ROUND(AVG(obtener_ingresos_vuelo(v.numero_vuelo)), 2)::MONEY AS "Ingreso Promedio",
    SUM(CASE WHEN v.estado_vuelo = 'cancelado' THEN 1 ELSE 0 END) AS "Cancelados",
    SUM(CASE WHEN v.estado_vuelo = 'retrasado' THEN 1 ELSE 0 END) AS "Retrasados",
    SUM(CASE WHEN v.estado_vuelo = 'aterrizado' THEN 1 ELSE 0 END) AS "Completados",
    ROUND(100.0 * SUM(CASE WHEN v.estado_vuelo = 'aterrizado' THEN 1 ELSE 0 END) / COUNT(*), 2) AS "% Éxito"
FROM tipo_vuelo tv
JOIN vuelo v ON tv.tipo_vuelo_id = v.tipo_vuelo_id
GROUP BY tv.tipo_vuelo_id, tv.nombre, tv.descripcion
ORDER BY SUM(obtener_ingresos_vuelo(v.numero_vuelo)) DESC;

\echo ''


-- ========================================
-- CONSULTA: DESTINOS NACIONALES VS INTERNACIONALES
-- ========================================

-- Esta consulta compara el rendimiento de rutas nacionales versus internacionales,
-- clasificándolas automáticamente mediante un CASE statement que compara el país de origen
-- con el país de destino. Para cada ruta muestra información completa de ubicaciones (aeropuertos,
-- ciudades y países involucrados), métricas operacionales (número de vuelos, duración promedio,
-- ocupación), ingresos totales y el número de pasajeros transportados (obtenido mediante una
-- subconsulta que cuenta boletos vendidos en esa ruta específica). Solo incluye rutas con al menos
-- un vuelo realizado y excluye vuelos cancelados. Los resultados se ordenan primero por tipo
-- (Nacional/Internacional) y luego por ingresos descendentes dentro de cada categoría, limitándose
-- a 15 rutas para identificar las más importantes en cada segmento, información crucial para
-- estrategias de expansión y optimización de rutas.


-- solo es para dar contraste a estos tipos de vuelos


\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'Análisis de Destinos Nacionales vs Internacionales'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    CASE
        WHEN dir_o.pais = dir_d.pais THEN 'Nacional'
        ELSE 'Internacional'
    END AS "Tipo",
    ao.nombre AS "Origen",
    ad.nombre AS "Destino",
    dir_o.ciudad || ', ' || dir_o.pais AS "Desde",
    dir_d.ciudad || ', ' || dir_d.pais AS "Hacia",
    COUNT(v.numero_vuelo) AS "Vuelos",
    ROUND(AVG(v.duracion_minutos), 0) AS "Duración Promedio (min)",
    ROUND(AVG(calcular_ocupacion_vuelo(v.numero_vuelo)), 2) AS "Ocupación %",
    SUM(obtener_ingresos_vuelo(v.numero_vuelo))::MONEY AS "Ingresos",
    (
        SELECT COUNT(DISTINCT b.boleto_id)
        FROM boleto b
        WHERE b.numero_vuelo IN (
            SELECT numero_vuelo
            FROM vuelo
            WHERE aeropuerto_salida_id = ao.aeropuerto_id
            AND aeropuerto_llegada_id = ad.aeropuerto_id
        )
    ) AS "Pasajeros Totales"
FROM vuelo v
JOIN aeropuerto ao ON v.aeropuerto_salida_id = ao.aeropuerto_id
JOIN aeropuerto ad ON v.aeropuerto_llegada_id = ad.aeropuerto_id
JOIN direccion dir_o ON ao.direccion_id = dir_o.direccion_id
JOIN direccion dir_d ON ad.direccion_id = dir_d.direccion_id
WHERE v.estado_vuelo != 'cancelado'
GROUP BY ao.aeropuerto_id, ad.aeropuerto_id, ao.nombre, ad.nombre,
         dir_o.ciudad, dir_o.pais, dir_d.ciudad, dir_d.pais
HAVING COUNT(v.numero_vuelo) > 0
ORDER BY
    CASE
        WHEN dir_o.pais = dir_d.pais THEN 'Nacional'
        ELSE 'Internacional'
    END,
    SUM(obtener_ingresos_vuelo(v.numero_vuelo)) DESC
LIMIT 15;