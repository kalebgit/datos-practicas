-- ========================================
-- TRIGGERS AVANZADOS - PRÁCTICA 12
-- Sistema de Aerolíneas
-- ========================================

-- ========================================
-- TRIGGER 1: VALIDAR CANCELACIÓN DE VUELO
-- ========================================

-- tenemos que hacer un trigger de before update para verificar que el estado del vuelo viejo
-- no diga 'en_vuelo' o 'aterrizado' ni 'cancelado' para evitar que reciban bonificaciones
-- extras para uno que ya estaba cancelado

-- esto va antes de actualizar estado de vuelo
CREATE OR REPLACE FUNCTION fn_validar_cancelacion_vuelo()
RETURNS TRIGGER AS $$
BEGIN
    -- solo validar si estan intentando cancelar (cambiar a 'cancelado')
    IF NEW.estado = 'cancelado' AND OLD.estado != 'cancelado' THEN

        -- no permitir cancelar si esta en vuelo o ya aterrizo
        IF OLD.estado IN ('en_vuelo', 'aterrizado', 'cancelado') THEN
            RAISE EXCEPTION 'No se puede cancelar un vuelo con estado "%". Solo se pueden cancelar vuelos "programado" o "abordando".', OLD.estado;
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
-- TRIGGER 2: PROCESAR CANCELACIÓN DE VUELO
-- ========================================

-- queremos reembolsos a cada cliente y creditos, pero solo estamos en una fila de VUELO
-- entonces necesitamos recorrer todos los clientes que compraron boletos para ese vuelo
CREATE OR REPLACE FUNCTION fn_procesar_cancelacion_vuelo()
RETURNS TRIGGER AS $$
DECLARE
    v_cliente RECORD;
    v_total_reembolsos NUMERIC := 0; -- el total que se reembolso por ese vuelo
    v_total_compensaciones NUMERIC := 0;
    v_total_clientes INT := 0;
BEGIN
    -- solo procesar si cambio a 'cancelado'
    IF NEW.estado = 'cancelado' AND OLD.estado != 'cancelado' THEN

        -- insertamos en creditos y notificaciones_pendientes
        FOR v_cliente IN
            SELECT DISTINCT -- es decir que solo tomamos los clientes
            -- diferentes no importa que haya comprado muchos boletos
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
            -- mientras no ponemos un vencimiento para los reembolsos
            INSERT INTO creditos (cliente_id, monto, origen)
            VALUES (
                v_cliente.cliente_id,
                v_cliente.precio,
                'cancelacion_vuelo'
            );

            -- despues agregamos la compensacion adicional (10% extra)
            INSERT INTO creditos (cliente_id, monto, origen)
            VALUES (
                v_cliente.cliente_id,
                v_cliente.precio * 0.10,
                'compensacion'
            );

            -- creamos la notif
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

            -- actualizar estadisticas para el log
            v_total_reembolsos := v_total_reembolsos + v_cliente.precio;
            v_total_compensaciones := v_total_compensaciones + (v_cliente.precio * 0.10);
            v_total_clientes := v_total_clientes + 1;
        END LOOP;

        -- actualizamos el estado de todos los boletos con ese vuelo
        UPDATE boleto
        SET estado_boleto = 'cancelado'
        WHERE numero_vuelo = OLD.numero_vuelo;

        -- log final con resumen de lo que se hizo
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
-- TRIGGER 3: APLICAR RECARGO POR ÚLTIMA HORA
-- ========================================

-- si el vuelo sale en menos de 7 dias, aplicamos un recargo del 30%
-- esto es automatico cada vez que se actualiza el precio de un boleto
CREATE OR REPLACE FUNCTION fn_aplicar_recargo_ultima_hora()
RETURNS TRIGGER AS $$
DECLARE
    v_dias_restantes INT;
    v_fecha_vuelo DATE;
BEGIN
    -- solo aplicar si el precio cambio
    IF NEW.precio IS DISTINCT FROM OLD.precio THEN

        -- obtener fecha del vuelo asociado al boleto
        SELECT fecha_salida INTO v_fecha_vuelo
        FROM vuelo
        WHERE numero_vuelo = NEW.numero_vuelo;

        -- calcular cuantos dias faltan para el vuelo
        v_dias_restantes := v_fecha_vuelo - CURRENT_DATE;

        -- si es ultima hora (menos de 7 dias y mayor o igual a 0), aplicar recargo del 30%
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
-- TRIGGER 4: REGISTRAR CAMBIO DE PRECIO
-- ========================================

-- cada vez que cambia el precio de un boleto, guardamos el historial y actualizamos
-- el ingreso proyectado del vuelo (para reportes)
CREATE OR REPLACE FUNCTION fn_registrar_cambio_precio()
RETURNS TRIGGER AS $$
DECLARE
    v_motivo VARCHAR(100);
    v_ingreso_total NUMERIC;
BEGIN
    -- solo procesar si el precio cambio
    IF NEW.precio IS DISTINCT FROM OLD.precio THEN

        -- determinar el motivo del cambio segun cuanto aumento
        IF NEW.precio > OLD.precio * 1.25 THEN
            v_motivo := 'Recargo última hora';
        ELSIF NEW.precio > OLD.precio THEN
            v_motivo := 'Ajuste por demanda';
        ELSE
            v_motivo := 'Descuento aplicado';
        END IF;

        -- 1. guardar en historial para auditoria
        INSERT INTO historial_precios_boleto (boleto_id, precio_anterior, precio_nuevo, motivo)
        VALUES (NEW.boleto_id, OLD.precio, NEW.precio, v_motivo);

        -- 2. recalcular ingreso proyectado del vuelo
        -- solo contamos boletos activos o usados, no los cancelados o reembolsados
        SELECT COALESCE(SUM(b.precio), 0) INTO v_ingreso_total
        FROM boleto b
        WHERE b.numero_vuelo = NEW.numero_vuelo
          AND b.estado_boleto IN ('activo', 'usado');

        -- actualizar o insertar en tabla de reportes (UPSERT)
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
-- TRIGGER 5: AJUSTAR PRECIOS POR OCUPACIÓN
-- ========================================

-- cuando se compra un boleto, checamos si la ocupacion del vuelo ya supero el 80%
-- si es asi, subimos automaticamente los precios de los boletos que quedan en un 20%
CREATE OR REPLACE FUNCTION fn_ajustar_precios_por_ocupacion()
RETURNS TRIGGER AS $$
DECLARE
    v_ocupacion NUMERIC;
    v_numero_vuelo VARCHAR(10);
    v_boletos_actualizados INT;
BEGIN
    -- obtener numero de vuelo del boleto que se acaba de comprar
    SELECT numero_vuelo INTO v_numero_vuelo
    FROM boleto
    WHERE boleto_id = NEW.boleto_id;

    -- calcular ocupacion actual usando la funcion que ya existe en la base de datos
    -- esta funcion ya cuenta los boletos vendidos y los compara con la capacidad del avion
    v_ocupacion := calcular_ocupacion_vuelo(v_numero_vuelo);

    -- si ocupacion supera el 80%, incrementar precios de boletos restantes en 20%
    IF v_ocupacion > 80 THEN

        -- actualizar precios de boletos activos que aun no han sido comprados
        UPDATE boleto
        SET precio = precio * 1.20
        WHERE numero_vuelo = v_numero_vuelo
          AND estado_boleto = 'activo'
          AND boleto_id NOT IN (SELECT boleto_id FROM comprar);

        -- contar cuantos boletos se actualizaron
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

