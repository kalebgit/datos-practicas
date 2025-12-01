-- ============================================================================
-- PRUEBAS DE FUNCIONES
-- ============================================================================

-- ----------------------------------------------------------------------------
-- calcular_ocupacion_vuelo
-- ----------------------------------------------------------------------------

SELECT 
    v.numero_vuelo,
    v.ciudad_salida || ' → ' || v.ciudad_llegada as ruta,
    av.capacidad_pasajeros as capacidad_total,
    (SELECT COUNT(*) FROM boleto b 
     INNER JOIN comprar c ON b.boleto_id = c.boleto_id 
     WHERE b.numero_vuelo = v.numero_vuelo) as boletos_vendidos,
    calcular_ocupacion_vuelo(v.numero_vuelo) as ocupacion_porcentaje
FROM vuelo v
INNER JOIN avion av ON v.matricula_avion = av.matricula_avion
LIMIT 10;

-- Prueba con vuelo inexistente (debe retornar 0)
SELECT calcular_ocupacion_vuelo('VUELO_INEXISTENTE') as resultado_vuelo_inexistente;


-- ----------------------------------------------------------------------------
-- obtener_ingresos_vuelo
-- ----------------------------------------------------------------------------

SELECT 
    v.numero_vuelo,
    v.ciudad_salida || ' - ' || v.ciudad_llegada as ruta,
    obtener_ingresos_vuelo(v.numero_vuelo) as ingresos_totales,
    (SELECT COUNT(*) FROM boleto b 
     INNER JOIN comprar c ON b.boleto_id = c.boleto_id 
     WHERE b.numero_vuelo = v.numero_vuelo) as num_boletos
FROM vuelo v
ORDER BY ingresos_totales DESC
LIMIT 10;

-- Prueba con vuelo sin boletos (debe retornar 0)
SELECT obtener_ingresos_vuelo('VUELO_SIN_BOLETOS') as resultado_sin_boletos;


-- ----------------------------------------------------------------------------
-- formatear_info_cliente
-- ----------------------------------------------------------------------------

SELECT 
    cliente_id,
    formatear_info_cliente(cliente_id) as info_formateada,
    nombres,
    apellido_paterno,
    apellido_materno,
    fecha_nacimiento
FROM cliente
LIMIT 10;

-- Prueba con cliente inexistente
SELECT formatear_info_cliente(99999) as cliente_inexistente;


-- ----------------------------------------------------------------------------
-- calcular_duracion_promedio_aerolinea
-- ----------------------------------------------------------------------------

SELECT 
    ae.aerolinea_id,
    ae.razon_social,
    COUNT(DISTINCT v.numero_vuelo) as total_vuelos,
    AVG(v.duracion_minutos) as duracion_minutos_promedio,
    calcular_duracion_promedio_aerolinea(ae.aerolinea_id) as duracion_horas_promedio
FROM aerolineas ae
INNER JOIN avion av ON ae.aerolinea_id = av.aerolinea_id
INNER JOIN vuelo v ON av.matricula_avion = v.matricula_avion
WHERE v.duracion_minutos IS NOT NULL
GROUP BY ae.aerolinea_id, ae.razon_social;

-- Prueba con aerolínea sin vuelos (debe retornar 0)
SELECT calcular_duracion_promedio_aerolinea(99999) as aerolinea_sin_vuelos;


-- ----------------------------------------------------------------------------
-- verificar_asiento_disponible
-- ----------------------------------------------------------------------------

-- Obtener un vuelo con boletos para probar
DO $$
DECLARE
    v_numero_vuelo VARCHAR;
    v_asiento_ocupado VARCHAR;
BEGIN
    -- Obtener un vuelo con al menos un boleto
    SELECT b.numero_vuelo, b.numero_asiento INTO v_numero_vuelo, v_asiento_ocupado
    FROM boleto b
    INNER JOIN comprar c ON b.boleto_id = c.boleto_id
    LIMIT 1;
    
    IF v_numero_vuelo IS NOT NULL THEN
        RAISE NOTICE 'Vuelo de prueba: %', v_numero_vuelo;
        RAISE NOTICE 'Asiento ocupado: % - Disponible: %', 
            v_asiento_ocupado, 
            verificar_asiento_disponible(v_numero_vuelo, v_asiento_ocupado);
        RAISE NOTICE 'Asiento 99Z (inexistente) - Disponible: %', 
            verificar_asiento_disponible(v_numero_vuelo, '99Z');
    ELSE
        RAISE NOTICE 'No hay boletos en la base de datos para probar';
    END IF;
