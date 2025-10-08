-- ========================================
-- SISTEMA DE AEROLÍNEAS - DML 
-- ========================================

-- ========================================
-- 1. TIPOS DE VUELO
-- ========================================
INSERT INTO Tipo_vuelo (Tipo_vuelo_id, Nombre, Descripcion) VALUES
(1, 'Pasajeros', 'Vuelo comercial regular para transporte de pasajeros'),
(2, 'Carga', 'Vuelo dedicado exclusivamente al transporte de carga'),
(3, 'Mixto', 'Vuelo que transporta tanto pasajeros como carga');

-- ========================================
-- 2. AEROLÍNEAS 
-- ========================================
INSERT INTO Aerolineas (Aerolinea_id, Razon_social, Pais_origen_empresa, Ciudad, Pais) VALUES
(1, 'Aeromexico', 'México', 'Ciudad de México', 'México'),
(2, 'Volaris', 'México', 'Ciudad de México', 'México'),
(3, 'VivaAerobus', 'México', 'Monterrey', 'México'),
(4, 'Aeromar', 'México', 'Ciudad de México', 'México'),
(5, 'Calafia Airlines', 'México', 'La Paz', 'México'),
(6, 'TAR Aerolíneas', 'México', 'Querétaro', 'México'),
(7, 'Magnicharters', 'México', 'Ciudad de México', 'México'),
(8, 'Interjet', 'México', 'Toluca', 'México'),
(9, 'AeroUnion', 'México', 'Ciudad de México', 'México'),
(10, 'Aéreo Calafia', 'México', 'Tijuana', 'México'),
(11, 'Air Canada', 'Canadá', 'Montreal', 'Canadá'),
(12, 'Alaska Airlines', 'Estados Unidos', 'Seattle', 'Estados Unidos'),
(13, 'Air France', 'Francia', 'París', 'Francia'),
(14, 'Lufthansa', 'Alemania', 'Frankfurt', 'Alemania'),
(15, 'Iberia', 'España', 'Madrid', 'España'),
(16, 'Avianca', 'Colombia', 'Bogotá', 'Colombia'),
(17, 'Copa Airlines', 'Panamá', 'Panamá', 'Panamá'),
(18, 'LATAM', 'Chile', 'Santiago', 'Chile'),
(19, 'Delta Airlines', 'Estados Unidos', 'Atlanta', 'Estados Unidos'),
(20, 'United Airlines', 'Estados Unidos', 'Chicago', 'Estados Unidos'),
(21, 'American Airlines', 'Estados Unidos', 'Dallas', 'Estados Unidos'),
(22, 'British Airways', 'Reino Unido', 'Londres', 'Reino Unido'),
(23, 'Southwest Airlines', 'Estados Unidos', 'Dallas', 'Estados Unidos'),
(24, 'JetBlue', 'Estados Unidos', 'Nueva York', 'Estados Unidos'),
(25, 'Spirit Airlines', 'Estados Unidos', 'Miami', 'Estados Unidos');

-- ========================================
-- 3. AEROPUERTOS 
-- ========================================
INSERT INTO Aeropuerto (Aeropuerto_id, Nombre, Pais, Ciudad) VALUES
(1, 'Aeropuerto Internacional de la Ciudad de México', 'México', 'Ciudad de México'),
(2, 'Aeropuerto Internacional de Cancún', 'México', 'Cancún'),
(3, 'Aeropuerto Internacional de Guadalajara', 'México', 'Guadalajara'),
(4, 'Aeropuerto Internacional de Monterrey', 'México', 'Monterrey'),
(5, 'Aeropuerto Internacional de Tijuana', 'México', 'Tijuana'),
(6, 'Aeropuerto Internacional de Los Cabos', 'México', 'Los Cabos'),
(7, 'Aeropuerto Internacional de Puerto Vallarta', 'México', 'Puerto Vallarta'),
(8, 'Aeropuerto Internacional de Mérida', 'México', 'Mérida'),
(9, 'Aeropuerto Internacional de Mazatlán', 'México', 'Mazatlán'),
(10, 'Aeropuerto Internacional de Acapulco', 'México', 'Acapulco'),
(11, 'Aeropuerto Internacional de Oaxaca', 'México', 'Oaxaca'),
(12, 'Aeropuerto Internacional de Puebla', 'México', 'Puebla'),
(13, 'Aeropuerto Internacional de Querétaro', 'México', 'Querétaro'),
(14, 'Aeropuerto Internacional de Toluca', 'México', 'Toluca'),
(15, 'Aeropuerto Internacional de Chihuahua', 'México', 'Chihuahua'),
(16, 'Aeropuerto Internacional de Hermosillo', 'México', 'Hermosillo'),
(17, 'Aeropuerto Internacional de Culiacán', 'México', 'Culiacán'),
(18, 'Aeropuerto Internacional de La Paz', 'México', 'La Paz'),
(19, 'Aeropuerto Internacional de Veracruz', 'México', 'Veracruz'),
(20, 'Aeropuerto Internacional de Durango', 'México', 'Durango'),
(21, 'Aeropuerto Internacional de León', 'México', 'León'),
(22, 'Aeropuerto John F. Kennedy', 'Estados Unidos', 'Nueva York'),
(23, 'Aeropuerto de Los Ángeles', 'Estados Unidos', 'Los Ángeles'),
(24, 'Aeropuerto de Miami', 'Estados Unidos', 'Miami'),
(25, 'Aeropuerto Charles de Gaulle', 'Francia', 'París');

-- ========================================
-- 4. EMPLEADOS 
-- ========================================
INSERT INTO Empleado (Empleado_id, Nombres, Apellido_paterno, Apellido_materno) VALUES
(1, 'Juan', 'Pérez', 'García'), (2, 'María', 'González', 'López'), (3, 'Carlos', 'Rodríguez', 'Martínez'),
(4, 'Ana', 'Martínez', 'Hernández'), (5, 'Jorge', 'Pérez', 'Sánchez'), (6, 'Laura', 'Sánchez', 'Díaz'),
(7, 'Miguel', 'Díaz', 'Torres'), (8, 'Fernanda', 'López', 'Ramírez'), (9, 'Diego', 'Jiménez', 'Flores'),
(10, 'Gabriela', 'Torres', 'Castro'), (11, 'Ricardo', 'Vargas', 'Morales'), (12, 'Isabel', 'Cruz', 'Ramos'),
(13, 'Oscar', 'Herrera', 'Ruiz'), (14, 'Adriana', 'Morales', 'Ortega'), (15, 'Sergio', 'Ortega', 'Silva'),
(16, 'Patricia', 'Castro', 'Méndez'), (17, 'Francisco', 'Núñez', 'Reyes'), (18, 'Lucía', 'Ramírez', 'Vega'),
(19, 'Eduardo', 'Campos', 'Guerrero'), (20, 'Daniela', 'Reyes', 'Medina'), (21, 'Roberto', 'Silva', 'Delgado'),
(22, 'Elena', 'Mendoza', 'Rojas'), (23, 'Arturo', 'Delgado', 'Acosta'), (24, 'Verónica', 'Rojas', 'Espinoza'),
(25, 'Raúl', 'Medina', 'Navarro'), (26, 'Carolina', 'Espinoza', 'Cruz'), (27, 'Guillermo', 'Acosta', 'Peña'),
(28, 'Sofía', 'Navarro', 'Luna'), (29, 'Javier', 'Peña', 'Campos'), (30, 'Mónica', 'Luna', 'Fuentes'),
(31, 'Alberto', 'Campos', 'Santos'), (32, 'Cristina', 'Fuentes', 'Aguilar'), (33, 'Luis', 'Santos', 'Jiménez'),
(34, 'Andrea', 'Aguilar', 'Carrillo'), (35, 'Manuel', 'Carrillo', 'Pacheco'), (36, 'Claudia', 'Pacheco', 'Muñoz'),
(37, 'Rodrigo', 'Muñoz', 'Cortés'), (38, 'Valeria', 'Cortés', 'Maldonado'), (39, 'Héctor', 'Maldonado', 'Guzmán'),
(40, 'Diana', 'Guzmán', 'Alvarado'), (41, 'Alejandro', 'Alvarado', 'Bravo'), (42, 'Mariana', 'Bravo', 'Mendoza'),
(43, 'Pablo', 'Mendoza', 'Castillo'), (44, 'Natalia', 'Castillo', 'Mora'), (45, 'Víctor', 'Mora', 'Herrera'),
(46, 'Paola', 'Herrera', 'Gil'), (47, 'Andrés', 'Gil', 'Vargas'), (48, 'Lorena', 'Vargas', 'Ibarra'),
(49, 'Fernando', 'Ibarra', 'León'), (50, 'Carmen', 'León', 'Ríos');

