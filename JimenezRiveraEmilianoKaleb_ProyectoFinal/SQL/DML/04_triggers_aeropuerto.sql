-- ========================================
-- TRIGGERS - SISTEMA DE AEROLÍNEAS
-- ========================================

-- ========================================
-- TRIGGERS EXISTENTES 
-- ========================================

-- ========================================
-- VALIDAR CANCELACIÓN DE VUELO
-- ========================================

-- Función trigger para validar que solo se puedan cancelar vuelos en estados apropiados
-- No permite cancelar vuelos que ya están en vuelo, aterrizados o ya cancelados
CREATE OR REPLACE FUNCTION fn_validar_cancelacion_vuelo()
RETURNS TRIGGER AS $$
BEGIN
    -- Solo validar si están intentando cancelar (cambiar a 'cancelado')
    IF NEW.estado_vuelo = 'cancelado' AND OLD.estado_vuelo != 'cancelado' THEN

        -- No permitir cancelar si está en vuelo o ya aterrizado
        IF OLD.estado_vuelo IN ('en_vuelo', 'aterrizado', 'cancelado') THEN
            RAISE EXCEPTION 'No se puede cancelar un vuelo con estado "%". Solo se pueden cancelar vuelos "programado" o "abordando".', OLD.estado_vuelo;
        END IF;

        RAISE NOTICE 'Iniciando cancelación del vuelo %', OLD.numero_vuelo;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_validar_cancelacion_vuelo
BEFORE UPDATE ON vuelo
FOR EACH ROW
EXECUTE FUNCTION fn_validar_cancelacion_vuelo();

COMMENT ON FUNCTION fn_validar_cancelacion_vuelo() IS
'Valida que solo se puedan cancelar vuelos en estados programado o abordando.';


-- ========================================
-- PROCESAR CANCELACIÓN DE VUELO
-- ========================================

-- Función trigger que procesa automáticamente reembolsos y compensaciones
-- cuando se cancela un vuelo
CREATE OR REPLACE FUNCTION fn_procesar_cancelacion_vuelo()
RETURNS TRIGGER AS $$
DECLARE
    v_cliente RECORD;
    v_total_reembolsos NUMERIC := 0;
    v_total_compensaciones NUMERIC := 0;
    v_total_clientes INT := 0;
BEGIN
    -- Solo procesar si cambió a 'cancelado'
    IF NEW.estado_vuelo = 'cancelado' AND OLD.estado_vuelo != 'cancelado' THEN

        -- Insertar en créditos y notificaciones_pendientes
        FOR v_cliente IN
            SELECT DISTINCT
                c.cliente_id,
                c.nombres,
                c.apellido_paterno,
                b.boleto_id,
                b.precio
            FROM boleto b
            INNER JOIN comprar comp ON b.boleto_id = comp.boleto_id
            INNER JOIN cliente c ON comp.cliente_id = c.cliente_id
            WHERE b.numero_vuelo = OLD.numero_vuelo
        LOOP
            -- Reembolso del precio del boleto
            INSERT INTO creditos (cliente_id, monto, origen)
            VALUES (
                v_cliente.cliente_id,
                v_cliente.precio,
                'cancelacion_vuelo'
            );

            -- Compensación adicional (10% extra)
            INSERT INTO creditos (cliente_id, monto, origen)
            VALUES (
                v_cliente.cliente_id,
                v_cliente.precio * 0.10,
                'compensacion'
            );

            -- Crear notificación
            INSERT INTO notificaciones_pendientes (cliente_id, tipo, mensaje)
            VALUES (
                v_cliente.cliente_id,
                'cancelacion',
                format('Estimado/a %s %s: Su vuelo %s ha sido cancelado. ' ||
                       'Reembolso procesado: $%s. Crédito adicional por compensación: $%s. ' ||
                       'Los créditos estarán disponibles en su cuenta.',
                       v_cliente.nombres,
                       v_cliente.apellido_paterno,
                       OLD.numero_vuelo,
                       v_cliente.precio,
                       ROUND(v_cliente.precio * 0.10, 2))
            );

            -- Actualizar estadísticas para el log
            v_total_reembolsos := v_total_reembolsos + v_cliente.precio;
            v_total_compensaciones := v_total_compensaciones + (v_cliente.precio * 0.10);
            v_total_clientes := v_total_clientes + 1;
        END LOOP;

        -- Actualizar el estado de todos los boletos con ese vuelo
        UPDATE boleto
        SET estado_boleto = 'cancelado'
        WHERE numero_vuelo = OLD.numero_vuelo;

        -- Log final con resumen de lo que se hizo
        RAISE NOTICE 'Cancelación procesada: Vuelo %, % clientes afectados, Reembolsos totales: $%, Compensaciones: $%',
            OLD.numero_vuelo,
            v_total_clientes,
            v_total_reembolsos,
            v_total_compensaciones;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_procesar_cancelacion_vuelo