END $$;

-- Consulta para ver asientos disponibles vs ocupados
SELECT 
    b.numero_vuelo,
    b.numero_asiento,
    verificar_asiento_disponible(b.numero_vuelo, b.numero_asiento) as esta_disponible,
    CASE 
        WHEN verificar_asiento_disponible(b.numero_vuelo, b.numero_asiento) 
        THEN 'DISPONIBLE' 
        ELSE 'OCUPADO' 
    END as estado
FROM boleto b
LIMIT 10;


-- ----------------------------------------------------------------------------
-- calcular_edad_cliente
-- ----------------------------------------------------------------------------

SELECT 
    cliente_id,
    formatear_info_cliente(cliente_id) as info_cliente,
    fecha_nacimiento,
    calcular_edad_cliente(cliente_id) as edad_calculada,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento)) as edad_verificacion
FROM cliente
WHERE fecha_nacimiento IS NOT NULL
ORDER BY edad_calculada DESC
LIMIT 10;

-- Prueba con cliente inexistente (debe retornar NULL)
SELECT calcular_edad_cliente(99999) as cliente_inexistente;


-- ============================================================================
-- PRUEBAS DE PROCEDIMIENTOS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- registrar_nuevo_vuelo
-- ----------------------------------------------------------------------------

DO $$
DECLARE
    v_numero_creado VARCHAR;
    v_mensaje TEXT;
    v_matricula_avion VARCHAR;
    v_aeropuerto1 INTEGER;
    v_aeropuerto2 INTEGER;
BEGIN
    -- Obtener una matrícula de avión existente
    SELECT matricula_avion INTO v_matricula_avion
    FROM avion
    LIMIT 1;
    
    -- Obtener dos aeropuertos diferentes
    SELECT aeropuerto_id INTO v_aeropuerto1
    FROM aeropuerto
    LIMIT 1;
    
    SELECT aeropuerto_id INTO v_aeropuerto2
    FROM aeropuerto
    WHERE aeropuerto_id != v_aeropuerto1
    LIMIT 1;
    
    IF v_matricula_avion IS NOT NULL AND v_aeropuerto1 IS NOT NULL AND v_aeropuerto2 IS NOT NULL THEN
        -- Caso exitoso: registrar vuelo válido
        CALL registrar_nuevo_vuelo(
            'TEST001',              -- número vuelo
            1,                      -- tipo vuelo
            v_matricula_avion,      -- matrícula
            v_aeropuerto1,          -- salida
            v_aeropuerto2,          -- llegada
            CURRENT_DATE + 30,      -- fecha salida
            '10:00:00',             -- hora salida
            CURRENT_DATE + 30,      -- fecha llegada
            '14:00:00',             -- hora llegada
            240,                    -- duración minutos
            v_numero_creado,
            v_mensaje
        );
        RAISE NOTICE 'Resultado: %', v_mensaje;
        
        -- Caso error: mismo aeropuerto origen y destino
        CALL registrar_nuevo_vuelo(
            'TEST002',
            1,
            v_matricula_avion,
            v_aeropuerto1,
            v_aeropuerto1,          -- mismo que salida (ERROR)
            CURRENT_DATE + 31,
            '10:00:00',
            CURRENT_DATE + 31,
            '14:00:00',
            240,
            v_numero_creado,
            v_mensaje
        );
        RAISE NOTICE 'Resultado: %', v_mensaje;
        
        -- Caso error: vuelo duplicado
        CALL registrar_nuevo_vuelo(
            'TEST001',              -- mismo número (ERROR)
            1,
            v_matricula_avion,
            v_aeropuerto1,
            v_aeropuerto2,
            CURRENT_DATE + 32,
            '10:00:00',
            CURRENT_DATE + 32,
            '14:00:00',
            240,
            v_numero_creado,
            v_mensaje
        );
        RAISE NOTICE 'Resultado: %', v_mensaje;
        
        -- Caso error: fecha llegada antes de salida
        CALL registrar_nuevo_vuelo(
            'TEST003',
            1,
            v_matricula_avion,
            v_aeropuerto1,
            v_aeropuerto2,
            CURRENT_DATE + 33,
            '14:00:00',             -- sale después
            CURRENT_DATE + 33,
            '10:00:00',             -- llega antes (ERROR)
            240,
            v_numero_creado,
            v_mensaje
        );
        RAISE NOTICE 'Resultado: %', v_mensaje;
    ELSE
        RAISE NOTICE 'No hay datos suficientes para realizar la prueba';
    END IF;