-- ========================================
-- 5. CONTRATAR - 
-- ========================================
INSERT INTO Contratar (Aerolinea_id, Empleado_id, Fecha_ingreso) VALUES
(1, 1, '2020-01-15'), (1, 2, '2019-06-20'), (1, 3, '2021-03-10'), (1, 4, '2018-09-05'),
(2, 5, '2020-02-12'), (2, 6, '2019-11-25'), (2, 7, '2021-07-18'),
(3, 8, '2020-04-08'), (3, 9, '2019-08-14'), (3, 10, '2021-05-22'),
(4, 11, '2020-03-19'), (4, 12, '2019-12-01'),
(5, 13, '2020-05-25'), (5, 14, '2021-02-14'),
(6, 15, '2020-01-30'), (6, 16, '2019-10-05'),
(7, 17, '2020-06-12'), (7, 18, '2021-01-20'),
(8, 19, '2020-07-08'), (8, 20, '2019-09-15'),
(9, 21, '2020-08-22'), (9, 22, '2021-04-10'),
(10, 23, '2020-09-05'), (10, 24, '2019-11-18'),
(11, 25, '2020-10-14'), (11, 26, '2021-06-25'),
(12, 27, '2020-11-20'), (12, 28, '2019-07-12'),
(13, 29, '2020-12-03'), (13, 30, '2021-03-08'),
(14, 31, '2020-02-17'), (14, 32, '2019-12-22'),
(15, 33, '2020-04-25'), (15, 34, '2021-01-15'),
(16, 35, '2020-05-30'), (16, 36, '2019-08-20'),
(17, 37, '2020-06-18'), (17, 38, '2021-02-28'),
(18, 39, '2020-07-22'), (18, 40, '2019-10-10'),
(19, 41, '2020-08-15'), (19, 42, '2021-05-05'),
(20, 43, '2020-09-20'), (20, 44, '2019-11-30'),
(21, 45, '2020-10-25'), (21, 46, '2021-04-18'),
(22, 47, '2020-11-12'), (22, 48, '2019-09-25'),
(23, 49, '2020-12-08'), (23, 50, '2021-06-15'),
(24, 1, '2021-07-20'), (25, 2, '2021-08-10');

-- ========================================
-- 6. AVIONES 
-- ========================================
INSERT INTO Avion (Matricula_avion, Capacidad_pasajeros, Modelo, Aerolinea_id) VALUES
('XA-001', 180, 'Boeing 737-800', 1), ('XA-002', 189, 'Airbus A320', 1), ('XA-003', 220, 'Boeing 787', 1),
('XB-001', 186, 'Airbus A320neo', 2), ('XB-002', 174, 'Airbus A320', 2), ('XB-003', 186, 'Airbus A320neo', 2),
('XC-001', 186, 'Airbus A320', 3), ('XC-002', 186, 'Airbus A320', 3),
('XD-001', 50, 'ATR 42', 4), ('XD-002', 48, 'ATR 42', 4),
('XE-001', 98, 'Embraer E190', 5), ('XE-002', 100, 'Embraer E195', 5),
('XF-001', 130, 'Airbus A319', 6),
('XG-001', 189, 'Boeing 737-800', 7), ('XG-002', 189, 'Boeing 737-800', 7),
('XH-001', 150, 'Airbus A320', 8),
('XI-001', 0, 'Boeing 737-800F', 9), ('XI-002', 0, 'Boeing 767-300F', 9),
('XJ-001', 174, 'Airbus A320', 10),
('CA-001', 200, 'Boeing 787-9', 11), ('CA-002', 220, 'Airbus A330', 11),
('AS-001', 181, 'Boeing 737 MAX', 12), ('AS-002', 178, 'Boeing 737-900', 12),
('AF-001', 280, 'Airbus A350', 13), ('AF-002', 262, 'Boeing 777', 13),
('LH-001', 236, 'Airbus A340', 14),
('IB-001', 200, 'Airbus A330', 15),
('AV-001', 138, 'Airbus A319', 16), ('AV-002', 150, 'Airbus A320', 16),
('CM-001', 160, 'Boeing 737-800', 17),
('LA-001', 220, 'Boeing 787', 18), ('LA-002', 174, 'Airbus A320', 18),
('DL-001', 150, 'Airbus A320', 19), ('DL-002', 200, 'Boeing 757', 19),
('UA-001', 179, 'Boeing 737-900', 20), ('UA-002', 160, 'Airbus A320', 20),
('AA-001', 172, 'Boeing 737-800', 21), ('AA-002', 260, 'Boeing 777', 21),
('BA-001', 275, 'Boeing 787-9', 22),
('WN-001', 175, 'Boeing 737-800', 23),
('B6-001', 162, 'Airbus A320', 24),
('NK-001', 178, 'Airbus A320neo', 25);

-- ========================================
-- 7. PILOTOS
-- ========================================
INSERT INTO Piloto (Piloto_id, Empleado_id, Licencia, Horas_vuelo, Fecha_vencimiento_licencia) VALUES
(1, 1, 'ATP-001234', 5000, '2026-06-30'),
(2, 2, 'ATP-002345', 4500, '2026-08-15'),
(3, 3, 'ATP-003456', 6000, '2026-12-31'),
(4, 5, 'ATP-005678', 3500, '2026-05-20'),
(5, 6, 'ATP-006789', 4000, '2026-09-10'),
(6, 8, 'ATP-008901', 3800, '2026-11-25'),
(7, 9, 'ATP-009012', 4200, '2026-07-14'),
(8, 11, 'ATP-011234', 5500, '2026-10-05'),
(9, 13, 'ATP-013456', 3200, '2026-04-18'),
(10, 15, 'ATP-015678', 4800, '2026-08-22'),
(11, 17, 'ATP-017890', 3900, '2026-06-12'),
(12, 19, 'ATP-019012', 5200, '2026-12-15'),
(13, 21, 'ATP-021234', 4100, '2026-03-30'),
(14, 23, 'ATP-023456', 3600, '2026-09-25'),
(15, 25, 'ATP-025678', 4700, '2026-11-08'),
(16, 27, 'ATP-027890', 5100, '2026-05-15'),
(17, 29, 'ATP-029012', 3400, '2026-07-22'),
(18, 31, 'ATP-031234', 4600, '2026-10-18'),
(19, 33, 'ATP-033456', 3700, '2026-04-25'),
(20, 35, 'ATP-035678', 5300, '2026-08-30'),
(21, 37, 'ATP-037890', 4300, '2026-12-05'),
(22, 39, 'ATP-039012', 3500, '2026-06-20'),
(23, 41, 'ATP-041234', 4900, '2026-09-15'),
(24, 43, 'ATP-043456', 5400, '2026-11-28'),
(25, 45, 'ATP-045678', 3300, '2026-03-10'),
(26, 47, 'ATP-047890', 4400, '2026-07-05'),
(27, 49, 'ATP-049012', 5000, '2026-10-22'),
(28, 4, 'ATP-004567', 3800, '2026-05-30'),
(29, 7, 'ATP-007890', 4200, '2026-08-18'),
(30, 10, 'ATP-010123', 4600, '2026-12-10');

-- ========================================
-- 8. VUELOS
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, 
                   Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada,
                   Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