AFTER UPDATE ON vuelo
FOR EACH ROW
EXECUTE FUNCTION fn_procesar_cancelacion_vuelo();

COMMENT ON FUNCTION fn_procesar_cancelacion_vuelo() IS
'Procesa reembolsos, compensaciones y notificaciones cuando se cancela un vuelo.';


-- ========================================
-- APLICAR RECARGO POR ÚLTIMA HORA
-- ========================================

-- Función trigger que aplica automáticamente un recargo del 30% a boletos
-- de vuelos que salen en menos de 7 días
CREATE OR REPLACE FUNCTION fn_aplicar_recargo_ultima_hora()
RETURNS TRIGGER AS $$
DECLARE
    v_dias_restantes INT;
    v_fecha_vuelo DATE;
BEGIN
    -- Solo aplicar si el precio cambió
    IF NEW.precio IS DISTINCT FROM OLD.precio THEN

        -- Obtener fecha del vuelo asociado al boleto
        SELECT fecha_salida INTO v_fecha_vuelo
        FROM vuelo
        WHERE numero_vuelo = NEW.numero_vuelo;

        -- Calcular cuántos días faltan para el vuelo
        v_dias_restantes := v_fecha_vuelo - CURRENT_DATE;

        -- Si es última hora (menos de 7 días y mayor o igual a 0), aplicar recargo del 30%
        IF v_dias_restantes < 7 AND v_dias_restantes >= 0 THEN
            NEW.precio := NEW.precio * 1.30;
            RAISE NOTICE 'Recargo última hora aplicado: % días restantes. Precio: % → %',
                v_dias_restantes, OLD.precio, NEW.precio;
        END IF;

    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_aplicar_recargo_ultima_hora
BEFORE UPDATE ON boleto
FOR EACH ROW
EXECUTE FUNCTION fn_aplicar_recargo_ultima_hora();

COMMENT ON FUNCTION fn_aplicar_recargo_ultima_hora() IS
'Aplica recargo del 30% automáticamente a boletos de vuelos que salen en menos de 7 días.';


-- ========================================
-- REGISTRAR CAMBIO DE PRECIO
-- ========================================

-- Función trigger que registra historial de cambios de precio y actualiza
-- el ingreso proyectado del vuelo
CREATE OR REPLACE FUNCTION fn_registrar_cambio_precio()
RETURNS TRIGGER AS $$
DECLARE
    v_motivo VARCHAR(100);
    v_ingreso_total NUMERIC;
BEGIN
    -- Solo procesar si el precio cambió
    IF NEW.precio IS DISTINCT FROM OLD.precio THEN

        -- Determinar el motivo del cambio según cuánto aumentó
        IF NEW.precio > OLD.precio * 1.25 THEN
            v_motivo := 'Recargo última hora';
        ELSIF NEW.precio > OLD.precio THEN
            v_motivo := 'Ajuste por demanda';
        ELSE
            v_motivo := 'Descuento aplicado';
        END IF;

        -- 1. Guardar en historial para auditoría
        INSERT INTO historial_precios_boleto (boleto_id, precio_anterior, precio_nuevo, motivo)
        VALUES (NEW.boleto_id, OLD.precio, NEW.precio, v_motivo);

        -- 2. Recalcular ingreso proyectado del vuelo
        -- Solo contamos boletos activos o usados, no los cancelados o reembolsados
        SELECT COALESCE(SUM(b.precio), 0) INTO v_ingreso_total
        FROM boleto b
        WHERE b.numero_vuelo = NEW.numero_vuelo
          AND b.estado_boleto IN ('activo', 'usado');

        -- Actualizar o insertar en tabla de reportes (UPSERT)
        INSERT INTO reporte_ingresos_vuelo (numero_vuelo, ingreso_proyectado)
        VALUES (NEW.numero_vuelo, v_ingreso_total)
        ON CONFLICT (numero_vuelo)
        DO UPDATE SET
            ingreso_proyectado = v_ingreso_total,
            ultima_actualizacion = CURRENT_TIMESTAMP;

        RAISE NOTICE 'Precio actualizado: Boleto % de $% → $%. Motivo: %. Ingreso proyectado vuelo %: $%',
            NEW.boleto_id, OLD.precio, NEW.precio, v_motivo, NEW.numero_vuelo, v_ingreso_total;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_registrar_cambio_precio
