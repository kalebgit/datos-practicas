-- ========================================
-- FUNCIONES - SISTEMA DE AEROLÍNEAS
-- ========================================

-- ========================================
-- FUNCIONES EXISTENTES 
-- ========================================

--
-- Función: calcular_ocupacion_vuelo
-- Descripción: Calcula el porcentaje de ocupación de un vuelo específico
--              comparando boletos vendidos contra capacidad del avión
-- Parámetros: p_numero_vuelo VARCHAR - Número del vuelo a consultar
-- Retorna: NUMERIC - Porcentaje de ocupación redondeado a 2 decimales
-- Tablas involucradas: vuelo, avion, boleto, comprar
--

CREATE OR REPLACE FUNCTION calcular_ocupacion_vuelo(p_numero_vuelo VARCHAR)
RETURNS NUMERIC
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

COMMENT ON FUNCTION calcular_ocupacion_vuelo(VARCHAR) IS
'Calcula el porcentaje de ocupación de un vuelo dividiendo boletos vendidos entre capacidad del avión.';


--
-- Función: obtener_ingresos_vuelo
-- Descripción: Suma todos los precios de boletos vendidos para un vuelo
-- Parámetros: p_numero_vuelo VARCHAR - Número del vuelo a consultar
-- Retorna: NUMERIC - Total de ingresos generados por el vuelo
-- Tablas involucradas: boleto, comprar
--

CREATE OR REPLACE FUNCTION obtener_ingresos_vuelo(p_numero_vuelo VARCHAR)
RETURNS NUMERIC
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

COMMENT ON FUNCTION obtener_ingresos_vuelo(VARCHAR) IS
'Calcula el ingreso total de un vuelo sumando el precio de todos los boletos vendidos.';


--
-- Función: formatear_info_cliente
-- Descripción: Devuelve información formateada del cliente en una sola cadena
-- Parámetros: p_cliente_id INTEGER - ID del cliente
-- Retorna: TEXT - Cadena con formato "Nombre ApellidoPaterno ApellidoMaterno (Edad años)"
-- Tablas involucradas: cliente
--

CREATE OR REPLACE FUNCTION formatear_info_cliente(p_cliente_id INTEGER)
RETURNS TEXT
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

COMMENT ON FUNCTION formatear_info_cliente(INTEGER) IS
'Devuelve una cadena formateada con nombre completo y edad del cliente.';


--
-- Función: calcular_duracion_promedio_aerolinea
-- Descripción: Calcula la duración promedio de vuelos de una aerolínea en horas
-- Parámetros: p_aerolinea_id INTEGER - ID de la aerolínea
-- Retorna: NUMERIC - Duración promedio en horas con 2 decimales
-- Tablas involucradas: vuelo, avion, aerolineas
--

CREATE OR REPLACE FUNCTION calcular_duracion_promedio_aerolinea(p_aerolinea_id INTEGER)
RETURNS NUMERIC
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

COMMENT ON FUNCTION calcular_duracion_promedio_aerolinea(INTEGER) IS
'Calcula el tiempo promedio de duración de vuelos de una aerolínea específica en horas.';


--
-- Función: verificar_asiento_disponible
-- Descripción: Verifica si un asiento está disponible en un vuelo
-- Parámetros: p_numero_vuelo VARCHAR - Número del vuelo
--             p_numero_asiento VARCHAR - Número del asiento a verificar
-- Retorna: BOOLEAN - TRUE si está disponible, FALSE si está ocupado
-- Tablas involucradas: boleto, comprar
--

CREATE OR REPLACE FUNCTION verificar_asiento_disponible(
    p_numero_vuelo VARCHAR,
    p_numero_asiento VARCHAR
)
RETURNS BOOLEAN
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

COMMENT ON FUNCTION verificar_asiento_disponible(VARCHAR, VARCHAR) IS
'Verifica la disponibilidad de un asiento específico en un vuelo.';


--
-- Función: calcular_edad_cliente
-- Descripción: Calcula la edad actual de un cliente en años
-- Parámetros: p_cliente_id INTEGER - ID del cliente
-- Retorna: INTEGER - Edad en años completos
-- Tablas involucradas: cliente
--