-- Enero 2025
('AM101', 1, 'Completado', '02:15:00', '2025-01-05', '08:00:00', 'Ciudad de México', 'México', '2025-01-05', '10:15:00', 'Cancún', 'México', 'XA-001', 1, 2),
('AM102', 1, 'Completado', '01:30:00', '2025-01-05', '14:00:00', 'Ciudad de México', 'México', '2025-01-05', '15:30:00', 'Guadalajara', 'México', 'XA-002', 1, 3),
('VO201', 1, 'Completado', '01:45:00', '2025-01-10', '09:30:00', 'Ciudad de México', 'México', '2025-01-10', '11:15:00', 'Monterrey', 'México', 'XB-001', 1, 4),
('VO202', 1, 'Completado', '03:30:00', '2025-01-10', '16:00:00', 'Tijuana', 'México', '2025-01-10', '19:30:00', 'Cancún', 'México', 'XB-002', 5, 2),
('VB301', 1, 'Completado', '02:00:00', '2025-01-15', '07:00:00', 'Monterrey', 'México', '2025-01-15', '09:00:00', 'Puerto Vallarta', 'México', 'XC-001', 4, 7),
-- Febrero 2025
('AM103', 1, 'Completado', '02:10:00', '2025-02-03', '10:30:00', 'Ciudad de México', 'México', '2025-02-03', '12:40:00', 'Los Cabos', 'México', 'XA-001', 1, 6),
('AM104', 1, 'Completado', '02:45:00', '2025-02-08', '13:00:00', 'Guadalajara', 'México', '2025-02-08', '15:45:00', 'Cancún', 'México', 'XA-002', 3, 2),
('VO203', 1, 'Completado', '01:20:00', '2025-02-12', '08:15:00', 'Ciudad de México', 'México', '2025-02-12', '09:35:00', 'Oaxaca', 'México', 'XB-001', 1, 11),
('VB302', 1, 'Completado', '02:30:00', '2025-02-18', '11:00:00', 'Monterrey', 'México', '2025-02-18', '13:30:00', 'Mérida', 'México', 'XC-002', 4, 8),
('AM105', 1, 'Completado', '01:50:00', '2025-02-22', '15:30:00', 'Ciudad de México', 'México', '2025-02-22', '17:20:00', 'Tijuana', 'México', 'XA-003', 1, 5),
-- Marzo 2025
('AM106', 1, 'Completado', '02:15:00', '2025-03-05', '09:00:00', 'Ciudad de México', 'México', '2025-03-05', '11:15:00', 'Cancún', 'México', 'XA-001', 1, 2),
('VO204', 1, 'Completado', '01:35:00', '2025-03-10', '12:00:00', 'Guadalajara', 'México', '2025-03-10', '13:35:00', 'Monterrey', 'México', 'XB-002', 3, 4),
('VB303', 1, 'Completado', '02:20:00', '2025-03-15', '07:30:00', 'Ciudad de México', 'México', '2025-03-15', '09:50:00', 'Puerto Vallarta', 'México', 'XC-001', 1, 7),
('AM107', 1, 'Completado', '03:00:00', '2025-03-20', '14:00:00', 'Cancún', 'México', '2025-03-20', '17:00:00', 'Los Cabos', 'México', 'XA-002', 2, 6),
('VO205', 1, 'Completado', '01:40:00', '2025-03-25', '10:00:00', 'Ciudad de México', 'México', '2025-03-25', '11:40:00', 'Veracruz', 'México', 'XB-001', 1, 19),
-- Abril 2025
('AM108', 1, 'Programado', '02:10:00', '2025-04-02', '08:30:00', 'Ciudad de México', 'México', '2025-04-02', '10:40:00', 'Cancún', 'México', 'XA-001', 1, 2),
('VO206', 1, 'Programado', '01:30:00', '2025-04-05', '13:00:00', 'Monterrey', 'México', '2025-04-05', '14:30:00', 'Guadalajara', 'México', 'XB-002', 4, 3),
('VB304', 1, 'Programado', '02:45:00', '2025-04-10', '09:15:00', 'Tijuana', 'México', '2025-04-10', '12:00:00', 'Mérida', 'México', 'XC-002', 5, 8),
('AM109', 1, 'Programado', '02:00:00', '2025-04-15', '11:00:00', 'Ciudad de México', 'México', '2025-04-15', '13:00:00', 'Mazatlán', 'México', 'XA-003', 1, 9),
('VO207', 1, 'Programado', '01:45:00', '2025-04-20', '15:30:00', 'Guadalajara', 'México', '2025-04-20', '17:15:00', 'Monterrey', 'México', 'XB-001', 3, 4),
-- Mayo 2025
('AM110', 1, 'Programado', '02:15:00', '2025-05-03', '07:00:00', 'Ciudad de México', 'México', '2025-05-03', '09:15:00', 'Cancún', 'México', 'XA-001', 1, 2),
('VO208', 1, 'Programado', '03:30:00', '2025-05-08', '10:00:00', 'Cancún', 'México', '2025-05-08', '13:30:00', 'Los Cabos', 'México', 'XB-002', 2, 6),
('VB305', 1, 'Programado', '02:30:00', '2025-05-12', '14:00:00', 'Monterrey', 'México', '2025-05-12', '16:30:00', 'Puerto Vallarta', 'México', 'XC-001', 4, 7),
('AM111', 1, 'Programado', '01:50:00', '2025-05-18', '08:45:00', 'Guadalajara', 'México', '2025-05-18', '10:35:00', 'Tijuana', 'México', 'XA-002', 3, 5),
('VO209', 1, 'Programado', '02:20:00', '2025-05-25', '12:30:00', 'Ciudad de México', 'México', '2025-05-25', '14:50:00', 'Acapulco', 'México', 'XB-001', 1, 10),
-- Vuelos de CARGA
('CG101', 2, 'Completado', '02:30:00', '2025-01-10', '22:00:00', 'Ciudad de México', 'México', '2025-01-11', '00:30:00', 'Monterrey', 'México', 'XI-001', 1, 4),
('CG102', 2, 'Completado', '03:00:00', '2025-01-20', '23:30:00', 'Guadalajara', 'México', '2025-01-21', '02:30:00', 'Tijuana', 'México', 'XI-002', 3, 5),
('CG103', 2, 'Completado', '02:45:00', '2025-02-05', '21:00:00', 'Ciudad de México', 'México', '2025-02-05', '23:45:00', 'Cancún', 'México', 'XI-001', 1, 2),
('CG104', 2, 'Completado', '03:15:00', '2025-02-15', '22:30:00', 'Monterrey', 'México', '2025-02-16', '01:45:00', 'Mérida', 'México', 'XI-002', 4, 8),
('CG105', 2, 'Completado', '02:20:00', '2025-03-01', '23:00:00', 'Tijuana', 'México', '2025-03-02', '01:20:00', 'Ciudad de México', 'México', 'XI-001', 5, 1),
('CG106', 2, 'Programado', '02:50:00', '2025-04-10', '21:30:00', 'Guadalajara', 'México', '2025-04-11', '00:20:00', 'Monterrey', 'México', 'XI-002', 3, 4),
('CG107', 2, 'Programado', '03:10:00', '2025-05-05', '22:00:00', 'Ciudad de México', 'México', '2025-05-06', '01:10:00', 'Los Cabos', 'México', 'XI-001', 1, 6),
-- 
('AM112', 1, 'Completado', '02:15:00', '2025-01-08', '11:00:00', 'Ciudad de México', 'México', '2025-01-08', '13:15:00', 'Cancún', 'México', 'XA-003', 1, 2),
('AM113', 1, 'Completado', '01:30:00', '2025-01-12', '16:00:00', 'Monterrey', 'México', '2025-01-12', '17:30:00', 'Ciudad de México', 'México', 'XA-001', 4, 1),
('VO210', 1, 'Completado', '02:00:00', '2025-01-18', '09:00:00', 'Guadalajara', 'México', '2025-01-18', '11:00:00', 'Cancún', 'México', 'XB-003', 3, 2),
('VB306', 1, 'Completado', '01:45:00', '2025-01-22', '13:30:00', 'Tijuana', 'México', '2025-01-22', '15:15:00', 'Monterrey', 'México', 'XC-001', 5, 4),
('AM114', 1, 'Completado', '02:30:00', '2025-02-02', '08:00:00', 'Ciudad de México', 'México', '2025-02-02', '10:30:00', 'Mérida', 'México', 'XA-002', 1, 8),
('VO211', 1, 'Completado', '01:50:00', '2025-02-07', '12:00:00', 'Cancún', 'México', '2025-02-07', '13:50:00', 'Ciudad de México', 'México', 'XB-001', 2, 1),
('VB307', 1, 'Completado', '02:15:00', '2025-02-14', '10:30:00', 'Monterrey', 'México', '2025-02-14', '12:45:00', 'Cancún', 'México', 'XC-002', 4, 2),
('AM115', 1, 'Completado', '01:40:00', '2025-02-20', '14:30:00', 'Guadalajara', 'México', '2025-02-20', '16:10:00', 'Ciudad de México', 'México', 'XA-001', 3, 1),
('VO212', 1, 'Completado', '03:00:00', '2025-02-25', '07:30:00', 'Tijuana', 'México', '2025-02-25', '10:30:00', 'Cancún', 'México', 'XB-002', 5, 2),
('VB308', 1, 'Completado', '02:20:00', '2025-03-02', '11:15:00', 'Ciudad de México', 'México', '2025-03-02', '13:35:00', 'Puerto Vallarta', 'México', 'XC-001', 1, 7),
('AM116', 1, 'Completado', '01:55:00', '2025-03-08', '15:00:00', 'Monterrey', 'México', '2025-03-08', '16:55:00', 'Guadalajara', 'México', 'XA-003', 4, 3),
('VO213', 1, 'Completado', '02:10:00', '2025-03-12', '09:30:00', 'Cancún', 'México', '2025-03-12', '11:40:00', 'Monterrey', 'México', 'XB-001', 2, 4),
('VB309', 1, 'Completado', '02:35:00', '2025-03-18', '13:00:00', 'Guadalajara', 'México', '2025-03-18', '15:35:00', 'Mérida', 'México', 'XC-002', 3, 8),
('AM117', 1, 'Programado', '02:00:00', '2025-04-01', '08:00:00', 'Ciudad de México', 'México', '2025-04-01', '10:00:00', 'Los Cabos', 'México', 'XA-001', 1, 6),
('VO214', 1, 'Programado', '01:45:00', '2025-04-07', '12:30:00', 'Tijuana', 'México', '2025-04-07', '14:15:00', 'Ciudad de México', 'México', 'XB-002', 5, 1),
('VB310', 1, 'Programado', '02:25:00', '2025-04-12', '10:00:00', 'Monterrey', 'México', '2025-04-12', '12:25:00', 'Cancún', 'México', 'XC-001', 4, 2),
('AM118', 1, 'Programado', '01:35:00', '2025-04-18', '14:00:00', 'Guadalajara', 'México', '2025-04-18', '15:35:00', 'Monterrey', 'México', 'XA-002', 3, 4),
('VO215', 1, 'Programado', '03:15:00', '2025-04-25', '08:30:00', 'Cancún', 'México', '2025-04-25', '11:45:00', 'Tijuana', 'México', 'XB-001', 2, 5),
('VB311', 1, 'Programado', '02:10:00', '2025-05-02', '11:00:00', 'Ciudad de México', 'México', '2025-05-02', '13:10:00', 'Mazatlán', 'México', 'XC-002', 1, 9),
('AM119', 1, 'Programado', '01:50:00', '2025-05-10', '15:30:00', 'Monterrey', 'México', '2025-05-10', '17:20:00', 'Ciudad de México', 'México', 'XA-001', 4, 1),
('VO216', 1, 'Programado', '02:30:00', '2025-05-15', '09:00:00', 'Guadalajara', 'México', '2025-05-15', '11:30:00', 'Cancún', 'México', 'XB-003', 3, 2),
('VB312', 1, 'Programado', '02:40:00', '2025-05-22', '12:45:00', 'Tijuana', 'México', '2025-05-22', '15:25:00', 'Puerto Vallarta', 'México', 'XC-001', 5, 7),
('AM120', 1, 'Programado', '02:15:00', '2025-05-28', '07:15:00', 'Ciudad de México', 'México', '2025-05-28', '09:30:00', 'Cancún', 'México', 'XA-003', 1, 2),
-- Vuelos adicionales de aerolíneas internacionales
('AC501', 1, 'Completado', '05:30:00', '2025-01-15', '10:00:00', 'Ciudad de México', 'México', '2025-01-15', '15:30:00', 'Montreal', 'Canadá', 'CA-001', 1, 22),
('AS601', 1, 'Completado', '04:45:00', '2025-02-10', '14:00:00', 'Los Angeles', 'Estados Unidos', '2025-02-10', '18:45:00', 'Ciudad de México', 'México', 'AS-001', 23, 1),
('AF701', 1, 'Completado', '11:30:00', '2025-03-05', '20:00:00', 'París', 'Francia', '2025-03-06', '07:30:00', 'Ciudad de México', 'México', 'AF-001', 25, 1),
('DL801', 1, 'Completado', '04:15:00', '2025-01-25', '09:30:00', 'Ciudad de México', 'México', '2025-01-25', '13:45:00', 'Nueva York', 'Estados Unidos', 'DL-001', 1, 22),
('UA901', 1, 'Completado', '03:50:00', '2025-02-20', '11:00:00', 'Cancún', 'México', '2025-02-20', '14:50:00', 'Miami', 'Estados Unidos', 'UA-001', 2, 24),
('AA801', 1, 'Completado', '02:30:00', '2025-03-15', '08:00:00', 'Guadalajara', 'México', '2025-03-15', '10:30:00', 'Los Angeles', 'Estados Unidos', 'AA-001', 3, 23),
('CG108', 2, 'Completado', '03:30:00', '2025-03-10', '20:00:00', 'Ciudad de México', 'México', '2025-03-10', '23:30:00', 'Guadalajara', 'México', 'XI-001', 1, 3),
('CG109', 2, 'Programado', '02:45:00', '2025-04-15', '21:00:00', 'Monterrey', 'México', '2025-04-15', '23:45:00', 'Tijuana', 'México', 'XI-002', 4, 5),
('CG110', 2, 'Programado', '03:00:00', '2025-05-20', '22:30:00', 'Cancún', 'México', '2025-05-21', '01:30:00', 'Ciudad de México', 'México', 'XI-001', 2, 1),
('AM121', 1, 'Completado', '02:15:00', '2025-01-28', '12:00:00', 'Ciudad de México', 'México', '2025-01-28', '14:15:00', 'Cancún', 'México', 'XA-001', 1, 2),
('VO217', 1, 'Completado', '01:50:00', '2025-02-28', '16:30:00', 'Monterrey', 'México', '2025-02-28', '18:20:00', 'Tijuana', 'México', 'XB-002', 4, 5),
('VB313', 1, 'Programado', '02:30:00', '2025-04-30', '10:15:00', 'Guadalajara', 'México', '2025-04-30', '12:45:00', 'Cancún', 'México', 'XC-001', 3, 2),
('AM122', 1, 'Programado', '02:05:00', '2025-05-31', '13:30:00', 'Ciudad de México', 'México', '2025-05-31', '15:35:00', 'Puerto Vallarta', 'México', 'XA-002', 1, 7);

