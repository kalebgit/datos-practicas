-- ========================================
-- SIMULACIÓN DE UN DÍA EN EL AEROPUERTO
-- ========================================
-- simla las operaciones comunes que ocurren
-- en un día típico en el aeropuerto, en orden lógico

\echo ''
\echo '╔══════════════════════════════════════════════════════════════════════════════╗'
\echo '║         SISTEMA DE AEROLÍNEAS - SIMULACIÓN DE UN DÍA :D EN EL AEROPUERTO       ║'
\echo '╚══════════════════════════════════════════════════════════════════════════════╝'
\echo ''

-- ========================================
-- HORA: 6:00 AM - INICIO DE OPERACIONES
-- ========================================
\echo '6:00 AM - INICIO DE OPERACIONES DEL DÍA (que temprano jiji)'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

-- Consultar vuelos programados para hoy
\echo 'Vuelos programados para hoy:'
SELECT
    v.numero_vuelo,
    a.razon_social AS aerolinea,
    v.hora_salida,
    v.estado_vuelo,
    av.modelo AS tipo_avion,
    calcular_ocupacion_vuelo(v.numero_vuelo)::NUMERIC(5,2) AS ocupacion_porcentaje
FROM vuelo v
JOIN avion av ON v.matricula_avion = av.matricula_avion
JOIN aerolineas a ON av.aerolinea_id = a.aerolinea_id
WHERE v.fecha_salida = CURRENT_DATE
ORDER BY v.hora_salida
LIMIT 5;

\echo ''


-- ========================================
-- HORA: 7:00 AM - OPERACIONES DE VENTA
-- ========================================
\echo '7:00 AM - APERTURA DE VENTAS Y SISTEMA DE RESERVAS'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

-- DEMOSTRACIÓN: generar_numero_vuelo
\echo 'FUNCIÓN: generar_numero_vuelo (Generando número para nuevo vuelo)'
DO $$
DECLARE
    v_nuevo_numero VARCHAR;
BEGIN
    v_nuevo_numero := generar_numero_vuelo(1); -- Aeroméxico
    RAISE NOTICE 'Nuevo número de vuelo generado para Aeroméxico: %', v_nuevo_numero;
END $$;

\echo ''

-- DEMOSTRACIÓN: calcular_ocupacion_vuelo
\echo 'FUNCIÓN: calcular_ocupacion_vuelo (Consultando disponibilidad de vuelos)'
SELECT
    numero_vuelo,
    calcular_ocupacion_vuelo(numero_vuelo)::NUMERIC(5,2) AS "Ocupación %",
    obtener_asientos_disponibles(numero_vuelo) AS "Asientos Disponibles",
    obtener_ingresos_vuelo(numero_vuelo) AS "Ingresos $"
FROM vuelo
WHERE fecha_salida BETWEEN CURRENT_DATE AND CURRENT_DATE + 7
ORDER BY calcular_ocupacion_vuelo(numero_vuelo) DESC
LIMIT 5;

\echo ''


-- ========================================
-- HORA: 8:00 AM - COMPRA DE BOLETOS
-- ========================================
\echo '8:00 AM - PRIMEROS CLIENTES COMPRANDO BOLETOS'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

-- DEMOSTRACIÓN: procesar_compra_boleto
\echo 'PROCEDIMIENTO: procesar_compra_boleto (Cliente comprando boleto)'
DO $$
DECLARE
    v_boleto_id INTEGER;
    v_codigo_exito INTEGER;
    v_mensaje TEXT;
    v_cliente_id INTEGER := 67;
    v_vuelo VARCHAR := 'VB306';
BEGIN
    -- Comprar boleto
    CALL procesar_compra_boleto(
        v_cliente_id,
        v_vuelo,
        '12E',
        'Economica',
        950.00,
        v_boleto_id,
        v_codigo_exito,
        v_mensaje
    );

    IF v_codigo_exito = 1 THEN
        RAISE NOTICE 'Compra exitosa! Boleto ID: % para cliente % en vuelo %',
            v_boleto_id, v_cliente_id, v_vuelo;
        RAISE NOTICE '  Información del cliente: %', formatear_info_cliente(v_cliente_id);
    ELSE
        RAISE NOTICE 'Error en compra: %', v_mensaje;
    END IF;
END $$;

\echo ''

