-- ========================================
-- DATOS ADICIONALES PARA POBLAR CONSULTAS ESPECÍFICAS
-- Crea datos para asegurar que las consultas retornen resultados suficientes
-- i.e. que haya al menos 5 registros en las consultas
-- ========================================

-- ========================================
-- VUELOS RECIENTES: Crear vuelos en oct-dic 2025 para consulta de demanda
-- ========================================

DO $$
DECLARE
    v_numero_vuelo_creado VARCHAR;
    v_mensaje TEXT;
    v_contador INTEGER := 0;
BEGIN
    RAISE NOTICE '=== CREANDO VUELOS RECIENTES (OCT-DIC 2025) ===';

    -- Vuelos Octubre 2025
    CALL registrar_nuevo_vuelo('AM201', 1, 'XA-001', 1, 2, '2025-10-15', '08:00:00', '2025-10-15', '10:15:00', 135, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO301', 1, 'XB-001', 1, 3, '2025-10-18', '09:30:00', '2025-10-18', '11:15:00', 105, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB401', 1, 'XC-001', 4, 7, '2025-10-22', '14:00:00', '2025-10-22', '16:30:00', 150, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM202', 1, 'XA-002', 1, 2, '2025-10-25', '10:00:00', '2025-10-25', '12:15:00', 135, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO302', 1, 'XB-002', 2, 6, '2025-10-28', '13:00:00', '2025-10-28', '16:30:00', 210, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;

    -- Vuelos Noviembre 2025
    CALL registrar_nuevo_vuelo('VB402', 1, 'XC-002', 3, 8, '2025-11-05', '11:00:00', '2025-11-05', '13:30:00', 150, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM203', 1, 'XA-001', 1, 4, '2025-11-10', '07:30:00', '2025-11-10', '09:15:00', 105, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO303', 1, 'XB-001', 1, 2, '2025-11-15', '08:00:00', '2025-11-15', '10:15:00', 135, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB403', 1, 'XC-001', 5, 7, '2025-11-20', '12:30:00', '2025-11-20', '15:00:00', 150, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM204', 1, 'XA-002', 3, 5, '2025-11-25', '15:00:00', '2025-11-25', '16:50:00', 110, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;

    -- Vuelos Diciembre 2025
    CALL registrar_nuevo_vuelo('VO304', 1, 'XB-002', 1, 6, '2025-12-05', '09:00:00', '2025-12-05', '11:00:00', 120, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB404', 1, 'XC-002', 4, 2, '2025-12-10', '10:30:00', '2025-12-10', '12:45:00', 135, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;

    RAISE NOTICE '=== % VUELOS RECIENTES CREADOS ===', v_contador;
END $$;


-- ========================================
-- ASIGNAR PILOTOS A VUELOS RECIENTES
-- ========================================

DO $$
DECLARE
    v_exito BOOLEAN;
    v_mensaje TEXT;
    v_contador INTEGER := 0;
BEGIN
    RAISE NOTICE '=== ASIGNANDO PILOTOS A VUELOS RECIENTES ===';

    CALL asignar_piloto_vuelo(1, 'AM201', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(2, 'VO301', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(3, 'VB401', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(4, 'AM202', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(5, 'VO302', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(6, 'VB402', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(7, 'AM203', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(8, 'VO303', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(9, 'VB403', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(10, 'AM204', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(11, 'VO304', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(12, 'VB404', v_exito, v_mensaje); v_contador := v_contador + 1;

    RAISE NOTICE '=== % PILOTOS ASIGNADOS ===', v_contador;
END $$;


-- ========================================
-- COMPRAS MASIVAS: Lograr >70% ocupación en vuelos recientes
-- ========================================

DO $$
DECLARE
    v_boleto_id INTEGER;
    v_codigo_exito INTEGER;
    v_mensaje TEXT;
    v_compras_exitosas INTEGER := 0;
    v_client_counter INTEGER;
BEGIN
    RAISE NOTICE '=== INICIANDO COMPRAS MASIVAS PARA ALTA OCUPACIÓN ===';

    -- AM201 (capacidad 180, necesita ~130 boletos para >70%)
    v_client_counter := 1;
    FOR i IN 1..130 LOOP
        CALL procesar_compra_boleto(v_client_counter, 'AM201', (i::TEXT || 'A'), 'Economica', 1300.00, v_boleto_id, v_codigo_exito, v_mensaje);
        IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
        v_client_counter := v_client_counter + 1;
        IF v_client_counter > 89 THEN v_client_counter := 1; END IF;
    END LOOP;

    -- VO301 (capacidad 186, necesita ~135 boletos)
    v_client_counter := 1;
    FOR i IN 1..135 LOOP
        CALL procesar_compra_boleto(v_client_counter, 'VO301', (i::TEXT || 'B'), 'Economica', 580.00, v_boleto_id, v_codigo_exito, v_mensaje);
        IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
        v_client_counter := v_client_counter + 1;
        IF v_client_counter > 89 THEN v_client_counter := 1; END IF;
    END LOOP;

    -- VB401 (capacidad 186, necesita ~140 boletos para 75%)
    v_client_counter := 1;
    FOR i IN 1..140 LOOP
        CALL procesar_compra_boleto(v_client_counter, 'VB401', (i::TEXT || 'C'), 'Economica', 750.00, v_boleto_id, v_codigo_exito, v_mensaje);
        IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
        v_client_counter := v_client_counter + 1;
        IF v_client_counter > 89 THEN v_client_counter := 1; END IF;
    END LOOP;

    -- AM202 (capacidad 189, necesita ~135 boletos)
    v_client_counter := 1;
    FOR i IN 1..135 LOOP
        CALL procesar_compra_boleto(v_client_counter, 'AM202', (i::TEXT || 'D'), 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
        IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
        v_client_counter := v_client_counter + 1;
        IF v_client_counter > 89 THEN v_client_counter := 1; END IF;
    END LOOP;

    -- VO302 (capacidad 174, necesita ~125 boletos)
    v_client_counter := 1;
    FOR i IN 1..125 LOOP
        CALL procesar_compra_boleto(v_client_counter, 'VO302', (i::TEXT || 'E'), 'Economica', 1350.00, v_boleto_id, v_codigo_exito, v_mensaje);
        IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
        v_client_counter := v_client_counter + 1;
        IF v_client_counter > 89 THEN v_client_counter := 1; END IF;
    END LOOP;

    -- VB402 (capacidad 186, necesita ~140 boletos)
    v_client_counter := 1;
    FOR i IN 1..140 LOOP
        CALL procesar_compra_boleto(v_client_counter, 'VB402', (i::TEXT || 'F'), 'Economica', 800.00, v_boleto_id, v_codigo_exito, v_mensaje);
        IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
        v_client_counter := v_client_counter + 1;
        IF v_client_counter > 89 THEN v_client_counter := 1; END IF;
    END LOOP;

    -- AM203 (capacidad 186, necesita ~140 boletos)
    v_client_counter := 1;
    FOR i IN 1..140 LOOP
        CALL procesar_compra_boleto(v_client_counter, 'AM203', (i::TEXT || 'G'), 'Economica', 580.00, v_boleto_id, v_codigo_exito, v_mensaje);
        IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
        v_client_counter := v_client_counter + 1;
        IF v_client_counter > 89 THEN v_client_counter := 1; END IF;
    END LOOP;

    -- VO303 (capacidad 180, necesita ~130 boletos)
    v_client_counter := 1;
    FOR i IN 1..130 LOOP
        CALL procesar_compra_boleto(v_client_counter, 'VO303', (i::TEXT || 'H'), 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
        IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
        v_client_counter := v_client_counter + 1;
        IF v_client_counter > 89 THEN v_client_counter := 1; END IF;
    END LOOP;

    -- VB403 (capacidad 186, necesita ~145 boletos para 78%)
    v_client_counter := 1;
    FOR i IN 1..145 LOOP
        CALL procesar_compra_boleto(v_client_counter, 'VB403', (i::TEXT || 'I'), 'Economica', 750.00, v_boleto_id, v_codigo_exito, v_mensaje);
        IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
        v_client_counter := v_client_counter + 1;
        IF v_client_counter > 89 THEN v_client_counter := 1; END IF;
    END LOOP;

    -- AM204 (capacidad 189, necesita ~140 boletos)
    v_client_counter := 1;
    FOR i IN 1..140 LOOP
        CALL procesar_compra_boleto(v_client_counter, 'AM204', (i::TEXT || 'J'), 'Economica', 750.00, v_boleto_id, v_codigo_exito, v_mensaje);
        IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
        v_client_counter := v_client_counter + 1;
        IF v_client_counter > 89 THEN v_client_counter := 1; END IF;
    END LOOP;

    RAISE NOTICE '=== % COMPRAS MASIVAS COMPLETADAS ===', v_compras_exitosas;
END $$;






-- ========================================
-- CLIENTES SIN ACTIVIDAD: Actualizar fechas para >60 días inactividad
-- ========================================

DO $$
DECLARE
    v_contador INTEGER := 0;
BEGIN
    RAISE NOTICE '=== ACTUALIZANDO FECHAS PARA CLIENTES INACTIVOS ===';

    -- Actualizar TODAS las compras de ciertos clientes para que sean antiguas
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '90 days' WHERE cliente_id = 15; v_contador := v_contador + (SELECT COUNT(*) FROM comprar WHERE cliente_id = 15);
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '85 days' WHERE cliente_id = 16; v_contador := v_contador + (SELECT COUNT(*) FROM comprar WHERE cliente_id = 16);
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '80 days' WHERE cliente_id = 17; v_contador := v_contador + (SELECT COUNT(*) FROM comprar WHERE cliente_id = 17);
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '75 days' WHERE cliente_id = 18; v_contador := v_contador + (SELECT COUNT(*) FROM comprar WHERE cliente_id = 18);
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '70 days' WHERE cliente_id = 19; v_contador := v_contador + (SELECT COUNT(*) FROM comprar WHERE cliente_id = 19);
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '95 days' WHERE cliente_id = 20; v_contador := v_contador + (SELECT COUNT(*) FROM comprar WHERE cliente_id = 20);
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '100 days' WHERE cliente_id = 21; v_contador := v_contador + (SELECT COUNT(*) FROM comprar WHERE cliente_id = 21);
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '105 days' WHERE cliente_id = 22; v_contador := v_contador + (SELECT COUNT(*) FROM comprar WHERE cliente_id = 22);
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '110 days' WHERE cliente_id = 23; v_contador := v_contador + (SELECT COUNT(*) FROM comprar WHERE cliente_id = 23);
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '115 days' WHERE cliente_id = 24; v_contador := v_contador + (SELECT COUNT(*) FROM comprar WHERE cliente_id = 24);

    RAISE NOTICE '=== % REGISTROS DE COMPRA ACTUALIZADOS PARA CLIENTES INACTIVOS ===', v_contador;
END $$;