-- ========================================
-- 9. PILOTO_VUELO - Asignar pilotos a vuelos
-- ========================================
INSERT INTO Piloto_vuelo (Piloto_id, Numero_vuelo) VALUES
(1, 'AM101'), (1, 'AM102'), (2, 'VO201'), (2, 'VO202'), (3, 'VB301'), (4, 'AM103'),
(4, 'AM104'), (5, 'VO203'), (6, 'VB302'), (7, 'AM105'), (8, 'AM106'), (9, 'VO204'),
(10, 'VB303'), (11, 'AM107'), (12, 'VO205'), (13, 'AM108'), (14, 'VO206'), (15, 'VB304'),
(16, 'AM109'), (17, 'VO207'), (18, 'AM110'), (19, 'VO208'), (20, 'VB305'), (21, 'AM111'),
(22, 'VO209'), (1, 'AM112'), (2, 'AM113'), (3, 'VO210'), (4, 'VB306'), (5, 'AM114'),
(6, 'VO211'), (7, 'VB307'), (8, 'AM115'), (9, 'VO212'), (10, 'VB308'), (11, 'AM116'),
(12, 'VO213'), (13, 'VB309'), (14, 'AM117'), (15, 'VO214'), (16, 'VB310'), (17, 'AM118'),
(18, 'VO215'), (19, 'VB311'), (20, 'AM119'), (21, 'VO216'), (22, 'VB312'), (23, 'AM120'),
(24, 'AC501'), (25, 'AS601'), (26, 'AF701'), (27, 'DL801'), (28, 'UA901'), (29, 'AA801'),
(30, 'AM121'), (1, 'VO217'), (2, 'VB313'), (3, 'AM122');