CREATE OR REPLACE FUNCTION calcular_edad_cliente(p_cliente_id INTEGER)
RETURNS INTEGER
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

COMMENT ON FUNCTION calcular_edad_cliente(INTEGER) IS
'Calcula la edad actual de un cliente a partir de su fecha de nacimiento.';


-- ========================================
-- FUNCIONES (que no estaban en las practicas
-- anteriores :D)
-- ========================================

--
-- Función: generar_numero_vuelo
-- Descripción: Genera un número de vuelo único basado en código de aerolínea y secuencia
-- Parámetros: p_aerolinea_id INTEGER - ID de la aerolínea
-- Retorna: VARCHAR - Número de vuelo generado (ej: "AA1001")
-- Tablas involucradas: aerolineas, vuelo
--

-- nota adicional: este tipo de funciones
-- son muy importantes para tener un formato
-- más formal en la generación de ids

CREATE OR REPLACE FUNCTION generar_numero_vuelo(p_aerolinea_id INTEGER)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
DECLARE
    v_razon_social VARCHAR(100);
    v_codigo_aerolinea VARCHAR(3);
    v_contador INTEGER;
    v_numero_vuelo VARCHAR(10);
BEGIN
    -- Obtener razón social de la aerolínea
    SELECT razon_social INTO v_razon_social
    FROM aerolineas
    WHERE aerolinea_id = p_aerolinea_id;

    IF v_razon_social IS NULL THEN
        RAISE EXCEPTION 'Aerolínea con ID % no encontrada', p_aerolinea_id;
    END IF;

    -- Extraer las primeras 2 letras de la razón social
    v_codigo_aerolinea := UPPER(SUBSTRING(v_razon_social FROM 1 FOR 2));

    -- Contar vuelos existentes de esta aerolínea para generar secuencia
    SELECT COUNT(*) INTO v_contador
    FROM vuelo v
    INNER JOIN avion av ON v.matricula_avion = av.matricula_avion
    WHERE av.aerolinea_id = p_aerolinea_id;

    -- Generar número de vuelo: código aerolínea + número secuencial de 4 dígitos
    v_numero_vuelo := v_codigo_aerolinea || LPAD((v_contador + 1)::TEXT, 4, '0');
    -- Nota: lo único que hace LPAD es rellenar con ceros a la izquierda

    RETURN v_numero_vuelo;
END;
$$;

COMMENT ON FUNCTION generar_numero_vuelo(INTEGER) IS
'Genera un número de vuelo único basado en el código de la aerolínea y una secuencia.';


--
-- Función: calcular_creditos_disponibles
-- Descripción: Calcula el total de créditos disponibles (no usados) de un cliente
-- Parámetros: p_cliente_id INTEGER - ID del cliente
-- Retorna: NUMERIC - Total de créditos disponibles
-- Tablas involucradas: creditos
--

CREATE OR REPLACE FUNCTION calcular_creditos_disponibles(p_cliente_id INTEGER)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_creditos NUMERIC;
BEGIN
    -- Sumar todos los créditos no usados del cliente
    SELECT COALESCE(SUM(monto), 0) INTO v_total_creditos
    FROM creditos
    WHERE cliente_id = p_cliente_id
    AND usado = FALSE;

    RETURN v_total_creditos;
END;
$$;

COMMENT ON FUNCTION calcular_creditos_disponibles(INTEGER) IS
'Calcula el total de créditos disponibles (no usados) para un cliente específico.';


--
-- Función: obtener_asientos_disponibles
-- Descripción: Retorna la cantidad de asientos disponibles en un vuelo
-- Parámetros: p_numero_vuelo VARCHAR - Número del vuelo
-- Retorna: INTEGER - Cantidad de asientos disponibles
-- Tablas involucradas: vuelo, avion, boleto, comprar
--