AFTER UPDATE ON boleto
FOR EACH ROW
EXECUTE FUNCTION fn_registrar_cambio_precio();

COMMENT ON FUNCTION fn_registrar_cambio_precio() IS
'Registra cambios de precio en historial y actualiza ingresos proyectados del vuelo.';


-- ========================================
-- AJUSTAR PRECIOS POR OCUPACIÓN
-- ========================================

-- Función trigger que incrementa automáticamente los precios de boletos
-- restantes en 20% cuando la ocupación del vuelo supera el 80%
CREATE OR REPLACE FUNCTION fn_ajustar_precios_por_ocupacion()
RETURNS TRIGGER AS $$
DECLARE
    v_ocupacion NUMERIC;
    v_numero_vuelo VARCHAR(10);
    v_boletos_actualizados INT;
BEGIN
    -- Obtener número de vuelo del boleto que se acaba de comprar
    SELECT numero_vuelo INTO v_numero_vuelo
    FROM boleto
    WHERE boleto_id = NEW.boleto_id;

    -- Calcular ocupación actual usando la función que ya existe en la base de datos
    v_ocupacion := calcular_ocupacion_vuelo(v_numero_vuelo);

    -- Si ocupación supera el 80%, incrementar precios de boletos restantes en 20%
    IF v_ocupacion > 80 THEN

        -- Actualizar precios de boletos activos que aún no han sido comprados
        UPDATE boleto
        SET precio = precio * 1.20
        WHERE numero_vuelo = v_numero_vuelo
          AND estado_boleto = 'activo'
          AND boleto_id NOT IN (SELECT boleto_id FROM comprar);

        -- Contar cuántos boletos se actualizaron
        GET DIAGNOSTICS v_boletos_actualizados = ROW_COUNT;

        RAISE NOTICE 'Ocupación del vuelo % alcanzó %.2f%%. Precios de % boletos restantes incrementados 20%%',
            v_numero_vuelo, v_ocupacion, v_boletos_actualizados;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_ajustar_precios_por_ocupacion
AFTER INSERT ON comprar
FOR EACH ROW
EXECUTE FUNCTION fn_ajustar_precios_por_ocupacion();

COMMENT ON FUNCTION fn_ajustar_precios_por_ocupacion() IS
'Incrementa automáticamente precios de boletos restantes en 20% cuando la ocupación supera 80%.';


-- ========================================
-- TRIGGERS NUEVOS (los que no estaban
-- en practicas anteriores :D)
-- ========================================

-- ========================================
-- VALIDAR CAPACIDAD DEL AVIÓN
-- ========================================

-- Función trigger que valida que la capacidad del avión sea coherente
-- con el tipo de avión y no permita valores negativos
CREATE OR REPLACE FUNCTION fn_validar_capacidad_avion()
RETURNS TRIGGER AS $$
BEGIN
    -- Validar que la capacidad sea positiva o cero (para aviones de carga)
    IF NEW.capacidad_pasajeros < 0 THEN
        RAISE EXCEPTION 'La capacidad de pasajeros no puede ser negativa';
    END IF;

    -- Validar capacidades según modelo de avión
    IF NEW.modelo = 'Boeing 747' AND (NEW.capacidad_pasajeros < 300 OR NEW.capacidad_pasajeros > 660) THEN
        RAISE WARNING 'Capacidad inusual para Boeing 747: %. Rango típico: 300-660 pasajeros', NEW.capacidad_pasajeros;
    ELSIF NEW.modelo = 'Airbus A380' AND (NEW.capacidad_pasajeros < 400 OR NEW.capacidad_pasajeros > 850) THEN
        RAISE WARNING 'Capacidad inusual para Airbus A380: %. Rango típico: 400-850 pasajeros', NEW.capacidad_pasajeros;
    ELSIF NEW.modelo LIKE '%Carga%' AND NEW.capacidad_pasajeros > 50 THEN
        RAISE WARNING 'Avión de carga con capacidad de pasajeros alta: %', NEW.capacidad_pasajeros;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_validar_capacidad_avion
BEFORE INSERT OR UPDATE ON avion
FOR EACH ROW
EXECUTE FUNCTION fn_validar_capacidad_avion();