-- ========================================
-- 10. BOLETOS 
-- ========================================
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
-- AM101 (Capacidad 180)
(1, '1A', 'Primera', 2500.00, 'AM101'), (2, '1B', 'Primera', 2500.00, 'AM101'), (3, '2A', 'Ejecutiva', 1800.00, 'AM101'),
(4, '2B', 'Ejecutiva', 1800.00, 'AM101'), (5, '3A', 'Ejecutiva', 1800.00, 'AM101'), (6, '10A', 'Economica', 950.00, 'AM101'),
(7, '10B', 'Economica', 950.00, 'AM101'), (8, '11A', 'Economica', 950.00, 'AM101'), (9, '11B', 'Economica', 950.00, 'AM101'),
(10, '12A', 'Economica', 950.00, 'AM101'), (11, '12B', 'Economica', 950.00, 'AM101'), (12, '13A', 'Economica', 950.00, 'AM101'),

-- AM102 (Capacidad 189)
(13, '1A', 'Primera', 1500.00, 'AM102'), (14, '1B', 'Primera', 1500.00, 'AM102'), (15, '2A', 'Ejecutiva', 1100.00, 'AM102'),
(16, '2B', 'Ejecutiva', 1100.00, 'AM102'), (17, '10A', 'Economica', 650.00, 'AM102'), (18, '10B', 'Economica', 650.00, 'AM102'),
(19, '11A', 'Economica', 650.00, 'AM102'), (20, '11B', 'Economica', 650.00, 'AM102'),

-- VO201 (Capacidad 186)
(21, '1A', 'Ejecutiva', 1200.00, 'VO201'), (22, '1B', 'Ejecutiva', 1200.00, 'VO201'), (23, '10A', 'Economica', 580.00, 'VO201'),
(24, '10B', 'Economica', 580.00, 'VO201'), (25, '11A', 'Economica', 580.00, 'VO201'), (26, '11B', 'Economica', 580.00, 'VO201'),
(27, '12A', 'Economica', 580.00, 'VO201'), (28, '12B', 'Economica', 580.00, 'VO201'), (29, '13A', 'Economica', 580.00, 'VO201'),

-- VO202 (Capacidad 174)
(30, '1A', 'Ejecutiva', 2200.00, 'VO202'), (31, '1B', 'Ejecutiva', 2200.00, 'VO202'), (32, '10A', 'Economica', 1350.00, 'VO202'),
(33, '10B', 'Economica', 1350.00, 'VO202'), (34, '11A', 'Economica', 1350.00, 'VO202'), (35, '11B', 'Economica', 1350.00, 'VO202'),

-- VB301 (Capacidad 186)
(36, '1A', 'Ejecutiva', 1400.00, 'VB301'), (37, '1B', 'Ejecutiva', 1400.00, 'VB301'), (38, '10A', 'Economica', 750.00, 'VB301'),
(39, '10B', 'Economica', 750.00, 'VB301'), (40, '11A', 'Economica', 750.00, 'VB301'),

-- AM103 (Capacidad 180)
(41, '1A', 'Primera', 2800.00, 'AM103'), (42, '1B', 'Primera', 2800.00, 'AM103'), (43, '2A', 'Ejecutiva', 1950.00, 'AM103'),
(44, '10A', 'Economica', 1100.00, 'AM103'), (45, '10B', 'Economica', 1100.00, 'AM103'), (46, '11A', 'Economica', 1100.00, 'AM103'),

-- AM104 (Capacidad 189)
(47, '1A', 'Primera', 2400.00, 'AM104'), (48, '1B', 'Primera', 2400.00, 'AM104'), (49, '10A', 'Economica', 1250.00, 'AM104'),
(50, '10B', 'Economica', 1250.00, 'AM104'), (51, '11A', 'Economica', 1250.00, 'AM104'),

-- VO203
(52, '1A', 'Ejecutiva', 950.00, 'VO203'), (53, '10A', 'Economica', 550.00, 'VO203'), (54, '10B', 'Economica', 550.00, 'VO203'),

-- VB302
(55, '1A', 'Ejecutiva', 1600.00, 'VB302'), (56, '10A', 'Economica', 850.00, 'VB302'), (57, '10B', 'Economica', 850.00, 'VB302'),

-- AM105
(58, '1A', 'Primera', 1800.00, 'AM105'), (59, '10A', 'Economica', 900.00, 'AM105'), (60, '10B', 'Economica', 900.00, 'AM105'),

(61, '1A', 'Primera', 2600.00, 'AM106'), (62, '1B', 'Primera', 2600.00, 'AM106'), (63, '2A', 'Ejecutiva', 1850.00, 'AM106'),
(64, '10A', 'Economica', 980.00, 'AM106'), (65, '10B', 'Economica', 980.00, 'AM106'), (66, '11A', 'Economica', 980.00, 'AM106'),
(67, '11B', 'Economica', 980.00, 'AM106'), (68, '12A', 'Economica', 980.00, 'AM106'),

(69, '1A', 'Ejecutiva', 1100.00, 'VO204'), (70, '10A', 'Economica', 620.00, 'VO204'), (71, '10B', 'Economica', 620.00, 'VO204'),
(72, '11A', 'Economica', 620.00, 'VO204'),

(73, '1A', 'Ejecutiva', 1500.00, 'VB303'), (74, '10A', 'Economica', 800.00, 'VB303'), (75, '10B', 'Economica', 800.00, 'VB303'),
(76, '11A', 'Economica', 800.00, 'VB303'), (77, '11B', 'Economica', 800.00, 'VB303'),

(78, '1A', 'Primera', 3200.00, 'AM107'), (79, '1B', 'Primera', 3200.00, 'AM107'), (80, '2A', 'Ejecutiva', 2100.00, 'AM107'),
(81, '10A', 'Economica', 1450.00, 'AM107'), (82, '10B', 'Economica', 1450.00, 'AM107'),

(83, '1A', 'Ejecutiva', 900.00, 'VO205'), (84, '10A', 'Economica', 520.00, 'VO205'), (85, '10B', 'Economica', 520.00, 'VO205'),

(86, '1A', 'Primera', 2700.00, 'AM108'), (87, '1B', 'Primera', 2700.00, 'AM108'), (88, '10A', 'Economica', 1020.00, 'AM108'),
(89, '10B', 'Economica', 1020.00, 'AM108'), (90, '11A', 'Economica', 1020.00, 'AM108'),

(91, '1A', 'Ejecutiva', 1050.00, 'VO206'), (92, '10A', 'Economica', 590.00, 'VO206'), (93, '10B', 'Economica', 590.00, 'VO206'),

(94, '1A', 'Ejecutiva', 1700.00, 'VB304'), (95, '10A', 'Economica', 920.00, 'VB304'), (96, '10B', 'Economica', 920.00, 'VB304'),

(97, '1A', 'Primera', 1950.00, 'AM109'), (98, '10A', 'Economica', 880.00, 'AM109'), (99, '10B', 'Economica', 880.00, 'AM109'),

(100, '1A', 'Ejecutiva', 1150.00, 'VO207'), (101, '10A', 'Economica', 640.00, 'VO207'), (102, '10B', 'Economica', 640.00, 'VO207'),

