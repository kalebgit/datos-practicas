-- ============================================================================
-- CONSULTA 1: Dashboard de Ocupación y Rentabilidad por Aerolínea
-- ============================================================================
--
-- Descripción: Genera un reporte completo para cada aerolínea mostrando
--              métricas operacionales y financieras clave de los últimos 30 días
-- Funciones usadas: calcular_ocupacion_vuelo, obtener_ingresos_vuelo, 
--                   calcular_duracion_promedio_aerolinea
-- Complejidad: Combina JOINs, agregaciones, funciones en SELECT/HAVING, 
--              filtros temporales
--

SELECT 
    ae.razon_social as aerolinea,
    COUNT(DISTINCT v.numero_vuelo) as total_vuelos,
    ROUND(AVG(calcular_ocupacion_vuelo(v.numero_vuelo)), 2) 
        as ocupacion_promedio_pct,
    SUM(obtener_ingresos_vuelo(v.numero_vuelo)) 
        as ingresos_totales,
    ROUND(SUM(obtener_ingresos_vuelo(v.numero_vuelo))::NUMERIC / 
        NULLIF(COUNT(DISTINCT v.numero_vuelo), 0), 2)
        as ingreso_promedio_por_vuelo,
    calcular_duracion_promedio_aerolinea(ae.aerolinea_id) 
        as duracion_promedio_horas
FROM aerolineas ae
INNER JOIN avion av ON ae.aerolinea_id = av.aerolinea_id
INNER JOIN vuelo v ON av.matricula_avion = v.matricula_avion
WHERE v.fecha_salida >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY ae.aerolinea_id, ae.razon_social
HAVING AVG(calcular_ocupacion_vuelo(v.numero_vuelo)) > 50
ORDER BY ingresos_totales DESC;

--
-- Esta consulta demuestra cómo las funciones permiten agregaciones
-- complejas. Filtra aerolíneas con ocupación superior al 50% y ordena por
-- rentabilidad. Ideal para reportes gerenciales de desempeño.
--



-- ============================================================================
-- CONSULTA 2: Ranking de Vuelos Más Rentables
-- ============================================================================
--
-- Descripción: Identifica los vuelos más exitosos usando un factor compuesto
--              que considera ocupación, ingresos y eficiencia
-- Funciones usadas: calcular_ocupacion_vuelo, obtener_ingresos_vuelo
-- Complejidad: Métricas derivadas, normalización, clasificación multinivel,
--              filtros de estado, TOP N
--

SELECT 
    v.numero_vuelo,
    v.ciudad_salida || ' -> ' || v.ciudad_llegada as ruta,
    TO_CHAR(v.fecha_salida, 'DD/MM/YYYY') as fecha,
    ROUND(calcular_ocupacion_vuelo(v.numero_vuelo), 1) as ocupacion_pct,
    obtener_ingresos_vuelo(v.numero_vuelo) as ingresos,
    av.capacidad_pasajeros as capacidad,
    -- Ingreso por asiento disponible (métrica de eficiencia)
    ROUND(obtener_ingresos_vuelo(v.numero_vuelo) / 
        NULLIF(av.capacidad_pasajeros, 0), 2) as ingreso_por_asiento,
    -- Factor de éxito ponderado (ocupación * ingresos normalizados)
    ROUND(
        (calcular_ocupacion_vuelo(v.numero_vuelo) / 100.0) *
        (obtener_ingresos_vuelo(v.numero_vuelo) / 10000.0), 2
    ) as factor_exito,
    CASE
        WHEN calcular_ocupacion_vuelo(v.numero_vuelo) >= 90 
        THEN '★★★ Excelente'
        WHEN calcular_ocupacion_vuelo(v.numero_vuelo) >= 70 
        THEN '★★ Bueno'
        WHEN calcular_ocupacion_vuelo(v.numero_vuelo) >= 50 
        THEN '★ Regular'
        ELSE '☹ Bajo'
    END as clasificacion