END $$;


-- ----------------------------------------------------------------------------
-- actualizar esstados_vuelos
-- ----------------------------------------------------------------------------

-- Ver estados antes de actualizar
SELECT estado_vuelo, COUNT(*) as cantidad
FROM vuelo
GROUP BY estado_vuelo;

-- Ejecutar actualización
CALL actualizar_estados_vuelos();

-- Ver estados después de actualizar
SELECT estado_vuelo, COUNT(*) as cantidad
FROM vuelo
GROUP BY estado_vuelo;


-- ----------------------------------------------------------------------------
-- procesar_compra_boleto
-- ----------------------------------------------------------------------------

DO $$
DECLARE
    v_cliente_id INTEGER;
    v_numero_vuelo VARCHAR;
    v_boleto_creado INTEGER;
    v_codigo_exito INTEGER;
    v_mensaje TEXT;
BEGIN
    -- Obtener un cliente existente
    SELECT cliente_id INTO v_cliente_id
    FROM cliente
    LIMIT 1;
    
    -- Obtener un vuelo programado con espacio disponible
    SELECT v.numero_vuelo INTO v_numero_vuelo
    FROM vuelo v
    INNER JOIN avion av ON v.matricula_avion = av.matricula_avion
    WHERE v.estado_vuelo = 'programado'
    AND (SELECT COUNT(*) FROM boleto b 
         INNER JOIN comprar c ON b.boleto_id = c.boleto_id 
         WHERE b.numero_vuelo = v.numero_vuelo) < av.capacidad_pasajeros
    LIMIT 1;
    
    IF v_cliente_id IS NOT NULL AND v_numero_vuelo IS NOT NULL THEN
        -- Caso exitoso: compra válida
        CALL procesar_compra_boleto(
            v_cliente_id,
            v_numero_vuelo,
            '15A',                  -- asiento
            'economica',
            2500.00,
            v_boleto_creado,
            v_codigo_exito,
            v_mensaje
        );
        RAISE NOTICE 'Código: %, Mensaje: %', v_codigo_exito, v_mensaje;
        
        -- Caso error: mismo asiento (duplicado)
        CALL procesar_compra_boleto(
            v_cliente_id,
            v_numero_vuelo,
            '15A',                  -- mismo asiento (ERROR)
            'economica',
            2500.00,
            v_boleto_creado,
            v_codigo_exito,
            v_mensaje
        );
        RAISE NOTICE 'Código: %, Mensaje: %', v_codigo_exito, v_mensaje;
        
        -- Caso error: vuelo inexistente
        CALL procesar_compra_boleto(
            v_cliente_id,
            'VUELO_INEXISTENTE',
            '20B',
            'economica',
            2500.00,
            v_boleto_creado,
            v_codigo_exito,
            v_mensaje
        );
        RAISE NOTICE 'Código: %, Mensaje: %', v_codigo_exito, v_mensaje;
    ELSE
        RAISE NOTICE 'No hay datos suficientes para realizar la prueba';
    END IF;
END $$;


-- ----------------------------------------------------------------------------
-- generar_reporte_ocupacion_mensual
-- ----------------------------------------------------------------------------

-- Ejecutar generación de reporte para mes actual
CALL generar_reporte_ocupacion_mensual(
    EXTRACT(MONTH FROM CURRENT_DATE)::INTEGER,
    EXTRACT(YEAR FROM CURRENT_DATE)::INTEGER
);

-- Ver resultados del reporte
SELECT 
    mes,
    anio,
    numero_vuelo,
    ROUND(ocupacion_porcentaje, 2) as ocupacion_pct,
    ROUND(ingresos, 2) as ingresos_vuelo,
    fecha_generacion