(103, '1A', 'Primera', 2800.00, 'AM110'), (104, '10A', 'Economica', 1050.00, 'AM110'), (105, '10B', 'Economica', 1050.00, 'AM110'),
(106, '1A', 'Ejecutiva', 2300.00, 'VO208'), (107, '10A', 'Economica', 1400.00, 'VO208'), (108, '10B', 'Economica', 1400.00, 'VO208'),
(109, '1A', 'Ejecutiva', 1600.00, 'VB305'), (110, '10A', 'Economica', 870.00, 'VB305'), (111, '10B', 'Economica', 870.00, 'VB305'),
(112, '1A', 'Primera', 1750.00, 'AM111'), (113, '10A', 'Economica', 820.00, 'AM111'), (114, '10B', 'Economica', 820.00, 'AM111'),
(115, '1A', 'Ejecutiva', 1300.00, 'VO209'), (116, '10A', 'Economica', 710.00, 'VO209'), (117, '10B', 'Economica', 710.00, 'VO209'),

(118, '1A', 'Primera', 2650.00, 'AM112'), (119, '10A', 'Economica', 990.00, 'AM112'), (120, '10B', 'Economica', 990.00, 'AM112'),
(121, '1A', 'Ejecutiva', 1050.00, 'AM113'), (122, '10A', 'Economica', 600.00, 'AM113'), (123, '10B', 'Economica', 600.00, 'AM113'),
(124, '1A', 'Ejecutiva', 1450.00, 'VO210'), (125, '10A', 'Economica', 780.00, 'VO210'), (126, '10B', 'Economica', 780.00, 'VO210'),
(127, '1A', 'Ejecutiva', 1250.00, 'VB306'), (128, '10A', 'Economica', 670.00, 'VB306'), (129, '10B', 'Economica', 670.00, 'VB306'),
(130, '1A', 'Primera', 1900.00, 'AM114'), (131, '10A', 'Economica', 940.00, 'AM114'), (132, '10B', 'Economica', 940.00, 'AM114'),

(133, '1A', 'Ejecutiva', 1350.00, 'VO211'), (134, '10A', 'Economica', 730.00, 'VO211'), (135, '10B', 'Economica', 730.00, 'VO211'),
(136, '1A', 'Ejecutiva', 1550.00, 'VB307'), (137, '10A', 'Economica', 840.00, 'VB307'), (138, '10B', 'Economica', 840.00, 'VB307'),
(139, '1A', 'Primera', 1600.00, 'AM115'), (140, '10A', 'Economica', 750.00, 'AM115'), (141, '10B', 'Economica', 750.00, 'AM115'),
(142, '1A', 'Ejecutiva', 2100.00, 'VO212'), (143, '10A', 'Economica', 1300.00, 'VO212'), (144, '10B', 'Economica', 1300.00, 'VO212'),
(145, '1A', 'Ejecutiva', 1500.00, 'VB308'), (146, '10A', 'Economica', 810.00, 'VB308'), (147, '10B', 'Economica', 810.00, 'VB308'),

(148, '1A', 'Primera', 1400.00, 'AM116'), (149, '10A', 'Economica', 680.00, 'AM116'), (150, '10B', 'Economica', 680.00, 'AM116'),
(151, '1A', 'Ejecutiva', 1600.00, 'VO213'), (152, '10A', 'Economica', 860.00, 'VO213'), (153, '10B', 'Economica', 860.00, 'VO213'),
(154, '1A', 'Ejecutiva', 1750.00, 'VB309'), (155, '10A', 'Economica', 950.00, 'VB309'), (156, '10B', 'Economica', 950.00, 'VB309'),
(157, '1A', 'Primera', 2850.00, 'AM117'), (158, '10A', 'Economica', 1150.00, 'AM117'), (159, '10B', 'Economica', 1150.00, 'AM117'),
(160, '1A', 'Ejecutiva', 1250.00, 'VO214'), (161, '10A', 'Economica', 690.00, 'VO214'), (162, '10B', 'Economica', 690.00, 'VO214'),

(163, '1A', 'Ejecutiva', 1650.00, 'VB310'), (164, '10A', 'Economica', 900.00, 'VB310'), (165, '10B', 'Economica', 900.00, 'VB310'),
(166, '1A', 'Primera', 1500.00, 'AM118'), (167, '10A', 'Economica', 720.00, 'AM118'), (168, '10B', 'Economica', 720.00, 'AM118'),
(169, '1A', 'Ejecutiva', 2250.00, 'VO215'), (170, '10A', 'Economica', 1380.00, 'VO215'), (171, '10B', 'Economica', 1380.00, 'VO215'),
(172, '1A', 'Ejecutiva', 1400.00, 'VB311'), (173, '10A', 'Economica', 770.00, 'VB311'), (174, '10B', 'Economica', 770.00, 'VB311'),
(175, '1A', 'Primera', 1850.00, 'AM119'), (176, '10A', 'Economica', 890.00, 'AM119'), (177, '10B', 'Economica', 890.00, 'AM119'),

(178, '1A', 'Ejecutiva', 1550.00, 'VO216'), (179, '10A', 'Economica', 830.00, 'VO216'), (180, '10B', 'Economica', 830.00, 'VO216'),
(181, '1A', 'Ejecutiva', 1700.00, 'VB312'), (182, '10A', 'Economica', 930.00, 'VB312'), (183, '10B', 'Economica', 930.00, 'VB312'),
(184, '1A', 'Primera', 2750.00, 'AM120'), (185, '10A', 'Economica', 1040.00, 'AM120'), (186, '10B', 'Economica', 1040.00, 'AM120'),

-- Vuelos internacionales (más caros)
(187, '1A', 'Primera', 8500.00, 'AC501'), (188, '2A', 'Ejecutiva', 5200.00, 'AC501'), (189, '10A', 'Economica', 3100.00, 'AC501'),
(190, '1A', 'Primera', 7200.00, 'AS601'), (191, '2A', 'Ejecutiva', 4500.00, 'AS601'), (192, '10A', 'Economica', 2800.00, 'AS601'),
(193, '1A', 'Primera', 15000.00, 'AF701'), (194, '2A', 'Ejecutiva', 9500.00, 'AF701'), (195, '10A', 'Economica', 5800.00, 'AF701'),
(196, '1A', 'Primera', 8800.00, 'DL801'), (197, '2A', 'Ejecutiva', 5400.00, 'DL801'), (198, '10A', 'Economica', 3300.00, 'DL801'),
(199, '1A', 'Primera', 6900.00, 'UA901'), (200, '2A', 'Ejecutiva', 4200.00, 'UA901'), (201, '10A', 'Economica', 2600.00, 'UA901'),

(202, '1A', 'Primera', 2900.00, 'AM121'), (203, '10A', 'Economica', 1080.00, 'AM121'), (204, '10B', 'Economica', 1080.00, 'AM121'),
(205, '1A', 'Ejecutiva', 1350.00, 'VO217'), (206, '10A', 'Economica', 750.00, 'VO217'), (207, '10B', 'Economica', 750.00, 'VO217'),
(208, '1A', 'Ejecutiva', 1600.00, 'VB313'), (209, '10A', 'Economica', 880.00, 'VB313'), (210, '10B', 'Economica', 880.00, 'VB313'),
(211, '1A', 'Primera', 2000.00, 'AM122'), (212, '10A', 'Economica', 920.00, 'AM122'), (213, '10B', 'Economica', 920.00, 'AM122');