COMMENT ON FUNCTION fn_validar_capacidad_avion() IS
'Valida que la capacidad del avión sea coherente con su tipo y no sea negativa.';


-- ========================================
-- ACTUALIZAR HORAS DE VUELO DEL PILOTO
-- ========================================

-- Función trigger que actualiza automáticamente las horas de vuelo de un piloto
-- cuando se completa un vuelo (estado cambia a 'aterrizado')

-- como cuando aumentan tus stats en un videojuego
CREATE OR REPLACE FUNCTION fn_actualizar_horas_vuelo_piloto()
RETURNS TRIGGER AS $$
DECLARE
    v_duracion_horas NUMERIC;
    v_piloto RECORD;
BEGIN
    -- Solo ejecutar si el vuelo cambió a estado aterrizado
    IF NEW.estado_vuelo = 'aterrizado' AND OLD.estado_vuelo != 'aterrizado' THEN

        -- Convertir duración de minutos a horas
        v_duracion_horas := NEW.duracion_minutos / 60.0;

        -- Actualizar horas de vuelo para todos los pilotos asignados
        FOR v_piloto IN
            SELECT piloto_id
            FROM piloto_vuelo
            WHERE numero_vuelo = NEW.numero_vuelo
        LOOP
            UPDATE piloto
            SET horas_vuelo = COALESCE(horas_vuelo, 0) + v_duracion_horas
            WHERE piloto_id = v_piloto.piloto_id;

            RAISE NOTICE 'Piloto % acumuló %.2f horas del vuelo %',
                v_piloto.piloto_id, v_duracion_horas, NEW.numero_vuelo;
        END LOOP;

    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_actualizar_horas_vuelo_piloto
AFTER UPDATE ON vuelo
FOR EACH ROW
EXECUTE FUNCTION fn_actualizar_horas_vuelo_piloto();

COMMENT ON FUNCTION fn_actualizar_horas_vuelo_piloto() IS
'Actualiza automáticamente las horas de vuelo de los pilotos cuando un vuelo aterriza.';




-- ========================================
-- VALIDAR FECHA DE NACIMIENTO CLIENTE
-- ========================================

-- Función trigger que valida que los clientes sean mayores de edad
-- Este es un clásico :0
CREATE OR REPLACE FUNCTION fn_validar_edad_cliente()
RETURNS TRIGGER AS $$
DECLARE
    v_edad INTEGER;
BEGIN
    -- Calcular edad
    v_edad := EXTRACT(YEAR FROM AGE(CURRENT_DATE, NEW.fecha_nacimiento));

    -- Validar edad mínima de 18 años
    IF v_edad < 18 THEN
        RAISE EXCEPTION 'El cliente debe ser mayor de edad (18 años). Edad actual: % años', v_edad;
    END IF;

    -- Validar fecha de nacimiento no sea futura
    IF NEW.fecha_nacimiento > CURRENT_DATE THEN
        RAISE EXCEPTION 'La fecha de nacimiento no puede ser futura';
    END IF;

    -- Validar edad razonable (menos de 120 años)
    IF v_edad > 120 THEN
        RAISE WARNING 'Edad inusualmente alta: % años', v_edad;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_validar_edad_cliente
BEFORE INSERT OR UPDATE ON cliente
FOR EACH ROW
EXECUTE FUNCTION fn_validar_edad_cliente();

COMMENT ON FUNCTION fn_validar_edad_cliente() IS
'Valida que los clientes sean mayores de edad y tengan fecha de nacimiento válida.';


-- ========================================
-- NOTIFICAR CAMBIO DE ESTADO DE VUELO
-- ========================================

-- Función trigger que crea notificaciones automáticas para clientes
-- cuando cambia el estado de su vuelo
CREATE OR REPLACE FUNCTION fn_notificar_cambio_estado_vuelo()
RETURNS TRIGGER AS $$
DECLARE
    v_cliente RECORD;
    v_mensaje TEXT;