FROM reporte_ocupacion
WHERE mes = EXTRACT(MONTH FROM CURRENT_DATE)
AND anio = EXTRACT(YEAR FROM CURRENT_DATE)
ORDER BY ocupacion_porcentaje DESC
LIMIT 10;

-- Estadísticas del reporte
SELECT 
    mes,
    anio,
    COUNT(*) as total_vuelos_reportados,
    ROUND(AVG(ocupacion_porcentaje), 2) as ocupacion_promedio,
    ROUND(SUM(ingresos), 2) as ingresos_totales
FROM reporte_ocupacion
WHERE mes = EXTRACT(MONTH FROM CURRENT_DATE)
AND anio = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY mes, anio;


-- ----------------------------------------------------------------------------
-- cancelar_vuelo_con_reembolso
-- ----------------------------------------------------------------------------


DO $$
DECLARE
    v_numero_vuelo VARCHAR;
    v_boletos_reembolsados INTEGER;
    v_record RECORD;
BEGIN
    -- Obtener un vuelo programado para cancelar
    SELECT numero_vuelo INTO v_numero_vuelo
    FROM vuelo
    WHERE estado_vuelo = 'programado'
    AND numero_vuelo LIKE 'TEST%'
    LIMIT 1;  -- AGREGAR ESTO

    IF v_numero_vuelo IS NOT NULL THEN
        RAISE NOTICE 'Cancelando vuelo: %', v_numero_vuelo;

        CALL cancelar_vuelo_con_reembolso(
            v_numero_vuelo,
            'Prueba de cancelación',
            v_boletos_reembolsados
        );

        RAISE NOTICE 'Boletos reembolsados: %', v_boletos_reembolsados;

        -- COMENTAR O CAMBIAR ESTAS LÍNEAS:
        -- SELECT * FROM reembolso WHERE numero_vuelo = v_numero_vuelo;
        -- SELECT numero_vuelo, estado_vuelo FROM vuelo WHERE numero_vuelo = v_numero_vuelo;

        -- O usar un loop para mostrar:
        FOR v_record IN
            SELECT * FROM reembolso WHERE numero_vuelo = v_numero_vuelo
        LOOP
            RAISE NOTICE 'Reembolso registrado: %', v_record.id_reembolso;
        END LOOP;

    ELSE
        RAISE NOTICE 'No hay vuelos de prueba';
    END IF;
END $$;








-- ----------------------------------------------------------------------------
-- registrar_mantenimiento_avion
-- ----------------------------------------------------------------------------


DO $$
DECLARE
    v_matricula VARCHAR;
BEGIN
    -- Obtener un avión con vuelos programados
    SELECT DISTINCT v.matricula_avion INTO v_matricula
    FROM vuelo v
    WHERE v.estado_vuelo IN ('programado', 'abordando')
    AND v.fecha_salida > CURRENT_DATE
    LIMIT 1;

    IF v_matricula IS NOT NULL THEN
        RAISE NOTICE 'Registrando mantenimiento para avión: %', v_matricula;

        -- Ver vuelos actuales del avión
        SELECT numero_vuelo, fecha_salida, hora_salida, estado_vuelo
        FROM vuelo
        WHERE matricula_avion = v_matricula
        AND fecha_salida > CURRENT_DATE
        ORDER BY fecha_salida;

        -- Registrar mantenimiento que podría afectar vuelos
        CALL registrar_mantenimiento_avion(
            v_matricula,
            'PREVENTIVO',
            'Mantenimiento programado - Revisión de motores y sistemas',
            CURRENT_DATE + 5,
            CURRENT_DATE + 7
        );

        -- Ver tabla de mantenimiento creada
        SELECT * FROM mantenimiento_avion
        WHERE matricula_avion = v_matricula
        ORDER BY fecha_inicio DESC
        LIMIT 5;

        -- Ver vuelos afectados (deberían estar en 'retrasado')
        SELECT numero_vuelo, fecha_salida, estado_vuelo
        FROM vuelo
        WHERE matricula_avion = v_matricula
        AND fecha_salida BETWEEN CURRENT_DATE + 5 AND CURRENT_DATE + 7;
    ELSE
        RAISE NOTICE 'No hay aviones con vuelos programados futuros';
    END IF;
END $$;