FROM vuelo v
INNER JOIN avion av ON v.matricula_avion = av.matricula_avion
WHERE v.estado_vuelo IN ('aterrizado', 'en_vuelo')
AND v.fecha_salida >= CURRENT_DATE - INTERVAL '7 days'
ORDER BY factor_exito DESC
LIMIT 20;

--
-- El factor de éxito combina ocupación e ingresos con una ponderación apropiada.
--


-- ============================================================================
-- CONSULTA 3: Análisis Demográfico de Pasajeros por Rut
-- ============================================================================
--
-- Descripción: Segmenta pasajeros por grupos de edad para cada ruta,
--              identificando el perfil que sobresale o resalta
-- Funciones usadas: calcular_edad_cliente
-- Complejidad: COUNT con FILTER, múltiples segmentaciones, agregaciones sobre
--              funciones, clasificación automática de rutas
--

SELECT 
    v.ciudad_salida || ' - ' || v.ciudad_llegada as ruta,
    COUNT(DISTINCT c.cliente_id) as total_pasajeros,
    ROUND(AVG(calcular_edad_cliente(c.cliente_id)), 1) 
        as edad_promedio,
    COUNT(*) FILTER (WHERE calcular_edad_cliente(c.cliente_id) < 18) 
        as menores,
    COUNT(*) FILTER (WHERE calcular_edad_cliente(c.cliente_id) 
                           BETWEEN 18 AND 30) 
        as jovenes_18_30,
    COUNT(*) FILTER (WHERE calcular_edad_cliente(c.cliente_id) 
                           BETWEEN 31 AND 50) 
        as adultos_31_50,
    COUNT(*) FILTER (WHERE calcular_edad_cliente(c.cliente_id) 
                           BETWEEN 51 AND 65) 
        as adultos_mayores_51_65,
    COUNT(*) FILTER (WHERE calcular_edad_cliente(c.cliente_id) > 65) 
        as tercera_edad_65plus,
    CASE 
        WHEN AVG(calcular_edad_cliente(c.cliente_id)) < 25 
            THEN 'Ruta Juvenil'
        WHEN AVG(calcular_edad_cliente(c.cliente_id)) < 45 
            THEN 'Ruta Profesional'
        WHEN AVG(calcular_edad_cliente(c.cliente_id)) < 60 
            THEN 'Ruta Madura'
        ELSE 'Ruta Senior'
    END as perfil_ruta
FROM vuelo v
INNER JOIN boleto b ON v.numero_vuelo = b.numero_vuelo
INNER JOIN comprar co ON b.boleto_id = co.boleto_id
INNER JOIN cliente c ON co.cliente_id = c.cliente_id
WHERE v.fecha_salida >= CURRENT_DATE - INTERVAL '90 days'
GROUP BY v.ciudad_salida, v.ciudad_llegada
HAVING COUNT(DISTINCT c.cliente_id) >= 20
ORDER BY total_pasajeros DESC;



-- ============================================================================
-- CONSULTA 4: Predicción de Ocupación y Oportunidades de Overbooking
-- ============================================================================
--
-- Descripción: Analiza vuelos próximos para predecir ocupación final e
--              identificar oportunidades de overbooking o necesidad de promociones
-- Funciones usadas: calcular_ocupacion_vuelo, obtener_ingresos_vuelo