-- Ver compras recientes
\echo 'Últimas compras realizadas:'
SELECT
    c.cliente_id,
    cl.nombres || ' ' || cl.apellido_paterno AS cliente,
    b.numero_vuelo,
    b.numero_asiento,
    b.clase,
    b.precio,
    c.fecha_compra
FROM comprar c
JOIN cliente cl ON c.cliente_id = cl.cliente_id
JOIN boleto b ON c.boleto_id = b.boleto_id
ORDER BY c.fecha_compra DESC
LIMIT 5;

\echo ''


-- ========================================
-- HORA: 9:00 AM - VERIFICACIÓN DE CRÉDITOS Y COMPENSACIONES
-- ========================================
\echo '9:00 AM - VERIFICACIÓN DE CRÉDITOS DISPONIBLES'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

-- DEMOSTRACIÓN: calcular_creditos_disponibles
\echo 'FUNCIÓN: calcular_creditos_disponibles (Consultando créditos de clientes)'
SELECT
    c.cliente_id,
    cl.nombres || ' ' || cl.apellido_paterno AS cliente,
    COUNT(DISTINCT cr.credito_id) AS num_creditos,
    calcular_creditos_disponibles(c.cliente_id) AS "Total Créditos $"
FROM cliente cl
LEFT JOIN creditos cr ON cl.cliente_id = cr.cliente_id AND cr.usado = FALSE
LEFT JOIN comprar c ON cl.cliente_id = c.cliente_id
WHERE cr.cliente_id IS NOT NULL
GROUP BY c.cliente_id, cl.nombres, cl.apellido_paterno
LIMIT 5;

\echo ''


-- ========================================
-- HORA: 10:00 AM - NOTIFICACIÓN DE ESTADO DE VUELOS
-- ========================================
\echo '10:00 AM - ACTUALIZACIÓN DE ESTADOS DE VUELOS'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

-- Actualizar estados de vuelos automáticamente
\echo 'Actualizando estados de vuelos según hora actual...'
CALL actualizar_estados_vuelos();

-- Verificar notificaciones generadas
\echo ''
\echo 'Notificaciones pendientes de envío:'
SELECT
    n.notificacion_id,
    c.nombres || ' ' || c.apellido_paterno AS cliente,
    n.tipo,
    LEFT(n.mensaje, 60) || '...' AS mensaje_preview,
    n.fecha_creacion
FROM notificaciones_pendientes n
JOIN cliente c ON n.cliente_id = c.cliente_id
WHERE n.enviada = FALSE
ORDER BY n.fecha_creacion DESC
LIMIT 5;

\echo ''


-- ========================================
-- HORA: 11:00 AM - OPERACIONES CON TRIGGERS
-- ========================================
\echo '11:00 AM - COMPRA DE ÚLTIMA HORA (TRIGGER: Recargo 30%)'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

-- DEMOSTRACIÓN: fn_aplicar_recargo_ultima_hora (Trigger)
\echo 'TRIGGER: fn_aplicar_recargo_ultima_hora (Boleto comprado para vuelo en <7 días)'
DO $$
DECLARE
    v_vuelo_cercano VARCHAR;
    v_boleto_id INTEGER;
    v_codigo_exito INTEGER;
    v_mensaje TEXT;
    v_precio_original NUMERIC := 1200.00;
    v_precio_final NUMERIC;
BEGIN
    -- Buscar un vuelo que salga en menos de 7 días
    SELECT numero_vuelo INTO v_vuelo_cercano
    FROM vuelo
    WHERE fecha_salida BETWEEN CURRENT_DATE AND CURRENT_DATE + 6
    AND estado_vuelo = 'programado'
    LIMIT 1;

    IF v_vuelo_cercano IS NOT NULL THEN
        -- Intentar comprar boleto (se aplicará recargo automático)
        CALL procesar_compra_boleto(
            68, v_vuelo_cercano, '18F', 'Economica', v_precio_original,
            v_boleto_id, v_codigo_exito, v_mensaje
        );

        IF v_codigo_exito = 1 THEN
            SELECT precio INTO v_precio_final FROM boleto WHERE boleto_id = v_boleto_id;
            RAISE NOTICE '  Vuelo: % (Sale en < 7 días)', v_vuelo_cercano;
            RAISE NOTICE '  Precio original: $%', v_precio_original;
            RAISE NOTICE '  Precio con recargo 30%%: $%', v_precio_final;
            RAISE NOTICE '  Recargo aplicado: $%', (v_precio_final - v_precio_original);
        END IF;
    ELSE
        RAISE NOTICE '  No hay vuelos en los próximos 6 días';
    END IF;
