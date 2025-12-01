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