-- ========================================
-- 11. CLIENTES
-- ========================================
INSERT INTO Cliente (Cliente_id, Nombres, Apellido_paterno, Apellido_materno, Fecha_nacimiento) VALUES
(1, 'Ana', 'García', 'López', '1985-03-15'), (2, 'Carlos', 'Martínez', 'Hernández', '1990-07-22'),
(3, 'María', 'Hernández', 'González', '1988-11-30'), (4, 'José', 'Pérez', 'Sánchez', '1975-05-10'),
(5, 'Laura', 'Díaz', 'Torres', '1992-09-18'), (6, 'Miguel', 'Castro', 'Ramírez', '1983-02-25'),
(7, 'Fernanda', 'Ortega', 'Flores', '1995-06-12'), (8, 'Diego', 'Jiménez', 'Morales', '1987-12-08'),
(9, 'Gabriela', 'Torres', 'Ramos', '1991-04-03'), (10, 'Ricardo', 'Vargas', 'Ruiz', '1986-08-27'),
(11, 'Isabel', 'Núñez', 'Silva', '1993-01-20'), (12, 'Oscar', 'Herrera', 'Méndez', '1984-10-14'),
(13, 'Adriana', 'Morales', 'Reyes', '1989-07-09'), (14, 'Sergio', 'Soto', 'Vega', '1994-03-28'),
(15, 'Patricia', 'Ruiz', 'Guerrero', '1981-11-22'), (16, 'Francisco', 'Guerrero', 'Medina', '1996-05-16'),
(17, 'Lucía', 'Medina', 'Delgado', '1990-09-05'), (18, 'Eduardo', 'Campos', 'Rojas', '1985-12-11'),
(19, 'Daniela', 'Reyes', 'Acosta', '1993-02-14'), (20, 'Roberto', 'Silva', 'Espinoza', '1988-06-30'),
(21, 'Elena', 'Mendoza', 'Navarro', '1992-10-25'), (22, 'Arturo', 'Delgado', 'Cruz', '1987-04-18'),
(23, 'Verónica', 'Rojas', 'Peña', '1991-08-07'), (24, 'Raúl', 'Acosta', 'Luna', '1986-01-29'),
(25, 'Carolina', 'Espinoza', 'Campos', '1994-12-03'), (26, 'Guillermo', 'Navarro', 'Fuentes', '1989-03-21'),
(27, 'Sofía', 'Peña', 'Santos', '1995-07-14'), (28, 'Javier', 'Luna', 'Aguilar', '1984-11-08'),
(29, 'Mónica', 'Campos', 'Carrillo', '1990-05-02'), (30, 'Alberto', 'Fuentes', 'Pacheco', '1987-09-19'),
(31, 'Cristina', 'Santos', 'Muñoz', '1993-02-11'), (32, 'Luis', 'Aguilar', 'Cortés', '1988-06-24'),
(33, 'Andrea', 'Carrillo', 'Maldonado', '1992-10-17'), (34, 'Manuel', 'Pacheco', 'Guzmán', '1985-04-06'),
(35, 'Claudia', 'Muñoz', 'Alvarado', '1991-08-29'), (36, 'Rodrigo', 'Cortés', 'Bravo', '1986-12-22'),
(37, 'Valeria', 'Maldonado', 'Mendoza', '1994-03-15'), (38, 'Héctor', 'Guzmán', 'Castillo', '1989-07-08'),
(39, 'Diana', 'Alvarado', 'Mora', '1993-11-01'), (40, 'Alejandro', 'Bravo', 'Herrera', '1988-02-23'),
(41, 'Mariana', 'Mendoza', 'Gil', '1992-06-16'), (42, 'Pablo', 'Castillo', 'Vargas', '1987-10-09'),
(43, 'Natalia', 'Mora', 'Ibarra', '1991-04-02'), (44, 'Víctor', 'Herrera', 'León', '1986-08-25'),
(45, 'Paola', 'Gil', 'Ríos', '1994-12-18'), (46, 'Andrés', 'Vargas', 'Domínguez', '1990-05-11'),
(47, 'Lorena', 'Ibarra', 'Vázquez', '1995-09-04'), (48, 'Fernando', 'León', 'Román', '1989-01-27'),
(49, 'Carmen', 'Ríos', 'Ponce', '1993-06-20'), (50, 'Ignacio', 'Domínguez', 'Lara', '1988-10-13'),
(51, 'Beatriz', 'Vázquez', 'Sandoval', '1992-03-06'), (52, 'Emilio', 'Román', 'Bautista', '1987-07-29'),
(53, 'Alejandra', 'Ponce', 'Corona', '1991-11-22'), (54, 'Gustavo', 'Lara', 'Valencia', '1986-04-15'),
(55, 'Silvia', 'Sandoval', 'Figueroa', '1994-08-08'), (56, 'Óscar', 'Bautista', 'Cabrera', '1990-12-01'),
(57, 'Melissa', 'Corona', 'Galván', '1993-03-24'), (58, 'Antonio', 'Valencia', 'Escobar', '1988-07-17'),
(59, 'Cecilia', 'Figueroa', 'Olvera', '1992-11-10'), (60, 'Felipe', 'Cabrera', 'Solís', '1987-02-03'),
(61, 'Regina', 'Galván', 'Montes', '1991-06-26'), (62, 'Enrique', 'Escobar', 'Zárate', '1986-03-9'),
(63, 'Karla', 'Olvera', 'Portillo', '1995-01-12'), (64, 'Ramón', 'Solís', 'Meza', '1990-05-05'),
(65, 'Angélica', 'Montes', 'Rivas', '1993-09-28'), (66, 'Martín', 'Zárate', 'Cervantes', '1988-01-21'),
(67, 'Norma', 'Portillo', 'Salazar', '1992-05-14'), (68, 'Rubén', 'Meza', 'Téllez', '1987-09-07'),
(69, 'Claudia', 'Rivas', 'Aranda', '1991-01-30'), (70, 'Sergio', 'Cervantes', 'Ávila', '1986-06-23'),
(71, 'Victoria', 'Salazar', 'Benítez', '1994-10-16'), (72, 'Gerardo', 'Téllez', 'Cano', '1990-02-09'),
(73, 'Rosa', 'Aranda', 'Duarte', '1993-07-02'), (74, 'Daniel', 'Ávila', 'Escalante', '1988-11-25'),
(75, 'Sandra', 'Benítez', 'Franco', '1992-03-18'), (76, 'Armando', 'Cano', 'Garza', '1987-08-11'),
(77, 'Liliana', 'Duarte', 'Hinojosa', '1991-12-04'), (78, 'Jorge', 'Escalante', 'Iñiguez', '1986-04-27'),
(79, 'Gabriela', 'Franco', 'Jaramillo', '1994-09-20'), (80, 'Raúl', 'Garza', 'Kristal', '1990-01-13'),
(81, 'Mónica', 'Hinojosa', 'Ledesma', '1993-05-06'), (82, 'Hugo', 'Iñiguez', 'Macías', '1988-09-29'),
(83, 'Susana', 'Jaramillo', 'Nava', '1992-02-22'), (84, 'Ricardo', 'Kristal', 'Ochoa', '1987-06-15'),
(85, 'Patricia', 'Ledesma', 'Palacios', '1991-10-08'), (86, 'Alfredo', 'Macías', 'Quintero', '1986-03-01'),
(87, 'Yolanda', 'Nava', 'Robledo', '1994-07-24'), (88, 'Víctor', 'Ochoa', 'Soto', '1990-11-17'),
(89, 'Teresa', 'Palacios', 'Trejo', '1993-03-10'), (90, 'Manuel', 'Quintero', 'Uribe', '1988-08-03'),
(91, 'Verónica', 'Robledo', 'Valdez', '1992-12-26'), (92, 'Pedro', 'Soto', 'Wolff', '1987-04-19'),
(93, 'Laura', 'Trejo', 'Ximénez', '1991-08-12'), (94, 'Javier', 'Uribe', 'Yáñez', '1986-12-05'),
(95, 'Estela', 'Valdez', 'Zavala', '1994-05-28'), (96, 'Tomás', 'Wolff', 'Arias', '1990-09-21'),
(97, 'Gloria', 'Ximénez', 'Bernal', '1993-01-14'), (98, 'Julio', 'Yáñez', 'Cisneros', '1988-06-07'),
(99, 'Irma', 'Zavala', 'Dávila', '1992-10-30'), (100, 'Salvador', 'Arias', 'Elizondo', '1987-02-23');