CREATE OR REPLACE FUNCTION obtener_asientos_disponibles(p_numero_vuelo VARCHAR)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_capacidad_total INTEGER;
    v_asientos_ocupados INTEGER;
    v_asientos_disponibles INTEGER;
BEGIN
    -- Obtener capacidad del avión
    SELECT av.capacidad_pasajeros INTO v_capacidad_total
    FROM vuelo v
    INNER JOIN avion av ON v.matricula_avion = av.matricula_avion
    WHERE v.numero_vuelo = p_numero_vuelo;

    IF v_capacidad_total IS NULL THEN
        RETURN 0;
    END IF;

    -- Contar asientos ocupados (boletos vendidos)
    SELECT COUNT(*) INTO v_asientos_ocupados
    FROM boleto b
    INNER JOIN comprar c ON b.boleto_id = c.boleto_id
    WHERE b.numero_vuelo = p_numero_vuelo
    AND b.estado_boleto IN ('activo', 'usado');

    -- Calcular disponibles
    v_asientos_disponibles := v_capacidad_total - v_asientos_ocupados;

    RETURN v_asientos_disponibles;
END;
$$;

COMMENT ON FUNCTION obtener_asientos_disponibles(VARCHAR) IS
'Retorna la cantidad de asientos disponibles para venta en un vuelo específico.';


--
-- Función: verificar_piloto_calificado
-- Descripción: Verifica si un piloto está calificado para volar un tipo de avión
-- Parámetros: p_piloto_id INTEGER - ID del piloto
--             p_matricula_avion VARCHAR - Matrícula del avión
-- Retorna: BOOLEAN - TRUE si está calificado, FALSE si no
-- Tablas involucradas: piloto, avion, certificacion_tipo_aeronave
--