BEGIN
    -- Solo ejecutar si el estado cambió
    IF NEW.estado_vuelo IS DISTINCT FROM OLD.estado_vuelo THEN

        -- Generar mensaje según el nuevo estado
        CASE NEW.estado_vuelo
            WHEN 'retrasado' THEN
                v_mensaje := format('Su vuelo %s ha sido retrasado. Le mantendremos informado.',
                    NEW.numero_vuelo);
            WHEN 'abordando' THEN
                v_mensaje := format('Su vuelo %s está abordando. Por favor diríjase a la puerta de embarque.',
                    NEW.numero_vuelo);
            WHEN 'en_vuelo' THEN
                v_mensaje := format('Su vuelo %s ha despegado y está en curso.',
                    NEW.numero_vuelo);
            WHEN 'aterrizado' THEN
                v_mensaje := format('Su vuelo %s ha aterrizado exitosamente. Bienvenido a su destino.',
                    NEW.numero_vuelo);
            ELSE
                v_mensaje := format('El estado de su vuelo %s ha cambiado a: %s',
                    NEW.numero_vuelo, NEW.estado_vuelo);
        END CASE;

        -- Crear notificaciones para todos los clientes con boletos en este vuelo
        FOR v_cliente IN
            SELECT DISTINCT c.cliente_id
            FROM cliente c
            INNER JOIN comprar comp ON c.cliente_id = comp.cliente_id
            INNER JOIN boleto b ON comp.boleto_id = b.boleto_id
            WHERE b.numero_vuelo = NEW.numero_vuelo
        LOOP
            INSERT INTO notificaciones_pendientes (cliente_id, tipo, mensaje)
            VALUES (v_cliente.cliente_id, 'cambio_vuelo', v_mensaje);
        END LOOP;

        RAISE NOTICE 'Notificaciones enviadas por cambio de estado del vuelo % a %',
            NEW.numero_vuelo, NEW.estado_vuelo;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_notificar_cambio_estado_vuelo
AFTER UPDATE ON vuelo
FOR EACH ROW
EXECUTE FUNCTION fn_notificar_cambio_estado_vuelo();

COMMENT ON FUNCTION fn_notificar_cambio_estado_vuelo() IS
'Crea notificaciones automáticas para clientes cuando cambia el estado de su vuelo.';


-- ========================================
-- PRUEBAS DE TRIGGERS
-- ========================================

DO $$
BEGIN
    RAISE NOTICE '=== PRUEBAS DE TRIGGERS ===';
    RAISE NOTICE '';
END $$;


-- ========================================
-- fn_procesar_cancelacion_vuelo (trigger automático al cancelar)
-- ========================================
DO $$
DECLARE
    v_test_vuelo VARCHAR := 'TRTEST01';
    v_numero_creado VARCHAR;
    v_mensaje TEXT;
    v_boleto_id INTEGER;
    v_codigo_exito INTEGER;
    v_creditos_antes NUMERIC;
    v_creditos_despues NUMERIC;
BEGIN
    RAISE NOTICE '--- Prueba fn_procesar_cancelacion_vuelo ---';

    -- Crear vuelo de prueba
    CALL registrar_nuevo_vuelo(
        v_test_vuelo, 1, 'XA-001', 1, 2,
        CURRENT_DATE + 20, '10:00:00',
        CURRENT_DATE + 20, '12:00:00',
        120, v_numero_creado, v_mensaje
    );

    -- Comprar boleto
    CALL procesar_compra_boleto(
        75, v_test_vuelo, '5A', 'Primera', 2000.00,
        v_boleto_id, v_codigo_exito, v_mensaje
    );

    -- Verificar créditos antes
    v_creditos_antes := calcular_creditos_disponibles(75);
    RAISE NOTICE 'Créditos cliente 75 antes de cancelación: $%', v_creditos_antes;

    -- Cancelar vuelo (activa el trigger)
    UPDATE vuelo SET estado_vuelo = 'cancelado' WHERE numero_vuelo = v_test_vuelo;

    -- Verificar créditos después (debería tener reembolso + 10%)
    v_creditos_despues := calcular_creditos_disponibles(75);
    RAISE NOTICE 'Créditos cliente 75 después de cancelación: $%', v_creditos_despues;
    RAISE NOTICE 'Incremento por compensación: $%', (v_creditos_despues - v_creditos_antes);

    -- Limpiar (orden correcto para respetar FK)
    DELETE FROM comprar WHERE boleto_id IN (
        SELECT boleto_id FROM boleto WHERE numero_vuelo = v_test_vuelo
    );
    DELETE FROM creditos WHERE cliente_id = 75 AND origen = 'cancelacion_vuelo';
    DELETE FROM reporte_ingresos_vuelo WHERE numero_vuelo = v_test_vuelo;
    DELETE FROM vuelo WHERE numero_vuelo = v_test_vuelo;

    RAISE NOTICE '';
END $$;


