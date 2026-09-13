-- ========================================
-- INSERTS DE LÓGICA DE NEGOCIO - SISTEMA DE AEROLÍNEAS
-- ========================================

-- ========================================
-- CONTRATOS: EMPLEADOS CON AEROLÍNEAS
-- notar que como se pidio en las instrucciones
-- las tablas relacionadas con logica de negocios
-- y no de catalogos se llenan con nuestros 
-- stored procedures
-- ========================================

DO $$
DECLARE
    v_exito BOOLEAN;
    v_mensaje TEXT;
    v_contador INTEGER := 0;
BEGIN
    RAISE NOTICE '=== INICIANDO CONTRATACIONES DE EMPLEADOS POR AEROLÍNEAS ===';

    -- Datos originales de Contratar_aerolinea
    CALL contratar_empleado_aerolinea(1, 1, '2020-01-15', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(1, 2, '2019-06-20', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(1, 3, '2021-03-10', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(1, 4, '2018-09-05', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(2, 5, '2020-02-12', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(2, 6, '2019-11-25', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(2, 7, '2021-07-18', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(3, 8, '2020-04-08', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(3, 9, '2019-08-14', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(3, 10, '2021-05-22', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(4, 11, '2020-03-19', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(4, 12, '2019-12-01', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(5, 13, '2020-05-25', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(5, 14, '2021-02-14', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(6, 15, '2020-01-30', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(6, 16, '2019-10-05', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(7, 17, '2020-06-12', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(7, 18, '2021-01-20', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(8, 19, '2020-07-08', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(8, 20, '2019-09-15', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(9, 21, '2020-08-22', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(9, 22, '2021-04-10', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(10, 23, '2020-09-05', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(10, 24, '2019-11-18', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(11, 25, '2020-10-14', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(11, 26, '2021-06-25', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(12, 27, '2020-11-20', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(12, 28, '2019-07-12', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(13, 29, '2020-12-03', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(13, 30, '2021-03-08', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(14, 31, '2020-02-17', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(14, 32, '2019-12-22', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(15, 33, '2020-04-25', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(15, 34, '2021-01-15', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(16, 35, '2020-05-30', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(16, 36, '2019-08-20', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(17, 37, '2020-06-18', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(17, 38, '2021-02-28', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(18, 39, '2020-07-22', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(18, 40, '2019-10-10', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(19, 41, '2020-08-15', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(19, 42, '2021-05-05', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(20, 43, '2020-09-20', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(20, 44, '2019-11-30', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(21, 45, '2020-10-25', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(21, 46, '2021-04-18', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(22, 47, '2020-11-12', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(22, 48, '2019-09-25', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(23, 49, '2020-12-08', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(23, 50, '2021-06-15', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(24, 1, '2021-07-20', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aerolinea(25, 2, '2021-08-10', v_exito, v_mensaje); v_contador := v_contador + 1;

    RAISE NOTICE '=== % CONTRATACIONES DE EMPLEADOS POR AEROLÍNEAS COMPLETADAS ===', v_contador;
END $$;


-- ========================================
-- CONTRATOS: EMPLEADOS CON AEROPUERTOS
-- ========================================

DO $$
DECLARE
    v_exito BOOLEAN;
    v_mensaje TEXT;
    v_contador INTEGER := 0;
BEGIN
    RAISE NOTICE '=== INICIANDO CONTRATACIONES DE EMPLEADOS POR AEROPUERTOS ===';

    -- Datos originales de Contratar_aeropuerto
    CALL contratar_empleado_aeropuerto(1, 35, '2020-03-15', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(1, 36, '2021-06-01', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(2, 37, '2019-11-20', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(2, 38, '2022-01-10', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(1, 26, '2021-02-15', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(1, 27, '2020-09-01', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(2, 28, '2019-07-10', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(3, 29, '2022-03-20', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(1, 4, '2018-05-15', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(1, 5, '2019-08-01', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(2, 6, '2020-01-20', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(2, 7, '2017-11-05', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(3, 8, '2021-04-12', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(2, 10, '2022-07-15', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(3, 11, '2020-10-08', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL contratar_empleado_aeropuerto(1, 12, '2023-01-15', v_exito, v_mensaje); v_contador := v_contador + 1;

    RAISE NOTICE '=== % CONTRATACIONES DE EMPLEADOS POR AEROPUERTOS COMPLETADAS ===', v_contador;
END $$;


-- ========================================
-- VUELOS: REGISTRAR NUEVOS VUELOS
-- ========================================

DO $$
DECLARE
    v_numero_vuelo_creado VARCHAR;
    v_mensaje TEXT;
    v_contador INTEGER := 0;
BEGIN
    RAISE NOTICE '=== INICIANDO REGISTRO DE VUELOS ===';

    -- Vuelos Enero 2025
    CALL registrar_nuevo_vuelo('AM101', 1, 'XA-001', 1, 2, '2025-01-05', '08:00:00', '2025-01-05', '10:15:00', 135, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM102', 1, 'XA-002', 1, 3, '2025-01-05', '14:00:00', '2025-01-05', '15:30:00', 90, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO201', 1, 'XB-001', 1, 4, '2025-01-10', '09:30:00', '2025-01-10', '11:15:00', 105, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO202', 1, 'XB-002', 5, 2, '2025-01-10', '16:00:00', '2025-01-10', '19:30:00', 210, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB301', 1, 'XC-001', 4, 7, '2025-01-15', '07:00:00', '2025-01-15', '09:00:00', 120, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;

    -- Vuelos Febrero 2025
    CALL registrar_nuevo_vuelo('AM103', 1, 'XA-001', 1, 6, '2025-02-03', '10:30:00', '2025-02-03', '12:40:00', 130, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM104', 1, 'XA-002', 3, 2, '2025-02-08', '13:00:00', '2025-02-08', '15:45:00', 165, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO203', 1, 'XB-001', 1, 11, '2025-02-12', '08:15:00', '2025-02-12', '09:35:00', 80, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB302', 1, 'XC-002', 4, 8, '2025-02-18', '11:00:00', '2025-02-18', '13:30:00', 150, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM105', 1, 'XA-003', 1, 5, '2025-02-22', '15:30:00', '2025-02-22', '17:20:00', 110, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;

    -- Vuelos Marzo 2025
    CALL registrar_nuevo_vuelo('AM106', 1, 'XA-001', 1, 2, '2025-03-05', '09:00:00', '2025-03-05', '11:15:00', 135, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO204', 1, 'XB-002', 3, 4, '2025-03-10', '12:00:00', '2025-03-10', '13:35:00', 95, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB303', 1, 'XC-001', 1, 7, '2025-03-15', '07:30:00', '2025-03-15', '09:50:00', 140, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM107', 1, 'XA-002', 2, 6, '2025-03-20', '14:00:00', '2025-03-20', '17:00:00', 180, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO205', 1, 'XB-001', 1, 19, '2025-03-25', '10:00:00', '2025-03-25', '11:40:00', 100, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;

    -- Vuelos Abril 2025
    CALL registrar_nuevo_vuelo('AM108', 1, 'XA-001', 1, 2, '2025-04-02', '08:30:00', '2025-04-02', '10:40:00', 130, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO206', 1, 'XB-002', 4, 3, '2025-04-05', '13:00:00', '2025-04-05', '14:30:00', 90, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB304', 1, 'XC-002', 5, 8, '2025-04-10', '09:15:00', '2025-04-10', '12:00:00', 165, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM109', 1, 'XA-003', 1, 9, '2025-04-15', '11:00:00', '2025-04-15', '13:00:00', 120, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO207', 1, 'XB-001', 3, 4, '2025-04-20', '15:30:00', '2025-04-20', '17:15:00', 105, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;

    -- Vuelos Mayo 2025
    CALL registrar_nuevo_vuelo('AM110', 1, 'XA-001', 1, 2, '2025-05-03', '07:00:00', '2025-05-03', '09:15:00', 135, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO208', 1, 'XB-002', 2, 6, '2025-05-08', '10:00:00', '2025-05-08', '13:30:00', 210, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB305', 1, 'XC-001', 4, 7, '2025-05-12', '14:00:00', '2025-05-12', '16:30:00', 150, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM111', 1, 'XA-002', 3, 5, '2025-05-18', '08:45:00', '2025-05-18', '10:35:00', 110, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO209', 1, 'XB-001', 1, 10, '2025-05-25', '12:30:00', '2025-05-25', '14:50:00', 140, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;

    -- Vuelos de CARGA
    CALL registrar_nuevo_vuelo('CG101', 2, 'XI-001', 1, 4, '2025-01-10', '22:00:00', '2025-01-11', '00:30:00', 150, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('CG102', 2, 'XI-002', 3, 5, '2025-01-20', '23:30:00', '2025-01-21', '02:30:00', 180, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('CG103', 2, 'XI-001', 1, 2, '2025-02-05', '21:00:00', '2025-02-05', '23:45:00', 165, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('CG104', 2, 'XI-002', 4, 8, '2025-02-15', '22:30:00', '2025-02-16', '01:45:00', 195, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('CG105', 2, 'XI-001', 5, 1, '2025-03-01', '23:00:00', '2025-03-02', '01:20:00', 140, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('CG106', 2, 'XI-002', 3, 4, '2025-04-10', '21:30:00', '2025-04-11', '00:20:00', 170, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('CG107', 2, 'XI-001', 1, 6, '2025-05-05', '22:00:00', '2025-05-06', '01:10:00', 190, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;

    -- Vuelos adicionales
    CALL registrar_nuevo_vuelo('AM112', 1, 'XA-003', 1, 2, '2025-01-08', '11:00:00', '2025-01-08', '13:15:00', 135, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM113', 1, 'XA-001', 4, 1, '2025-01-12', '16:00:00', '2025-01-12', '17:30:00', 90, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO210', 1, 'XB-003', 3, 2, '2025-01-18', '09:00:00', '2025-01-18', '11:00:00', 120, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB306', 1, 'XC-001', 5, 4, '2025-01-22', '13:30:00', '2025-01-22', '15:15:00', 105, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM114', 1, 'XA-002', 1, 8, '2025-02-02', '08:00:00', '2025-02-02', '10:30:00', 150, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO211', 1, 'XB-001', 2, 1, '2025-02-07', '12:00:00', '2025-02-07', '13:50:00', 110, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB307', 1, 'XC-002', 4, 2, '2025-02-14', '10:30:00', '2025-02-14', '12:45:00', 135, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM115', 1, 'XA-001', 3, 1, '2025-02-20', '14:30:00', '2025-02-20', '16:10:00', 100, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO212', 1, 'XB-002', 5, 2, '2025-02-25', '07:30:00', '2025-02-25', '10:30:00', 180, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB308', 1, 'XC-001', 1, 7, '2025-03-02', '11:15:00', '2025-03-02', '13:35:00', 140, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM116', 1, 'XA-003', 4, 3, '2025-03-08', '15:00:00', '2025-03-08', '16:55:00', 115, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO213', 1, 'XB-001', 2, 4, '2025-03-12', '09:30:00', '2025-03-12', '11:40:00', 130, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB309', 1, 'XC-002', 3, 8, '2025-03-18', '13:00:00', '2025-03-18', '15:35:00', 155, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM117', 1, 'XA-001', 1, 6, '2025-04-01', '08:00:00', '2025-04-01', '10:00:00', 120, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO214', 1, 'XB-002', 5, 1, '2025-04-07', '12:30:00', '2025-04-07', '14:15:00', 105, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB310', 1, 'XC-001', 4, 2, '2025-04-12', '10:00:00', '2025-04-12', '12:25:00', 145, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM118', 1, 'XA-002', 3, 4, '2025-04-18', '14:00:00', '2025-04-18', '15:35:00', 95, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO215', 1, 'XB-001', 2, 5, '2025-04-25', '08:30:00', '2025-04-25', '11:45:00', 195, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB311', 1, 'XC-002', 1, 9, '2025-05-02', '11:00:00', '2025-05-02', '13:10:00', 130, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM119', 1, 'XA-001', 4, 1, '2025-05-10', '15:30:00', '2025-05-10', '17:20:00', 110, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO216', 1, 'XB-003', 3, 2, '2025-05-15', '09:00:00', '2025-05-15', '11:30:00', 150, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB312', 1, 'XC-001', 5, 7, '2025-05-22', '12:45:00', '2025-05-22', '15:25:00', 160, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM120', 1, 'XA-003', 1, 2, '2025-05-28', '07:15:00', '2025-05-28', '09:30:00', 135, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;

    -- Vuelos adicionales de aerolíneas internacionales
    CALL registrar_nuevo_vuelo('AC501', 1, 'CA-001', 1, 22, '2025-01-15', '10:00:00', '2025-01-15', '15:30:00', 330, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AS601', 1, 'AS-001', 23, 1, '2025-02-10', '14:00:00', '2025-02-10', '18:45:00', 285, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AF701', 1, 'AF-001', 25, 1, '2025-03-05', '20:00:00', '2025-03-06', '07:30:00', 690, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('DL801', 1, 'DL-001', 1, 22, '2025-01-25', '09:30:00', '2025-01-25', '13:45:00', 255, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('UA901', 1, 'UA-001', 2, 24, '2025-02-20', '11:00:00', '2025-02-20', '14:50:00', 230, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AA801', 1, 'AA-001', 3, 23, '2025-03-15', '08:00:00', '2025-03-15', '10:30:00', 150, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('CG108', 2, 'XI-001', 1, 3, '2025-03-10', '20:00:00', '2025-03-10', '23:30:00', 210, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('CG109', 2, 'XI-002', 4, 5, '2025-04-15', '21:00:00', '2025-04-15', '23:45:00', 165, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('CG110', 2, 'XI-001', 2, 1, '2025-05-20', '22:30:00', '2025-05-21', '01:30:00', 180, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM121', 1, 'XA-001', 1, 2, '2025-01-28', '12:00:00', '2025-01-28', '14:15:00', 135, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VO217', 1, 'XB-002', 4, 5, '2025-02-28', '16:30:00', '2025-02-28', '18:20:00', 110, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('VB313', 1, 'XC-001', 3, 2, '2025-04-30', '10:15:00', '2025-04-30', '12:45:00', 150, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;
    CALL registrar_nuevo_vuelo('AM122', 1, 'XA-002', 1, 7, '2025-05-31', '13:30:00', '2025-05-31', '15:35:00', 125, v_numero_vuelo_creado, v_mensaje); v_contador := v_contador + 1;

    RAISE NOTICE '=== % VUELOS REGISTRADOS EXITOSAMENTE ===', v_contador;
END $$;


-- ========================================
-- ASIGNAR PILOTOS A VUELOS
-- ========================================

DO $$
DECLARE
    v_exito BOOLEAN;
    v_mensaje TEXT;
    v_contador INTEGER := 0;
BEGIN
    RAISE NOTICE '=== INICIANDO ASIGNACIÓN DE PILOTOS A VUELOS ===';

    -- Asignaciones originales de Piloto_vuelo
    CALL asignar_piloto_vuelo(1, 'AM101', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(1, 'AM102', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(2, 'VO201', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(2, 'VO202', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(3, 'VB301', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(4, 'AM103', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(4, 'AM104', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(5, 'VO203', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(6, 'VB302', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(7, 'AM105', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(8, 'AM106', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(9, 'VO204', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(10, 'VB303', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(11, 'AM107', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(12, 'VO205', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(13, 'AM108', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(14, 'VO206', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(15, 'VB304', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(16, 'AM109', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(17, 'VO207', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(18, 'AM110', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(19, 'VO208', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(20, 'VB305', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(21, 'AM111', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(22, 'VO209', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(1, 'AM112', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(2, 'AM113', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(3, 'VO210', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(4, 'VB306', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(5, 'AM114', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(6, 'VO211', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(7, 'VB307', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(8, 'AM115', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(9, 'VO212', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(10, 'VB308', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(11, 'AM116', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(12, 'VO213', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(13, 'VB309', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(14, 'AM117', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(15, 'VO214', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(16, 'VB310', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(17, 'AM118', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(18, 'VO215', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(19, 'VB311', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(20, 'AM119', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(21, 'VO216', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(22, 'VB312', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(23, 'AM120', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(24, 'AC501', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(25, 'AS601', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(26, 'AF701', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(27, 'DL801', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(28, 'UA901', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(29, 'AA801', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(30, 'AM121', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(1, 'VO217', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(2, 'VB313', v_exito, v_mensaje); v_contador := v_contador + 1;
    CALL asignar_piloto_vuelo(3, 'AM122', v_exito, v_mensaje); v_contador := v_contador + 1;

    RAISE NOTICE '=== % ASIGNACIONES DE PILOTOS COMPLETADAS ===', v_contador;
END $$;


-- ========================================
-- COMPRAR BOLETOS
-- ========================================

DO $$
DECLARE
    v_boleto_id INTEGER;
    v_codigo_exito INTEGER;
    v_mensaje TEXT;
    v_compras_exitosas INTEGER := 0;
BEGIN
    RAISE NOTICE '=== INICIANDO COMPRAS DE BOLETOS ===';

    -- Compras para VO202 (muestra de las compras originales)
    CALL procesar_compra_boleto(14, 'VO202', '10A', 'Economica', 1200.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(15, 'VO202', '10B', 'Economica', 1200.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(16, 'VO202', '10C', 'Economica', 1200.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(17, 'VO202', '10D', 'Economica', 1200.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    -- Compras para VB301 (muestra)
    CALL procesar_compra_boleto(5, 'VB301', '10A', 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(6, 'VB301', '10B', 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(7, 'VB301', '10C', 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    -- Compras para VB303 (muestra)
    CALL procesar_compra_boleto(4, 'VB303', '10A', 'Economica', 920.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(5, 'VB303', '10B', 'Economica', 920.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    -- Compras adicionales de diferentes vuelos
    CALL procesar_compra_boleto(1, 'AM101', '1A', 'Primera', 2500.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(2, 'AM101', '1B', 'Primera', 2500.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(3, 'AM101', '2A', 'Ejecutiva', 1800.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(10, 'AM102', '1A', 'Primera', 1500.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(11, 'AM102', '10A', 'Economica', 650.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(12, 'AM102', '10B', 'Economica', 650.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    -- Más compras representativas de distintos vuelos
    CALL procesar_compra_boleto(20, 'AM103', '1A', 'Primera', 2800.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(21, 'AM103', '10A', 'Economica', 1100.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(22, 'AM104', '1A', 'Primera', 2400.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(23, 'AM104', '10A', 'Economica', 1250.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(24, 'VO201', '1A', 'Ejecutiva', 1200.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(25, 'VO201', '10A', 'Economica', 580.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    -- Agregar más compras para alcanzar las 60+ transacciones
    CALL procesar_compra_boleto(26, 'VO203', '1A', 'Ejecutiva', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(27, 'VO203', '10A', 'Economica', 550.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(28, 'AM105', '1A', 'Primera', 1800.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(29, 'AM106', '1A', 'Primera', 2500.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(30, 'AM106', '10A', 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(31, 'VO204', '1A', 'Ejecutiva', 1100.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(32, 'VO204', '10A', 'Economica', 650.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(33, 'VB302', '1A', 'Ejecutiva', 1500.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(34, 'VB302', '10A', 'Economica', 800.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(35, 'AM107', '1A', 'Primera', 3000.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(36, 'AM107', '10A', 'Economica', 1500.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(37, 'VO205', '1A', 'Ejecutiva', 1000.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(38, 'VO205', '10A', 'Economica', 600.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(39, 'AM108', '1A', 'Primera', 2500.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(40, 'AM108', '10A', 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(41, 'VO206', '1A', 'Ejecutiva', 1100.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(42, 'VO206', '10A', 'Economica', 650.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(43, 'VB304', '1A', 'Ejecutiva', 1600.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(44, 'VB304', '10A', 'Economica', 900.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(45, 'AM109', '1A', 'Primera', 2200.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(46, 'AM109', '10A', 'Economica', 850.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(47, 'VO207', '1A', 'Ejecutiva', 1100.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(48, 'VO207', '10A', 'Economica', 650.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(49, 'AM110', '1A', 'Primera', 2500.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(50, 'AM110', '10A', 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(51, 'VO208', '1A', 'Ejecutiva', 2200.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(52, 'VO208', '10A', 'Economica', 1350.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(53, 'VB305', '1A', 'Ejecutiva', 1400.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(54, 'VB305', '10A', 'Economica', 750.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(55, 'AM111', '1A', 'Primera', 1900.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(56, 'AM111', '10A', 'Economica', 750.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(57, 'VO209', '1A', 'Ejecutiva', 1500.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(58, 'VO209', '10A', 'Economica', 850.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(59, 'AM112', '1A', 'Primera', 2500.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(60, 'AM112', '10A', 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(61, 'AM113', '1A', 'Primera', 1500.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(62, 'AM113', '10A', 'Economica', 650.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(63, 'VO210', '1A', 'Ejecutiva', 1300.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(64, 'VO210', '10A', 'Economica', 700.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    CALL procesar_compra_boleto(65, 'VB306', '1A', 'Ejecutiva', 1100.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    RAISE NOTICE '=== COMPRAS COMPLETADAS: % BOLETOS VENDIDOS ===', v_compras_exitosas;
END $$;


-- ========================================
-- OPERACIONES PARA VER RESULTADOS
-- ========================================

-- Actualizar estados de vuelos
CALL actualizar_estados_vuelos();

-- Generar reporte de ocupación mensual (enero 2025)
CALL generar_reporte_ocupacion_mensual(1, 2025);


--verificacion del porcentaje bajo de los vuelos por si interesa
SELECT
      v.numero_vuelo,
      v.fecha_salida,
      v.matricula_avion,
      av.capacidad_pasajeros,
      COUNT(c.boleto_id) as boletos_vendidos,
      CASE
          WHEN av.capacidad_pasajeros > 0 THEN
              ROUND((COUNT(c.boleto_id)::NUMERIC / av.capacidad_pasajeros) * 100, 2)
          ELSE 0
      END as ocupacion
  FROM vuelo v
  LEFT JOIN avion av ON v.matricula_avion = av.matricula_avion
  LEFT JOIN boleto b ON b.numero_vuelo = v.numero_vuelo
  LEFT JOIN comprar c ON c.boleto_id = b.boleto_id
  WHERE EXTRACT(MONTH FROM v.fecha_salida) = 1
    AND EXTRACT(YEAR FROM v.fecha_salida) = 2025
  GROUP BY v.numero_vuelo, v.fecha_salida, v.matricula_avion, av.capacidad_pasajeros
  ORDER BY v.numero_vuelo;









-- ========================================
-- DATOS ADICIONALES PARA CONSULTAS ESPECÍFICAS
-- A partir de aquí agrego datos 
-- para poblar consultas que retornan pocos registros
-- ========================================

-- ========================================
-- VUELOS CON MAYOR DEMANDA: Agregar compras para lograr ocupación >70%
-- ========================================

DO $$
DECLARE
    v_boleto_id INTEGER;
    v_codigo_exito INTEGER;
    v_mensaje TEXT;
    v_compras_exitosas INTEGER := 0;
BEGIN
    RAISE NOTICE '=== INICIANDO COMPRAS ADICIONALES PARA VUELOS CON ALTA DEMANDA ===';

    -- AM101 tiene capacidad 180, necesitamos ~130 boletos para >70% ocupación
    CALL procesar_compra_boleto(8, 'AM101', '3A', 'Ejecutiva', 1800.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(9, 'AM101', '3B', 'Ejecutiva', 1800.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(18, 'AM101', '4A', 'Ejecutiva', 1800.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(19, 'AM101', '4B', 'Ejecutiva', 1800.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(66, 'AM101', '10A', 'Economica', 1300.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(67, 'AM101', '10B', 'Economica', 1300.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(68, 'AM101', '10C', 'Economica', 1300.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(69, 'AM101', '10D', 'Economica', 1300.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(70, 'AM101', '11A', 'Economica', 1300.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(71, 'AM101', '11B', 'Economica', 1300.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(72, 'AM101', '11C', 'Economica', 1300.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(73, 'AM101', '11D', 'Economica', 1300.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(74, 'AM101', '12A', 'Economica', 1300.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(75, 'AM101', '12B', 'Economica', 1300.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    -- AM102 tiene capacidad 189, necesitamos ~135 boletos
    CALL procesar_compra_boleto(1, 'AM102', '2A', 'Ejecutiva', 1100.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(4, 'AM102', '2B', 'Ejecutiva', 1100.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(13, 'AM102', '3A', 'Ejecutiva', 1100.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(76, 'AM102', '10C', 'Economica', 650.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(77, 'AM102', '10D', 'Economica', 650.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(78, 'AM102', '11A', 'Economica', 650.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(79, 'AM102', '11B', 'Economica', 650.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(80, 'AM102', '11C', 'Economica', 650.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    -- VO201 tiene capacidad 186, necesitamos ~135 boletos
    CALL procesar_compra_boleto(2, 'VO201', '2A', 'Ejecutiva', 1200.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(3, 'VO201', '2B', 'Ejecutiva', 1200.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(81, 'VO201', '10B', 'Economica', 580.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(82, 'VO201', '10C', 'Economica', 580.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(83, 'VO201', '10D', 'Economica', 580.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(84, 'VO201', '11A', 'Economica', 580.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(85, 'VO201', '11B', 'Economica', 580.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    -- VB301 tiene capacidad 186, necesitamos ~135 boletos (ya tiene 3, agregar más)
    CALL procesar_compra_boleto(8, 'VB301', '10D', 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(9, 'VB301', '11A', 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(86, 'VB301', '11B', 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(87, 'VB301', '11C', 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(88, 'VB301', '11D', 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;
    CALL procesar_compra_boleto(89, 'VB301', '12A', 'Economica', 950.00, v_boleto_id, v_codigo_exito, v_mensaje);
    IF v_codigo_exito = 1 THEN v_compras_exitosas := v_compras_exitosas + 1; END IF;

    RAISE NOTICE '=== % COMPRAS ADICIONALES PARA ALTA DEMANDA COMPLETADAS ===', v_compras_exitosas;
END $$;


-- ========================================
-- CRÉDITOS Y COMPENSACIÓN: Agregar registros para más clientes
-- ========================================

DO $$
DECLARE
    v_contador INTEGER := 0;
BEGIN
    RAISE NOTICE '=== INICIANDO REGISTROS DE CRÉDITOS Y COMPENSACIONES ===';

    -- Agregar créditos por cancelación de vuelo y compensaciones
    INSERT INTO creditos (cliente_id, monto, fecha_emision, fecha_vencimiento, usado, origen)
    VALUES
    (1, 1500.00, CURRENT_DATE - INTERVAL '30 days', CURRENT_DATE + INTERVAL '365 days', FALSE, 'cancelacion_vuelo'),
    (2, 2000.00, CURRENT_DATE - INTERVAL '25 days', CURRENT_DATE + INTERVAL '365 days', FALSE, 'cancelacion_vuelo'),
    (3, 1200.00, CURRENT_DATE - INTERVAL '20 days', CURRENT_DATE + INTERVAL '365 days', FALSE, 'compensacion'),
    (4, 1800.00, CURRENT_DATE - INTERVAL '15 days', CURRENT_DATE + INTERVAL '365 days', FALSE, 'cancelacion_vuelo'),
    (5, 1000.00, CURRENT_DATE - INTERVAL '10 days', CURRENT_DATE + INTERVAL '365 days', FALSE, 'compensacion'),
    (6, 2500.00, CURRENT_DATE - INTERVAL '8 days', CURRENT_DATE + INTERVAL '365 days', FALSE, 'cancelacion_vuelo'),
    (7, 1300.00, CURRENT_DATE - INTERVAL '5 days', CURRENT_DATE + INTERVAL '365 days', FALSE, 'compensacion'),
    (8, 1700.00, CURRENT_DATE - INTERVAL '3 days', CURRENT_DATE + INTERVAL '365 days', FALSE, 'cancelacion_vuelo'),
    (9, 900.00, CURRENT_DATE - INTERVAL '2 days', CURRENT_DATE + INTERVAL '365 days', FALSE, 'compensacion'),
    (10, 2200.00, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE + INTERVAL '365 days', FALSE, 'cancelacion_vuelo');

    v_contador := v_contador + 10;
    RAISE NOTICE '=== % REGISTROS DE CRÉDITOS COMPLETADOS ===', v_contador;
END $$;


-- ========================================
-- EMPLEADOS MULTITAREA: Actualizar salarios NULL para empleados que trabajan en aerolínea y aeropuerto
-- ========================================

DO $$
DECLARE
    v_contador INTEGER := 0;
BEGIN
    RAISE NOTICE '=== INICIANDO ACTUALIZACIÓN DE SALARIOS PARA EMPLEADOS MULTITAREA ===';

    -- Actualizar salarios basados en el tipo de empleado
    UPDATE empleado SET salario = 85000.00 WHERE empleado_id = 4 AND salario IS NULL; v_contador := v_contador + 1;
    UPDATE empleado SET salario = 78000.00 WHERE empleado_id = 5 AND salario IS NULL; v_contador := v_contador + 1;
    UPDATE empleado SET salario = 82000.00 WHERE empleado_id = 6 AND salario IS NULL; v_contador := v_contador + 1;
    UPDATE empleado SET salario = 76000.00 WHERE empleado_id = 7 AND salario IS NULL; v_contador := v_contador + 1;
    UPDATE empleado SET salario = 79000.00 WHERE empleado_id = 8 AND salario IS NULL; v_contador := v_contador + 1;
    UPDATE empleado SET salario = 81000.00 WHERE empleado_id = 10 AND salario IS NULL; v_contador := v_contador + 1;
    UPDATE empleado SET salario = 83000.00 WHERE empleado_id = 11 AND salario IS NULL; v_contador := v_contador + 1;
    UPDATE empleado SET salario = 77000.00 WHERE empleado_id = 12 AND salario IS NULL; v_contador := v_contador + 1;
    UPDATE empleado SET salario = 80000.00 WHERE empleado_id = 26 AND salario IS NULL; v_contador := v_contador + 1;
    UPDATE empleado SET salario = 84000.00 WHERE empleado_id = 27 AND salario IS NULL; v_contador := v_contador + 1;
    UPDATE empleado SET salario = 75000.00 WHERE empleado_id = 28 AND salario IS NULL; v_contador := v_contador + 1;
    UPDATE empleado SET salario = 86000.00 WHERE empleado_id = 29 AND salario IS NULL; v_contador := v_contador + 1;

    RAISE NOTICE '=== % SALARIOS DE EMPLEADOS MULTITAREA ACTUALIZADOS ===', v_contador;
END $$;


-- ========================================
-- HISTORIAL DE CAMBIOS DE PRECIO: Agregar registros de cambios de precio en boletos
-- ========================================

DO $$
DECLARE
    v_contador INTEGER := 0;
BEGIN
    RAISE NOTICE '=== INICIANDO REGISTROS DE HISTORIAL DE CAMBIOS DE PRECIO ===';

    -- Insertar historial de precios para boletos existentes
    -- Boleto 1: cambio de precio antes de la compra
    INSERT INTO historial_precios_boleto (boleto_id, precio_anterior, precio_nuevo, fecha_cambio, motivo)
    VALUES
    (1, 2300.00, 2500.00, CURRENT_DATE - INTERVAL '5 days', 'Ajuste por demanda alta'),
    (2, 2300.00, 2500.00, CURRENT_DATE - INTERVAL '4 days', 'Ajuste por demanda alta'),
    (3, 1600.00, 1800.00, CURRENT_DATE - INTERVAL '6 days', 'Ajuste por temporada alta'),
    (10, 1300.00, 1500.00, CURRENT_DATE - INTERVAL '7 days', 'Ajuste por disponibilidad limitada'),
    (11, 550.00, 650.00, CURRENT_DATE - INTERVAL '3 days', 'Ajuste por inflación'),
    (12, 550.00, 650.00, CURRENT_DATE - INTERVAL '3 days', 'Ajuste por inflación'),
    (20, 2600.00, 2800.00, CURRENT_DATE - INTERVAL '8 days', 'Ajuste por demanda alta'),
    (21, 1000.00, 1100.00, CURRENT_DATE - INTERVAL '2 days', 'Ajuste por temporada alta'),
    (22, 2200.00, 2400.00, CURRENT_DATE - INTERVAL '9 days', 'Ajuste por disponibilidad limitada'),
    (23, 1150.00, 1250.00, CURRENT_DATE - INTERVAL '1 day', 'Ajuste por demanda alta'),
    (24, 1100.00, 1200.00, CURRENT_DATE - INTERVAL '10 days', 'Ajuste por temporada alta'),
    (25, 500.00, 580.00, CURRENT_DATE - INTERVAL '4 days', 'Ajuste por inflación');

    v_contador := v_contador + 12;
    RAISE NOTICE '=== % REGISTROS DE HISTORIAL DE PRECIOS COMPLETADOS ===', v_contador;
END $$;


-- ========================================
-- ESTADOS DE VUELOS: Actualizar para tener variedad en estados
-- ========================================

DO $$
DECLARE
    v_contador INTEGER := 0;
BEGIN
    RAISE NOTICE '=== INICIANDO ACTUALIZACIÓN DE ESTADOS DE VUELOS ===';

    -- Actualizar estados para tener variedad: programado, en_vuelo, retrasado, cancelado
    -- Vuelos programados (futuros)
    UPDATE vuelo SET estado = 'programado' WHERE numero_vuelo = 'AM110'; v_contador := v_contador + 1;
    UPDATE vuelo SET estado = 'programado' WHERE numero_vuelo = 'VO208'; v_contador := v_contador + 1;
    UPDATE vuelo SET estado = 'programado' WHERE numero_vuelo = 'VB305'; v_contador := v_contador + 1;
    UPDATE vuelo SET estado = 'programado' WHERE numero_vuelo = 'AM111'; v_contador := v_contador + 1;
    UPDATE vuelo SET estado = 'programado' WHERE numero_vuelo = 'VO209'; v_contador := v_contador + 1;

    -- Vuelos en vuelo (actualmente volando)
    UPDATE vuelo SET estado = 'en_vuelo' WHERE numero_vuelo = 'AM109'; v_contador := v_contador + 1;
    UPDATE vuelo SET estado = 'en_vuelo' WHERE numero_vuelo = 'VO207'; v_contador := v_contador + 1;
    UPDATE vuelo SET estado = 'en_vuelo' WHERE numero_vuelo = 'VB304'; v_contador := v_contador + 1;

    -- Vuelos retrasados
    UPDATE vuelo SET estado = 'retrasado' WHERE numero_vuelo = 'AM108'; v_contador := v_contador + 1;
    UPDATE vuelo SET estado = 'retrasado' WHERE numero_vuelo = 'VO206'; v_contador := v_contador + 1;
    UPDATE vuelo SET estado = 'retrasado' WHERE numero_vuelo = 'VB302'; v_contador := v_contador + 1;
    UPDATE vuelo SET estado = 'retrasado' WHERE numero_vuelo = 'AM107'; v_contador := v_contador + 1;

    -- Vuelos cancelados
    UPDATE vuelo SET estado = 'cancelado' WHERE numero_vuelo = 'CG101'; v_contador := v_contador + 1;
    UPDATE vuelo SET estado = 'cancelado' WHERE numero_vuelo = 'CG102'; v_contador := v_contador + 1;

    RAISE NOTICE '=== % ESTADOS DE VUELOS ACTUALIZADOS ===', v_contador;
END $$;


-- ========================================
-- CLIENTES SIN ACTIVIDAD: Actualizar fechas de compra para simular inactividad
-- ========================================

DO $$
DECLARE
    v_contador INTEGER := 0;
BEGIN
    RAISE NOTICE '=== INICIANDO ACTUALIZACIÓN DE FECHAS PARA CLIENTES SIN ACTIVIDAD ===';

    -- Actualizar fecha de compra a más de 60 días atrás para varios clientes
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '90 days' WHERE cliente_id = 66; v_contador := v_contador + 1;
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '85 days' WHERE cliente_id = 67; v_contador := v_contador + 1;
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '80 days' WHERE cliente_id = 68; v_contador := v_contador + 1;
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '75 days' WHERE cliente_id = 69; v_contador := v_contador + 1;
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '70 days' WHERE cliente_id = 71; v_contador := v_contador + 1;
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '95 days' WHERE cliente_id = 72; v_contador := v_contador + 1;
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '100 days' WHERE cliente_id = 73; v_contador := v_contador + 1;
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '105 days' WHERE cliente_id = 74; v_contador := v_contador + 1;
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '110 days' WHERE cliente_id = 76; v_contador := v_contador + 1;
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '115 days' WHERE cliente_id = 77; v_contador := v_contador + 1;
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '120 days' WHERE cliente_id = 78; v_contador := v_contador + 1;
    UPDATE comprar SET fecha_compra = CURRENT_DATE - INTERVAL '125 days' WHERE cliente_id = 79; v_contador := v_contador + 1;

    RAISE NOTICE '=== % FECHAS DE COMPRA ACTUALIZADAS PARA CLIENTES INACTIVOS ===', v_contador;
END $$;