WITH analisis_vuelos AS (
    SELECT
        v.numero_vuelo,
        v.ciudad_salida,
        v.ciudad_llegada,
        v.fecha_salida,
        v.hora_salida,
        av.capacidad_pasajeros as capacidad,
        calcular_ocupacion_vuelo(v.numero_vuelo) as ocupacion_actual,
        obtener_ingresos_vuelo(v.numero_vuelo) as ingresos_actuales,
        -- CORRECCIÓN: Convertir explícitamente a INTEGER
        (v.fecha_salida - CURRENT_DATE)::INTEGER as dias_hasta_vuelo,
        v.estado_vuelo
    FROM vuelo v
    INNER JOIN avion av ON v.matricula_avion = av.matricula_avion
    WHERE v.fecha_salida BETWEEN CURRENT_DATE
                         AND CURRENT_DATE + INTERVAL '30 days'
    AND v.estado_vuelo = 'programado'
)
SELECT
    numero_vuelo,
    ciudad_salida || ' → ' || ciudad_llegada as ruta,
    TO_CHAR(fecha_salida, 'DD/MM/YYYY') as fecha,
    TO_CHAR(hora_salida, 'HH24:MI') as hora,
    ROUND(ocupacion_actual, 1) as ocupacion_actual_pct,
    ROUND(capacidad - (capacidad * ocupacion_actual / 100), 0)
        as asientos_disponibles,
    ingresos_actuales,
    dias_hasta_vuelo,
    -- Predicción simple: extrapola tasa actual de reservas
    ROUND(
        ocupacion_actual +
        (ocupacion_actual / NULLIF(dias_hasta_vuelo, 0)) *
        LEAST(dias_hasta_vuelo, 7),
        1
    ) as ocupacion_proyectada_pct,
    CASE
        WHEN ocupacion_actual >= 95 THEN
            'CRÍTICO: Considerar overbooking controlado (+5%)'
        WHEN ocupacion_actual >= 80 AND dias_hasta_vuelo > 7 THEN
            'ALTO: Vuelo en camino a llenarse normalmente'
        WHEN ocupacion_actual < 40 AND dias_hasta_vuelo < 7 THEN
            'URGENTE: Lanzar promoción agresiva inmediata'
        WHEN ocupacion_actual < 60 AND dias_hasta_vuelo < 14 THEN
            'MEDIO: Activar campañas de marketing'
        ELSE 'NORMAL: Ritmo de reservas esperado'
    END as recomendacion,
    CASE
        WHEN ocupacion_actual >= 95 THEN 'CRÍTICO'
        WHEN ocupacion_actual >= 70 THEN 'ATENCIÓN'
        ELSE 'NORMAL'
    END as semaforo
FROM analisis_vuelos
ORDER BY
    CASE
        WHEN ocupacion_actual >= 95 THEN 1
        WHEN ocupacion_actual < 40 AND dias_hasta_vuelo < 7 THEN 2
        ELSE 3
    END,
    fecha_salida;
--
-- Análisis: prediciendo ocupación final
-- basándose en la tendencia actual. El sistema de semáforos y recomendaciones
-- permite tomar acciones. El ORDER BY personalizado prioriza situaciones
-- críticas que requieren atención urgenteeee
--

-- ============================================================================
-- JFDAFDAS
-- CONSULTA 5: Análisis de Tendencias de Ocupación Semanal
-- ============================================================================
--
-- Descripción: Analiza patrones de ocupación por día de la semana para
--              optimizar programación de vuelos
-- Funciones usadas: calcular_ocupacion_vuelo, obtener_ingresos_vuelo
-- Complejidad: Extracción de partes de fecha, agregaciones temporales,
--              pivoteo de datos
--

SELECT 
    TO_CHAR(v.fecha_salida, 'Day') as dia_semana,
    EXTRACT(DOW FROM v.fecha_salida) as num_dia,  -- 0=domingo, 6=sábado
    COUNT(v.numero_vuelo) as total_vuelos,
    ROUND(AVG(calcular_ocupacion_vuelo(v.numero_vuelo)), 2) 
        as ocupacion_promedio_pct,
    ROUND(MIN(calcular_ocupacion_vuelo(v.numero_vuelo)), 2) 
        as ocupacion_minima_pct,
    ROUND(MAX(calcular_ocupacion_vuelo(v.numero_vuelo)), 2) 
        as ocupacion_maxima_pct,
    SUM(obtener_ingresos_vuelo(v.numero_vuelo)) as ingresos_totales,
    ROUND(AVG(obtener_ingresos_vuelo(v.numero_vuelo)), 2) 
        as ingreso_promedio_por_vuelo,
    CASE 
        WHEN EXTRACT(DOW FROM v.fecha_salida) IN (0, 6) 
            THEN 'Fin de semana'
        ELSE 'Entre semana'
    END as tipo_dia