-- ========================================
-- fn_aplicar_recargo_ultima_hora
-- ========================================
DO $$
DECLARE
    v_test_vuelo VARCHAR := 'TRTEST02';
    v_numero_creado VARCHAR;
    v_mensaje TEXT;
    v_boleto_id INTEGER;
    v_codigo_exito INTEGER;
    v_precio_original NUMERIC := 1000.00;
    v_precio_final NUMERIC;
BEGIN
    RAISE NOTICE '--- Prueba fn_aplicar_recargo_ultima_hora ---';

    -- Crear vuelo que sale en 5 días (dentro de 7 días)
    CALL registrar_nuevo_vuelo(
        v_test_vuelo, 1, 'XA-001', 1, 3,
        CURRENT_DATE + 5, '15:00:00',
        CURRENT_DATE + 5, '17:00:00',
        120, v_numero_creado, v_mensaje
    );

    -- Comprar boleto (debería aplicar recargo del 30%)
    CALL procesar_compra_boleto(
        80, v_test_vuelo, '10B', 'economica', v_precio_original,
        v_boleto_id, v_codigo_exito, v_mensaje
    );

    -- Verificar precio final
    SELECT precio INTO v_precio_final
    FROM boleto
    WHERE boleto_id = v_boleto_id;

    RAISE NOTICE 'Precio original: $%', v_precio_original;
    RAISE NOTICE 'Precio con recargo 30%%: $%', v_precio_final;
    RAISE NOTICE 'Recargo aplicado: $%', (v_precio_final - v_precio_original);

    -- Limpiar
    DELETE FROM comprar WHERE boleto_id = v_boleto_id;
    DELETE FROM boleto WHERE boleto_id = v_boleto_id;
    DELETE FROM reporte_ingresos_vuelo WHERE numero_vuelo = v_test_vuelo;
    DELETE FROM vuelo WHERE numero_vuelo = v_test_vuelo;

    RAISE NOTICE '';
END $$;











-- ========================================
-- fn_registrar_cambio_precio
-- ========================================
DO $$
DECLARE
    v_test_vuelo VARCHAR := 'TRTEST03';
    v_numero_creado VARCHAR;
    v_mensaje TEXT;
    v_boleto_id INTEGER;
    v_codigo_exito INTEGER;
    v_cambios_registrados INTEGER;
BEGIN
    RAISE NOTICE '--- Prueba fn_registrar_cambio_precio ---';

    -- Crear vuelo
    CALL registrar_nuevo_vuelo(
        v_test_vuelo, 1, 'XB-001', 2, 4,
        CURRENT_DATE + 30, '08:00:00',
        CURRENT_DATE + 30, '10:00:00',
        120, v_numero_creado, v_mensaje
    );

    -- Comprar boleto
    CALL procesar_compra_boleto(
        85, v_test_vuelo, '15D', 'Ejecutiva', 1500.00,
        v_boleto_id, v_codigo_exito, v_mensaje
    );

    -- Cambiar precio del boleto (activa el trigger)
    UPDATE boleto SET precio = 1800.00 WHERE boleto_id = v_boleto_id;

    -- Verificar que se registró el cambio
    SELECT COUNT(*) INTO v_cambios_registrados
    FROM historial_precios_boleto
    WHERE boleto_id = v_boleto_id;

    RAISE NOTICE 'Cambios de precio registrados: %', v_cambios_registrados;

    -- Limpiar (orden correcto para respetar FK)
    DELETE FROM historial_precios_boleto WHERE boleto_id = v_boleto_id;
    DELETE FROM comprar WHERE boleto_id = v_boleto_id;
    DELETE FROM boleto WHERE boleto_id = v_boleto_id;
    DELETE FROM reporte_ingresos_vuelo WHERE numero_vuelo = v_test_vuelo;
    DELETE FROM vuelo WHERE numero_vuelo = v_test_vuelo;

    RAISE NOTICE '';
END $$;


-- ========================================
-- fn_ajustar_precios_por_ocupacion
-- ========================================
DO $$
DECLARE
    v_test_vuelo VARCHAR := 'TRTEST04';
    v_numero_creado VARCHAR;
    v_mensaje TEXT;
    v_boleto_id INTEGER;
    v_codigo_exito INTEGER;
    v_capacidad INTEGER;
    v_boletos_a_vender INTEGER;
    i INTEGER;
    v_ocupacion NUMERIC;
