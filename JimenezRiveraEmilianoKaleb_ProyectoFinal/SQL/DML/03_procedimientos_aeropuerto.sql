-- ========================================
-- PROCEDIMIENTOS - SISTEMA DE AEROLÍNEAS
-- ========================================

-- ========================================
-- PROCEDIMIENTOS EXISTENTES 
-- ========================================

--
-- Procedimiento: registrar_nuevo_vuelo
-- Descripción: Registra un nuevo vuelo validando todas las reglas de negocio
-- Parámetros IN:
--   p_numero_vuelo VARCHAR - Código único del vuelo
--   p_tipo_vuelo_id INTEGER - Tipo de vuelo
--   p_matricula_avion VARCHAR - Matrícula del avión asignado
--   p_aeropuerto_salida_id INTEGER - ID del aeropuerto de origen
--   p_aeropuerto_llegada_id INTEGER - ID del aeropuerto de destino
--   p_fecha_salida DATE - Fecha de salida
--   p_hora_salida TIME - Hora de salida
--   p_fecha_llegada DATE - Fecha de llegada
--   p_hora_llegada TIME - Hora de llegada
--   p_duracion_minutos INTEGER - Duración estimada en minutos
-- Parámetros OUT:
--   p_numero_vuelo_creado VARCHAR - Número del vuelo creado
--   p_mensaje TEXT - Mensaje de resultado
-- Tablas involucradas: vuelo, aeropuerto, avion
--