END $$;

\echo ''


-- ========================================
-- HORA: 12:00 PM - CANCELACIÓN DE VUELO
-- ========================================
\echo '12:00 PM - EMERGENCIA: CANCELACIÓN DE VUELO'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

-- DEMOSTRACIÓN: cancelar_vuelo_con_reembolso + fn_procesar_cancelacion_vuelo
\echo 'PROCEDIMIENTO: cancelar_vuelo_con_reembolso + TRIGGER: fn_procesar_cancelacion_vuelo'
DO $$
DECLARE
    v_test_vuelo VARCHAR := 'SIMDEMO01';
    v_numero_creado VARCHAR;
    v_mensaje TEXT;
    v_boleto_id1 INTEGER;
    v_boleto_id2 INTEGER;
    v_codigo_exito INTEGER;
    v_boletos_reembolsados INTEGER;
    v_creditos_cliente1 NUMERIC;
    v_creditos_cliente2 NUMERIC;
BEGIN
    RAISE NOTICE '  Paso 1: Creando vuelo de demostración...';
    CALL registrar_nuevo_vuelo(
        v_test_vuelo, 1, 'XA-001', 1, 2,
        CURRENT_DATE + 14, '15:00:00',
        CURRENT_DATE + 14, '17:00:00',
        120, v_numero_creado, v_mensaje
    );

    RAISE NOTICE '  Paso 2: Vendiendo boletos...';
    CALL procesar_compra_boleto(70, v_test_vuelo, '1A', 'Primera', 3000.00,
        v_boleto_id1, v_codigo_exito, v_mensaje);
    CALL procesar_compra_boleto(71, v_test_vuelo, '1B', 'Primera', 3000.00,
        v_boleto_id2, v_codigo_exito, v_mensaje);

    RAISE NOTICE '  Paso 3: Cancelando vuelo y procesando reembolsos...';
    CALL cancelar_vuelo_con_reembolso(v_test_vuelo, 'Cancelación por mantenimiento no programado', v_boletos_reembolsados);

    RAISE NOTICE '  Vuelo cancelado. Boletos reembolsados: %', v_boletos_reembolsados;

    -- Verificar créditos generados (precio + 10% compensación)
    v_creditos_cliente1 := calcular_creditos_disponibles(70);
    v_creditos_cliente2 := calcular_creditos_disponibles(71);

    RAISE NOTICE '  Créditos generados para cliente 70: $% (incluye 10%% compensación)', v_creditos_cliente1;
    RAISE NOTICE '  Créditos generados para cliente 71: $% (incluye 10%% compensación)', v_creditos_cliente2;

    -- Limpiar datos de demostración (orden correcto para evitar violaciones de FK)
    DELETE FROM comprar WHERE boleto_id IN (
        SELECT boleto_id FROM boleto WHERE numero_vuelo = v_test_vuelo
    );
    DELETE FROM creditos WHERE cliente_id IN (70, 71) AND origen = 'cancelacion_vuelo';
    DELETE FROM reporte_ingresos_vuelo WHERE numero_vuelo = v_test_vuelo;
    DELETE FROM vuelo WHERE numero_vuelo = v_test_vuelo;
END $$;

\echo ''


-- ========================================
-- HORA: 1:00 PM - CAMBIOS DE ESTADO Y NOTIFICACIONES
-- ========================================
\echo '1:00 PM - CAMBIOS DE ESTADO DE VUELOS'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

-- DEMOSTRACIÓN: fn_notificar_cambio_estado_vuelo (Trigger)
\echo 'TRIGGER: fn_notificar_cambio_estado_vuelo (Vuelo retrasado genera notificaciones)'
DO $$
DECLARE
    v_vuelo_demo VARCHAR;
    v_notif_antes INTEGER;
    v_notif_despues INTEGER;