BEGIN
    RAISE NOTICE '--- Prueba fn_ajustar_precios_por_ocupacion ---';

    -- Crear vuelo
    CALL registrar_nuevo_vuelo(
        v_test_vuelo, 1, 'XC-001', 1, 5,
        CURRENT_DATE + 40, '12:00:00',
        CURRENT_DATE + 40, '14:00:00',
        120, v_numero_creado, v_mensaje
    );

    -- Obtener capacidad del avión
    SELECT av.capacidad_pasajeros INTO v_capacidad
    FROM vuelo v
    JOIN avion av ON v.matricula_avion = av.matricula_avion
    WHERE v.numero_vuelo = v_test_vuelo;

    -- Vender boletos hasta llegar a 82% de ocupación
    v_boletos_a_vender := FLOOR(v_capacidad * 0.82);

    FOR i IN 1..v_boletos_a_vender LOOP
        CALL procesar_compra_boleto(
            (80 + (i % 20)), -- Rotar clientes
            v_test_vuelo,
            i::VARCHAR || 'A',
            'Economica',
            500.00,
            v_boleto_id,
            v_codigo_exito,
            v_mensaje
        );
    END LOOP;

    v_ocupacion := calcular_ocupacion_vuelo(v_test_vuelo);
    RAISE NOTICE 'Ocupación final: %%%', ROUND(v_ocupacion, 2);
    RAISE NOTICE 'Trigger debería haber incrementado precios en 20%% para boletos restantes';

    -- Limpiar
    DELETE FROM comprar WHERE boleto_id IN (
        SELECT boleto_id FROM boleto WHERE numero_vuelo = v_test_vuelo
    );
    DELETE FROM boleto WHERE numero_vuelo = v_test_vuelo;
    DELETE FROM reporte_ingresos_vuelo WHERE numero_vuelo = v_test_vuelo;
    DELETE FROM vuelo WHERE numero_vuelo = v_test_vuelo;

    RAISE NOTICE '';
END $$;


-- ========================================
-- fn_validar_capacidad_avion
-- ========================================
DO $$
DECLARE
    v_test_matricula VARCHAR := 'TEST-CAP';
BEGIN
    RAISE NOTICE '--- Prueba fn_validar_capacidad_avion ---';

    -- Intentar crear avión con capacidad negativa (debería fallar)
    BEGIN
        INSERT INTO avion (matricula_avion, capacidad_pasajeros, modelo, aerolinea_id)
        VALUES (v_test_matricula, -50, 'Boeing 737', 1);

        RAISE NOTICE 'ERROR: Se permitió capacidad negativa';
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Validación exitosa: No se permite capacidad negativa';
    END;

    -- Crear avión con capacidad válida
    INSERT INTO avion (matricula_avion, capacidad_pasajeros, modelo, aerolinea_id)
    VALUES (v_test_matricula, 180, 'Boeing 737', 1);

    RAISE NOTICE 'Avión creado exitosamente con capacidad válida: 180 pasajeros';

    -- Limpiar
    DELETE FROM avion WHERE matricula_avion = v_test_matricula;

    RAISE NOTICE '';
END $$;


-- ========================================
-- fn_actualizar_horas_vuelo_piloto
-- ========================================
DO $$
DECLARE
    v_test_vuelo VARCHAR := 'TRTEST06';
    v_numero_creado VARCHAR;
    v_mensaje TEXT;
    v_horas_antes NUMERIC;
    v_horas_despues NUMERIC;
    v_exito BOOLEAN;
BEGIN
    RAISE NOTICE '--- Prueba  fn_actualizar_horas_vuelo_piloto ---';

    -- Crear vuelo
    CALL registrar_nuevo_vuelo(
        v_test_vuelo, 1, 'XA-003', 3, 4,
        CURRENT_DATE - 1, '06:00:00',
        CURRENT_DATE - 1, '08:00:00',
        120, v_numero_creado, v_mensaje
    );

    -- Asignar piloto
    CALL asignar_piloto_vuelo(15, v_test_vuelo, v_exito, v_mensaje);

    -- Obtener horas antes
    v_horas_antes := calcular_horas_vuelo_piloto(15);
    RAISE NOTICE 'Horas piloto 15 antes del aterrizaje: %', v_horas_antes;

    -- Marcar vuelo como aterrizado (activa el trigger)
    UPDATE vuelo SET estado_vuelo = 'aterrizado' WHERE numero_vuelo = v_test_vuelo;

    -- Obtener horas después
    v_horas_despues := calcular_horas_vuelo_piloto(15);
    RAISE NOTICE 'Horas piloto 15 después del aterrizaje: %', v_horas_despues;
    RAISE NOTICE 'Horas añadidas: %', (v_horas_despues - v_horas_antes);

    -- Limpiar
    UPDATE piloto SET horas_vuelo = v_horas_antes WHERE piloto_id = 15;
    DELETE FROM piloto_vuelo WHERE numero_vuelo = v_test_vuelo;
    DELETE FROM reporte_ingresos_vuelo WHERE numero_vuelo = v_test_vuelo;
    DELETE FROM vuelo WHERE numero_vuelo = v_test_vuelo;

    RAISE NOTICE '';