FROM vuelo v
WHERE v.fecha_salida >= CURRENT_DATE - INTERVAL '60 days'
AND v.fecha_salida < CURRENT_DATE
GROUP BY EXTRACT(DOW FROM v.fecha_salida), TO_CHAR(v.fecha_salida, 'Day')
ORDER BY num_dia;

--
-- Análisis: Identifica patrones semanales de demanda. Típicamente, viernes
-- y domingos tienen mayor ocupación en rutas de negocios, mientras que
-- sábados lideran en rutas turísticas. Usamos estos casos que 
-- intuitivamente son comunes en las aerolineas o a puro ojo fjdkasl
--


--
-- ============================================================================
-- JFDAFDAS
-- CONSULTA 8: Identificación de Clientes Frecuentes y VIP
-- ============================================================================
--
-- Descripción: Clasifica clientes según su frecuencia de viaje y gasto total
--              para programas de lealtad
-- Funciones usadas: formatear_info_cliente, calcular_edad_cliente
-- Complejidad: Agregaciones por cliente, clasificación multi-nivel,
--              segmentación por valor
--

SELECT 
    c.cliente_id,
    formatear_info_cliente(c.cliente_id) as cliente_info,
    calcular_edad_cliente(c.cliente_id) as edad,
    COUNT(DISTINCT b.numero_vuelo) as total_vuelos,
    COUNT(DISTINCT co.boleto_id) as total_boletos,
    SUM(b.precio) as gasto_total,
    ROUND(AVG(b.precio), 2) as gasto_promedio_por_boleto,
    MAX(co.fecha_compra) as ultima_compra,
    CURRENT_DATE - MAX(co.fecha_compra) as dias_desde_ultima_compra,
    -- Clasificación de cliente
    CASE 
        WHEN COUNT(DISTINCT b.numero_vuelo) >= 20 
            THEN '💎 Diamante'
        WHEN COUNT(DISTINCT b.numero_vuelo) >= 10 
            THEN '🥇 Oro'
        WHEN COUNT(DISTINCT b.numero_vuelo) >= 5 
            THEN '🥈 Plata'
        WHEN COUNT(DISTINCT b.numero_vuelo) >= 2 
            THEN '🥉 Bronce'
        ELSE '⭐ Regular'
    END as categoria_lealtad,
    -- Segmentación por valor
    CASE
        WHEN SUM(b.precio) >= 100000 THEN 'VIP - Alto valor'
        WHEN SUM(b.precio) >= 50000 THEN 'Premium'
        WHEN SUM(b.precio) >= 20000 THEN 'Estándar'
        ELSE 'Ocasional'
    END as segmento_valor,
    -- Estado de actividad
    CASE
        WHEN CURRENT_DATE - MAX(co.fecha_compra) > 180 
            THEN 'Inactivo - Reactivar'
        WHEN CURRENT_DATE - MAX(co.fecha_compra) > 90 
            THEN 'En riesgo - Contactar'
        ELSE 'Activo'
    END as estado_actividad
FROM cliente c
INNER JOIN comprar co ON c.cliente_id = co.cliente_id
INNER JOIN boleto b ON co.boleto_id = b.boleto_id
GROUP BY c.cliente_id
HAVING COUNT(DISTINCT b.numero_vuelo) >= 2  -- Mínimo 2 vuelos
ORDER BY gasto_total DESC, total_vuelos DESC;

--
-- Análisis: Identifica clientes de alto valor para programas VIP y detecta
-- clientes en riesgo de deserción. 
--

