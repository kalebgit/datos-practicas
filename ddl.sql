--
-- PostgreSQL database dump
--

\restrict 7HaY9Q3Y7cChoodcz4dp5O6zrGmvtskbneFbYabIabf0xI8LND9feQ0Lz65QU46

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: actualizar_estados_vuelos(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.actualizar_estados_vuelos()
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
            UPDATE vuelo SET estado = 'COMPLETO'
            WHERE numero_vuelo = v_vuelo.numero_vuelo;
            v_vuelos_actualizados := v_vuelos_actualizados + 1;
        END IF;
    END LOOP;

    RAISE NOTICE 'Se actualizaron % vuelos', v_vuelos_actualizados;
END;
$$;


ALTER PROCEDURE public.actualizar_estados_vuelos() OWNER TO postgres;

--
-- Name: PROCEDURE actualizar_estados_vuelos(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON PROCEDURE public.actualizar_estados_vuelos() IS 'Actualiza automáticamente el estado de los vuelos basándose en fechas, horarios y capacidad.';


--
-- Name: aerolinea_de_avion(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.aerolinea_de_avion(avion_id character varying) RETURNS TABLE(aeropuert_razon_social character varying, matricula_avion character varying, modelo_avion character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT ar.razon_social, av.matricula_avion, av.modelo
    FROM aerolineas ar
    INNER JOIN avion av ON av.aerolinea_id = ar.aerolinea_id
    WHERE ar.aerolinea_id = (SELECT ar.aerolinea_id
                             FROM avion av
                             INNER JOIN aerolineas ar ON ar.aerolinea_id = av.aerolinea_id
                             WHERE av.matricula_avion = avion_id);
END
$$;


ALTER FUNCTION public.aerolinea_de_avion(avion_id character varying) OWNER TO postgres;

--
-- Name: calcular_coupacion_vuelo(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calcular_coupacion_vuelo(vuelo_id integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    avion_id INTEGER;
    capacidad_max INTEGER := 0;
    pasajeros_vuelo INTEGER;
BEGIN
    avion_id := (SELECT matricula_avion FROM vuelo WHERE numero_vuelo = vuelo_id);
    capacidad_max := (SELECT capacidad_pasajeros FROM avion WHERE matricula_avion = avion_id);
    pasajeros_vuelo := (SELECT COUNT(*) FROM boleto WHERE numero_vuelo = vuelo_id GROUP BY numero_vuelo);
    RETURN (pasajeros_vuelo::NUMERIC * 100)/capacidad_max::NUMERIC;
END
$$;


ALTER FUNCTION public.calcular_coupacion_vuelo(vuelo_id integer) OWNER TO postgres;

--
-- Name: calcular_coupacion_vuelo(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calcular_coupacion_vuelo(vuelo_id character varying) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    avion_id VARCHAR(20);
    capacidad_max INTEGER := 0;
    pasajeros_vuelo INTEGER;
BEGIN
    avion_id := (SELECT matricula_avion FROM vuelo WHERE numero_vuelo = vuelo_id);
    capacidad_max := (SELECT capacidad_pasajeros FROM avion WHERE matricula_avion = avion_id);
    pasajeros_vuelo := (SELECT COUNT(*) FROM boleto WHERE numero_vuelo = vuelo_id GROUP BY numero_vuelo);
    RETURN (pasajeros_vuelo::NUMERIC * 100)/capacidad_max::NUMERIC;
END
$$;


ALTER FUNCTION public.calcular_coupacion_vuelo(vuelo_id character varying) OWNER TO postgres;

--
-- Name: calcular_duracion_promedio_aerolinea(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calcular_duracion_promedio_aerolinea(p_aerolinea_id integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_promedio_minutos NUMERIC;
    v_promedio_horas NUMERIC;
BEGIN
    -- Calcular promedio de duración en minutos
    SELECT AVG(v.duracion_minutos) INTO v_promedio_minutos
    FROM vuelo v
    INNER JOIN avion av ON v.matricula_avion = av.matricula_avion
    WHERE av.aerolinea_id = p_aerolinea_id
    AND v.duracion_minutos IS NOT NULL;

    -- Si no hay vuelos, retornar 0
    IF v_promedio_minutos IS NULL THEN
        RETURN 0;
    END IF;

    -- Convertir minutos a horas
    v_promedio_horas := v_promedio_minutos / 60.0;

    RETURN ROUND(v_promedio_horas, 2);
END;
$$;


ALTER FUNCTION public.calcular_duracion_promedio_aerolinea(p_aerolinea_id integer) OWNER TO postgres;

--
-- Name: FUNCTION calcular_duracion_promedio_aerolinea(p_aerolinea_id integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.calcular_duracion_promedio_aerolinea(p_aerolinea_id integer) IS 'Calcula el tiempo promedio de duración de vuelos de una aerolínea específica en horas.';


--
-- Name: calcular_edad_cliente(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calcular_edad_cliente(p_cliente_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_fecha_nacimiento DATE;
    v_edad INTEGER;
BEGIN
    -- Obtener fecha de nacimiento del cliente
    SELECT fecha_nacimiento INTO v_fecha_nacimiento
    FROM cliente
    WHERE cliente_id = p_cliente_id;

    -- Si no se encuentra el cliente, retornar NULL
    IF v_fecha_nacimiento IS NULL THEN
        RETURN NULL;
    END IF;

    -- Calcular edad usando la función AGE
    v_edad := EXTRACT(YEAR FROM AGE(CURRENT_DATE, v_fecha_nacimiento));

    RETURN v_edad;
END;
$$;


ALTER FUNCTION public.calcular_edad_cliente(p_cliente_id integer) OWNER TO postgres;

--
-- Name: FUNCTION calcular_edad_cliente(p_cliente_id integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.calcular_edad_cliente(p_cliente_id integer) IS 'Calcula la edad actual de un cliente a partir de su fecha de nacimiento.';


--
-- Name: calcular_ocupacion_vuelo(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calcular_ocupacion_vuelo(p_numero_vuelo character varying) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_boletos_vendidos INTEGER;
    v_capacidad_total INTEGER;
    v_porcentaje NUMERIC;
BEGIN
    -- Obtener capacidad del avión asignado al vuelo
    SELECT av.capacidad_pasajeros INTO v_capacidad_total
    FROM vuelo v
    INNER JOIN avion av ON v.matricula_avion = av.matricula_avion
    WHERE v.numero_vuelo = p_numero_vuelo;

    -- Si no se encuentra el vuelo o avión, retornar 0
    IF v_capacidad_total IS NULL THEN
        RETURN 0;
    END IF;

    -- Contar boletos vendidos para este vuelo
    SELECT COUNT(*) INTO v_boletos_vendidos
    FROM boleto b
    INNER JOIN comprar c ON b.boleto_id = c.boleto_id
    WHERE b.numero_vuelo = p_numero_vuelo;

    -- Calcular porcentaje de ocupación
    IF v_capacidad_total > 0 THEN
        v_porcentaje := (v_boletos_vendidos::NUMERIC / v_capacidad_total) * 100;
    ELSE
        v_porcentaje := 0;
    END IF;

    RETURN ROUND(v_porcentaje, 2);
END;
$$;


ALTER FUNCTION public.calcular_ocupacion_vuelo(p_numero_vuelo character varying) OWNER TO postgres;

--
-- Name: FUNCTION calcular_ocupacion_vuelo(p_numero_vuelo character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.calcular_ocupacion_vuelo(p_numero_vuelo character varying) IS 'Calcula el porcentaje de ocupación de un vuelo dividiendo boletos vendidos entre capacidad del avión.';


--
-- Name: cancelar_vuelo_con_reembolso(character varying, text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.cancelar_vuelo_con_reembolso(IN p_numero_vuelo character varying, IN p_motivo text, OUT p_boletos_reembolsados integer)
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


ALTER PROCEDURE public.cancelar_vuelo_con_reembolso(IN p_numero_vuelo character varying, IN p_motivo text, OUT p_boletos_reembolsados integer) OWNER TO postgres;

--
-- Name: PROCEDURE cancelar_vuelo_con_reembolso(IN p_numero_vuelo character varying, IN p_motivo text, OUT p_boletos_reembolsados integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON PROCEDURE public.cancelar_vuelo_con_reembolso(IN p_numero_vuelo character varying, IN p_motivo text, OUT p_boletos_reembolsados integer) IS 'Cancela un vuelo y genera reembolsos automáticos para todos los boletos vendidos.';


--
-- Name: formatear_info_cliente(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.formatear_info_cliente(p_cliente_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_info TEXT;
    v_nombres VARCHAR;
    v_apellido_p VARCHAR;
    v_apellido_m VARCHAR;
    v_edad INTEGER;
BEGIN
    -- Obtener información del cliente
    SELECT
        c.nombres,
        c.apellido_paterno,
        COALESCE(c.apellido_materno, ''),
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.fecha_nacimiento))
    INTO v_nombres, v_apellido_p, v_apellido_m, v_edad
    FROM cliente c
    WHERE c.cliente_id = p_cliente_id;

    -- Verificar si se encontró el cliente
    IF v_nombres IS NULL THEN
        RETURN 'Cliente no encontrado';
    END IF;

    -- Formatear la información
    v_info := v_nombres || ' ' || v_apellido_p;

    IF v_apellido_m != '' THEN
        v_info := v_info || ' ' || v_apellido_m;
    END IF;

    v_info := v_info || ' (' || v_edad || ' años)';

    RETURN v_info;
END;
$$;


ALTER FUNCTION public.formatear_info_cliente(p_cliente_id integer) OWNER TO postgres;

--
-- Name: FUNCTION formatear_info_cliente(p_cliente_id integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.formatear_info_cliente(p_cliente_id integer) IS 'Devuelve una cadena formateada con nombre completo y edad del cliente.';


--
-- Name: generar_reporte_ocupacion_mensual(integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.generar_reporte_ocupacion_mensual(IN p_mes integer, IN p_anio integer)
    LANGUAGE plpgsql
    AS $_$
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
$_$;


ALTER PROCEDURE public.generar_reporte_ocupacion_mensual(IN p_mes integer, IN p_anio integer) OWNER TO postgres;

--
-- Name: PROCEDURE generar_reporte_ocupacion_mensual(IN p_mes integer, IN p_anio integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON PROCEDURE public.generar_reporte_ocupacion_mensual(IN p_mes integer, IN p_anio integer) IS 'Genera un reporte estadístico de ocupación e ingresos de vuelos para un mes específico.';


--
-- Name: obtener_ingresos_vuelo(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_ingresos_vuelo(p_numero_vuelo character varying) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_total NUMERIC;
BEGIN
    -- Sumar precios de todos los boletos vendidos
    SELECT COALESCE(SUM(b.precio), 0) INTO v_total
    FROM boleto b
    INNER JOIN comprar c ON b.boleto_id = c.boleto_id
    WHERE b.numero_vuelo = p_numero_vuelo;

    RETURN v_total;
END;
$$;


ALTER FUNCTION public.obtener_ingresos_vuelo(p_numero_vuelo character varying) OWNER TO postgres;

--
-- Name: FUNCTION obtener_ingresos_vuelo(p_numero_vuelo character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.obtener_ingresos_vuelo(p_numero_vuelo character varying) IS 'Calcula el ingreso total de un vuelo sumando el precio de todos los boletos vendidos.';


--
-- Name: obtener_ingresos_vuelo_por_clase(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_ingresos_vuelo_por_clase(vuelo_id character varying) RETURNS TABLE(ejecutiva numeric, economica numeric, primera numeric)
    LANGUAGE plpgsql
    AS $$
DECLARE
    total_ejecutiva NUMERIC(20, 2);
    total_economica NUMERIC(20, 2);
    total_primera NUMERIC(20, 2);
BEGIN
    total_ejecutiva := (SELECT SUM(precio) FROM boleto WHERE numero_vuelo = vuelo_id AND clase = 'Ejecutiva' GROUP BY clase);
    total_economica := (SELECT SUM(precio) FROM boleto WHERE numero_vuelo = vuelo_id AND clase = 'Economica' GROUP BY clase);
    total_primera := (SELECT SUM(precio) FROM boleto WHERE numero_vuelo = vuelo_id AND clase = 'Primera' GROUP BY clase);

    -- Retornar los valores como una fila de la tabla
    RETURN QUERY SELECT total_ejecutiva, total_economica, total_primera;
END;
$$;


ALTER FUNCTION public.obtener_ingresos_vuelo_por_clase(vuelo_id character varying) OWNER TO postgres;

--
-- Name: procesar_compra_boleto(integer, character varying, character varying, character varying, numeric); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.procesar_compra_boleto(IN p_cliente_id integer, IN p_numero_vuelo character varying, IN p_numero_asiento character varying, IN p_clase character varying, IN p_precio numeric, OUT p_boleto_id_creado integer, OUT p_codigo_exito integer, OUT p_mensaje text)
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


ALTER PROCEDURE public.procesar_compra_boleto(IN p_cliente_id integer, IN p_numero_vuelo character varying, IN p_numero_asiento character varying, IN p_clase character varying, IN p_precio numeric, OUT p_boleto_id_creado integer, OUT p_codigo_exito integer, OUT p_mensaje text) OWNER TO postgres;

--
-- Name: PROCEDURE procesar_compra_boleto(IN p_cliente_id integer, IN p_numero_vuelo character varying, IN p_numero_asiento character varying, IN p_clase character varying, IN p_precio numeric, OUT p_boleto_id_creado integer, OUT p_codigo_exito integer, OUT p_mensaje text); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON PROCEDURE public.procesar_compra_boleto(IN p_cliente_id integer, IN p_numero_vuelo character varying, IN p_numero_asiento character varying, IN p_clase character varying, IN p_precio numeric, OUT p_boleto_id_creado integer, OUT p_codigo_exito integer, OUT p_mensaje text) IS 'Procesa la compra de un boleto validando: vuelo existente, estado válido, capacidad disponible y asiento libre. Usa transacciones.';


--
-- Name: registrar_mantenimiento_avion(character varying, character varying, text, date, date); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.registrar_mantenimiento_avion(IN p_matricula_avion character varying, IN p_tipo_mantenimiento character varying, IN p_descripcion text, IN p_fecha_inicio date, IN p_fecha_fin_estimada date)
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
        RAISE NOTICE '⚠ ADVERTENCIA: % vuelos programados serán afectados', v_vuelos_afectados;

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


ALTER PROCEDURE public.registrar_mantenimiento_avion(IN p_matricula_avion character varying, IN p_tipo_mantenimiento character varying, IN p_descripcion text, IN p_fecha_inicio date, IN p_fecha_fin_estimada date) OWNER TO postgres;

--
-- Name: PROCEDURE registrar_mantenimiento_avion(IN p_matricula_avion character varying, IN p_tipo_mantenimiento character varying, IN p_descripcion text, IN p_fecha_inicio date, IN p_fecha_fin_estimada date); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON PROCEDURE public.registrar_mantenimiento_avion(IN p_matricula_avion character varying, IN p_tipo_mantenimiento character varying, IN p_descripcion text, IN p_fecha_inicio date, IN p_fecha_fin_estimada date) IS 'Registra un mantenimiento de avión y actualiza el estado de vuelos afectados durante ese período.';


--
-- Name: registrar_nuevo_vuelo(character varying, integer, character varying, integer, integer, date, time without time zone, date, time without time zone, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.registrar_nuevo_vuelo(IN p_numero_vuelo character varying, IN p_tipo_vuelo_id integer, IN p_matricula_avion character varying, IN p_aeropuerto_salida_id integer, IN p_aeropuerto_llegada_id integer, IN p_fecha_salida date, IN p_hora_salida time without time zone, IN p_fecha_llegada date, IN p_hora_llegada time without time zone, IN p_duracion_minutos integer, OUT p_numero_vuelo_creado character varying, OUT p_mensaje text)
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


ALTER PROCEDURE public.registrar_nuevo_vuelo(IN p_numero_vuelo character varying, IN p_tipo_vuelo_id integer, IN p_matricula_avion character varying, IN p_aeropuerto_salida_id integer, IN p_aeropuerto_llegada_id integer, IN p_fecha_salida date, IN p_hora_salida time without time zone, IN p_fecha_llegada date, IN p_hora_llegada time without time zone, IN p_duracion_minutos integer, OUT p_numero_vuelo_creado character varying, OUT p_mensaje text) OWNER TO postgres;

--
-- Name: PROCEDURE registrar_nuevo_vuelo(IN p_numero_vuelo character varying, IN p_tipo_vuelo_id integer, IN p_matricula_avion character varying, IN p_aeropuerto_salida_id integer, IN p_aeropuerto_llegada_id integer, IN p_fecha_salida date, IN p_hora_salida time without time zone, IN p_fecha_llegada date, IN p_hora_llegada time without time zone, IN p_duracion_minutos integer, OUT p_numero_vuelo_creado character varying, OUT p_mensaje text); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON PROCEDURE public.registrar_nuevo_vuelo(IN p_numero_vuelo character varying, IN p_tipo_vuelo_id integer, IN p_matricula_avion character varying, IN p_aeropuerto_salida_id integer, IN p_aeropuerto_llegada_id integer, IN p_fecha_salida date, IN p_hora_salida time without time zone, IN p_fecha_llegada date, IN p_hora_llegada time without time zone, IN p_duracion_minutos integer, OUT p_numero_vuelo_creado character varying, OUT p_mensaje text) IS 'Registra un nuevo vuelo validando reglas de negocio: aeropuertos diferentes, fechas válidas, número único y disponibilidad de avión.';


--
-- Name: verificar_asiento_disponible(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.verificar_asiento_disponible(p_numero_vuelo character varying, p_numero_asiento character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_existe INTEGER;
BEGIN
    -- Verificar si existe un boleto con ese asiento en el vuelo
    SELECT COUNT(*) INTO v_existe
    FROM boleto b
    INNER JOIN comprar c ON b.boleto_id = c.boleto_id
    WHERE b.numero_vuelo = p_numero_vuelo
    AND b.numero_asiento = p_numero_asiento;

    -- Retornar TRUE si no existe (disponible), FALSE si existe (ocupado)
    RETURN (v_existe = 0);
END;
$$;


ALTER FUNCTION public.verificar_asiento_disponible(p_numero_vuelo character varying, p_numero_asiento character varying) OWNER TO postgres;

--
-- Name: FUNCTION verificar_asiento_disponible(p_numero_vuelo character varying, p_numero_asiento character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.verificar_asiento_disponible(p_numero_vuelo character varying, p_numero_asiento character varying) IS 'Verifica la disponibilidad de un asiento específico en un vuelo.';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: aerolineas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aerolineas (
    aerolinea_id integer NOT NULL,
    razon_social character varying(100) NOT NULL,
    pais_origen_empresa character varying(50),
    ciudad character varying(50),
    municipio character varying(50),
    codigo_postal character varying(20),
    calle character varying(100),
    colonia character varying(50),
    numero_exterior character varying(10),
    pais character varying(50)
);


ALTER TABLE public.aerolineas OWNER TO postgres;

--
-- Name: TABLE aerolineas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.aerolineas IS 'Tabla que almacena información de las aerolíneas registradas en el sistema.';


--
-- Name: COLUMN aerolineas.aerolinea_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.aerolineas.aerolinea_id IS 'Identificador único de la aerolínea.';


--
-- Name: COLUMN aerolineas.razon_social; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.aerolineas.razon_social IS 'Nombre legal y comercial de la aerolínea.';


--
-- Name: COLUMN aerolineas.pais_origen_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.aerolineas.pais_origen_empresa IS 'País donde se fundó la aerolínea.';


--
-- Name: aeropuerto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aeropuerto (
    aeropuerto_id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    pais character varying(50),
    ciudad character varying(50),
    municipio character varying(50),
    codigo_postal character varying(20),
    calle character varying(100),
    colonia character varying(50),
    numero_exterior character varying(10)
);


ALTER TABLE public.aeropuerto OWNER TO postgres;

--
-- Name: TABLE aeropuerto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.aeropuerto IS 'Tabla que registra información de aeropuertos donde operan las aerolíneas.';


--
-- Name: avion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avion (
    matricula_avion character varying(20) NOT NULL,
    capacidad_pasajeros integer NOT NULL,
    modelo character varying(50),
    aerolinea_id integer,
    fecha_ultimo_mantenimiento date,
    CONSTRAINT chk_capacidad_pasajeros CHECK (((capacidad_pasajeros >= 0) AND (capacidad_pasajeros <= 1000))),
    CONSTRAINT chk_fecha_mantenimiento CHECK ((fecha_ultimo_mantenimiento <= CURRENT_DATE))
);


ALTER TABLE public.avion OWNER TO postgres;

--
-- Name: TABLE avion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.avion IS 'Tabla que almacena datos de la flota de aviones de cada aerolínea.';


--
-- Name: COLUMN avion.matricula_avion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.avion.matricula_avion IS 'Matrícula única que identifica la aeronave.';


--
-- Name: COLUMN avion.capacidad_pasajeros; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.avion.capacidad_pasajeros IS 'Número máximo de pasajeros que puede transportar. 0 para aviones de carga.';


--
-- Name: COLUMN avion.modelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.avion.modelo IS 'Modelo y marca de la aeronave.';


--
-- Name: boleto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.boleto (
    boleto_id integer NOT NULL,
    numero_asiento character varying(10),
    clase character varying(20),
    precio numeric(10,2) NOT NULL,
    numero_vuelo character varying(10),
    CONSTRAINT chk_precio_boleto CHECK (((precio > (0)::numeric) AND (precio <= (1000000)::numeric)))
);


ALTER TABLE public.boleto OWNER TO postgres;

--
-- Name: TABLE boleto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.boleto IS 'Tabla que registra los boletos disponibles para cada vuelo.';


--
-- Name: COLUMN boleto.boleto_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boleto.boleto_id IS 'Identificador único del boleto.';


--
-- Name: COLUMN boleto.numero_asiento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boleto.numero_asiento IS 'Número del asiento asignado.';


--
-- Name: COLUMN boleto.clase; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boleto.clase IS 'Clase de servicio (económica, ejecutiva, primera).';


--
-- Name: COLUMN boleto.precio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boleto.precio IS 'Precio del boleto en la moneda local.';


--
-- Name: certificacion_mecanico_aeronave; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certificacion_mecanico_aeronave (
    nombre character varying(100) NOT NULL,
    mecanico_id integer NOT NULL
);


ALTER TABLE public.certificacion_mecanico_aeronave OWNER TO postgres;

--
-- Name: TABLE certificacion_mecanico_aeronave; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.certificacion_mecanico_aeronave IS 'Tabla que almacena las certificaciones de mecánicos de aeronaves.';


--
-- Name: COLUMN certificacion_mecanico_aeronave.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.certificacion_mecanico_aeronave.nombre IS 'Nombre de la certificación de mecánico de aeronaves.';


--
-- Name: COLUMN certificacion_mecanico_aeronave.mecanico_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.certificacion_mecanico_aeronave.mecanico_id IS 'Identificador del mecánico certificado.';


--
-- Name: certificacion_seguridad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certificacion_seguridad (
    nombre character varying(100) NOT NULL,
    sobrecargo_id integer NOT NULL
);


ALTER TABLE public.certificacion_seguridad OWNER TO postgres;

--
-- Name: TABLE certificacion_seguridad; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.certificacion_seguridad IS 'Tabla que almacena las certificaciones de seguridad de los sobrecargos.';


--
-- Name: certificacion_tipo_aeronave; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certificacion_tipo_aeronave (
    nombre character varying(100) NOT NULL,
    piloto_id integer NOT NULL
);


ALTER TABLE public.certificacion_tipo_aeronave OWNER TO postgres;

--
-- Name: TABLE certificacion_tipo_aeronave; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.certificacion_tipo_aeronave IS 'Tabla que almacena las certificaciones de tipo de aeronave de los pilotos.';


--
-- Name: COLUMN certificacion_tipo_aeronave.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.certificacion_tipo_aeronave.nombre IS 'Nombre de la certificación de tipo de aeronave.';


--
-- Name: COLUMN certificacion_tipo_aeronave.piloto_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.certificacion_tipo_aeronave.piloto_id IS 'Identificador del piloto certificado para ese tipo de aeronave.';


--
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    cliente_id integer NOT NULL,
    nombres character varying(50) NOT NULL,
    apellido_paterno character varying(50) NOT NULL,
    apellido_materno character varying(50),
    fecha_nacimiento date
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- Name: TABLE cliente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cliente IS 'Tabla que almacena información personal de los clientes.';


--
-- Name: COLUMN cliente.cliente_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cliente.cliente_id IS 'Identificador único del cliente.';


--
-- Name: COLUMN cliente.fecha_nacimiento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cliente.fecha_nacimiento IS 'Fecha de nacimiento del cliente.';


--
-- Name: comprar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comprar (
    cliente_id integer NOT NULL,
    boleto_id integer NOT NULL,
    fecha_compra date
);


ALTER TABLE public.comprar OWNER TO postgres;

--
-- Name: TABLE comprar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.comprar IS 'Tabla de relación que registra la compra de boletos por clientes.';


--
-- Name: contratar_aerolinea; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contratar_aerolinea (
    aerolinea_id integer CONSTRAINT contratar_aerolinea_id_not_null NOT NULL,
    empleado_id integer CONSTRAINT contratar_empleado_id_not_null NOT NULL,
    fecha_ingreso date,
    fecha_egreso date
);


ALTER TABLE public.contratar_aerolinea OWNER TO postgres;

--
-- Name: TABLE contratar_aerolinea; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.contratar_aerolinea IS 'Tabla de relación que registra la contratación de empleados por aerolíneas.';


--
-- Name: contratar_aeropuerto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contratar_aeropuerto (
    aeropuerto_id integer NOT NULL,
    empleado_id integer NOT NULL,
    fecha_ingreso date NOT NULL,
    fecha_egreso date,
    CONSTRAINT chk_fechas_aeropuerto CHECK (((fecha_egreso IS NULL) OR (fecha_egreso > fecha_ingreso)))
);


ALTER TABLE public.contratar_aeropuerto OWNER TO postgres;

--
-- Name: TABLE contratar_aeropuerto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.contratar_aeropuerto IS 'Tabla de relación que registra la contratación de empleados por aeropuertos. La especialización del empleado (Controlador de Vuelo, Mecánico, etc.) se determina consultando las tablas correspondientes.';


--
-- Name: COLUMN contratar_aeropuerto.aeropuerto_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contratar_aeropuerto.aeropuerto_id IS 'Identificador del aeropuerto empleador.';


--
-- Name: COLUMN contratar_aeropuerto.empleado_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contratar_aeropuerto.empleado_id IS 'Identificador del empleado contratado por el aeropuerto.';


--
-- Name: COLUMN contratar_aeropuerto.fecha_ingreso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contratar_aeropuerto.fecha_ingreso IS 'Fecha en que el empleado inició labores en el aeropuerto.';


--
-- Name: COLUMN contratar_aeropuerto.fecha_egreso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contratar_aeropuerto.fecha_egreso IS 'Fecha en que el empleado terminó su relación laboral con el aeropuerto. NULL indica que aún está activo.';


--
-- Name: controlador_de_abordaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.controlador_de_abordaje (
    empleado_id integer NOT NULL,
    certificacion_atencion_cliente character varying(100),
    fecha_vencimiento_certificacion date
);


ALTER TABLE public.controlador_de_abordaje OWNER TO postgres;

--
-- Name: TABLE controlador_de_abordaje; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.controlador_de_abordaje IS 'Tabla que almacena información específica de controladores de abordaje, siendo un subtipo de Empleado.';


--
-- Name: controlador_de_vuelos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.controlador_de_vuelos (
    empleado_id integer NOT NULL,
    licencia_control_trafico character varying(50),
    sector_asignado character varying(50),
    fecha_vencimiento_licencia date
);


ALTER TABLE public.controlador_de_vuelos OWNER TO postgres;

--
-- Name: TABLE controlador_de_vuelos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.controlador_de_vuelos IS 'Tabla que almacena información específica de controladores de vuelo, siendo un subtipo de Empleado.';


--
-- Name: correo_aerolineas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.correo_aerolineas (
    aerolinea_id integer NOT NULL,
    direccion_correo character varying(100) NOT NULL
);


ALTER TABLE public.correo_aerolineas OWNER TO postgres;

--
-- Name: TABLE correo_aerolineas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.correo_aerolineas IS 'Tabla que almacena las direcciones de correo electrónico de las aerolíneas.';


--
-- Name: correo_cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.correo_cliente (
    cliente_id integer NOT NULL,
    direccion_correo character varying(100) NOT NULL
);


ALTER TABLE public.correo_cliente OWNER TO postgres;

--
-- Name: TABLE correo_cliente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.correo_cliente IS 'Tabla que almacena las direcciones de correo electrónico de los clientes.';


--
-- Name: empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empleado (
    empleado_id integer NOT NULL,
    nombres character varying(50) NOT NULL,
    apellido_paterno character varying(50) NOT NULL,
    apellido_materno character varying(50),
    pais character varying(50),
    ciudad character varying(50),
    municipio character varying(50),
    codigo_postal character varying(10),
    calle character varying(100),
    colonia character varying(50),
    numero_exterior character varying(10),
    numero_interior character varying(10),
    identificacion_unica_pobla character varying(50),
    salario numeric(10,2),
    fecha_nacimiento date,
    CONSTRAINT chk_fecha_nacimiento_empleado CHECK (((fecha_nacimiento >= '1940-01-01'::date) AND (fecha_nacimiento <= (CURRENT_DATE - '18 years'::interval)))),
    CONSTRAINT chk_salario_empleado CHECK (((salario >= (5000)::numeric) AND (salario <= (5000000)::numeric)))
);


ALTER TABLE public.empleado OWNER TO postgres;

--
-- Name: TABLE empleado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.empleado IS 'Tabla que contiene datos personales y de ubicación de todos los empleados.';


--
-- Name: COLUMN empleado.empleado_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.empleado.empleado_id IS 'Identificador único del empleado.';


--
-- Name: COLUMN empleado.nombres; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.empleado.nombres IS 'Nombre(s) del empleado.';


--
-- Name: COLUMN empleado.apellido_paterno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.empleado.apellido_paterno IS 'Apellido paterno del empleado.';


--
-- Name: COLUMN empleado.apellido_materno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.empleado.apellido_materno IS 'Apellido materno del empleado.';


--
-- Name: idioma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idioma (
    nombre character varying(50) NOT NULL,
    sobrecargo_id integer NOT NULL
);


ALTER TABLE public.idioma OWNER TO postgres;

--
-- Name: TABLE idioma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.idioma IS 'Tabla que almacena los idiomas que hablan los sobrecargos.';


--
-- Name: mecanico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mecanico (
    empleado_id integer NOT NULL,
    titulo character varying(100),
    especializacion character varying(100)
);


ALTER TABLE public.mecanico OWNER TO postgres;

--
-- Name: TABLE mecanico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.mecanico IS 'Tabla que almacena información específica de los mecánicos, siendo un subtipo de Empleado.';


--
-- Name: piloto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.piloto (
    piloto_id integer NOT NULL,
    empleado_id integer NOT NULL,
    licencia character varying(50),
    horas_vuelo integer,
    fecha_vencimiento_licencia date,
    CONSTRAINT chk_horas_experiencia CHECK (((horas_vuelo >= 0) AND (horas_vuelo <= 50000)))
);


ALTER TABLE public.piloto OWNER TO postgres;

--
-- Name: TABLE piloto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.piloto IS 'Tabla que almacena información específica de los pilotos, siendo un subtipo de Empleado.';


--
-- Name: COLUMN piloto.piloto_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.piloto.piloto_id IS 'Identificador único del piloto.';


--
-- Name: COLUMN piloto.empleado_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.piloto.empleado_id IS 'Referencia al empleado que es piloto.';


--
-- Name: COLUMN piloto.licencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.piloto.licencia IS 'Número de licencia del piloto.';


--
-- Name: COLUMN piloto.horas_vuelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.piloto.horas_vuelo IS 'Total de horas de vuelo acumuladas por el piloto.';


--
-- Name: COLUMN piloto.fecha_vencimiento_licencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.piloto.fecha_vencimiento_licencia IS 'Fecha de vencimiento de la licencia del piloto.';


--
-- Name: piloto_vuelo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.piloto_vuelo (
    piloto_id integer NOT NULL,
    numero_vuelo character varying(10) NOT NULL
);


ALTER TABLE public.piloto_vuelo OWNER TO postgres;

--
-- Name: TABLE piloto_vuelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.piloto_vuelo IS 'Tabla de unión que asigna pilotos a los vuelos, modelando la relación muchos a muchos.';


--
-- Name: COLUMN piloto_vuelo.piloto_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.piloto_vuelo.piloto_id IS 'Identificador del piloto asignado.';


--
-- Name: COLUMN piloto_vuelo.numero_vuelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.piloto_vuelo.numero_vuelo IS 'Número del vuelo al que está asignado el piloto.';


--
-- Name: sobrecargo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sobrecargo (
    empleado_id integer NOT NULL
);


ALTER TABLE public.sobrecargo OWNER TO postgres;

--
-- Name: TABLE sobrecargo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sobrecargo IS 'Tabla que almacena información específica de sobrecargos, siendo un subtipo de Empleado.';


--
-- Name: telefono; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefono (
    empleado_id integer NOT NULL,
    numero_telefono character varying(15) NOT NULL
);


ALTER TABLE public.telefono OWNER TO postgres;

--
-- Name: TABLE telefono; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.telefono IS 'Tabla que almacena los números telefónicos de los empleados.';


--
-- Name: telefono_aerolineas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefono_aerolineas (
    aerolinea_id integer NOT NULL,
    numero_telefono character varying(15) NOT NULL
);


ALTER TABLE public.telefono_aerolineas OWNER TO postgres;

--
-- Name: TABLE telefono_aerolineas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.telefono_aerolineas IS 'Tabla que almacena los números telefónicos de las aerolíneas.';


--
-- Name: telefono_cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefono_cliente (
    cliente_id integer NOT NULL,
    numero_telefono character varying(15) NOT NULL
);


ALTER TABLE public.telefono_cliente OWNER TO postgres;

--
-- Name: TABLE telefono_cliente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.telefono_cliente IS 'Tabla que almacena los números telefónicos de los clientes.';


--
-- Name: tipo_vuelo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_vuelo (
    tipo_vuelo_id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion text
);


ALTER TABLE public.tipo_vuelo OWNER TO postgres;

--
-- Name: TABLE tipo_vuelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tipo_vuelo IS 'Tabla catálogo que define los tipos de vuelo disponibles en el sistema.';


--
-- Name: COLUMN tipo_vuelo.tipo_vuelo_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tipo_vuelo.tipo_vuelo_id IS 'Identificador único del tipo de vuelo.';


--
-- Name: COLUMN tipo_vuelo.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tipo_vuelo.nombre IS 'Nombre del tipo de vuelo (ej. Pasajeros, Carga, Mixto).';


--
-- Name: COLUMN tipo_vuelo.descripcion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tipo_vuelo.descripcion IS 'Descripción detallada del tipo de vuelo.';


--
-- Name: vuelo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vuelo (
    numero_vuelo character varying(10) NOT NULL,
    tipo_vuelo_id integer,
    estado character varying(20),
    duracion time without time zone,
    fecha_salida date NOT NULL,
    hora_salida time without time zone NOT NULL,
    ciudad_salida character varying(50),
    pais_salida character varying(50),
    fecha_llegada date,
    hora_llegada time without time zone,
    ciudad_llegada character varying(50),
    pais_llegada character varying(50),
    matricula_avion character varying(20),
    aeropuerto_salida_id integer,
    aeropuerto_llegada_id integer,
    estado_vuelo character varying(20) DEFAULT 'programado'::character varying,
    duracion_minutos integer,
    CONSTRAINT chk_duracion_minutos CHECK (((duracion_minutos > 0) AND (duracion_minutos <= 1500))),
    CONSTRAINT chk_estado_vuelo CHECK (((estado_vuelo)::text = ANY ((ARRAY['programado'::character varying, 'abordando'::character varying, 'en_vuelo'::character varying, 'aterrizado'::character varying, 'cancelado'::character varying, 'retrasado'::character varying])::text[]))),
    CONSTRAINT chk_fechas_vuelo CHECK (((fecha_salida < fecha_llegada) OR ((fecha_salida = fecha_llegada) AND (hora_salida < hora_llegada))))
);


ALTER TABLE public.vuelo OWNER TO postgres;

--
-- Name: TABLE vuelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.vuelo IS 'Tabla que contiene información de vuelos programados y su estado.';


--
-- Name: COLUMN vuelo.numero_vuelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.numero_vuelo IS 'Código único que identifica el vuelo.';


--
-- Name: COLUMN vuelo.tipo_vuelo_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.tipo_vuelo_id IS 'Referencia al tipo de vuelo del catálogo.';


--
-- Name: COLUMN vuelo.estado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.estado IS 'Estado actual del vuelo (programado, en vuelo, cancelado, completado).';


--
-- Name: COLUMN vuelo.duracion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.duracion IS 'Tiempo estimado de duración del vuelo.';


--
-- Name: COLUMN vuelo.ciudad_salida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.ciudad_salida IS 'Ciudad de origen del vuelo.';


--
-- Name: COLUMN vuelo.pais_salida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.pais_salida IS 'País de origen del vuelo.';


--
-- Name: COLUMN vuelo.ciudad_llegada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.ciudad_llegada IS 'Ciudad de destino del vuelo.';


--
-- Name: COLUMN vuelo.pais_llegada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.pais_llegada IS 'País de destino del vuelo.';


--
-- Name: COLUMN vuelo.aeropuerto_salida_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.aeropuerto_salida_id IS 'Aeropuerto de origen del vuelo.';


--
-- Name: COLUMN vuelo.aeropuerto_llegada_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.aeropuerto_llegada_id IS 'Aeropuerto de destino del vuelo.';


--
-- Name: aerolineas aerolineas_razon_social_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aerolineas
    ADD CONSTRAINT aerolineas_razon_social_key UNIQUE (razon_social);


--
-- Name: correo_aerolineas correo_aerolineas_direccion_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.correo_aerolineas
    ADD CONSTRAINT correo_aerolineas_direccion_correo_key UNIQUE (direccion_correo);


--
-- Name: correo_cliente correo_cliente_direccion_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.correo_cliente
    ADD CONSTRAINT correo_cliente_direccion_correo_key UNIQUE (direccion_correo);


--
-- Name: empleado empleado_identificacion_unica_pobla_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_identificacion_unica_pobla_key UNIQUE (identificacion_unica_pobla);


--
-- Name: aerolineas pk_aerolineas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aerolineas
    ADD CONSTRAINT pk_aerolineas PRIMARY KEY (aerolinea_id);


--
-- Name: aeropuerto pk_aeropuerto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeropuerto
    ADD CONSTRAINT pk_aeropuerto PRIMARY KEY (aeropuerto_id);


--
-- Name: avion pk_avion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avion
    ADD CONSTRAINT pk_avion PRIMARY KEY (matricula_avion);


--
-- Name: boleto pk_boleto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boleto
    ADD CONSTRAINT pk_boleto PRIMARY KEY (boleto_id);


--
-- Name: certificacion_mecanico_aeronave pk_cert_mecanico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificacion_mecanico_aeronave
    ADD CONSTRAINT pk_cert_mecanico PRIMARY KEY (nombre, mecanico_id);


--
-- Name: certificacion_seguridad pk_cert_seguridad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificacion_seguridad
    ADD CONSTRAINT pk_cert_seguridad PRIMARY KEY (nombre, sobrecargo_id);


--
-- Name: certificacion_tipo_aeronave pk_cert_tipo_aeronave; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificacion_tipo_aeronave
    ADD CONSTRAINT pk_cert_tipo_aeronave PRIMARY KEY (nombre, piloto_id);


--
-- Name: cliente pk_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT pk_cliente PRIMARY KEY (cliente_id);


--
-- Name: comprar pk_comprar; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comprar
    ADD CONSTRAINT pk_comprar PRIMARY KEY (cliente_id, boleto_id);


--
-- Name: contratar_aerolinea pk_contratar_aerolinea; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratar_aerolinea
    ADD CONSTRAINT pk_contratar_aerolinea PRIMARY KEY (aerolinea_id, empleado_id);


--
-- Name: contratar_aeropuerto pk_contratar_aeropuerto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratar_aeropuerto
    ADD CONSTRAINT pk_contratar_aeropuerto PRIMARY KEY (aeropuerto_id, empleado_id);


--
-- Name: controlador_de_abordaje pk_controlador_abordaje; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.controlador_de_abordaje
    ADD CONSTRAINT pk_controlador_abordaje PRIMARY KEY (empleado_id);


--
-- Name: controlador_de_vuelos pk_controlador_vuelos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.controlador_de_vuelos
    ADD CONSTRAINT pk_controlador_vuelos PRIMARY KEY (empleado_id);


--
-- Name: correo_aerolineas pk_correo_aerolineas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.correo_aerolineas
    ADD CONSTRAINT pk_correo_aerolineas PRIMARY KEY (aerolinea_id, direccion_correo);


--
-- Name: correo_cliente pk_correo_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.correo_cliente
    ADD CONSTRAINT pk_correo_cliente PRIMARY KEY (cliente_id, direccion_correo);


--
-- Name: empleado pk_empleado; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT pk_empleado PRIMARY KEY (empleado_id);


--
-- Name: idioma pk_idioma; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idioma
    ADD CONSTRAINT pk_idioma PRIMARY KEY (nombre, sobrecargo_id);


--
-- Name: mecanico pk_mecanico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanico
    ADD CONSTRAINT pk_mecanico PRIMARY KEY (empleado_id);


--
-- Name: piloto pk_piloto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.piloto
    ADD CONSTRAINT pk_piloto PRIMARY KEY (piloto_id);


--
-- Name: piloto_vuelo pk_piloto_vuelo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.piloto_vuelo
    ADD CONSTRAINT pk_piloto_vuelo PRIMARY KEY (piloto_id, numero_vuelo);


--
-- Name: sobrecargo pk_sobrecargo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sobrecargo
    ADD CONSTRAINT pk_sobrecargo PRIMARY KEY (empleado_id);


--
-- Name: telefono pk_telefono; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT pk_telefono PRIMARY KEY (empleado_id, numero_telefono);


--
-- Name: telefono_aerolineas pk_telefono_aerolineas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_aerolineas
    ADD CONSTRAINT pk_telefono_aerolineas PRIMARY KEY (aerolinea_id, numero_telefono);


--
-- Name: telefono_cliente pk_telefono_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_cliente
    ADD CONSTRAINT pk_telefono_cliente PRIMARY KEY (cliente_id, numero_telefono);


--
-- Name: tipo_vuelo pk_tipo_vuelo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_vuelo
    ADD CONSTRAINT pk_tipo_vuelo PRIMARY KEY (tipo_vuelo_id);


--
-- Name: vuelo pk_vuelo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT pk_vuelo PRIMARY KEY (numero_vuelo);


--
-- Name: telefono_aerolineas telefono_aerolineas_numero_telefono_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_aerolineas
    ADD CONSTRAINT telefono_aerolineas_numero_telefono_key UNIQUE (numero_telefono);


--
-- Name: telefono_cliente telefono_cliente_numero_telefono_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_cliente
    ADD CONSTRAINT telefono_cliente_numero_telefono_key UNIQUE (numero_telefono);


--
-- Name: telefono telefono_numero_telefono_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT telefono_numero_telefono_key UNIQUE (numero_telefono);


--
-- Name: correo_cliente uq_correo_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.correo_cliente
    ADD CONSTRAINT uq_correo_cliente UNIQUE (direccion_correo);


--
-- Name: avion fk_avion_aerolinea; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avion
    ADD CONSTRAINT fk_avion_aerolinea FOREIGN KEY (aerolinea_id) REFERENCES public.aerolineas(aerolinea_id) ON DELETE RESTRICT;


--
-- Name: boleto fk_boleto_vuelo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boleto
    ADD CONSTRAINT fk_boleto_vuelo FOREIGN KEY (numero_vuelo) REFERENCES public.vuelo(numero_vuelo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: certificacion_mecanico_aeronave fk_cert_mec_mecanico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificacion_mecanico_aeronave
    ADD CONSTRAINT fk_cert_mec_mecanico FOREIGN KEY (mecanico_id) REFERENCES public.mecanico(empleado_id);


--
-- Name: certificacion_seguridad fk_cert_seg_sobrecargo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificacion_seguridad
    ADD CONSTRAINT fk_cert_seg_sobrecargo FOREIGN KEY (sobrecargo_id) REFERENCES public.sobrecargo(empleado_id);


--
-- Name: certificacion_tipo_aeronave fk_cert_tipo_piloto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificacion_tipo_aeronave
    ADD CONSTRAINT fk_cert_tipo_piloto FOREIGN KEY (piloto_id) REFERENCES public.piloto(piloto_id);


--
-- Name: comprar fk_comprar_boleto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comprar
    ADD CONSTRAINT fk_comprar_boleto FOREIGN KEY (boleto_id) REFERENCES public.boleto(boleto_id);


--
-- Name: comprar fk_comprar_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comprar
    ADD CONSTRAINT fk_comprar_cliente FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contratar_aeropuerto fk_contratar_aero_aeropuerto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratar_aeropuerto
    ADD CONSTRAINT fk_contratar_aero_aeropuerto FOREIGN KEY (aeropuerto_id) REFERENCES public.aeropuerto(aeropuerto_id);


--
-- Name: contratar_aeropuerto fk_contratar_aero_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratar_aeropuerto
    ADD CONSTRAINT fk_contratar_aero_empleado FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: contratar_aerolinea fk_contratar_aerolinea_aero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratar_aerolinea
    ADD CONSTRAINT fk_contratar_aerolinea_aero FOREIGN KEY (aerolinea_id) REFERENCES public.aerolineas(aerolinea_id);


--
-- Name: contratar_aerolinea fk_contratar_aerolinea_emp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratar_aerolinea
    ADD CONSTRAINT fk_contratar_aerolinea_emp FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: controlador_de_abordaje fk_control_abordaje_emp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.controlador_de_abordaje
    ADD CONSTRAINT fk_control_abordaje_emp FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: controlador_de_vuelos fk_control_vuelos_emp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.controlador_de_vuelos
    ADD CONSTRAINT fk_control_vuelos_emp FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: correo_aerolineas fk_correo_aerolineas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.correo_aerolineas
    ADD CONSTRAINT fk_correo_aerolineas FOREIGN KEY (aerolinea_id) REFERENCES public.aerolineas(aerolinea_id);


--
-- Name: correo_cliente fk_correo_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.correo_cliente
    ADD CONSTRAINT fk_correo_cliente FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id);


--
-- Name: idioma fk_idioma_sobrecargo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idioma
    ADD CONSTRAINT fk_idioma_sobrecargo FOREIGN KEY (sobrecargo_id) REFERENCES public.sobrecargo(empleado_id);


--
-- Name: mecanico fk_mecanico_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanico
    ADD CONSTRAINT fk_mecanico_empleado FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: piloto fk_piloto_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.piloto
    ADD CONSTRAINT fk_piloto_empleado FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: piloto_vuelo fk_pilotovuelo_piloto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.piloto_vuelo
    ADD CONSTRAINT fk_pilotovuelo_piloto FOREIGN KEY (piloto_id) REFERENCES public.piloto(piloto_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: piloto_vuelo fk_pilotovuelo_vuelo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.piloto_vuelo
    ADD CONSTRAINT fk_pilotovuelo_vuelo FOREIGN KEY (numero_vuelo) REFERENCES public.vuelo(numero_vuelo);


--
-- Name: sobrecargo fk_sobrecargo_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sobrecargo
    ADD CONSTRAINT fk_sobrecargo_empleado FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: telefono_aerolineas fk_tel_aerolineas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_aerolineas
    ADD CONSTRAINT fk_tel_aerolineas FOREIGN KEY (aerolinea_id) REFERENCES public.aerolineas(aerolinea_id);


--
-- Name: telefono_cliente fk_tel_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_cliente
    ADD CONSTRAINT fk_tel_cliente FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id);


--
-- Name: telefono fk_telefono_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT fk_telefono_empleado FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: vuelo fk_vuelo_aeropuerto_llegada; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT fk_vuelo_aeropuerto_llegada FOREIGN KEY (aeropuerto_llegada_id) REFERENCES public.aeropuerto(aeropuerto_id);


--
-- Name: vuelo fk_vuelo_aeropuerto_salida; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT fk_vuelo_aeropuerto_salida FOREIGN KEY (aeropuerto_salida_id) REFERENCES public.aeropuerto(aeropuerto_id);


--
-- Name: vuelo fk_vuelo_avion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT fk_vuelo_avion FOREIGN KEY (matricula_avion) REFERENCES public.avion(matricula_avion) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: vuelo fk_vuelo_tipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT fk_vuelo_tipo FOREIGN KEY (tipo_vuelo_id) REFERENCES public.tipo_vuelo(tipo_vuelo_id);


--
-- PostgreSQL database dump complete
--

\unrestrict 7HaY9Q3Y7cChoodcz4dp5O6zrGmvtskbneFbYabIabf0xI8LND9feQ0Lz65QU46