END $$;


-- ========================================
-- fn_validar_edad_cliente
-- ========================================
DO $$
DECLARE
    v_test_cliente_id INTEGER := 999;
BEGIN
    RAISE NOTICE '--- Prueba fn_validar_edad_cliente ---';

    -- Intentar crear cliente menor de edad (debería fallar)
    BEGIN
        INSERT INTO cliente (cliente_id, nombres, apellido_paterno, apellido_materno, fecha_nacimiento)
        VALUES (v_test_cliente_id, 'Test', 'Menor', 'Edad', CURRENT_DATE - INTERVAL '10 years');

        RAISE NOTICE 'ERROR: Se permitió cliente menor de edad';
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Validación exitosa: No se permite cliente menor de 18 años';
    END;

    -- Crear cliente con edad válida
    INSERT INTO cliente (cliente_id, nombres, apellido_paterno, apellido_materno, fecha_nacimiento)
    VALUES (v_test_cliente_id, 'Test', 'Adulto', 'Válido', CURRENT_DATE - INTERVAL '25 years');

    RAISE NOTICE 'Cliente creado exitosamente con edad válida: 25 años';

    -- Limpiar
    DELETE FROM cliente WHERE cliente_id = v_test_cliente_id;

    RAISE NOTICE '';
END $$;


-- ========================================
-- fn_notificar_cambio_estado_vuelo
-- ========================================
DO $$
DECLARE
    v_test_vuelo VARCHAR := 'TRTEST08';
    v_numero_creado VARCHAR;
    v_mensaje TEXT;
    v_boleto_id INTEGER;
    v_codigo_exito INTEGER;
    v_notificaciones INTEGER;
BEGIN
    RAISE NOTICE '--- Prueba fn_notificar_cambio_estado_vuelo ---';

    -- Crear vuelo
    CALL registrar_nuevo_vuelo(
        v_test_vuelo, 1, 'XB-002', 1, 2,
        CURRENT_DATE + 10, '14:00:00',
        CURRENT_DATE + 10, '16:00:00',
        120, v_numero_creado, v_mensaje
    );

    -- Comprar boleto
    CALL procesar_compra_boleto(
        90, v_test_vuelo, '8C', 'Economica', 750.00,
        v_boleto_id, v_codigo_exito, v_mensaje
    );

    -- Cambiar estado a retrasado (activa el trigger)
    UPDATE vuelo SET estado_vuelo = 'retrasado' WHERE numero_vuelo = v_test_vuelo;

    -- Verificar que se creó notificación
    SELECT COUNT(*) INTO v_notificaciones
    FROM notificaciones_pendientes
    WHERE cliente_id = 90
    AND tipo = 'cambio_vuelo'
    AND enviada = FALSE;

    RAISE NOTICE 'Notificaciones creadas para cliente 90: %', v_notificaciones;

    -- Cambiar a en_vuelo (otra notificación)
    UPDATE vuelo SET estado_vuelo = 'en_vuelo' WHERE numero_vuelo = v_test_vuelo;

    SELECT COUNT(*) INTO v_notificaciones
    FROM notificaciones_pendientes
    WHERE cliente_id = 90
    AND enviada = FALSE;

    RAISE NOTICE 'Total notificaciones pendientes: %', v_notificaciones;

    -- Limpiar
    DELETE FROM notificaciones_pendientes WHERE cliente_id = 90;
    DELETE FROM comprar WHERE boleto_id = v_boleto_id;
    DELETE FROM boleto WHERE boleto_id = v_boleto_id;
    DELETE FROM reporte_ingresos_vuelo WHERE numero_vuelo = v_test_vuelo;
    DELETE FROM vuelo WHERE numero_vuelo = v_test_vuelo;

    RAISE NOTICE '';
END $$;


DO $$
BEGIN
    RAISE NOTICE '=== PRUEBAS DE TRIGGERS COMPLETADAS ===';
END $$;