BEGIN
    -- Seleccionar un vuelo programado
    SELECT numero_vuelo INTO v_vuelo_demo
    FROM vuelo
    WHERE estado_vuelo = 'programado'
    AND fecha_salida >= CURRENT_DATE
    LIMIT 1;

    IF v_vuelo_demo IS NOT NULL THEN
        -- Contar notificaciones antes
        SELECT COUNT(*) INTO v_notif_antes
        FROM notificaciones_pendientes
        WHERE enviada = FALSE;

        RAISE NOTICE '  Cambiando estado del vuelo % a RETRASADO...', v_vuelo_demo;
        UPDATE vuelo SET estado_vuelo = 'retrasado' WHERE numero_vuelo = v_vuelo_demo;

        -- Contar notificaciones después
        SELECT COUNT(*) INTO v_notif_despues
        FROM notificaciones_pendientes
        WHERE enviada = FALSE;

        RAISE NOTICE '  Notificaciones antes: %', v_notif_antes;
        RAISE NOTICE '  Notificaciones después: %', v_notif_despues;
        RAISE NOTICE '  Nuevas notificaciones creadas: %', (v_notif_despues - v_notif_antes);

        -- Revertir cambio
        UPDATE vuelo SET estado_vuelo = 'programado' WHERE numero_vuelo = v_vuelo_demo;
    END IF;
END $$;

\echo ''










-- ========================================
-- HORA: 3:00 PM - REPORTES Y ANÁLISIS
-- ========================================
\echo '3:00 PM - GENERACIÓN DE REPORTES EJECUTIVOS'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

-- DEMOSTRACIÓN: generar_reporte_ocupacion_mensual
\echo 'PROCEDIMIENTO: generar_reporte_ocupacion_mensual (Reporte de Enero 2025)'
CALL generar_reporte_ocupacion_mensual(1, 2025);

\echo ''
\echo 'Resumen del reporte generado:'
SELECT
    numero_vuelo,
    ocupacion_porcentaje AS "Ocupación %",
    ingresos AS "Ingresos $",
    fecha_generacion
FROM reporte_ocupacion
WHERE mes = 1 AND anio = 2025
ORDER BY ocupacion_porcentaje DESC
LIMIT 5;

\echo ''


-- ========================================
-- ESTADÍSTICAS FINALES DEL DÍA
-- ========================================
\echo '6:00 PM - ESTADÍSTICAS Y RESUMEN DEL DÍA'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

\echo 'RESUMEN DE OPERACIONES DEL DÍA:'
\echo ''

-- Total de vuelos por estado
\echo 'Estado de vuelos:'
SELECT
    estado_vuelo AS "Estado",
    COUNT(*) AS "Cantidad",
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS "Porcentaje %"
FROM vuelo
GROUP BY estado_vuelo
ORDER BY COUNT(*) DESC;

\echo ''

-- Top 5 aerolíneas por ingresos
\echo 'Top 5 Aerolíneas por Ingresos:'
SELECT
    a.razon_social AS "Aerolínea",
    COUNT(DISTINCT v.numero_vuelo) AS "Vuelos",
    SUM(obtener_ingresos_vuelo(v.numero_vuelo)) AS "Ingresos Totales $",
    ROUND(AVG(calcular_ocupacion_vuelo(v.numero_vuelo)), 2) AS "Ocupación Promedio %"
FROM aerolineas a
JOIN avion av ON a.aerolinea_id = av.aerolinea_id
JOIN vuelo v ON av.matricula_avion = v.matricula_avion
GROUP BY a.razon_social
ORDER BY SUM(obtener_ingresos_vuelo(v.numero_vuelo)) DESC
LIMIT 5;

\echo ''

-- Rendimiento de pilotos
\echo 'Top 5 Pilotos por Horas de Vuelo:'
SELECT
    p.piloto_id,
    e.nombres || ' ' || e.apellido_paterno AS "Piloto",
    calcular_horas_vuelo_piloto(p.piloto_id) AS "Horas Totales",
    COUNT(DISTINCT pv.numero_vuelo) AS "Vuelos Asignados"
FROM piloto p
JOIN empleado e ON p.empleado_id = e.empleado_id
LEFT JOIN piloto_vuelo pv ON p.piloto_id = pv.piloto_id
GROUP BY p.piloto_id, e.nombres, e.apellido_paterno
ORDER BY calcular_horas_vuelo_piloto(p.piloto_id) DESC
LIMIT 5;

\echo ''