CREATE OR REPLACE FUNCTION verificar_piloto_calificado(
    p_piloto_id INTEGER,
    p_matricula_avion VARCHAR
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    v_modelo_avion VARCHAR(50);
    v_tiene_certificacion INTEGER;
BEGIN
    -- Obtener modelo de avión
    SELECT modelo INTO v_modelo_avion
    FROM avion
    WHERE matricula_avion = p_matricula_avion;

    IF v_modelo_avion IS NULL THEN
        RETURN FALSE;
    END IF;

    -- Verificar si el piloto tiene certificación para ese tipo/modelo
    SELECT COUNT(*) INTO v_tiene_certificacion
    FROM certificacion_tipo_aeronave
    WHERE piloto_id = p_piloto_id
    AND nombre = v_modelo_avion;

    RETURN (v_tiene_certificacion > 0);
END;
$$;

COMMENT ON FUNCTION verificar_piloto_calificado(INTEGER, VARCHAR) IS
'Verifica si un piloto tiene la certificación necesaria para operar un tipo específico de aeronave.';


--
-- Función: verificar_empleado_activo_aeropuerto
-- Descripción: Verifica si un empleado está actualmente activo en un aeropuerto
-- Parámetros: p_empleado_id INTEGER - ID del empleado
--             p_aeropuerto_id INTEGER - ID del aeropuerto
-- Retorna: BOOLEAN - TRUE si está activo, FALSE si no
-- Tablas involucradas: contratar_aeropuerto
--

CREATE OR REPLACE FUNCTION verificar_empleado_activo_aeropuerto(
    p_empleado_id INTEGER,
    p_aeropuerto_id INTEGER
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    v_contrato_activo INTEGER;
BEGIN
    -- Verificar si existe un contrato activo (sin fecha de egreso)
    SELECT COUNT(*) INTO v_contrato_activo
    FROM contratar_aeropuerto
    WHERE empleado_id = p_empleado_id
    AND aeropuerto_id = p_aeropuerto_id
    AND fecha_egreso IS NULL;

    RETURN (v_contrato_activo > 0);
END;
$$;

COMMENT ON FUNCTION verificar_empleado_activo_aeropuerto(INTEGER, INTEGER) IS
'Verifica si un empleado tiene un contrato activo en un aeropuerto específico.';


--
-- Función: calcular_horas_vuelo_piloto
-- Descripción: Calcula las horas totales de vuelo registradas de un piloto
-- Parámetros: p_piloto_id INTEGER - ID del piloto
-- Retorna: NUMERIC - Total de horas de vuelo
-- Tablas involucradas: piloto
--

CREATE OR REPLACE FUNCTION calcular_horas_vuelo_piloto(p_piloto_id INTEGER)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    v_horas_vuelo NUMERIC;
BEGIN
    -- Obtener horas de vuelo del piloto
    SELECT horas_vuelo INTO v_horas_vuelo
    FROM piloto
    WHERE piloto_id = p_piloto_id;

    RETURN COALESCE(v_horas_vuelo, 0);
END;
$$;

COMMENT ON FUNCTION calcular_horas_vuelo_piloto(INTEGER) IS
'Retorna el total de horas de vuelo acumuladas por un piloto.';


--
-- Función: obtener_precio_base_boleto
-- Descripción: Calcula un precio base para un boleto según la duración del vuelo
--              Precio base = 100 + (duración_minutos * 0.5)
-- Parámetros: p_numero_vuelo VARCHAR - Número del vuelo
-- Retorna: NUMERIC - Precio base sugerido
-- Tablas involucradas: vuelo
--

CREATE OR REPLACE FUNCTION obtener_precio_base_boleto(p_numero_vuelo VARCHAR)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    v_duracion_minutos INTEGER;
    v_precio_base NUMERIC;
BEGIN
    -- Obtener duración del vuelo
    SELECT duracion_minutos INTO v_duracion_minutos
    FROM vuelo
    WHERE numero_vuelo = p_numero_vuelo;

    IF v_duracion_minutos IS NULL THEN
        RETURN 100; -- Precio mínimo por defecto
    END IF;

    -- Calcular precio: base $100 + $0.50 por minuto
    v_precio_base := 100 + (v_duracion_minutos * 0.5);

    RETURN ROUND(v_precio_base, 2);
END;
$$;

COMMENT ON FUNCTION obtener_precio_base_boleto(VARCHAR) IS
'Calcula un precio base sugerido para boletos según la duración del vuelo.';














-- ========================================
-- PRUEBAS DE EJECUCIÓN DE FUNCIONES
-- ========================================

DO $$
BEGIN
    RAISE NOTICE '=== PRUEBAS DE FUNCIONES ===';
    RAISE NOTICE '';
END $$;

-- ========================================
-- calcular_ocupacion_vuelo
-- ========================================
DO $$
DECLARE
    v_ocupacion NUMERIC;
BEGIN
    RAISE NOTICE '--- Prueba  calcular_ocupacion_vuelo ---';

    -- Calcular ocupación del vuelo AM101
    v_ocupacion := calcular_ocupacion_vuelo('AM101');
    RAISE NOTICE 'Ocupación del vuelo AM101: %%%', ROUND(v_ocupacion, 2);

    -- Calcular ocupación del vuelo VO202
    v_ocupacion := calcular_ocupacion_vuelo('VO202');
    RAISE NOTICE 'Ocupación del vuelo VO202: %%%', ROUND(v_ocupacion, 2);

    RAISE NOTICE '';
END $$;


-- ========================================
-- obtener_ingresos_vuelo
-- ========================================
DO $$
DECLARE
    v_ingresos NUMERIC;
BEGIN
    RAISE NOTICE '--- Prueba obtener_ingresos_vuelo ---';

    -- Calcular ingresos del vuelo AM101
    v_ingresos := obtener_ingresos_vuelo('AM101');
    RAISE NOTICE 'Ingresos del vuelo AM101: $%', v_ingresos;

    -- Calcular ingresos del vuelo VO202
    v_ingresos := obtener_ingresos_vuelo('VO202');
    RAISE NOTICE 'Ingresos del vuelo VO202: $%', v_ingresos;

    RAISE NOTICE '';
END $$;


-- ========================================
-- formatear_info_cliente
-- ========================================
DO $$
DECLARE
    v_info TEXT;
BEGIN
    RAISE NOTICE '--- Prueba formatear_info_cliente ---';

    -- Formatear información del cliente 1
    v_info := formatear_info_cliente(1);
    RAISE NOTICE 'Cliente 1: %', v_info;

    -- Formatear información del cliente 10
    v_info := formatear_info_cliente(10);
    RAISE NOTICE 'Cliente 10: %', v_info;

    RAISE NOTICE '';
END $$;


-- ========================================
-- calcular_duracion_promedio_aerolinea
-- ========================================
DO $$
DECLARE
    v_duracion_promedio NUMERIC;
BEGIN
    RAISE NOTICE '--- Prueba calcular_duracion_promedio_aerolinea ---';

    -- Calcular duración promedio de vuelos de Aeroméxico (ID 1)
    v_duracion_promedio := calcular_duracion_promedio_aerolinea(1);
    RAISE NOTICE 'Duración promedio de vuelos de Aeroméxico: % horas', ROUND(v_duracion_promedio, 2);

    -- Calcular duración promedio de vuelos de Volaris (ID 2)
    v_duracion_promedio := calcular_duracion_promedio_aerolinea(2);
    RAISE NOTICE 'Duración promedio de vuelos de Volaris: % horas', ROUND(v_duracion_promedio, 2);

    RAISE NOTICE '';
END $$;


-- ========================================
-- verificar_asiento_disponible
-- ========================================
DO $$
DECLARE
    v_disponible BOOLEAN;
BEGIN
    RAISE NOTICE '--- Prueba verificar_asiento_disponible ---';

    -- Verificar asiento 1A en vuelo AM101 (probablemente ocupado)
    v_disponible := verificar_asiento_disponible('AM101', '1A');
    RAISE NOTICE 'Asiento 1A en AM101 disponible: %', v_disponible;

    -- Verificar asiento 20Z en vuelo AM101 (probablemente disponible)
    v_disponible := verificar_asiento_disponible('AM101', '20Z');
    RAISE NOTICE 'Asiento 20Z en AM101 disponible: %', v_disponible;

    RAISE NOTICE '';
END $$;


-- ========================================
-- calcular_edad_cliente
-- ========================================
DO $$
DECLARE
    v_edad INTEGER;
BEGIN
    RAISE NOTICE '--- Prueba calcular_edad_cliente ---';

    -- Calcular edad del cliente 1
    v_edad := calcular_edad_cliente(1);
    RAISE NOTICE 'Edad del cliente 1: % años', v_edad;

    -- Calcular edad del cliente 5
    v_edad := calcular_edad_cliente(5);
    RAISE NOTICE 'Edad del cliente 5: % años', v_edad;

    RAISE NOTICE '';
END $$;


-- ========================================
-- generar_numero_vuelo
-- ========================================
DO $$
DECLARE
    v_numero_vuelo VARCHAR;
BEGIN
    RAISE NOTICE '--- Prueba generar_numero_vuelo ---';

    -- Generar número de vuelo para Aeroméxico (ID 1)
    v_numero_vuelo := generar_numero_vuelo(1);
    RAISE NOTICE 'Nuevo número de vuelo para Aeroméxico: %', v_numero_vuelo;

    -- Generar número de vuelo para Volaris (ID 2)
    v_numero_vuelo := generar_numero_vuelo(2);
    RAISE NOTICE 'Nuevo número de vuelo para Volaris: %', v_numero_vuelo;

    RAISE NOTICE '';
END $$;


-- ========================================
-- calcular_creditos_disponibles
-- ========================================
DO $$
DECLARE
    v_creditos NUMERIC;
BEGIN
    RAISE NOTICE '--- Prueba  calcular_creditos_disponibles ---';

    -- Insertar un crédito de prueba
    INSERT INTO creditos (cliente_id, monto, fecha_vencimiento, usado, origen)
    VALUES (1, 500.00, CURRENT_DATE + INTERVAL '30 days', FALSE, 'compensacion');

    -- Calcular créditos disponibles del cliente 1
    v_creditos := calcular_creditos_disponibles(1);
    RAISE NOTICE 'Créditos disponibles del cliente 1: $%', v_creditos;

    -- Limpiar datos de prueba
    DELETE FROM creditos WHERE cliente_id = 1 AND monto = 500.00;

    RAISE NOTICE '';
END $$;


-- ========================================
-- obtener_asientos_disponibles
-- ========================================
DO $$
DECLARE
    v_asientos_disponibles INTEGER;
BEGIN
    RAISE NOTICE '--- Prueba  obtener_asientos_disponibles ---';

    -- Obtener asientos disponibles en vuelo AM101
    v_asientos_disponibles := obtener_asientos_disponibles('AM101');
    RAISE NOTICE 'Asientos disponibles en AM101: %', v_asientos_disponibles;

    -- Obtener asientos disponibles en vuelo VO202
    v_asientos_disponibles := obtener_asientos_disponibles('VO202');
    RAISE NOTICE 'Asientos disponibles en VO202: %', v_asientos_disponibles;

    RAISE NOTICE '';
END $$;


-- ========================================
-- verificar_piloto_calificado
-- ========================================
DO $$
DECLARE
    v_calificado BOOLEAN;
BEGIN
    RAISE NOTICE '--- Prueba verificar_piloto_calificado ---';

    -- Verificar si el piloto 1 está calificado para el avión XA-001
    v_calificado := verificar_piloto_calificado(1, 'XA-001');
    RAISE NOTICE 'Piloto 1 calificado para XA-001: %', v_calificado;

    -- Verificar si el piloto 5 está calificado para el avión XB-001
    v_calificado := verificar_piloto_calificado(5, 'XB-001');
    RAISE NOTICE 'Piloto 5 calificado para XB-001: %', v_calificado;

    RAISE NOTICE '';
END $$;


-- ========================================
-- verificar_empleado_activo_aeropuerto
-- ========================================
DO $$
DECLARE
    v_activo BOOLEAN;
BEGIN
    RAISE NOTICE '--- Prueba verificar_empleado_activo_aeropuerto ---';

    -- Verificar si el empleado 35 está activo en el aeropuerto 1
    v_activo := verificar_empleado_activo_aeropuerto(35, 1);
    RAISE NOTICE 'Empleado 35 activo en aeropuerto 1: %', v_activo;

    -- Verificar un empleado que no está en ese aeropuerto
    v_activo := verificar_empleado_activo_aeropuerto(1, 5);
    RAISE NOTICE 'Empleado 1 activo en aeropuerto 5: %', v_activo;

    RAISE NOTICE '';
END $$;


-- ========================================
-- calcular_horas_vuelo_piloto
-- ========================================
DO $$
DECLARE
    v_horas NUMERIC;
BEGIN
    RAISE NOTICE '--- Prueba calcular_horas_vuelo_piloto ---';

    -- Calcular horas de vuelo del piloto 1
    v_horas := calcular_horas_vuelo_piloto(1);
    RAISE NOTICE 'Horas de vuelo del piloto 1: % horas', v_horas;

    -- Calcular horas de vuelo del piloto 5
    v_horas := calcular_horas_vuelo_piloto(5);
    RAISE NOTICE 'Horas de vuelo del piloto 5: % horas', v_horas;

    RAISE NOTICE '';
END $$;


-- ========================================
-- obtener_precio_base_boleto
-- ========================================
DO $$
DECLARE
    v_precio NUMERIC;
BEGIN
    RAISE NOTICE '--- Prueba obtener_precio_base_boleto ---';

    -- Obtener precio base para vuelo AM101
    v_precio := obtener_precio_base_boleto('AM101');
    RAISE NOTICE 'Precio base sugerido para AM101: $%', v_precio;

    -- Obtener precio base para vuelo VO202 (vuelo más largo)
    v_precio := obtener_precio_base_boleto('VO202');
    RAISE NOTICE 'Precio base sugerido para VO202: $%', v_precio;

    RAISE NOTICE '';
END $$;


DO $$
BEGIN
    RAISE NOTICE '=== PRUEBAS DE FUNCIONES FIN :D ===';
END $$;