-- ========================================
-- 12. COMPRAR - Asignar boletos a clientes
-- ========================================
INSERT INTO Comprar (Cliente_id, Boleto_id, Fecha_compra) VALUES
(1, 1, '2024-12-15'), (2, 2, '2024-12-20'), (3, 3, '2024-12-22'), (4, 4, '2024-12-25'),
(5, 5, '2024-12-28'), (6, 6, '2025-01-02'), (7, 7, '2025-01-03'), (8, 8, '2025-01-04'),
(9, 9, '2025-01-05'), (10, 10, '2025-01-06'), (11, 11, '2025-01-07'), (12, 12, '2025-01-08'),
(13, 13, '2025-01-02'), (14, 14, '2025-01-03'), (15, 15, '2025-01-04'), (16, 16, '2025-01-05'),
(17, 17, '2025-01-06'), (18, 18, '2025-01-07'), (19, 19, '2025-01-08'), (20, 20, '2025-01-09'),
(21, 21, '2025-01-05'), (22, 22, '2025-01-06'), (23, 23, '2025-01-07'), (24, 24, '2025-01-08'),
(25, 25, '2025-01-09'), (26, 26, '2025-01-10'), (27, 27, '2025-01-11'), (28, 28, '2025-01-12'),
(29, 29, '2025-01-13'), (30, 30, '2025-01-08'), (31, 31, '2025-01-09'), (32, 32, '2025-01-10'),
(33, 33, '2025-01-11'), (34, 34, '2025-01-12'), (35, 35, '2025-01-13'), (36, 36, '2025-01-10'),
(37, 37, '2025-01-11'), (38, 38, '2025-01-12'), (39, 39, '2025-01-13'), (40, 40, '2025-01-14'),
(41, 41, '2025-01-20'), (42, 42, '2025-01-21'), (43, 43, '2025-01-22'), (44, 44, '2025-01-23'),
(45, 45, '2025-01-24'), (46, 46, '2025-01-25'), (47, 47, '2025-02-01'), (48, 48, '2025-02-02'),
(49, 49, '2025-02-03'), (50, 50, '2025-02-04'), (51, 51, '2025-02-05'), (52, 52, '2025-02-03'),
(53, 53, '2025-02-04'), (54, 54, '2025-02-05'), (55, 55, '2025-02-10'), (56, 56, '2025-02-11'),
(57, 57, '2025-02-12'), (58, 58, '2025-02-05'), (59, 59, '2025-02-06'), (60, 60, '2025-02-07'),
(61, 61, '2025-02-20'), (62, 62, '2025-02-21'), (63, 63, '2025-02-22'), (64, 64, '2025-02-23'),
(65, 65, '2025-02-24'), (66, 66, '2025-02-25'), (67, 67, '2025-02-26'), (68, 68, '2025-02-27'),
(69, 69, '2025-02-28'), (70, 70, '2025-03-01'), (71, 71, '2025-03-02'), (72, 72, '2025-03-03'),
(73, 73, '2025-03-04'), (74, 74, '2025-03-05'), (75, 75, '2025-03-06'), (76, 76, '2025-03-07'),
(77, 77, '2025-03-08'), (78, 78, '2025-03-09'), (79, 79, '2025-03-10'), (80, 80, '2025-03-11'),
(81, 81, '2025-03-12'), (82, 82, '2025-03-13'), (83, 83, '2025-03-14'), (84, 84, '2025-03-15'),
(85, 85, '2025-03-16'), (86, 86, '2025-03-22'), (87, 87, '2025-03-23'), (88, 88, '2025-03-24'),
(89, 89, '2025-03-25'), (90, 90, '2025-03-26'), (91, 91, '2025-03-27'), (92, 92, '2025-03-28'),
(93, 93, '2025-03-29'), (94, 94, '2025-03-30'), (95, 95, '2025-03-31'), (96, 96, '2025-04-01'),
(97, 97, '2025-04-02'), (98, 98, '2025-04-03'), (99, 99, '2025-04-04'), (100, 100, '2025-04-05'),
(1, 101, '2025-03-28'), (2, 102, '2025-03-29'), (3, 103, '2025-04-20'), (4, 104, '2025-04-21'),
(5, 105, '2025-04-22'), (6, 106, '2025-04-23'), (7, 107, '2025-04-24'), (8, 108, '2025-04-25'),
(9, 109, '2025-04-26'), (10, 110, '2025-04-27'), (11, 111, '2025-04-28'), (12, 112, '2025-04-29'),
(13, 113, '2025-04-30'), (14, 114, '2025-05-01'), (15, 115, '2025-05-02'), (16, 116, '2025-05-03'),
(17, 117, '2025-05-04'), (18, 118, '2025-01-22'), (19, 119, '2025-01-23'), (20, 120, '2025-01-24');

-- ========================================
-- 13. ESPECIALIDADES DE EMPLEADOS
-- ========================================
INSERT INTO Mecanico (Empleado_id, Titulo, Especializacion) VALUES
(4, 'Ingeniero Aeronáutico', 'Motores y turbinas'),
(7, 'Técnico Certificado', 'Sistemas hidráulicos'),
(10, 'Ingeniero Mecánico', 'Aviónica y electrónica'),
(12, 'Técnico Senior', 'Fuselaje y estructura'),
(14, 'Ingeniero', 'Sistemas de combustible'),
(16, 'Técnico Certificado', 'Tren de aterrizaje'),
(18, 'Ingeniero', 'Sistemas de presurización'),
(20, 'Técnico Senior', 'Instrumentos de cabina'),
(22, 'Ingeniero Aeronáutico', 'Sistemas de navegación'),
(24, 'Técnico Certificado', 'Motores y turbinas');

INSERT INTO Controlador_de_abordaje (Empleado_id, Certificacion_atencion_cliente, Fecha_vencimiento_certificacion) VALUES
(26, 'Certificación Internacional de Servicio al Cliente', '2026-12-31'),
(28, 'Certificación en Atención de Pasajeros', '2026-06-30'),
(30, 'Certificación IATA', '2026-09-15'),
(32, 'Certificación de Servicio Premium', '2026-11-20'),
(34, 'Certificación Internacional', '2026-08-10');

INSERT INTO Sobrecargo (Empleado_id) VALUES
(36), (38), (40), (42), (44), (46), (48), (50);

INSERT INTO Controlador_de_vuelos (Empleado_id, Licencia_control_trafico, Sector_asignado, Fecha_vencimiento_licencia) VALUES
(35, 'ATC-MX-001', 'Centro', '2026-12-31'),
(37, 'ATC-MX-002', 'Norte', '2026-10-15'),
(39, 'ATC-MX-003', 'Sur', '2026-08-20'),
(41, 'ATC-MX-004', 'Este', '2026-11-30'),
(43, 'ATC-MX-005', 'Oeste', '2026-09-25');

-- ========================================
-- 14. CERTIFICACIONES
-- ========================================
INSERT INTO Certificacion_mecanico_aeronave (Nombre, Mecanico_id) VALUES
('Certificación A320', 4), ('Certificación Boeing 737', 7), ('Certificación Aviónica Avanzada', 10),
('Certificación Estructural', 12), ('Certificación Sistemas de Combustible', 14),
('Certificación Tren de Aterrizaje', 16), ('Certificación Presurización', 18),
('Certificación Instrumentos', 20), ('Certificación Navegación', 22), ('Certificación Motores', 24);

INSERT INTO Certificacion_seguridad (Nombre, Sobrecargo_id) VALUES
('Primeros Auxilios Avanzados', 36), ('Evacuación de Emergencia', 38),
('Manejo de Incendios', 40), ('Seguridad en Vuelo', 42),
('Atención Médica Básica', 44), ('Procedimientos de Emergencia', 46),
('Seguridad Aeronáutica', 48), ('Rescate y Evacuación', 50);

INSERT INTO Idioma (Nombre, Sobrecargo_id) VALUES
('Inglés', 36), ('Francés', 36), ('Inglés', 38), ('Alemán', 38),
('Inglés', 40), ('Japonés', 40), ('Inglés', 42), ('Italiano', 42),
('Inglés', 44), ('Portugués', 44), ('Inglés', 46), ('Mandarín', 46),
('Inglés', 48), ('Ruso', 48), ('Inglés', 50), ('Coreano', 50);

INSERT INTO Certificacion_tipo_aeronave (Nombre, Piloto_id) VALUES
('Boeing 737-800', 1), ('Airbus A320', 2), ('Boeing 787', 3),
('Airbus A320neo', 4), ('Airbus A320', 5), ('ATR 42', 6),
('Embraer E190', 7), ('Boeing 737-800', 8), ('Airbus A319', 9),
('Boeing 737 MAX', 10), ('Airbus A350', 11), ('Boeing 777', 12),
('Airbus A340', 13), ('Airbus A330', 14), ('Boeing 787-9', 15),
('Boeing 757', 16), ('Boeing 737-900', 17), ('Airbus A320', 18),
('Boeing 767-300F', 19), ('Boeing 737-800F', 20);