CREATE OR REPLACE PROCEDURE registrar_nuevo_vuelo(
    p_numero_vuelo VARCHAR,
    p_tipo_vuelo_id INTEGER,
    p_matricula_avion VARCHAR,
    p_aeropuerto_salida_id INTEGER,
    p_aeropuerto_llegada_id INTEGER,
    p_fecha_salida DATE,
    p_hora_salida TIME,
    p_fecha_llegada DATE,
    p_hora_llegada TIME,
    p_duracion_minutos INTEGER,
    OUT p_numero_vuelo_creado VARCHAR,
    OUT p_mensaje TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_existe_vuelo INTEGER;
    v_avion_disponible BOOLEAN;
BEGIN
    -- Aeropuertos de origen y destino diferentes
    IF p_aeropuerto_salida_id = p_aeropuerto_llegada_id THEN
        p_mensaje := 'ERROR: El aeropuerto de salida y llegada deben ser diferentes';
        RETURN;
    END IF;

    -- Fecha y hora de llegada posterior a salida
    IF (p_fecha_llegada < p_fecha_salida) OR
       (p_fecha_llegada = p_fecha_salida AND p_hora_llegada <= p_hora_salida) THEN
        p_mensaje := 'ERROR: La fecha/hora de llegada debe ser posterior a la salida';
        RETURN;
    END IF;

    -- Verificar que no exista otro vuelo con el mismo número
    SELECT COUNT(*) INTO v_existe_vuelo
    FROM vuelo
    WHERE numero_vuelo = p_numero_vuelo;

    IF v_existe_vuelo > 0 THEN
        p_mensaje := 'ERROR: Ya existe un vuelo con ese número';
        RETURN;
    END IF;

    -- Verificar disponibilidad del avión en ese horario
    SELECT NOT EXISTS (
        SELECT 1 FROM vuelo
        WHERE matricula_avion = p_matricula_avion
        AND (
            (p_fecha_salida BETWEEN fecha_salida AND fecha_llegada)
            OR (p_fecha_llegada BETWEEN fecha_salida AND fecha_llegada)
            OR (fecha_salida BETWEEN p_fecha_salida AND p_fecha_llegada)
        )
    ) INTO v_avion_disponible;

    IF NOT v_avion_disponible THEN
        p_mensaje := 'ERROR: El avión no está disponible en ese horario';
        RETURN;
    END IF;

    -- Insertar el nuevo vuelo (sin campos redundantes de ciudad/país eliminados en 3NF)
    INSERT INTO vuelo (
        numero_vuelo, tipo_vuelo_id, estado_vuelo,
        fecha_salida, hora_salida,
        fecha_llegada, hora_llegada,
        matricula_avion, aeropuerto_salida_id, aeropuerto_llegada_id,
        duracion_minutos
    ) VALUES (
        p_numero_vuelo, p_tipo_vuelo_id, 'programado',
        p_fecha_salida, p_hora_salida,
        p_fecha_llegada, p_hora_llegada,
        p_matricula_avion, p_aeropuerto_salida_id, p_aeropuerto_llegada_id,
        p_duracion_minutos
    );

    p_numero_vuelo_creado := p_numero_vuelo;
    p_mensaje := 'Vuelo registrado exitosamente con número: ' || p_numero_vuelo;

    RAISE NOTICE '%', p_mensaje;
END;
$$;

COMMENT ON PROCEDURE registrar_nuevo_vuelo IS
'Registra un nuevo vuelo validando reglas de negocio: aeropuertos diferentes, fechas válidas, número único y disponibilidad de avión.';


--
-- Procedimiento: actualizar_estados_vuelos
-- Descripción: Actualiza automáticamente los estados de los vuelos según fecha/hora actual
--              y boletos vendidos. Recorre todos los vuelos no finalizados.
-- Parámetros: Ninguno
-- Tablas involucradas: vuelo, avion, boleto, comprar
--

CREATE OR REPLACE PROCEDURE actualizar_estados_vuelos()
LANGUAGE plpgsql
AS $$
DECLARE
    v_vuelo RECORD;
    v_boletos_vendidos INTEGER;
    v_capacidad INTEGER;
    v_vuelos_actualizados INTEGER := 0;
    v_fecha_hora_salida TIMESTAMP;
    v_fecha_hora_llegada TIMESTAMP;
BEGIN
    -- Recorrer todos los vuelos que no estén en estado final
    FOR v_vuelo IN
        SELECT * FROM vuelo
        WHERE estado_vuelo NOT IN ('aterrizado', 'cancelado')
    LOOP
        -- Construir timestamps para comparación
        v_fecha_hora_salida := v_vuelo.fecha_salida + v_vuelo.hora_salida;
        v_fecha_hora_llegada := v_vuelo.fecha_llegada + v_vuelo.hora_llegada;

        -- Obtener capacidad del avión
        SELECT capacidad_pasajeros INTO v_capacidad
        FROM avion
        WHERE matricula_avion = v_vuelo.matricula_avion;

        -- Contar boletos vendidos
        SELECT COUNT(*) INTO v_boletos_vendidos
        FROM boleto b
        INNER JOIN comprar c ON b.boleto_id = c.boleto_id
        WHERE b.numero_vuelo = v_vuelo.numero_vuelo;

        -- Aplicar lógica de actualización de estados

        -- Si ya pasó la hora de llegada -> aterrizado
        IF v_fecha_hora_llegada < NOW() THEN
            UPDATE vuelo SET estado_vuelo = 'aterrizado'
            WHERE numero_vuelo = v_vuelo.numero_vuelo;
            v_vuelos_actualizados := v_vuelos_actualizados + 1;

        -- Si ya pasó la hora de salida pero no la de llegada -> en_vuelo
        ELSIF v_fecha_hora_salida < NOW() AND v_fecha_hora_llegada > NOW() THEN
            UPDATE vuelo SET estado_vuelo = 'en_vuelo'
            WHERE numero_vuelo = v_vuelo.numero_vuelo;
            v_vuelos_actualizados := v_vuelos_actualizados + 1;

        -- Si faltan menos de 2 horas para salida -> abordando
        ELSIF v_fecha_hora_salida - INTERVAL '2 hours' < NOW()
              AND v_fecha_hora_salida > NOW() THEN
            UPDATE vuelo SET estado_vuelo = 'abordando'
            WHERE numero_vuelo = v_vuelo.numero_vuelo;
            v_vuelos_actualizados := v_vuelos_actualizados + 1;

        -- Si está lleno -> actualizar solo si aún está en programado
        ELSIF v_boletos_vendidos >= v_capacidad
              AND v_vuelo.estado_vuelo = 'programado' THEN
            UPDATE vuelo SET estado_vuelo = 'programado'
            WHERE numero_vuelo = v_vuelo.numero_vuelo;
            v_vuelos_actualizados := v_vuelos_actualizados + 1;
        END IF;
    END LOOP;

    RAISE NOTICE 'Se actualizaron % vuelos', v_vuelos_actualizados;
END;
$$;

COMMENT ON PROCEDURE actualizar_estados_vuelos IS
'Actualiza automáticamente el estado de los vuelos basándose en fechas, horarios y capacidad.';


--
-- Procedimiento: procesar_compra_boleto
-- Descripción: Procesa la venta de un boleto con todas las validaciones de negocio
--              y manejo de transacciones
-- Parámetros IN:
--   p_cliente_id INTEGER - ID del cliente que compra
--   p_numero_vuelo VARCHAR - Número del vuelo
--   p_numero_asiento VARCHAR - Asiento seleccionado
--   p_clase VARCHAR - Clase del boleto (económica, ejecutiva, primera)
--   p_precio NUMERIC - Precio del boleto
-- Parámetros OUT:
--   p_boleto_id_creado INTEGER - ID del boleto creado
--   p_codigo_exito INTEGER - 0 = error, 1 = éxito
--   p_mensaje TEXT - Mensaje descriptivo del resultado
-- Tablas involucradas: boleto, comprar, vuelo, avion
--

CREATE OR REPLACE PROCEDURE procesar_compra_boleto(
    p_cliente_id INTEGER,
    p_numero_vuelo VARCHAR,
    p_numero_asiento VARCHAR,
    p_clase VARCHAR,
    p_precio NUMERIC,
    OUT p_boleto_id_creado INTEGER,
    OUT p_codigo_exito INTEGER,
    OUT p_mensaje TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_capacidad INTEGER;
    v_boletos_actuales INTEGER;
    v_asiento_ocupado BOOLEAN;
    v_estado_vuelo VARCHAR;
    v_max_boleto_id INTEGER;
BEGIN
    -- Inicializar código de éxito
    p_codigo_exito := 0;

    -- Verificar que el vuelo existe y obtener estado
    SELECT estado_vuelo INTO v_estado_vuelo
    FROM vuelo
    WHERE numero_vuelo = p_numero_vuelo;

    IF v_estado_vuelo IS NULL THEN
        p_mensaje := 'ERROR: El vuelo especificado no existe';
        RETURN;
    END IF;

    -- Verificar que el vuelo acepta reservas
    IF v_estado_vuelo IN ('aterrizado', 'cancelado', 'en_vuelo') THEN
        p_mensaje := 'ERROR: El vuelo no acepta reservas (Estado: ' || v_estado_vuelo || ')';
        RETURN;
    END IF;

    -- Verificar disponibilidad de capacidad
    SELECT av.capacidad_pasajeros INTO v_capacidad
    FROM vuelo v
    INNER JOIN avion av ON v.matricula_avion = av.matricula_avion
    WHERE v.numero_vuelo = p_numero_vuelo;

    SELECT COUNT(*) INTO v_boletos_actuales
    FROM boleto b
    INNER JOIN comprar c ON b.boleto_id = c.boleto_id
    WHERE b.numero_vuelo = p_numero_vuelo;

    IF v_boletos_actuales >= v_capacidad THEN
        p_mensaje := 'ERROR: El vuelo está lleno (Capacidad: ' || v_capacidad || ')';
        RETURN;
    END IF;

    -- Verificar que el asiento no esté ocupado
    SELECT NOT verificar_asiento_disponible(p_numero_vuelo, p_numero_asiento)
    INTO v_asiento_ocupado;

    IF v_asiento_ocupado THEN
        p_mensaje := 'ERROR: El asiento ' || p_numero_asiento || ' ya está ocupado';
        RETURN;
    END IF;

    -- Iniciar transacción y procesar compra
    BEGIN
        -- Obtener el siguiente ID de boleto
        SELECT COALESCE(MAX(boleto_id), 0) + 1 INTO v_max_boleto_id
        FROM boleto;

        -- Insertar el boleto
        INSERT INTO boleto (
            boleto_id, numero_asiento, clase, precio, numero_vuelo
        ) VALUES (
            v_max_boleto_id, p_numero_asiento, p_clase, p_precio, p_numero_vuelo
        );

        -- Registrar la compra
        INSERT INTO comprar (
            cliente_id, boleto_id, fecha_compra
        ) VALUES (
            p_cliente_id, v_max_boleto_id, CURRENT_DATE
        );

        p_boleto_id_creado := v_max_boleto_id;
        p_codigo_exito := 1;
        p_mensaje := 'Boleto creado exitosamente. ID: ' || p_boleto_id_creado;

    EXCEPTION
        WHEN OTHERS THEN
            p_codigo_exito := 0;
            p_mensaje := 'ERROR en transacción: ' || SQLERRM;
            RAISE NOTICE 'Error al procesar boleto: %', SQLERRM;
    END;
END;
$$;

COMMENT ON PROCEDURE procesar_compra_boleto IS
'Procesa la compra de un boleto validando: vuelo existente, estado válido, capacidad disponible y asiento libre. Usa transacciones.';


--
-- Procedimiento: generar_reporte_ocupacion_mensual
-- Descripción: Genera un reporte estadístico de ocupación de vuelos por mes
--              creando registros en una tabla de reportes
-- Parámetros IN:
--   p_mes INTEGER - Mes a analizar (1-12)
--   p_anio INTEGER - Año a analizar
-- Tablas involucradas: vuelo, reporte_ocupacion (se crea si no existe)
--

CREATE OR REPLACE PROCEDURE generar_reporte_ocupacion_mensual(
    p_mes INTEGER,
    p_anio INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_vuelo RECORD;
    v_total_vuelos INTEGER := 0;
    v_ocupacion_promedio NUMERIC := 0;
    v_ingresos_totales NUMERIC := 0;
BEGIN
    CREATE TABLE IF NOT EXISTS reporte_ocupacion (
        id_reporte SERIAL PRIMARY KEY,
        mes INTEGER NOT NULL,
        anio INTEGER NOT NULL,
        numero_vuelo VARCHAR(10),
        ocupacion_porcentaje NUMERIC(5,2),
        ingresos NUMERIC(12,2),
        fecha_generacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    -- Eliminar reportes previos del mismo período
    DELETE FROM reporte_ocupacion
    WHERE mes = p_mes AND anio = p_anio;

    -- Procesar cada vuelo del mes especificado
    FOR v_vuelo IN
        SELECT numero_vuelo, fecha_salida
        FROM vuelo
        WHERE EXTRACT(MONTH FROM fecha_salida) = p_mes
        AND EXTRACT(YEAR FROM fecha_salida) = p_anio
    LOOP
        -- Insertar registro en el reporte usando las funciones creadas
        INSERT INTO reporte_ocupacion (
            mes, anio, numero_vuelo,
            ocupacion_porcentaje, ingresos
        ) VALUES (
            p_mes, p_anio, v_vuelo.numero_vuelo,
            calcular_ocupacion_vuelo(v_vuelo.numero_vuelo),
            obtener_ingresos_vuelo(v_vuelo.numero_vuelo)
        );

        v_total_vuelos := v_total_vuelos + 1;
    END LOOP;

    -- Calcular totales del reporte
    SELECT
        COALESCE(AVG(ocupacion_porcentaje), 0),
        COALESCE(SUM(ingresos), 0)
    INTO v_ocupacion_promedio, v_ingresos_totales
    FROM reporte_ocupacion
    WHERE mes = p_mes AND anio = p_anio;

    -- Mostrar resumen
    RAISE NOTICE 'Reporte generado para %/%', p_mes, p_anio;
    RAISE NOTICE 'Total de vuelos: %', v_total_vuelos;
    RAISE NOTICE 'Ocupación promedio: %%%', ROUND(v_ocupacion_promedio, 2);
    RAISE NOTICE 'Ingresos totales: $%', v_ingresos_totales;
END;
$$;

COMMENT ON PROCEDURE generar_reporte_ocupacion_mensual IS
'Genera un reporte estadístico de ocupación e ingresos de vuelos para un mes específico.';


--
-- Procedimiento: cancelar_vuelo_con_reembolso
-- Descripción: Cancela un vuelo y procesa reembolsos para todos los boletos vendidos
--              NOTA: Los triggers tg_validar_cancelacion_vuelo y tg_procesar_cancelacion_vuelo
--              ya manejan automáticamente las validaciones y reembolsos.
--              Este procedimiento provee una interfaz adicional para cancelaciones manuales.
-- Parámetros IN:
--   p_numero_vuelo VARCHAR - Número del vuelo a cancelar
--   p_motivo TEXT - Motivo de la cancelación
-- Parámetros OUT:
--   p_boletos_reembolsados INTEGER - Cantidad de boletos reembolsados
-- Tablas involucradas: vuelo, boleto, comprar, creditos, notificaciones_pendientes
--

CREATE OR REPLACE PROCEDURE cancelar_vuelo_con_reembolso(
    p_numero_vuelo VARCHAR,
    p_motivo TEXT,
    OUT p_boletos_reembolsados INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_estado_actual VARCHAR;
BEGIN
    p_boletos_reembolsados := 0;

    -- Verificar estado del vuelo
    SELECT estado_vuelo INTO v_estado_actual
    FROM vuelo
    WHERE numero_vuelo = p_numero_vuelo;

    IF v_estado_actual IS NULL THEN
        RAISE EXCEPTION 'El vuelo % no existe', p_numero_vuelo;
    END IF;

    -- Contar boletos antes de cancelar
    SELECT COUNT(*) INTO p_boletos_reembolsados
    FROM boleto b
    INNER JOIN comprar c ON b.boleto_id = c.boleto_id
    WHERE b.numero_vuelo = p_numero_vuelo;

    -- Actualizar estado del vuelo a cancelado
    -- Los triggers fn_validar_cancelacion_vuelo y fn_procesar_cancelacion_vuelo
    -- se encargan automáticamente de validar y procesar reembolsos/compensaciones
    UPDATE vuelo
    SET estado_vuelo = 'cancelado'
    WHERE numero_vuelo = p_numero_vuelo;

    RAISE NOTICE 'Vuelo % cancelado. Motivo: %', p_numero_vuelo, p_motivo;
    RAISE NOTICE 'Boletos reembolsados: %', p_boletos_reembolsados;
    RAISE NOTICE 'Los triggers procesaron automáticamente reembolsos y compensaciones';
END;
$$;

COMMENT ON PROCEDURE cancelar_vuelo_con_reembolso IS
'Cancela un vuelo. Los triggers procesan automáticamente reembolsos y compensaciones.';


--
-- Procedimiento: registrar_mantenimiento_avion
-- Descripción: Registra un mantenimiento programado para un avión y verifica
--              vuelos afectados en ese período
-- Parámetros IN:
--   p_matricula_avion VARCHAR - Matrícula del avión
--   p_tipo_mantenimiento VARCHAR - Tipo: PREVENTIVO, CORRECTIVO, EMERGENCIA
--   p_descripcion TEXT - Descripción detallada del mantenimiento
--   p_fecha_inicio DATE - Fecha de inicio del mantenimiento
--   p_fecha_fin_estimada DATE - Fecha estimada de finalización
-- Tablas involucradas: avion, vuelo, mantenimiento_avion (se crea si no existe)
--

CREATE OR REPLACE PROCEDURE registrar_mantenimiento_avion(
    p_matricula_avion VARCHAR,
    p_tipo_mantenimiento VARCHAR,
    p_descripcion TEXT,
    p_fecha_inicio DATE,
    p_fecha_fin_estimada DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_vuelos_afectados INTEGER;
    v_vuelo RECORD;
BEGIN
    -- Crear tabla de mantenimiento si no existe
    CREATE TABLE IF NOT EXISTS mantenimiento_avion (
        id_mantenimiento SERIAL PRIMARY KEY,
        matricula_avion VARCHAR(20) NOT NULL,
        tipo_mantenimiento VARCHAR(50) NOT NULL,
        descripcion TEXT,
        fecha_inicio DATE NOT NULL,
        fecha_fin_estimada DATE,
        fecha_fin_real DATE,
        estado VARCHAR(20) DEFAULT 'EN_PROCESO',
        CONSTRAINT chk_tipo_mantenimiento CHECK (tipo_mantenimiento IN ('PREVENTIVO', 'CORRECTIVO', 'EMERGENCIA')),
        CONSTRAINT chk_estado_mantenimiento CHECK (estado IN ('EN_PROCESO', 'COMPLETADO', 'CANCELADO'))
    );

    -- Contar vuelos programados durante el mantenimiento
    SELECT COUNT(*) INTO v_vuelos_afectados
    FROM vuelo
    WHERE matricula_avion = p_matricula_avion
    AND estado_vuelo IN ('programado', 'abordando')
    AND (
        (fecha_salida BETWEEN p_fecha_inicio AND p_fecha_fin_estimada)
        OR (fecha_llegada BETWEEN p_fecha_inicio AND p_fecha_fin_estimada)
    );

    -- Advertir sobre vuelos afectados
    IF v_vuelos_afectados > 0 THEN
        RAISE NOTICE 'ADVERTENCIA: % vuelos programados serán afectados', v_vuelos_afectados;

        -- Mostrar detalle de vuelos afectados
        FOR v_vuelo IN
            SELECT v.numero_vuelo, v.fecha_salida,
                   ae_salida.nombre AS aeropuerto_salida,
                   ae_llegada.nombre AS aeropuerto_llegada
            FROM vuelo v
            INNER JOIN aeropuerto ae_salida ON v.aeropuerto_salida_id = ae_salida.aeropuerto_id
            INNER JOIN aeropuerto ae_llegada ON v.aeropuerto_llegada_id = ae_llegada.aeropuerto_id
            WHERE v.matricula_avion = p_matricula_avion
            AND v.estado_vuelo IN ('programado', 'abordando')
            AND (
                (v.fecha_salida BETWEEN p_fecha_inicio AND p_fecha_fin_estimada)
                OR (v.fecha_llegada BETWEEN p_fecha_inicio AND p_fecha_fin_estimada)
            )
        LOOP
            RAISE NOTICE 'Vuelo afectado: % (% → %) el %',
                v_vuelo.numero_vuelo,
                v_vuelo.aeropuerto_salida,
                v_vuelo.aeropuerto_llegada,
                v_vuelo.fecha_salida;
        END LOOP;

        -- Actualizar estado de vuelos afectados
        UPDATE vuelo
        SET estado_vuelo = 'retrasado'
        WHERE matricula_avion = p_matricula_avion
        AND estado_vuelo IN ('programado', 'abordando')
        AND (
            (fecha_salida BETWEEN p_fecha_inicio AND p_fecha_fin_estimada)
            OR (fecha_llegada BETWEEN p_fecha_inicio AND p_fecha_fin_estimada)
        );
    END IF;

    -- Registrar el mantenimiento
    INSERT INTO mantenimiento_avion (
        matricula_avion, tipo_mantenimiento, descripcion,
        fecha_inicio, fecha_fin_estimada
    ) VALUES (
        p_matricula_avion, p_tipo_mantenimiento, p_descripcion,
        p_fecha_inicio, p_fecha_fin_estimada
    );

    -- Actualizar fecha de último mantenimiento del avión
    UPDATE avion
    SET fecha_ultimo_mantenimiento = p_fecha_inicio
    WHERE matricula_avion = p_matricula_avion;

    RAISE NOTICE 'Mantenimiento registrado para avión %', p_matricula_avion;
    RAISE NOTICE 'Tipo: % | Período: % al %',
        p_tipo_mantenimiento, p_fecha_inicio, p_fecha_fin_estimada;
END;
$$;

COMMENT ON PROCEDURE registrar_mantenimiento_avion IS
'Registra un mantenimiento de avión y actualiza el estado de vuelos afectados durante ese período.';


-- ========================================
-- PROCEDIMIENTOS (las que no estaban en las
-- practicas anteriores :D)
-- ========================================

--
-- Procedimiento: asignar_piloto_vuelo
-- Descripción: Asigna un piloto a un vuelo verificando certificaciones y disponibilidad
-- Parámetros IN:
--   p_piloto_id INTEGER - ID del piloto a asignar
--   p_numero_vuelo VARCHAR - Número del vuelo
-- Parámetros OUT:
--   p_exito BOOLEAN - TRUE si se asignó exitosamente
--   p_mensaje TEXT - Mensaje descriptivo del resultado
-- Tablas involucradas: piloto_vuelo, piloto, vuelo, avion, certificacion_tipo_aeronave
--

CREATE OR REPLACE PROCEDURE asignar_piloto_vuelo(
    p_piloto_id INTEGER,
    p_numero_vuelo VARCHAR,
    OUT p_exito BOOLEAN,
    OUT p_mensaje TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_matricula_avion VARCHAR;
    v_piloto_calificado BOOLEAN;
    v_ya_asignado INTEGER;
BEGIN
    p_exito := FALSE;

    -- Obtener matrícula del avión asignado al vuelo
    SELECT matricula_avion INTO v_matricula_avion
    FROM vuelo
    WHERE numero_vuelo = p_numero_vuelo;

    IF v_matricula_avion IS NULL THEN
        p_mensaje := 'ERROR: El vuelo no existe o no tiene avión asignado';
        RETURN;
    END IF;

    -- Verificar que el piloto esté calificado para ese tipo de avión
    v_piloto_calificado := verificar_piloto_calificado(p_piloto_id, v_matricula_avion);

    IF NOT v_piloto_calificado THEN
        p_mensaje := 'ERROR: El piloto no tiene certificación para este tipo de avión';
        RETURN;
    END IF;

    -- Verificar que el piloto no esté ya asignado a este vuelo
    SELECT COUNT(*) INTO v_ya_asignado
    FROM piloto_vuelo
    WHERE piloto_id = p_piloto_id
    AND numero_vuelo = p_numero_vuelo;

    IF v_ya_asignado > 0 THEN
        p_mensaje := 'ERROR: El piloto ya está asignado a este vuelo';
        RETURN;
    END IF;

    -- Asignar el piloto al vuelo
    INSERT INTO piloto_vuelo (piloto_id, numero_vuelo)
    VALUES (p_piloto_id, p_numero_vuelo);

    p_exito := TRUE;
    p_mensaje := 'Piloto asignado exitosamente al vuelo ' || p_numero_vuelo;
    RAISE NOTICE '%', p_mensaje;
END;
$$;

COMMENT ON PROCEDURE asignar_piloto_vuelo IS
'Asigna un piloto a un vuelo verificando certificación, disponibilidad y evitando duplicados.';


--
-- Procedimiento: contratar_empleado_aerolinea
-- Descripción: Registra la contratación de un empleado por una aerolínea
-- Parámetros IN:
--   p_aerolinea_id INTEGER - ID de la aerolínea
--   p_empleado_id INTEGER - ID del empleado
--   p_fecha_ingreso DATE - Fecha de inicio del contrato
--   p_puesto VARCHAR - Puesto del empleado en la aerolínea
-- Parámetros OUT:
--   p_exito BOOLEAN - TRUE si se registró exitosamente
--   p_mensaje TEXT - Mensaje descriptivo del resultado
-- Tablas involucradas: contratar_aerolinea, empleado, aerolineas
--

CREATE OR REPLACE PROCEDURE contratar_empleado_aerolinea(
    p_aerolinea_id INTEGER,
    p_empleado_id INTEGER,
    p_fecha_ingreso DATE,
    OUT p_exito BOOLEAN,
    OUT p_mensaje TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_contrato_activo INTEGER;
BEGIN
    p_exito := FALSE;

    -- Verificar que no tenga un contrato activo con la misma aerolínea
    SELECT COUNT(*) INTO v_contrato_activo
    FROM contratar_aerolinea
    WHERE aerolinea_id = p_aerolinea_id
    AND empleado_id = p_empleado_id
    AND fecha_egreso IS NULL;

    IF v_contrato_activo > 0 THEN
        p_mensaje := 'ERROR: El empleado ya tiene un contrato activo con esta aerolínea';
        RETURN;
    END IF;

    -- Registrar la contratación
    INSERT INTO contratar_aerolinea (
        aerolinea_id, empleado_id, fecha_ingreso
    ) VALUES (
        p_aerolinea_id, p_empleado_id, p_fecha_ingreso
    );

    p_exito := TRUE;
    p_mensaje := 'Empleado contratado exitosamente por la aerolínea';
    RAISE NOTICE '%', p_mensaje;
END;
$$;

COMMENT ON PROCEDURE contratar_empleado_aerolinea IS
'Registra la contratación de un empleado por una aerolínea, evitando contratos duplicados activos.';


--
-- Procedimiento: contratar_empleado_aeropuerto
-- Descripción: Registra la contratación de un empleado por un aeropuerto
-- Parámetros IN:
--   p_aeropuerto_id INTEGER - ID del aeropuerto
--   p_empleado_id INTEGER - ID del empleado
--   p_fecha_ingreso DATE - Fecha de inicio del contrato
-- Parámetros OUT:
--   p_exito BOOLEAN - TRUE si se registró exitosamente
--   p_mensaje TEXT - Mensaje descriptivo del resultado
-- Tablas involucradas: contratar_aeropuerto, empleado, aeropuerto
--

CREATE OR REPLACE PROCEDURE contratar_empleado_aeropuerto(
    p_aeropuerto_id INTEGER,
    p_empleado_id INTEGER,
    p_fecha_ingreso DATE,
    OUT p_exito BOOLEAN,
    OUT p_mensaje TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_contrato_activo INTEGER;
BEGIN
    p_exito := FALSE;

    -- Verificar que no tenga un contrato activo con el mismo aeropuerto
    SELECT COUNT(*) INTO v_contrato_activo
    FROM contratar_aeropuerto
    WHERE aeropuerto_id = p_aeropuerto_id
    AND empleado_id = p_empleado_id
    AND fecha_egreso IS NULL;

    IF v_contrato_activo > 0 THEN
        p_mensaje := 'ERROR: El empleado ya tiene un contrato activo con este aeropuerto';
        RETURN;
    END IF;

    -- Registrar la contratación
    INSERT INTO contratar_aeropuerto (
        aeropuerto_id, empleado_id, fecha_ingreso
    ) VALUES (
        p_aeropuerto_id, p_empleado_id, p_fecha_ingreso
    );

    p_exito := TRUE;
    p_mensaje := 'Empleado contratado exitosamente por el aeropuerto';
    RAISE NOTICE '%', p_mensaje;
END;
$$;

COMMENT ON PROCEDURE contratar_empleado_aeropuerto IS
'Registra la contratación de un empleado por un aeropuerto, evitando contratos duplicados activos.';


--
-- Procedimiento: generar_boletos_vuelo
-- Descripción: Genera automáticamente todos los boletos para un vuelo según
--              la capacidad del avión asignado, con precio base calculado
-- Parámetros IN:
--   p_numero_vuelo VARCHAR - Número del vuelo
-- Parámetros OUT:
--   p_boletos_generados INTEGER - Cantidad de boletos generados
--   p_mensaje TEXT - Mensaje descriptivo del resultado
-- Tablas involucradas: boleto, vuelo, avion
--

CREATE OR REPLACE PROCEDURE generar_boletos_vuelo(
    p_numero_vuelo VARCHAR,
    OUT p_boletos_generados INTEGER,
    OUT p_mensaje TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_capacidad INTEGER;
    v_precio_base NUMERIC;
    v_precio_boleto NUMERIC;
    v_max_boleto_id INTEGER;
    v_asiento VARCHAR(10);
    v_clase VARCHAR(20);
    i INTEGER;
BEGIN
    p_boletos_generados := 0;

    -- Obtener capacidad del avión
    SELECT av.capacidad_pasajeros INTO v_capacidad
    FROM vuelo v
    INNER JOIN avion av ON v.matricula_avion = av.matricula_avion
    WHERE v.numero_vuelo = p_numero_vuelo;

    IF v_capacidad IS NULL THEN
        p_mensaje := 'ERROR: El vuelo no existe o no tiene avión asignado';
        RETURN;
    END IF;

    -- Calcular precio base usando la función
    v_precio_base := obtener_precio_base_boleto(p_numero_vuelo);

    -- Obtener el último ID de boleto
    SELECT COALESCE(MAX(boleto_id), 0) INTO v_max_boleto_id
    FROM boleto;

    -- Generar boletos según la capacidad
    FOR i IN 1..v_capacidad LOOP
        -- Generar número de asiento
        v_asiento := (i / 6 + 1)::TEXT || SUBSTRING('ABCDEF' FROM (i % 6 + 1) FOR 1);

        -- Asignar clase según ubicación
        IF i <= v_capacidad * 0.1 THEN
            v_clase := 'primera';
        ELSIF i <= v_capacidad * 0.3 THEN
            v_clase := 'ejecutiva';
        ELSE
            v_clase := 'economica';
        END IF;

        -- Calcular precio según clase (sin modificar v_precio_base)
        IF v_clase = 'primera' THEN
            v_precio_boleto := v_precio_base * 3;
        ELSIF v_clase = 'ejecutiva' THEN
            v_precio_boleto := v_precio_base * 1.5;
        ELSE
            v_precio_boleto := v_precio_base;
        END IF;

        -- Insertar el boleto
        INSERT INTO boleto (boleto_id, numero_asiento, clase, precio, numero_vuelo)
        VALUES (v_max_boleto_id + i, v_asiento, v_clase, v_precio_boleto, p_numero_vuelo);

        p_boletos_generados := p_boletos_generados + 1;
    END LOOP;

    p_mensaje := 'Se generaron ' || p_boletos_generados || ' boletos para el vuelo ' || p_numero_vuelo;
    RAISE NOTICE '%', p_mensaje;
END;
$$;

COMMENT ON PROCEDURE generar_boletos_vuelo IS
'Genera automáticamente todos los boletos para un vuelo según la capacidad del avión.';
















-- ========================================
-- PRUEBAS DE EJECUCIÓN DE PROCEDIMIENTOS
-- ========================================

DO $$
BEGIN
    RAISE NOTICE '=== PRUEBAS DE PROCEDIMIENTOS ===';
    RAISE NOTICE '';
END $$;


-- ========================================
-- procesar_compra_boleto
-- ========================================
DO $$
DECLARE
    v_boleto_id INTEGER;
    v_codigo_exito INTEGER;
    v_mensaje TEXT;
BEGIN
    RAISE NOTICE '--- Prueba procesar_compra_boleto ---';

    -- Comprar un boleto en un vuelo futuro
    CALL procesar_compra_boleto(
        66, -- Cliente ID
        'AM112', -- Vuelo
        '15C', -- Asiento
        'Economica', -- Clase
        800.00, -- Precio
        v_boleto_id,
        v_codigo_exito,
        v_mensaje
    );

    RAISE NOTICE 'Resultado: %', v_mensaje;
    RAISE NOTICE 'Código de éxito: %', v_codigo_exito;
    RAISE NOTICE 'Boleto ID generado: %', v_boleto_id;
    RAISE NOTICE '';
END $$;


-- ========================================
-- generar_reporte_ocupacion_mensual
-- ========================================
DO $$
BEGIN
    RAISE NOTICE '--- Prueba generar_reporte_ocupacion_mensual ---';

    -- Generar reporte de ocupación para enero 2025
    CALL generar_reporte_ocupacion_mensual(1, 2025);

    RAISE NOTICE 'Reporte generado para Enero 2025';
    RAISE NOTICE '';
END $$;


-- ========================================
-- registrar_nuevo_vuelo
-- ========================================
DO $$
DECLARE
    v_numero_vuelo_creado VARCHAR;
    v_mensaje TEXT;
BEGIN
    RAISE NOTICE '--- Prueba registrar_nuevo_vuelo ---';

    -- Registrar un nuevo vuelo de prueba
    CALL registrar_nuevo_vuelo(
        'TEST001', -- Número de vuelo
        1, -- Tipo vuelo (pasajeros)
        'XA-001', -- Avión
        1, -- Aeropuerto salida
        2, -- Aeropuerto llegada
        CURRENT_DATE + 30, -- Fecha salida (en 30 días)
        '10:00:00', -- Hora salida
        CURRENT_DATE + 30, -- Fecha llegada
        '12:00:00', -- Hora llegada
        120, -- Duración minutos
        v_numero_vuelo_creado,
        v_mensaje
    );

    RAISE NOTICE 'Resultado: %', v_mensaje;
    RAISE NOTICE 'Vuelo creado: %', v_numero_vuelo_creado;

    -- Limpiar el vuelo de prueba
    DELETE FROM reporte_ingresos_vuelo WHERE numero_vuelo = 'TEST001';
    DELETE FROM vuelo WHERE numero_vuelo = 'TEST001';
    RAISE NOTICE '';
END $$;


-- ========================================
-- asignar_piloto_vuelo
-- ========================================
DO $$
DECLARE
    v_exito BOOLEAN;
    v_mensaje TEXT;
BEGIN
    RAISE NOTICE '--- Prueba asignar_piloto_vuelo ---';

    -- Asignar piloto a vuelo CG101 (vuelo de carga sin piloto asignado aún)
    CALL asignar_piloto_vuelo(10, 'CG101', v_exito, v_mensaje);

    RAISE NOTICE 'Resultado: %', v_mensaje;
    RAISE NOTICE 'Éxito: %', v_exito;
    RAISE NOTICE '';
END $$;


-- ========================================
-- contratar_empleado_aerolinea
-- ========================================
DO $$
DECLARE
    v_exito BOOLEAN;
    v_mensaje TEXT;
BEGIN
    RAISE NOTICE '--- Prueba contratar_empleado_aerolinea ---';

    -- Intentar contratar empleado 3 en aerolínea 5
    CALL contratar_empleado_aerolinea(5, 3, CURRENT_DATE, v_exito, v_mensaje);

    RAISE NOTICE 'Resultado: %', v_mensaje;
    RAISE NOTICE 'Éxito: %', v_exito;

    -- Si se contrató, limpiar
    IF v_exito THEN
        DELETE FROM contratar_aerolinea WHERE aerolinea_id = 5 AND empleado_id = 3 AND fecha_egreso IS NULL;
    END IF;

    RAISE NOTICE '';
END $$;


-- ========================================
-- contratar_empleado_aeropuerto
-- ========================================
DO $$
DECLARE
    v_exito BOOLEAN;
    v_mensaje TEXT;
BEGIN
    RAISE NOTICE '--- Prueba contratar_empleado_aeropuerto ---';

    -- Contratar empleado 15 en aeropuerto 2
    CALL contratar_empleado_aeropuerto(2, 15, CURRENT_DATE, v_exito, v_mensaje);

    RAISE NOTICE 'Resultado: %', v_mensaje;
    RAISE NOTICE 'Éxito: %', v_exito;

    -- Si se contrató, limpiar
    IF v_exito THEN
        DELETE FROM contratar_aeropuerto WHERE aeropuerto_id = 2 AND empleado_id = 15 AND fecha_egreso IS NULL;
    END IF;

    RAISE NOTICE '';
END $$;












-- ========================================
-- cancelar_vuelo_con_reembolso
-- ========================================
DO $$
DECLARE
    v_test_vuelo VARCHAR := 'TESTCANCEL';
    v_numero_creado VARCHAR;
    v_msg_temp TEXT;
    v_boleto_id INTEGER;
    v_codigo_exito INTEGER;
    v_boletos_reembolsados INTEGER;
BEGIN
    RAISE NOTICE '--- Prueba cancelar_vuelo_con_reembolso ---';

    -- Crear vuelo de prueba
    CALL registrar_nuevo_vuelo(
        v_test_vuelo,
        1,
        'XA-001',
        1,
        2,
        CURRENT_DATE + 15,
        '10:00:00',
        CURRENT_DATE + 15,
        '12:00:00',
        120,
        v_numero_creado,
        v_msg_temp
    );

    -- Crear un boleto para ese vuelo
    CALL procesar_compra_boleto(
        70,
        v_test_vuelo,
        '1A',
        'Primera',
        1500.00,
        v_boleto_id,
        v_codigo_exito,
        v_msg_temp
    );

    -- Cancelar el vuelo
    CALL cancelar_vuelo_con_reembolso(v_test_vuelo, 'Cancelación de vuelo de prueba', v_boletos_reembolsados);

    RAISE NOTICE 'Vuelo cancelado exitosamente';
    RAISE NOTICE 'Boletos reembolsados: %', v_boletos_reembolsados;

    -- Limpiar datos de prueba (orden correcto para evitar violaciones de FK)
    DELETE FROM comprar WHERE boleto_id IN (
        SELECT boleto_id FROM boleto WHERE numero_vuelo = v_test_vuelo
    );
    DELETE FROM creditos WHERE cliente_id = 70 AND origen = 'cancelacion_vuelo';
    DELETE FROM reporte_ingresos_vuelo WHERE numero_vuelo = v_test_vuelo;
    DELETE FROM vuelo WHERE numero_vuelo = v_test_vuelo;

    RAISE NOTICE '';
END $$;


-- ========================================
-- actualizar_estados_vuelos
-- ========================================
DO $$
BEGIN
    RAISE NOTICE '--- Prueba actualizar_estados_vuelos ---';

    -- Actualizar estados de vuelos según fecha/hora actual
    CALL actualizar_estados_vuelos();

    RAISE NOTICE 'Estados de vuelos actualizados según fecha/hora actual';
    RAISE NOTICE '';
END $$;










-- ========================================
-- registrar_mantenimiento_avion
-- ========================================
DO $$
BEGIN
    RAISE NOTICE '--- Prueba registrar_mantenimiento_avion ---';

    -- Registrar mantenimiento para avión XA-001
    -- Parámetros: matricula, tipo_mantenimiento, descripcion, fecha_inicio, fecha_fin_estimada
    CALL registrar_mantenimiento_avion(
        'XA-001',
        'PREVENTIVO',
        'Revisión general de motores y sistemas hidráulicos',
        CURRENT_DATE,
        CURRENT_DATE + 15
    );

    RAISE NOTICE 'Mantenimiento registrado exitosamente para avión XA-001';
    RAISE NOTICE 'Los vuelos programados con este avión fueron cancelados/reasignados automáticamente';
    RAISE NOTICE '';
END $$;












-- ========================================
-- generar_boletos_vuelo
-- ========================================
DO $$
DECLARE
    v_boletos_generados INTEGER;
    v_mensaje TEXT;
    v_test_vuelo VARCHAR := 'TESTBOL';
    v_numero_creado VARCHAR;
    v_msg_temp TEXT;
BEGIN
    RAISE NOTICE '--- Prueba generar_boletos_vuelo ---';

    -- Crear vuelo de prueba
    CALL registrar_nuevo_vuelo(
        v_test_vuelo,
        1,
        'XA-002', -- Avión con capacidad conocida
        1,
        3,
        CURRENT_DATE + 45,
        '15:00:00',
        CURRENT_DATE + 45,
        '17:00:00',
        120,
        v_numero_creado,
        v_msg_temp
    );

    -- Generar boletos automáticamente
    CALL generar_boletos_vuelo(v_test_vuelo, v_boletos_generados, v_mensaje);

    RAISE NOTICE 'Resultado: %', v_mensaje;
    RAISE NOTICE 'Boletos generados: %', v_boletos_generados;

    -- Limpiar
    DELETE FROM boleto WHERE numero_vuelo = v_test_vuelo;
    DELETE FROM reporte_ingresos_vuelo WHERE numero_vuelo = v_test_vuelo;
    DELETE FROM vuelo WHERE numero_vuelo = v_test_vuelo;

    RAISE NOTICE '';
END $$;


DO $$
BEGIN
    RAISE NOTICE '=== PRUEBAS DE PROCEDIMIENTOS FIN :D ===';
END $$;
