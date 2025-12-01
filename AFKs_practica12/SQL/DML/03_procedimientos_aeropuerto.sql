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
    v_ciudad_salida VARCHAR;
    v_pais_salida VARCHAR;
    v_ciudad_llegada VARCHAR;
    v_pais_llegada VARCHAR;
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
    
    -- Obtener información de ciudades y países de los aeropuertos
    SELECT ciudad, pais INTO v_ciudad_salida, v_pais_salida
    FROM aeropuerto
    WHERE aeropuerto_id = p_aeropuerto_salida_id;
    
    SELECT ciudad, pais INTO v_ciudad_llegada, v_pais_llegada
    FROM aeropuerto
    WHERE aeropuerto_id = p_aeropuerto_llegada_id;
    
    -- Insertar el nuevo vuelo
    INSERT INTO vuelo (
        numero_vuelo, tipo_vuelo_id, estado_vuelo,
        fecha_salida, hora_salida, ciudad_salida, pais_salida,
        fecha_llegada, hora_llegada, ciudad_llegada, pais_llegada,
        matricula_avion, aeropuerto_salida_id, aeropuerto_llegada_id,
        duracion_minutos
    ) VALUES (
        p_numero_vuelo, p_tipo_vuelo_id, 'programado',
        p_fecha_salida, p_hora_salida, v_ciudad_salida, v_pais_salida,
        p_fecha_llegada, p_hora_llegada, v_ciudad_llegada, v_pais_llegada,
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
        --USAMOS ESTA FUCNINO PARA NO EQUIVOCARNOS EN LA INSERCION
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
        
        -- Si se llenó el vuelo, actualizar estado
        IF v_boletos_actuales + 1 >= v_capacidad THEN
            UPDATE vuelo SET estado = 'COMPLETO'
            WHERE numero_vuelo = p_numero_vuelo;
        END IF;
        
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
-- Parámetros IN:
--   p_numero_vuelo VARCHAR - Número del vuelo a cancelar
--   p_motivo TEXT - Motivo de la cancelación
-- Parámetros OUT:
--   p_boletos_reembolsados INTEGER - Cantidad de boletos reembolsados
-- Tablas involucradas: vuelo, boleto, comprar, reembolso (se crea si no existe)
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
    v_boleto RECORD;
BEGIN
    p_boletos_reembolsados := 0;
    
    -- Verificar estado del vuelo
    SELECT estado_vuelo INTO v_estado_actual
    FROM vuelo
    WHERE numero_vuelo = p_numero_vuelo;
    
    IF v_estado_actual IS NULL THEN
        RAISE EXCEPTION 'El vuelo % no existe', p_numero_vuelo;
    END IF;
    
    -- No se puede cancelar vuelos ya finalizados o en vuelo
    IF v_estado_actual IN ('aterrizado', 'en_vuelo') THEN
        RAISE EXCEPTION 'No se puede cancelar un vuelo en estado %', v_estado_actual;
    END IF;
    
    -- Crear tabla de reembolsos si no existe
    CREATE TABLE IF NOT EXISTS reembolso (
        id_reembolso SERIAL PRIMARY KEY,
        boleto_id INTEGER NOT NULL,
        cliente_id INTEGER NOT NULL,
        numero_vuelo VARCHAR(10),
        monto_reembolsado NUMERIC(10,2),
        motivo TEXT,
        fecha_reembolso TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    
    -- Procesar reembolso para cada boleto vendido
    FOR v_boleto IN 
        SELECT b.boleto_id, c.cliente_id, b.precio
        FROM boleto b
        INNER JOIN comprar c ON b.boleto_id = c.boleto_id
        WHERE b.numero_vuelo = p_numero_vuelo
    LOOP
        -- Registrar el reembolso
        INSERT INTO reembolso (
            boleto_id, cliente_id, numero_vuelo,
            monto_reembolsado, motivo
        ) VALUES (
            v_boleto.boleto_id,
            v_boleto.cliente_id,
            p_numero_vuelo,
            v_boleto.precio,
            p_motivo
        );
        
        p_boletos_reembolsados := p_boletos_reembolsados + 1;
    END LOOP;
    
    -- Actualizar estado del vuelo
    UPDATE vuelo
    SET estado_vuelo = 'cancelado'
    WHERE numero_vuelo = p_numero_vuelo;
    
    RAISE NOTICE 'Vuelo % cancelado', p_numero_vuelo;
    RAISE NOTICE 'Boletos reembolsados: %', p_boletos_reembolsados;
    RAISE NOTICE 'Motivo: %', p_motivo;
END;
$$;

COMMENT ON PROCEDURE cancelar_vuelo_con_reembolso IS 
'Cancela un vuelo y genera reembolsos automáticos para todos los boletos vendidos.';


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
    -- funcion que eta en la docu de postgresql
        RAISE NOTICE 'ADVERTENCIA: % vuelos programados serán afectados', v_vuelos_afectados;
        
        -- Mostrar detalle de vuelos afectados
        FOR v_vuelo IN 
            SELECT numero_vuelo, fecha_salida, ciudad_salida, ciudad_llegada
            FROM vuelo
            WHERE matricula_avion = p_matricula_avion
            AND estado_vuelo IN ('programado', 'abordando')
            AND (
                (fecha_salida BETWEEN p_fecha_inicio AND p_fecha_fin_estimada)
                OR (fecha_llegada BETWEEN p_fecha_inicio AND p_fecha_fin_estimada)
            )
        LOOP
            RAISE NOTICE 'Vuelo afectado: % (% → %) el %', 
                v_vuelo.numero_vuelo, 
                v_vuelo.ciudad_salida, 
                v_vuelo.ciudad_llegada,
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