-- ========================================
-- DATOS INICIALES PARA LA SIMULACIÓN
-- ========================================

\echo ''
\echo '╔══════════════════════════════════════════════════════════════════════════════╗'
\echo '║             INSERTANDO DATOS INICIALES PARA LA SIMULACIÓN                   ║'
\echo '╚══════════════════════════════════════════════════════════════════════════════╝'
\echo ''

-- ========================================
-- VUELOS PARA HOY (fecha actual)
-- ========================================
\echo 'Creando vuelos para hoy...'

-- Obtener fecha actual y crear vuelos
DO $$
DECLARE
    v_fecha_hoy DATE := CURRENT_DATE;
    v_mensaje TEXT;
    v_vuelo_creado VARCHAR;
BEGIN
    -- Vuelo 1: Aeroméxico temprano (CDMX -> Cancún)
    CALL registrar_nuevo_vuelo(
        'SIMDEMO01', 1, 'XA-001', 1, 2,
        v_fecha_hoy, '06:30:00',
        v_fecha_hoy, '08:30:00',
        120, v_vuelo_creado, v_mensaje
    );
    RAISE NOTICE 'Vuelo creado: %', v_vuelo_creado;

    -- Vuelo 2: Volaris mañana (Guadalajara -> Monterrey)
    CALL registrar_nuevo_vuelo(
        'SIMDEMO02', 1, 'XB-001', 3, 4,
        v_fecha_hoy, '09:00:00',
        v_fecha_hoy, '11:00:00',
        90, v_vuelo_creado, v_mensaje
    );
    RAISE NOTICE 'Vuelo creado: %', v_vuelo_creado;

    -- Vuelo 3: VivaAerobus mediodía (Tijuana -> Los Cabos)
    CALL registrar_nuevo_vuelo(
        'SIMDEMO03', 1, 'XC-001', 5, 6,
        v_fecha_hoy, '12:00:00',
        v_fecha_hoy, '14:30:00',
        150, v_vuelo_creado, v_mensaje
    );
    RAISE NOTICE 'Vuelo creado: %', v_vuelo_creado;

    -- Vuelo 4: Aeroméxico tarde (Puerto Vallarta -> Mérida)
    CALL registrar_nuevo_vuelo(
        'SIMDEMO04', 1, 'XA-002', 7, 8,
        v_fecha_hoy, '15:00:00',
        v_fecha_hoy, '17:00:00',
        120, v_vuelo_creado, v_mensaje
    );
    RAISE NOTICE 'Vuelo creado: %', v_vuelo_creado;

    -- Vuelo 5: Volaris noche (Mazatlán -> Acapulco)
    CALL registrar_nuevo_vuelo(
        'SIMDEMO05', 1, 'XB-002', 9, 10,
        v_fecha_hoy, '19:00:00',
        v_fecha_hoy, '21:00:00',
        100, v_vuelo_creado, v_mensaje
    );
    RAISE NOTICE 'Vuelo creado: %', v_vuelo_creado;
END $$;

\echo ''

-- ========================================
-- VUELOS PARA LA PRÓXIMA SEMANA
-- ========================================
\echo 'Creando vuelos para la próxima semana...'

DO $$
DECLARE
    v_fecha_siguiente DATE := CURRENT_DATE + 3;
    v_mensaje TEXT;
    v_vuelo_creado VARCHAR;
BEGIN
    -- Vuelos para dentro de 3 días (CDMX -> Cancún)
    CALL registrar_nuevo_vuelo(
        'SIMFUT01', 1, 'XA-001', 1, 2,
        v_fecha_siguiente, '10:00:00',
        v_fecha_siguiente, '12:00:00',
        120, v_vuelo_creado, v_mensaje
    );

    -- Vuelos para dentro de 4 días (Guadalajara -> Monterrey)
    CALL registrar_nuevo_vuelo(
        'SIMFUT02', 1, 'XC-002', 3, 4,
        v_fecha_siguiente + 1, '14:00:00',
        v_fecha_siguiente + 1, '16:00:00',
        150, v_vuelo_creado, v_mensaje
    );

    -- Vuelos para dentro de 5 días (Tijuana -> Los Cabos)
    CALL registrar_nuevo_vuelo(
        'SIMFUT03', 1, 'XB-003', 5, 6,
        v_fecha_siguiente + 2, '16:00:00',
        v_fecha_siguiente + 2, '18:00:00',
        90, v_vuelo_creado, v_mensaje
    );
END $$;

\echo ''

-- ========================================
-- BOLETOS PARA VUELOS DE HOY
-- ========================================
\echo 'Vendiendo boletos para vuelos de hoy...'

DO $$
DECLARE
    v_boleto_id INTEGER;
    v_codigo INTEGER;
    v_mensaje TEXT;
BEGIN
    -- Boletos para SIMDEMO01 - XA-001 Boeing 737 (180 asientos - vender 120 = 66% ocupación)
    CALL procesar_compra_boleto(1, 'SIMDEMO01', '1A', 'Primera', 2500.00, v_boleto_id, v_codigo, v_mensaje);
    CALL procesar_compra_boleto(2, 'SIMDEMO01', '1B', 'Primera', 2500.00, v_boleto_id, v_codigo, v_mensaje);
    CALL procesar_compra_boleto(3, 'SIMDEMO01', '1C', 'Primera', 2500.00, v_boleto_id, v_codigo, v_mensaje);
    CALL procesar_compra_boleto(4, 'SIMDEMO01', '2A', 'Ejecutiva', 1800.00, v_boleto_id, v_codigo, v_mensaje);
    CALL procesar_compra_boleto(5, 'SIMDEMO01', '2B', 'Ejecutiva', 1800.00, v_boleto_id, v_codigo, v_mensaje);
    CALL procesar_compra_boleto(6, 'SIMDEMO01', '2C', 'Ejecutiva', 1800.00, v_boleto_id, v_codigo, v_mensaje);

    -- Añadir más boletos económicos para SIMDEMO01
    FOR i IN 3..40 LOOP
        CALL procesar_compra_boleto(
            (i % 30) + 1,  -- Rotar entre clientes 1-30
            'SIMDEMO01',
            i || 'A',
            'Economica',
            1200.00,
            v_boleto_id,
            v_codigo,
            v_mensaje
        );
    END LOOP;

    -- Boletos para SIMDEMO02 - XB-001 Airbus A320neo (186 asientos - vender 93 = 50% ocupación)
    FOR i IN 1..45 LOOP
        CALL procesar_compra_boleto(
            (i % 30) + 1,
            'SIMDEMO02',
            i || 'B',
            'Economica',
            950.00,
            v_boleto_id,
            v_codigo,
            v_mensaje
        );
    END LOOP;

    -- Boletos para SIMDEMO03 - XC-001 Airbus A320 (186 asientos - vender 148 = 80% ocupación)
    CALL procesar_compra_boleto(10, 'SIMDEMO03', '1A', 'Primera', 3000.00, v_boleto_id, v_codigo, v_mensaje);
    CALL procesar_compra_boleto(11, 'SIMDEMO03', '1B', 'Primera', 3000.00, v_boleto_id, v_codigo, v_mensaje);
    CALL procesar_compra_boleto(12, 'SIMDEMO03', '2A', 'Ejecutiva', 2000.00, v_boleto_id, v_codigo, v_mensaje);
    CALL procesar_compra_boleto(13, 'SIMDEMO03', '2B', 'Ejecutiva', 2000.00, v_boleto_id, v_codigo, v_mensaje);

    FOR i IN 3..75 LOOP
        CALL procesar_compra_boleto(
            (i % 30) + 1,
            'SIMDEMO03',
            i || 'C',
            'Economica',
            1300.00,
            v_boleto_id,
            v_codigo,
            v_mensaje
        );
    END LOOP;

    -- Boletos para SIMDEMO04 - XA-002 Airbus A320 (189 asientos - vender 76 = 40% ocupación)
    FOR i IN 1..38 LOOP
        CALL procesar_compra_boleto(
            (i % 30) + 1,
            'SIMDEMO04',
            i || 'D',
            'Economica',
            1100.00,
            v_boleto_id,
            v_codigo,
            v_mensaje
        );
    END LOOP;

    -- Boletos para SIMDEMO05 - XB-002 Airbus A320 (174 asientos - vender 52 = 30% ocupación)
    FOR i IN 1..26 LOOP
        CALL procesar_compra_boleto(
            (i % 30) + 1,
            'SIMDEMO05',
            i || 'E',
            'Economica',
            900.00,
            v_boleto_id,
            v_codigo,
            v_mensaje
        );
    END LOOP;

    RAISE NOTICE 'Boletos creados exitosamente';
END $$;

\echo ''

-- ========================================
-- BOLETOS PARA VUELOS FUTUROS
-- ========================================
\echo 'Vendiendo boletos para vuelos futuros...'

DO $$
DECLARE
    v_boleto_id INTEGER;
    v_codigo INTEGER;
    v_mensaje TEXT;
BEGIN
    -- Boletos para SIMFUT01 (XA-001, 180 asientos - vender 54 = 30%)
    FOR i IN 1..27 LOOP
        CALL procesar_compra_boleto(
            (i % 30) + 1,
            'SIMFUT01',
            i || 'F',
            'Economica',
            1150.00,
            v_boleto_id,
            v_codigo,
            v_mensaje
        );
    END LOOP;

    -- Boletos para SIMFUT02 (XC-002, 186 asientos - vender 56 = 30%)
    FOR i IN 1..28 LOOP
        CALL procesar_compra_boleto(
            (i % 30) + 1,
            'SIMFUT02',
            i || 'G',
            'Primera',
            2800.00,
            v_boleto_id,
            v_codigo,
            v_mensaje
        );
    END LOOP;

    -- Boletos para SIMFUT03 (XB-003, 186 asientos - vender 56 = 30%)
    FOR i IN 1..28 LOOP
        CALL procesar_compra_boleto(
            (i % 30) + 1,
            'SIMFUT03',
            i || 'H',
            'Ejecutiva',
            1900.00,
            v_boleto_id,
            v_codigo,
            v_mensaje
        );
    END LOOP;

    RAISE NOTICE 'Boletos para vuelos futuros creados exitosamente';
END $$;

\echo ''

-- ========================================
-- CREAR ALGUNOS CRÉDITOS PARA CLIENTES
-- ========================================
\echo 'Generando créditos de prueba para clientes...'

INSERT INTO creditos (cliente_id, monto, origen, usado, fecha_emision)
VALUES
    (1, 500.00, 'compensacion', FALSE, CURRENT_DATE - 10),
    (1, 300.00, 'promocion', FALSE, CURRENT_DATE - 5),
    (2, 750.00, 'cancelacion_vuelo', FALSE, CURRENT_DATE - 15),
    (3, 400.00, 'compensacion', FALSE, CURRENT_DATE - 8),
    (4, 600.00, 'cancelacion_vuelo', FALSE, CURRENT_DATE - 12),
    (5, 250.00, 'promocion', FALSE, CURRENT_DATE - 3)
ON CONFLICT DO NOTHING;

\echo ''
