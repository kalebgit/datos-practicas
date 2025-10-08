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
INSERT INTO Contratar_aerolinea (Aerolinea_id, Empleado_id, Fecha_ingreso) VALUES
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




-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================




-- ========================================
--  CAMBIOS NUEVOS DE PRACTICAS SIGUIENTES 7/09/2025
-- ========================================

-- ========================================
-- CONTROLADORES DE VUELO (trabajan para aeropuerto)
-- ========================================

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(1, 35, '2020-03-15', NULL);

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(1, 36, '2021-06-01', NULL);

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(2, 37, '2019-11-20', NULL);

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(2, 38, '2022-01-10', NULL);

-- ========================================
-- CONTROLADORES DE ABORDAJE (trabajan para aeropuerto)
-- ========================================

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(1, 26, '2021-02-15', NULL);

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(1, 27, '2020-09-01', NULL);

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(2, 28, '2019-07-10', NULL);

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(3, 29, '2022-03-20', NULL);

-- ========================================
-- MECÁNICOS (trabajan para aeropuerto)
-- ========================================

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(1, 4, '2018-05-15', NULL);

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(1, 5, '2019-08-01', NULL);

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(2, 6, '2020-01-20', NULL);

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(2, 7, '2017-11-05', NULL);

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(3, 8, '2021-04-12', NULL);

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(1, 9, '2016-02-01', '2023-12-31');

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(2, 10, '2022-07-15', NULL);

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(3, 11, '2020-10-08', NULL);

INSERT INTO Contratar_aeropuerto 
(Aeropuerto_id, Empleado_id, Fecha_ingreso, Fecha_egreso)
VALUES 
(1, 12, '2023-01-15', NULL);


-- ========================================
-- modificaciones para que algunos pilotos tengan las mismas licencias
-- ========================================ra
-- Grupo 1: Pilotos con licencia ATP-001234
UPDATE pilotos 
SET licencia = 'ATP-001234' 
WHERE piloto_id IN (2, 5, 12);

-- Grupo 2: Pilotos con licencia ATP-003456
UPDATE pilotos 
SET licencia = 'ATP-003456' 
WHERE piloto_id IN (3, 8, 15);

-- Grupo 3: Pilotos con licencia ATP-005678
UPDATE pilotos 
SET licencia = 'ATP-005678' 
WHERE piloto_id IN (4, 10, 18);

-- Grupo 4: Pilotos con licencia ATP-009012
UPDATE pilotos 
SET licencia = 'ATP-009012' 
WHERE piloto_id IN (7, 14, 20);






-- ========================================
-- Vamos agregar boletos vendidos de vuelos para tener al menos 50% vendidos
-- ========================================ra
-- Boletos Económicos para AM101 
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(214, '10A', 'Economica', 850.00, 'AM101'),
(215, '10B', 'Economica', 850.00, 'AM101'),
(216, '10C', 'Economica', 850.00, 'AM101'),
(217, '10D', 'Economica', 850.00, 'AM101'),
(218, '11A', 'Economica', 850.00, 'AM101'),
(219, '11B', 'Economica', 850.00, 'AM101'),
(220, '11C', 'Economica', 850.00, 'AM101'),
(221, '11D', 'Economica', 850.00, 'AM101'),
(222, '12A', 'Economica', 850.00, 'AM101'),
(223, '12B', 'Economica', 850.00, 'AM101'),
(224, '12C', 'Economica', 850.00, 'AM101'),
(225, '12D', 'Economica', 850.00, 'AM101'),
(226, '13A', 'Economica', 850.00, 'AM101'),
(227, '13B', 'Economica', 850.00, 'AM101'),
(228, '13C', 'Economica', 850.00, 'AM101'),
(229, '13D', 'Economica', 850.00, 'AM101'),
(230, '14A', 'Economica', 850.00, 'AM101'),
(231, '14B', 'Economica', 850.00, 'AM101'),
(232, '14C', 'Economica', 850.00, 'AM101'),
(233, '14D', 'Economica', 850.00, 'AM101'),
(234, '15A', 'Economica', 850.00, 'AM101'),
(235, '15B', 'Economica', 850.00, 'AM101'),
(236, '15C', 'Economica', 850.00, 'AM101'),
(237, '15D', 'Economica', 850.00, 'AM101'),
(238, '16A', 'Economica', 850.00, 'AM101'),
(239, '16B', 'Economica', 850.00, 'AM101'),
(240, '16C', 'Economica', 850.00, 'AM101'),
(241, '16D', 'Economica', 850.00, 'AM101'),
(242, '17A', 'Economica', 850.00, 'AM101'),
(243, '17B', 'Economica', 850.00, 'AM101'),
(244, '17C', 'Economica', 850.00, 'AM101'),
(245, '17D', 'Economica', 850.00, 'AM101'),
(246, '18A', 'Economica', 850.00, 'AM101'),
(247, '18B', 'Economica', 850.00, 'AM101'),
(248, '18C', 'Economica', 850.00, 'AM101'),
(249, '18D', 'Economica', 850.00, 'AM101'),
(250, '19A', 'Economica', 850.00, 'AM101'),
(251, '19B', 'Economica', 850.00, 'AM101'),
(252, '19C', 'Economica', 850.00, 'AM101'),
(253, '19D', 'Economica', 850.00, 'AM101'),
(254, '20A', 'Economica', 850.00, 'AM101'),
(255, '20B', 'Economica', 850.00, 'AM101'),
(256, '20C', 'Economica', 850.00, 'AM101'),
(257, '20D', 'Economica', 850.00, 'AM101'),
(258, '21A', 'Economica', 850.00, 'AM101'),
(259, '21B', 'Economica', 850.00, 'AM101'),
(260, '21C', 'Economica', 850.00, 'AM101'),
(261, '21D', 'Economica', 850.00, 'AM101'),
(262, '22A', 'Economica', 850.00, 'AM101'),
(263, '22B', 'Economica', 850.00, 'AM101'),
(264, '22C', 'Economica', 850.00, 'AM101'),
(265, '22D', 'Economica', 850.00, 'AM101'),
(266, '23A', 'Economica', 850.00, 'AM101'),
(267, '23B', 'Economica', 850.00, 'AM101'),
(268, '23C', 'Economica', 850.00, 'AM101'),
(269, '23D', 'Economica', 850.00, 'AM101'),
(270, '24A', 'Economica', 850.00, 'AM101'),
(271, '24B', 'Economica', 850.00, 'AM101'),
(272, '24C', 'Economica', 850.00, 'AM101'),
(273, '24D', 'Economica', 850.00, 'AM101'),
(274, '25A', 'Economica', 850.00, 'AM101');

-- Boletos Ejecutivos para AM101 (30 boletos: ID 275-304)
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(275, '3A', 'Ejecutiva', 1800.00, 'AM101'),
(276, '3B', 'Ejecutiva', 1800.00, 'AM101'),
(277, '3C', 'Ejecutiva', 1800.00, 'AM101'),
(278, '3D', 'Ejecutiva', 1800.00, 'AM101'),
(279, '4A', 'Ejecutiva', 1800.00, 'AM101'),
(280, '4B', 'Ejecutiva', 1800.00, 'AM101'),
(281, '4C', 'Ejecutiva', 1800.00, 'AM101'),
(282, '4D', 'Ejecutiva', 1800.00, 'AM101'),
(283, '5A', 'Ejecutiva', 1800.00, 'AM101'),
(284, '5B', 'Ejecutiva', 1800.00, 'AM101'),
(285, '5C', 'Ejecutiva', 1800.00, 'AM101'),
(286, '5D', 'Ejecutiva', 1800.00, 'AM101'),
(287, '6A', 'Ejecutiva', 1800.00, 'AM101'),
(288, '6B', 'Ejecutiva', 1800.00, 'AM101'),
(289, '6C', 'Ejecutiva', 1800.00, 'AM101'),
(290, '6D', 'Ejecutiva', 1800.00, 'AM101'),
(291, '7A', 'Ejecutiva', 1800.00, 'AM101'),
(292, '7B', 'Ejecutiva', 1800.00, 'AM101'),
(293, '7C', 'Ejecutiva', 1800.00, 'AM101'),
(294, '7D', 'Ejecutiva', 1800.00, 'AM101'),
(295, '8A', 'Ejecutiva', 1800.00, 'AM101'),
(296, '8B', 'Ejecutiva', 1800.00, 'AM101'),
(297, '8C', 'Ejecutiva', 1800.00, 'AM101'),
(298, '8D', 'Ejecutiva', 1800.00, 'AM101'),
(299, '9A', 'Ejecutiva', 1800.00, 'AM101'),
(300, '9B', 'Ejecutiva', 1800.00, 'AM101'),
(301, '9C', 'Ejecutiva', 1800.00, 'AM101'),
(302, '9D', 'Ejecutiva', 1800.00, 'AM101'),
(303, '25B', 'Ejecutiva', 1800.00, 'AM101'),
(304, '25C', 'Ejecutiva', 1800.00, 'AM101');

-- Boletos Primera Clase para AM101 (10 boletos: ID 305-314)
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(305, '1C', 'Primera', 2500.00, 'AM101'),
(306, '1D', 'Primera', 2500.00, 'AM101'),
(307, '2C', 'Primera', 2500.00, 'AM101'),
(308, '2D', 'Primera', 2500.00, 'AM101'),
(309, '25D', 'Primera', 2500.00, 'AM101'),
(310, '26A', 'Primera', 2500.00, 'AM101'),
(311, '26B', 'Primera', 2500.00, 'AM101'),
(312, '26C', 'Primera', 2500.00, 'AM101'),
(313, '26D', 'Primera', 2500.00, 'AM101'),
(314, '27A', 'Primera', 2500.00, 'AM101');

-- ========================================
-- INSERCIÓN DE BOLETOS PARA VUELO VO201
-- ========================================
-- Necesitamos: 103 boletos adicionales (ya tiene 9)

-- Boletos Económicos para VO201 (62 boletos: ID 315-376)
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(315, '10A', 'Economica', 900.00, 'VO201'),
(316, '10B', 'Economica', 900.00, 'VO201'),
(317, '10C', 'Economica', 900.00, 'VO201'),
(318, '10D', 'Economica', 900.00, 'VO201'),
(319, '11A', 'Economica', 900.00, 'VO201'),
(320, '11B', 'Economica', 900.00, 'VO201'),
(321, '11C', 'Economica', 900.00, 'VO201'),
(322, '11D', 'Economica', 900.00, 'VO201'),
(323, '12A', 'Economica', 900.00, 'VO201'),
(324, '12B', 'Economica', 900.00, 'VO201'),
(325, '12C', 'Economica', 900.00, 'VO201'),
(326, '12D', 'Economica', 900.00, 'VO201'),
(327, '13A', 'Economica', 900.00, 'VO201'),
(328, '13B', 'Economica', 900.00, 'VO201'),
(329, '13C', 'Economica', 900.00, 'VO201'),
(330, '13D', 'Economica', 900.00, 'VO201'),
(331, '14A', 'Economica', 900.00, 'VO201'),
(332, '14B', 'Economica', 900.00, 'VO201'),
(333, '14C', 'Economica', 900.00, 'VO201'),
(334, '14D', 'Economica', 900.00, 'VO201'),
(335, '15A', 'Economica', 900.00, 'VO201'),
(336, '15B', 'Economica', 900.00, 'VO201'),
(337, '15C', 'Economica', 900.00, 'VO201'),
(338, '15D', 'Economica', 900.00, 'VO201'),
(339, '16A', 'Economica', 900.00, 'VO201'),
(340, '16B', 'Economica', 900.00, 'VO201'),
(341, '16C', 'Economica', 900.00, 'VO201'),
(342, '16D', 'Economica', 900.00, 'VO201'),
(343, '17A', 'Economica', 900.00, 'VO201'),
(344, '17B', 'Economica', 900.00, 'VO201'),
(345, '17C', 'Economica', 900.00, 'VO201'),
(346, '17D', 'Economica', 900.00, 'VO201'),
(347, '18A', 'Economica', 900.00, 'VO201'),
(348, '18B', 'Economica', 900.00, 'VO201'),
(349, '18C', 'Economica', 900.00, 'VO201'),
(350, '18D', 'Economica', 900.00, 'VO201'),
(351, '19A', 'Economica', 900.00, 'VO201'),
(352, '19B', 'Economica', 900.00, 'VO201'),
(353, '19C', 'Economica', 900.00, 'VO201'),
(354, '19D', 'Economica', 900.00, 'VO201'),
(355, '20A', 'Economica', 900.00, 'VO201'),
(356, '20B', 'Economica', 900.00, 'VO201'),
(357, '20C', 'Economica', 900.00, 'VO201'),
(358, '20D', 'Economica', 900.00, 'VO201'),
(359, '21A', 'Economica', 900.00, 'VO201'),
(360, '21B', 'Economica', 900.00, 'VO201'),
(361, '21C', 'Economica', 900.00, 'VO201'),
(362, '21D', 'Economica', 900.00, 'VO201'),
(363, '22A', 'Economica', 900.00, 'VO201'),
(364, '22B', 'Economica', 900.00, 'VO201'),
(365, '22C', 'Economica', 900.00, 'VO201'),
(366, '22D', 'Economica', 900.00, 'VO201'),
(367, '23A', 'Economica', 900.00, 'VO201'),
(368, '23B', 'Economica', 900.00, 'VO201'),
(369, '23C', 'Economica', 900.00, 'VO201'),
(370, '23D', 'Economica', 900.00, 'VO201'),
(371, '24A', 'Economica', 900.00, 'VO201'),
(372, '24B', 'Economica', 900.00, 'VO201'),
(373, '24C', 'Economica', 900.00, 'VO201'),
(374, '24D', 'Economica', 900.00, 'VO201'),
(375, '25A', 'Economica', 900.00, 'VO201'),
(376, '25B', 'Economica', 900.00, 'VO201');

-- Boletos Ejecutivos para VO201 (31 boletos: ID 377-407)
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(377, '3A', 'Ejecutiva', 1900.00, 'VO201'),
(378, '3B', 'Ejecutiva', 1900.00, 'VO201'),
(379, '3C', 'Ejecutiva', 1900.00, 'VO201'),
(380, '3D', 'Ejecutiva', 1900.00, 'VO201'),
(381, '4A', 'Ejecutiva', 1900.00, 'VO201'),
(382, '4B', 'Ejecutiva', 1900.00, 'VO201'),
(383, '4C', 'Ejecutiva', 1900.00, 'VO201'),
(384, '4D', 'Ejecutiva', 1900.00, 'VO201'),
(385, '5A', 'Ejecutiva', 1900.00, 'VO201'),
(386, '5B', 'Ejecutiva', 1900.00, 'VO201'),
(387, '5C', 'Ejecutiva', 1900.00, 'VO201'),
(388, '5D', 'Ejecutiva', 1900.00, 'VO201'),
(389, '6A', 'Ejecutiva', 1900.00, 'VO201'),
(390, '6B', 'Ejecutiva', 1900.00, 'VO201'),
(391, '6C', 'Ejecutiva', 1900.00, 'VO201'),
(392, '6D', 'Ejecutiva', 1900.00, 'VO201'),
(393, '7A', 'Ejecutiva', 1900.00, 'VO201'),
(394, '7B', 'Ejecutiva', 1900.00, 'VO201'),
(395, '7C', 'Ejecutiva', 1900.00, 'VO201'),
(396, '7D', 'Ejecutiva', 1900.00, 'VO201'),
(397, '8A', 'Ejecutiva', 1900.00, 'VO201'),
(398, '8B', 'Ejecutiva', 1900.00, 'VO201'),
(399, '8C', 'Ejecutiva', 1900.00, 'VO201'),
(400, '8D', 'Ejecutiva', 1900.00, 'VO201'),
(401, '9A', 'Ejecutiva', 1900.00, 'VO201'),
(402, '9B', 'Ejecutiva', 1900.00, 'VO201'),
(403, '9C', 'Ejecutiva', 1900.00, 'VO201'),
(404, '9D', 'Ejecutiva', 1900.00, 'VO201'),
(405, '25C', 'Ejecutiva', 1900.00, 'VO201'),
(406, '25D', 'Ejecutiva', 1900.00, 'VO201'),
(407, '26A', 'Ejecutiva', 1900.00, 'VO201');

-- Boletos Primera Clase para VO201 (10 boletos: ID 408-417)
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(408, '1C', 'Primera', 2800.00, 'VO201'),
(409, '1D', 'Primera', 2800.00, 'VO201'),
(410, '2C', 'Primera', 2800.00, 'VO201'),
(411, '2D', 'Primera', 2800.00, 'VO201'),
(412, '26B', 'Primera', 2800.00, 'VO201'),
(413, '26C', 'Primera', 2800.00, 'VO201'),
(414, '26D', 'Primera', 2800.00, 'VO201'),
(415, '27A', 'Primera', 2800.00, 'VO201'),
(416, '27B', 'Primera', 2800.00, 'VO201'),
(417, '27C', 'Primera', 2800.00, 'VO201');

-- ========================================
-- INSERCIÓN DE BOLETOS PARA VUELO AM102
-- ========================================

-- Boletos Económicos para AM102 
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(418, '10A', 'Economica', 750.00, 'AM102'),
(419, '10B', 'Economica', 750.00, 'AM102'),
(420, '10C', 'Economica', 750.00, 'AM102'),
(421, '10D', 'Economica', 750.00, 'AM102'),
(422, '11A', 'Economica', 750.00, 'AM102'),
(423, '11B', 'Economica', 750.00, 'AM102'),
(424, '11C', 'Economica', 750.00, 'AM102'),
(425, '11D', 'Economica', 750.00, 'AM102'),
(426, '12A', 'Economica', 750.00, 'AM102'),
(427, '12B', 'Economica', 750.00, 'AM102'),
(428, '12C', 'Economica', 750.00, 'AM102'),
(429, '12D', 'Economica', 750.00, 'AM102'),
(430, '13A', 'Economica', 750.00, 'AM102'),
(431, '13B', 'Economica', 750.00, 'AM102'),
(432, '13C', 'Economica', 750.00, 'AM102'),
(433, '13D', 'Economica', 750.00, 'AM102'),
(434, '14A', 'Economica', 750.00, 'AM102'),
(435, '14B', 'Economica', 750.00, 'AM102'),
(436, '14C', 'Economica', 750.00, 'AM102'),
(437, '14D', 'Economica', 750.00, 'AM102'),
(438, '15A', 'Economica', 750.00, 'AM102'),
(439, '15B', 'Economica', 750.00, 'AM102'),
(440, '15C', 'Economica', 750.00, 'AM102'),
(441, '15D', 'Economica', 750.00, 'AM102'),
(442, '16A', 'Economica', 750.00, 'AM102'),
(443, '16B', 'Economica', 750.00, 'AM102'),
(444, '16C', 'Economica', 750.00, 'AM102'),
(445, '16D', 'Economica', 750.00, 'AM102'),
(446, '17A', 'Economica', 750.00, 'AM102'),
(447, '17B', 'Economica', 750.00, 'AM102'),
(448, '17C', 'Economica', 750.00, 'AM102'),
(449, '17D', 'Economica', 750.00, 'AM102'),
(450, '18A', 'Economica', 750.00, 'AM102'),
(451, '18B', 'Economica', 750.00, 'AM102'),
(452, '18C', 'Economica', 750.00, 'AM102'),
(453, '18D', 'Economica', 750.00, 'AM102'),
(454, '19A', 'Economica', 750.00, 'AM102'),
(455, '19B', 'Economica', 750.00, 'AM102'),
(456, '19C', 'Economica', 750.00, 'AM102'),
(457, '19D', 'Economica', 750.00, 'AM102'),
(458, '20A', 'Economica', 750.00, 'AM102'),
(459, '20B', 'Economica', 750.00, 'AM102'),
(460, '20C', 'Economica', 750.00, 'AM102'),
(461, '20D', 'Economica', 750.00, 'AM102'),
(462, '21A', 'Economica', 750.00, 'AM102'),
(463, '21B', 'Economica', 750.00, 'AM102'),
(464, '21C', 'Economica', 750.00, 'AM102'),
(465, '21D', 'Economica', 750.00, 'AM102'),
(466, '22A', 'Economica', 750.00, 'AM102'),
(467, '22B', 'Economica', 750.00, 'AM102'),
(468, '22C', 'Economica', 750.00, 'AM102'),
(469, '22D', 'Economica', 750.00, 'AM102'),
(470, '23A', 'Economica', 750.00, 'AM102'),
(471, '23B', 'Economica', 750.00, 'AM102'),
(472, '23C', 'Economica', 750.00, 'AM102'),
(473, '23D', 'Economica', 750.00, 'AM102'),
(474, '24A', 'Economica', 750.00, 'AM102'),
(475, '24B', 'Economica', 750.00, 'AM102'),
(476, '24C', 'Economica', 750.00, 'AM102'),
(477, '24D', 'Economica', 750.00, 'AM102'),
(478, '25A', 'Economica', 750.00, 'AM102'),
(479, '25B', 'Economica', 750.00, 'AM102'),
(480, '26A', 'Economica', 750.00, 'AM102'),
(481, '26B', 'Economica', 750.00, 'AM102');

-- Boletos Ejecutivos para AM102 
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(482, '3A', 'Ejecutiva', 1600.00, 'AM102'),
(483, '3B', 'Ejecutiva', 1600.00, 'AM102'),
(484, '3C', 'Ejecutiva', 1600.00, 'AM102'),
(485, '3D', 'Ejecutiva', 1600.00, 'AM102'),
(486, '4A', 'Ejecutiva', 1600.00, 'AM102'),
(487, '4B', 'Ejecutiva', 1600.00, 'AM102'),
(488, '4C', 'Ejecutiva', 1600.00, 'AM102'),
(489, '4D', 'Ejecutiva', 1600.00, 'AM102'),
(490, '5A', 'Ejecutiva', 1600.00, 'AM102'),
(491, '5B', 'Ejecutiva', 1600.00, 'AM102'),
(492, '5C', 'Ejecutiva', 1600.00, 'AM102'),
(493, '5D', 'Ejecutiva', 1600.00, 'AM102'),
(494, '6A', 'Ejecutiva', 1600.00, 'AM102'),
(495, '6B', 'Ejecutiva', 1600.00, 'AM102'),
(496, '6C', 'Ejecutiva', 1600.00, 'AM102'),
(497, '6D', 'Ejecutiva', 1600.00, 'AM102'),
(498, '7A', 'Ejecutiva', 1600.00, 'AM102'),
(499, '7B', 'Ejecutiva', 1600.00, 'AM102'),
(500, '7C', 'Ejecutiva', 1600.00, 'AM102'),
(501, '7D', 'Ejecutiva', 1600.00, 'AM102'),
(502, '8A', 'Ejecutiva', 1600.00, 'AM102'),
(503, '8B', 'Ejecutiva', 1600.00, 'AM102'),
(504, '8C', 'Ejecutiva', 1600.00, 'AM102'),
(505, '8D', 'Ejecutiva', 1600.00, 'AM102'),
(506, '9A', 'Ejecutiva', 1600.00, 'AM102'),
(507, '9B', 'Ejecutiva', 1600.00, 'AM102'),
(508, '9C', 'Ejecutiva', 1600.00, 'AM102'),
(509, '9D', 'Ejecutiva', 1600.00, 'AM102'),
(510, '26C', 'Ejecutiva', 1600.00, 'AM102'),
(511, '26D', 'Ejecutiva', 1600.00, 'AM102'),
(512, '27A', 'Ejecutiva', 1600.00, 'AM102'),
(513, '27B', 'Ejecutiva', 1600.00, 'AM102');

-- Boletos Primera Clase para AM102 (10 boletos: ID 514-523)
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(514, '1C', 'Primera', 2300.00, 'AM102'),
(515, '1D', 'Primera', 2300.00, 'AM102'),
(516, '2C', 'Primera', 2300.00, 'AM102'),
(517, '2D', 'Primera', 2300.00, 'AM102'),
(518, '27C', 'Primera', 2300.00, 'AM102'),
(519, '27D', 'Primera', 2300.00, 'AM102'),
(520, '28A', 'Primera', 2300.00, 'AM102'),
(521, '28B', 'Primera', 2300.00, 'AM102'),
(522, '28C', 'Primera', 2300.00, 'AM102'),
(523, '28D', 'Primera', 2300.00, 'AM102');

-- ========================================
-- INSERCIÓN DE COMPRAS (TABLA COMPRAR)
-- ========================================

-- Compras para AM101 
INSERT INTO Comprar (Cliente_id, Boleto_id, Fecha_compra) VALUES
(1, 214, '2024-12-06'), (2, 215, '2024-12-06'), (3, 216, '2024-12-07'), (4, 217, '2024-12-07'),
(5, 218, '2024-12-08'), (6, 219, '2024-12-08'), (7, 220, '2024-12-09'), (8, 221, '2024-12-09'),
(9, 222, '2024-12-10'), (10, 223, '2024-12-10'), (11, 224, '2024-12-11'), (12, 225, '2024-12-11'),
(13, 226, '2024-12-12'), (14, 227, '2024-12-12'), (15, 228, '2024-12-13'), (16, 229, '2024-12-13'),
(17, 230, '2024-12-14'), (18, 231, '2024-12-14'), (19, 232, '2024-12-15'), (20, 233, '2024-12-15'),
(21, 234, '2024-12-16'), (22, 235, '2024-12-16'), (23, 236, '2024-12-17'), (24, 237, '2024-12-17'),
(25, 238, '2024-12-18'), (26, 239, '2024-12-18'), (27, 240, '2024-12-19'), (28, 241, '2024-12-19'),
(29, 242, '2024-12-20'), (30, 243, '2024-12-20'), (31, 244, '2024-12-21'), (32, 245, '2024-12-21'),
(33, 246, '2024-12-22'), (34, 247, '2024-12-22'), (35, 248, '2024-12-23'), (36, 249, '2024-12-23'),
(37, 250, '2024-12-24'), (38, 251, '2024-12-24'), (39, 252, '2024-12-25'), (40, 253, '2024-12-25'),
(41, 254, '2024-12-26'), (42, 255, '2024-12-26'), (43, 256, '2024-12-27'), (44, 257, '2024-12-27'),
(45, 258, '2024-12-28'), (46, 259, '2024-12-28'), (47, 260, '2024-12-29'), (48, 261, '2024-12-29'),
(49, 262, '2024-12-30'), (50, 263, '2024-12-30'), (51, 264, '2024-12-31'), (52, 265, '2024-12-31'),
(53, 266, '2025-01-01'), (54, 267, '2025-01-01'), (55, 268, '2025-01-02'), (56, 269, '2025-01-02'),
(57, 270, '2025-01-03'), (58, 271, '2025-01-03'), (59, 272, '2025-01-04'), (60, 273, '2025-01-04'),
(61, 274, '2024-12-06'), (62, 275, '2024-12-07'), (63, 276, '2024-12-08'), (64, 277, '2024-12-09'),
(65, 278, '2024-12-10'), (66, 279, '2024-12-11'), (67, 280, '2024-12-12'), (68, 281, '2024-12-13'),
(69, 282, '2024-12-14'), (70, 283, '2024-12-15'), (71, 284, '2024-12-16'), (72, 285, '2024-12-17'),
(73, 286, '2024-12-18'), (74, 287, '2024-12-19'), (75, 288, '2024-12-20'), (76, 289, '2024-12-21'),
(77, 290, '2024-12-22'), (78, 291, '2024-12-23'), (79, 292, '2024-12-24'), (80, 293, '2024-12-25'),
(81, 294, '2024-12-26'), (82, 295, '2024-12-27'), (83, 296, '2024-12-28'), (84, 297, '2024-12-29'),
(85, 298, '2024-12-30'), (86, 299, '2024-12-31'), (87, 300, '2025-01-01'), (88, 301, '2025-01-02'),
(89, 302, '2025-01-03'), (90, 303, '2025-01-04'), (91, 304, '2024-12-06'), (92, 305, '2024-12-07'),
(93, 306, '2024-12-08'), (94, 307, '2024-12-09'), (95, 308, '2024-12-10'), (96, 309, '2024-12-11'),
(97, 310, '2024-12-12'), (98, 311, '2024-12-13'), (99, 312, '2024-12-14'), (1, 313, '2024-12-15'),
(2, 314, '2024-12-16');

-- Compras para VO201 
INSERT INTO Comprar (Cliente_id, Boleto_id, Fecha_compra) VALUES
(3, 315, '2024-12-11'), (4, 316, '2024-12-11'), (5, 317, '2024-12-12'), (6, 318, '2024-12-12'),
(7, 319, '2024-12-13'), (8, 320, '2024-12-13'), (9, 321, '2024-12-14'), (10, 322, '2024-12-14'),
(11, 323, '2024-12-15'), (12, 324, '2024-12-15'), (13, 325, '2024-12-16'), (14, 326, '2024-12-16'),
(15, 327, '2024-12-17'), (16, 328, '2024-12-17'), (17, 329, '2024-12-18'), (18, 330, '2024-12-18'),
(19, 331, '2024-12-19'), (20, 332, '2024-12-19'), (21, 333, '2024-12-20'), (22, 334, '2024-12-20'),
(23, 335, '2024-12-21'), (24, 336, '2024-12-21'), (25, 337, '2024-12-22'), (26, 338, '2024-12-22'),
(27, 339, '2024-12-23'), (28, 340, '2024-12-23'), (29, 341, '2024-12-24'), (30, 342, '2024-12-24'),
(31, 343, '2024-12-25'), (32, 344, '2024-12-25'), (33, 345, '2024-12-26'), (34, 346, '2024-12-26'),
(35, 347, '2024-12-27'), (36, 348, '2024-12-27'), (37, 349, '2024-12-28'), (38, 350, '2024-12-28'),
(39, 351, '2024-12-29'), (40, 352, '2024-12-29'), (41, 353, '2024-12-30'), (42, 354, '2024-12-30'),
(43, 355, '2024-12-31'), (44, 356, '2024-12-31'), (45, 357, '2025-01-01'), (46, 358, '2025-01-01'),
(47, 359, '2025-01-02'), (48, 360, '2025-01-02'), (49, 361, '2025-01-03'), (50, 362, '2025-01-03'),
(51, 363, '2025-01-04'), (52, 364, '2025-01-04'), (53, 365, '2025-01-05'), (54, 366, '2025-01-05'),
(55, 367, '2025-01-06'), (56, 368, '2025-01-06'), (57, 369, '2025-01-07'), (58, 370, '2025-01-07'),
(59, 371, '2025-01-08'), (60, 372, '2025-01-08'), (61, 373, '2025-01-09'), (62, 374, '2024-12-11'),
(63, 375, '2024-12-12'), (64, 376, '2024-12-13'), (65, 377, '2024-12-14'), (66, 378, '2024-12-15'),
(67, 379, '2024-12-16'), (68, 380, '2024-12-17'), (69, 381, '2024-12-18'), (70, 382, '2024-12-19'),
(71, 383, '2024-12-20'), (72, 384, '2024-12-21'), (73, 385, '2024-12-22'), (74, 386, '2024-12-23'),
(75, 387, '2024-12-24'), (76, 388, '2024-12-25'), (77, 389, '2024-12-26'), (78, 390, '2024-12-27'),
(79, 391, '2024-12-28'), (80, 392, '2024-12-29'), (81, 393, '2024-12-30'), (82, 394, '2024-12-31'),
(83, 395, '2025-01-01'), (84, 396, '2025-01-02'), (85, 397, '2025-01-03'), (86, 398, '2025-01-04'),
(87, 399, '2025-01-05'), (88, 400, '2025-01-06'), (89, 401, '2025-01-07'), (90, 402, '2025-01-08'),
(91, 403, '2025-01-09'), (92, 404, '2024-12-11'), (93, 405, '2024-12-12'), (94, 406, '2024-12-13'),
(95, 407, '2024-12-14'), (96, 408, '2024-12-15'), (97, 409, '2024-12-16'), (98, 410, '2024-12-17'),
(99, 411, '2024-12-18'), (1, 412, '2024-12-19'), (2, 413, '2024-12-20'), (3, 414, '2024-12-21'),
(4, 415, '2024-12-22'), (5, 416, '2024-12-23'), (6, 417, '2024-12-24');

-- Compras para AM102 
INSERT INTO Comprar (Cliente_id, Boleto_id, Fecha_compra) VALUES
(7, 418, '2024-12-06'), (8, 419, '2024-12-06'), (9, 420, '2024-12-07'), (10, 421, '2024-12-07'),
(11, 422, '2024-12-08'), (12, 423, '2024-12-08'), (13, 424, '2024-12-09'), (14, 425, '2024-12-09'),
(15, 426, '2024-12-10'), (16, 427, '2024-12-10'), (17, 428, '2024-12-11'), (18, 429, '2024-12-11'),
(19, 430, '2024-12-12'), (20, 431, '2024-12-12'), (21, 432, '2024-12-13'), (22, 433, '2024-12-13'),
(23, 434, '2024-12-14'), (24, 435, '2024-12-14'), (25, 436, '2024-12-15'), (26, 437, '2024-12-15'),
(27, 438, '2024-12-16'), (28, 439, '2024-12-16'), (29, 440, '2024-12-17'), (30, 441, '2024-12-17'),
(31, 442, '2024-12-18'), (32, 443, '2024-12-18'), (33, 444, '2024-12-19'), (34, 445, '2024-12-19'),
(35, 446, '2024-12-20'), (36, 447, '2024-12-20'), (37, 448, '2024-12-21'), (38, 449, '2024-12-21'),
(39, 450, '2024-12-22'), (40, 451, '2024-12-22'), (41, 452, '2024-12-23'), (42, 453, '2024-12-23'),
(43, 454, '2024-12-24'), (44, 455, '2024-12-24'), (45, 456, '2024-12-25'), (46, 457, '2024-12-25'),
(47, 458, '2024-12-26'), (48, 459, '2024-12-26'), (49, 460, '2024-12-27'), (50, 461, '2024-12-27'),
(51, 462, '2024-12-28'), (52, 463, '2024-12-28'), (53, 464, '2024-12-29'), (54, 465, '2024-12-29'),
(55, 466, '2024-12-30'), (56, 467, '2024-12-30'), (57, 468, '2024-12-31'), (58, 469, '2024-12-31'),
(59, 470, '2025-01-01'), (60, 471, '2025-01-01'), (61, 472, '2025-01-02'), (62, 473, '2025-01-02'),
(63, 474, '2025-01-03'), (64, 475, '2025-01-03'), (65, 476, '2025-01-04'), (66, 477, '2025-01-04'),
(67, 478, '2024-12-06'), (68, 479, '2024-12-07'), (69, 480, '2024-12-08'), (70, 481, '2024-12-09'),
(71, 482, '2024-12-10'), (72, 483, '2024-12-11'), (73, 484, '2024-12-12'), (74, 485, '2024-12-13'),
(75, 486, '2024-12-14'), (76, 487, '2024-12-15'), (77, 488, '2024-12-16'), (78, 489, '2024-12-17'),
(79, 490, '2024-12-18'), (80, 491, '2024-12-19'), (81, 492, '2024-12-20'), (82, 493, '2024-12-21'),
(83, 494, '2024-12-22'), (84, 495, '2024-12-23'), (85, 496, '2024-12-24'), (86, 497, '2024-12-25'),
(87, 498, '2024-12-26'), (88, 499, '2024-12-27'), (89, 500, '2024-12-28'), (90, 501, '2024-12-29'),
(91, 502, '2024-12-30'), (92, 503, '2024-12-31'), (93, 504, '2025-01-01'), (94, 505, '2025-01-02'),
(95, 506, '2025-01-03'), (96, 507, '2025-01-04'), (97, 508, '2024-12-06'), (98, 509, '2024-12-07'),
(99, 510, '2024-12-08'), (1, 511, '2024-12-09'), (2, 512, '2024-12-10'), (3, 513, '2024-12-11'),
(4, 514, '2024-12-12'), (5, 515, '2024-12-13'), (6, 516, '2024-12-14'), (7, 517, '2024-12-15'),
(8, 518, '2024-12-16'), (9, 519, '2024-12-17'), (10, 520, '2024-12-18'), (11, 521, '2024-12-19'),
(12, 522, '2024-12-20'), (13, 523, '2024-12-21');



-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- agregamos mas boletos vendidos para que aparezcan al menos 5 registros
-- ========================================ra
-- Boletos Económicos para VO202 
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(524, '10A', 'Economica', 1200.00, 'VO202'),
(525, '10B', 'Economica', 1200.00, 'VO202'),
(526, '10C', 'Economica', 1200.00, 'VO202'),
(527, '10D', 'Economica', 1200.00, 'VO202'),
(528, '11A', 'Economica', 1200.00, 'VO202'),
(529, '11B', 'Economica', 1200.00, 'VO202'),
(530, '11C', 'Economica', 1200.00, 'VO202'),
(531, '11D', 'Economica', 1200.00, 'VO202'),
(532, '12A', 'Economica', 1200.00, 'VO202'),
(533, '12B', 'Economica', 1200.00, 'VO202'),
(534, '12C', 'Economica', 1200.00, 'VO202'),
(535, '12D', 'Economica', 1200.00, 'VO202'),
(536, '13A', 'Economica', 1200.00, 'VO202'),
(537, '13B', 'Economica', 1200.00, 'VO202'),
(538, '13C', 'Economica', 1200.00, 'VO202'),
(539, '13D', 'Economica', 1200.00, 'VO202'),
(540, '14A', 'Economica', 1200.00, 'VO202'),
(541, '14B', 'Economica', 1200.00, 'VO202'),
(542, '14C', 'Economica', 1200.00, 'VO202'),
(543, '14D', 'Economica', 1200.00, 'VO202'),
(544, '15A', 'Economica', 1200.00, 'VO202'),
(545, '15B', 'Economica', 1200.00, 'VO202'),
(546, '15C', 'Economica', 1200.00, 'VO202'),
(547, '15D', 'Economica', 1200.00, 'VO202'),
(548, '16A', 'Economica', 1200.00, 'VO202'),
(549, '16B', 'Economica', 1200.00, 'VO202'),
(550, '16C', 'Economica', 1200.00, 'VO202'),
(551, '16D', 'Economica', 1200.00, 'VO202'),
(552, '17A', 'Economica', 1200.00, 'VO202'),
(553, '17B', 'Economica', 1200.00, 'VO202'),
(554, '17C', 'Economica', 1200.00, 'VO202'),
(555, '17D', 'Economica', 1200.00, 'VO202'),
(556, '18A', 'Economica', 1200.00, 'VO202'),
(557, '18B', 'Economica', 1200.00, 'VO202'),
(558, '18C', 'Economica', 1200.00, 'VO202'),
(559, '18D', 'Economica', 1200.00, 'VO202'),
(560, '19A', 'Economica', 1200.00, 'VO202'),
(561, '19B', 'Economica', 1200.00, 'VO202'),
(562, '19C', 'Economica', 1200.00, 'VO202'),
(563, '19D', 'Economica', 1200.00, 'VO202'),
(564, '20A', 'Economica', 1200.00, 'VO202'),
(565, '20B', 'Economica', 1200.00, 'VO202'),
(566, '20C', 'Economica', 1200.00, 'VO202'),
(567, '20D', 'Economica', 1200.00, 'VO202'),
(568, '21A', 'Economica', 1200.00, 'VO202'),
(569, '21B', 'Economica', 1200.00, 'VO202'),
(570, '21C', 'Economica', 1200.00, 'VO202'),
(571, '21D', 'Economica', 1200.00, 'VO202'),
(572, '22A', 'Economica', 1200.00, 'VO202'),
(573, '22B', 'Economica', 1200.00, 'VO202'),
(574, '22C', 'Economica', 1200.00, 'VO202'),
(575, '22D', 'Economica', 1200.00, 'VO202'),
(576, '23A', 'Economica', 1200.00, 'VO202'),
(577, '23B', 'Economica', 1200.00, 'VO202');

-- Boletos Ejecutivos para VO202 (
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(578, '3A', 'Ejecutiva', 2100.00, 'VO202'),
(579, '3B', 'Ejecutiva', 2100.00, 'VO202'),
(580, '3C', 'Ejecutiva', 2100.00, 'VO202'),
(581, '3D', 'Ejecutiva', 2100.00, 'VO202'),
(582, '4A', 'Ejecutiva', 2100.00, 'VO202'),
(583, '4B', 'Ejecutiva', 2100.00, 'VO202'),
(584, '4C', 'Ejecutiva', 2100.00, 'VO202'),
(585, '4D', 'Ejecutiva', 2100.00, 'VO202'),
(586, '5A', 'Ejecutiva', 2100.00, 'VO202'),
(587, '5B', 'Ejecutiva', 2100.00, 'VO202'),
(588, '5C', 'Ejecutiva', 2100.00, 'VO202'),
(589, '5D', 'Ejecutiva', 2100.00, 'VO202'),
(590, '6A', 'Ejecutiva', 2100.00, 'VO202'),
(591, '6B', 'Ejecutiva', 2100.00, 'VO202'),
(592, '6C', 'Ejecutiva', 2100.00, 'VO202'),
(593, '6D', 'Ejecutiva', 2100.00, 'VO202'),
(594, '7A', 'Ejecutiva', 2100.00, 'VO202'),
(595, '7B', 'Ejecutiva', 2100.00, 'VO202'),
(596, '7C', 'Ejecutiva', 2100.00, 'VO202'),
(597, '7D', 'Ejecutiva', 2100.00, 'VO202'),
(598, '8A', 'Ejecutiva', 2100.00, 'VO202'),
(599, '8B', 'Ejecutiva', 2100.00, 'VO202'),
(600, '8C', 'Ejecutiva', 2100.00, 'VO202'),
(601, '8D', 'Ejecutiva', 2100.00, 'VO202'),
(602, '9A', 'Ejecutiva', 2100.00, 'VO202'),
(603, '9B', 'Ejecutiva', 2100.00, 'VO202'),
(604, '9C', 'Ejecutiva', 2100.00, 'VO202');

-- Boletos Primera Clase para VO202 (9 boletos: ID 605-613)
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(605, '1C', 'Primera', 3200.00, 'VO202'),
(606, '1D', 'Primera', 3200.00, 'VO202'),
(607, '2C', 'Primera', 3200.00, 'VO202'),
(608, '2D', 'Primera', 3200.00, 'VO202'),
(609, '9D', 'Primera', 3200.00, 'VO202'),
(610, '23C', 'Primera', 3200.00, 'VO202'),
(611, '23D', 'Primera', 3200.00, 'VO202'),
(612, '24A', 'Primera', 3200.00, 'VO202'),
(613, '24B', 'Primera', 3200.00, 'VO202');

-- ========================================
-- INSERCIÓN DE BOLETOS PARA VUELO VB301
-- ========================================

-- Boletos Económicos para VB301 
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(614, '10A', 'Economica', 950.00, 'VB301'),
(615, '10B', 'Economica', 950.00, 'VB301'),
(616, '10C', 'Economica', 950.00, 'VB301'),
(617, '10D', 'Economica', 950.00, 'VB301'),
(618, '11A', 'Economica', 950.00, 'VB301'),
(619, '11B', 'Economica', 950.00, 'VB301'),
(620, '11C', 'Economica', 950.00, 'VB301'),
(621, '11D', 'Economica', 950.00, 'VB301'),
(622, '12A', 'Economica', 950.00, 'VB301'),
(623, '12B', 'Economica', 950.00, 'VB301'),
(624, '12C', 'Economica', 950.00, 'VB301'),
(625, '12D', 'Economica', 950.00, 'VB301'),
(626, '13A', 'Economica', 950.00, 'VB301'),
(627, '13B', 'Economica', 950.00, 'VB301'),
(628, '13C', 'Economica', 950.00, 'VB301'),
(629, '13D', 'Economica', 950.00, 'VB301'),
(630, '14A', 'Economica', 950.00, 'VB301'),
(631, '14B', 'Economica', 950.00, 'VB301'),
(632, '14C', 'Economica', 950.00, 'VB301'),
(633, '14D', 'Economica', 950.00, 'VB301'),
(634, '15A', 'Economica', 950.00, 'VB301'),
(635, '15B', 'Economica', 950.00, 'VB301'),
(636, '15C', 'Economica', 950.00, 'VB301'),
(637, '15D', 'Economica', 950.00, 'VB301'),
(638, '16A', 'Economica', 950.00, 'VB301'),
(639, '16B', 'Economica', 950.00, 'VB301'),
(640, '16C', 'Economica', 950.00, 'VB301'),
(641, '16D', 'Economica', 950.00, 'VB301'),
(642, '17A', 'Economica', 950.00, 'VB301'),
(643, '17B', 'Economica', 950.00, 'VB301'),
(644, '17C', 'Economica', 950.00, 'VB301'),
(645, '17D', 'Economica', 950.00, 'VB301'),
(646, '18A', 'Economica', 950.00, 'VB301'),
(647, '18B', 'Economica', 950.00, 'VB301'),
(648, '18C', 'Economica', 950.00, 'VB301'),
(649, '18D', 'Economica', 950.00, 'VB301'),
(650, '19A', 'Economica', 950.00, 'VB301'),
(651, '19B', 'Economica', 950.00, 'VB301'),
(652, '19C', 'Economica', 950.00, 'VB301'),
(653, '19D', 'Economica', 950.00, 'VB301'),
(654, '20A', 'Economica', 950.00, 'VB301'),
(655, '20B', 'Economica', 950.00, 'VB301'),
(656, '20C', 'Economica', 950.00, 'VB301'),
(657, '20D', 'Economica', 950.00, 'VB301'),
(658, '21A', 'Economica', 950.00, 'VB301'),
(659, '21B', 'Economica', 950.00, 'VB301'),
(660, '21C', 'Economica', 950.00, 'VB301'),
(661, '21D', 'Economica', 950.00, 'VB301'),
(662, '22A', 'Economica', 950.00, 'VB301'),
(663, '22B', 'Economica', 950.00, 'VB301'),
(664, '22C', 'Economica', 950.00, 'VB301'),
(665, '22D', 'Economica', 950.00, 'VB301'),
(666, '23A', 'Economica', 950.00, 'VB301'),
(667, '23B', 'Economica', 950.00, 'VB301'),
(668, '23C', 'Economica', 950.00, 'VB301'),
(669, '23D', 'Economica', 950.00, 'VB301'),
(670, '24A', 'Economica', 950.00, 'VB301'),
(671, '24B', 'Economica', 950.00, 'VB301'),
(672, '24C', 'Economica', 950.00, 'VB301');

-- Boletos Ejecutivos para VB301 
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(673, '3A', 'Ejecutiva', 1950.00, 'VB301'),
(674, '3B', 'Ejecutiva', 1950.00, 'VB301'),
(675, '3C', 'Ejecutiva', 1950.00, 'VB301'),
(676, '3D', 'Ejecutiva', 1950.00, 'VB301'),
(677, '4A', 'Ejecutiva', 1950.00, 'VB301'),
(678, '4B', 'Ejecutiva', 1950.00, 'VB301'),
(679, '4C', 'Ejecutiva', 1950.00, 'VB301'),
(680, '4D', 'Ejecutiva', 1950.00, 'VB301'),
(681, '5A', 'Ejecutiva', 1950.00, 'VB301'),
(682, '5B', 'Ejecutiva', 1950.00, 'VB301'),
(683, '5C', 'Ejecutiva', 1950.00, 'VB301'),
(684, '5D', 'Ejecutiva', 1950.00, 'VB301'),
(685, '6A', 'Ejecutiva', 1950.00, 'VB301'),
(686, '6B', 'Ejecutiva', 1950.00, 'VB301'),
(687, '6C', 'Ejecutiva', 1950.00, 'VB301'),
(688, '6D', 'Ejecutiva', 1950.00, 'VB301'),
(689, '7A', 'Ejecutiva', 1950.00, 'VB301'),
(690, '7B', 'Ejecutiva', 1950.00, 'VB301'),
(691, '7C', 'Ejecutiva', 1950.00, 'VB301'),
(692, '7D', 'Ejecutiva', 1950.00, 'VB301'),
(693, '8A', 'Ejecutiva', 1950.00, 'VB301'),
(694, '8B', 'Ejecutiva', 1950.00, 'VB301'),
(695, '8C', 'Ejecutiva', 1950.00, 'VB301'),
(696, '8D', 'Ejecutiva', 1950.00, 'VB301'),
(697, '9A', 'Ejecutiva', 1950.00, 'VB301'),
(698, '9B', 'Ejecutiva', 1950.00, 'VB301'),
(699, '9C', 'Ejecutiva', 1950.00, 'VB301'),
(700, '9D', 'Ejecutiva', 1950.00, 'VB301'),
(701, '24D', 'Ejecutiva', 1950.00, 'VB301');

-- Boletos Primera Clase para VB301 
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(702, '1C', 'Primera', 2850.00, 'VB301'),
(703, '1D', 'Primera', 2850.00, 'VB301'),
(704, '2C', 'Primera', 2850.00, 'VB301'),
(705, '2D', 'Primera', 2850.00, 'VB301'),
(706, '25A', 'Primera', 2850.00, 'VB301'),
(707, '25B', 'Primera', 2850.00, 'VB301'),
(708, '25C', 'Primera', 2850.00, 'VB301'),
(709, '25D', 'Primera', 2850.00, 'VB301'),
(710, '26A', 'Primera', 2850.00, 'VB301'),
(711, '26B', 'Primera', 2850.00, 'VB301');

-- ========================================
-- INSERCIÓN DE BOLETOS PARA VUELO VB303
-- ========================================

-- Boletos Económicos para VB303 
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(712, '10A', 'Economica', 920.00, 'VB303'),
(713, '10B', 'Economica', 920.00, 'VB303'),
(714, '10C', 'Economica', 920.00, 'VB303'),
(715, '10D', 'Economica', 920.00, 'VB303'),
(716, '11A', 'Economica', 920.00, 'VB303'),
(717, '11B', 'Economica', 920.00, 'VB303'),
(718, '11C', 'Economica', 920.00, 'VB303'),
(719, '11D', 'Economica', 920.00, 'VB303'),
(720, '12A', 'Economica', 920.00, 'VB303'),
(721, '12B', 'Economica', 920.00, 'VB303'),
(722, '12C', 'Economica', 920.00, 'VB303'),
(723, '12D', 'Economica', 920.00, 'VB303'),
(724, '13A', 'Economica', 920.00, 'VB303'),
(725, '13B', 'Economica', 920.00, 'VB303'),
(726, '13C', 'Economica', 920.00, 'VB303'),
(727, '13D', 'Economica', 920.00, 'VB303'),
(728, '14A', 'Economica', 920.00, 'VB303'),
(729, '14B', 'Economica', 920.00, 'VB303'),
(730, '14C', 'Economica', 920.00, 'VB303'),
(731, '14D', 'Economica', 920.00, 'VB303'),
(732, '15A', 'Economica', 920.00, 'VB303'),
(733, '15B', 'Economica', 920.00, 'VB303'),
(734, '15C', 'Economica', 920.00, 'VB303'),
(735, '15D', 'Economica', 920.00, 'VB303'),
(736, '16A', 'Economica', 920.00, 'VB303'),
(737, '16B', 'Economica', 920.00, 'VB303'),
(738, '16C', 'Economica', 920.00, 'VB303'),
(739, '16D', 'Economica', 920.00, 'VB303'),
(740, '17A', 'Economica', 920.00, 'VB303'),
(741, '17B', 'Economica', 920.00, 'VB303'),
(742, '17C', 'Economica', 920.00, 'VB303'),
(743, '17D', 'Economica', 920.00, 'VB303'),
(744, '18A', 'Economica', 920.00, 'VB303'),
(745, '18B', 'Economica', 920.00, 'VB303'),
(746, '18C', 'Economica', 920.00, 'VB303'),
(747, '18D', 'Economica', 920.00, 'VB303'),
(748, '19A', 'Economica', 920.00, 'VB303'),
(749, '19B', 'Economica', 920.00, 'VB303'),
(750, '19C', 'Economica', 920.00, 'VB303'),
(751, '19D', 'Economica', 920.00, 'VB303'),
(752, '20A', 'Economica', 920.00, 'VB303'),
(753, '20B', 'Economica', 920.00, 'VB303'),
(754, '20C', 'Economica', 920.00, 'VB303'),
(755, '20D', 'Economica', 920.00, 'VB303'),
(756, '21A', 'Economica', 920.00, 'VB303'),
(757, '21B', 'Economica', 920.00, 'VB303'),
(758, '21C', 'Economica', 920.00, 'VB303'),
(759, '21D', 'Economica', 920.00, 'VB303'),
(760, '22A', 'Economica', 920.00, 'VB303'),
(761, '22B', 'Economica', 920.00, 'VB303'),
(762, '22C', 'Economica', 920.00, 'VB303'),
(763, '22D', 'Economica', 920.00, 'VB303'),
(764, '23A', 'Economica', 920.00, 'VB303'),
(765, '23B', 'Economica', 920.00, 'VB303'),
(766, '23C', 'Economica', 920.00, 'VB303'),
(767, '23D', 'Economica', 920.00, 'VB303'),
(768, '24A', 'Economica', 920.00, 'VB303'),
(769, '24B', 'Economica', 920.00, 'VB303'),
(770, '24C', 'Economica', 920.00, 'VB303');

-- Boletos Ejecutivos para VB303 
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(771, '3A', 'Ejecutiva', 1900.00, 'VB303'),
(772, '3B', 'Ejecutiva', 1900.00, 'VB303'),
(773, '3C', 'Ejecutiva', 1900.00, 'VB303'),
(774, '3D', 'Ejecutiva', 1900.00, 'VB303'),
(775, '4A', 'Ejecutiva', 1900.00, 'VB303'),
(776, '4B', 'Ejecutiva', 1900.00, 'VB303'),
(777, '4C', 'Ejecutiva', 1900.00, 'VB303'),
(778, '4D', 'Ejecutiva', 1900.00, 'VB303'),
(779, '5A', 'Ejecutiva', 1900.00, 'VB303'),
(780, '5B', 'Ejecutiva', 1900.00, 'VB303'),
(781, '5C', 'Ejecutiva', 1900.00, 'VB303'),
(782, '5D', 'Ejecutiva', 1900.00, 'VB303'),
(783, '6A', 'Ejecutiva', 1900.00, 'VB303'),
(784, '6B', 'Ejecutiva', 1900.00, 'VB303'),
(785, '6C', 'Ejecutiva', 1900.00, 'VB303'),
(786, '6D', 'Ejecutiva', 1900.00, 'VB303'),
(787, '7A', 'Ejecutiva', 1900.00, 'VB303'),
(788, '7B', 'Ejecutiva', 1900.00, 'VB303'),
(789, '7C', 'Ejecutiva', 1900.00, 'VB303'),
(790, '7D', 'Ejecutiva', 1900.00, 'VB303'),
(791, '8A', 'Ejecutiva', 1900.00, 'VB303'),
(792, '8B', 'Ejecutiva', 1900.00, 'VB303'),
(793, '8C', 'Ejecutiva', 1900.00, 'VB303'),
(794, '8D', 'Ejecutiva', 1900.00, 'VB303'),
(795, '9A', 'Ejecutiva', 1900.00, 'VB303'),
(796, '9B', 'Ejecutiva', 1900.00, 'VB303'),
(797, '9C', 'Ejecutiva', 1900.00, 'VB303'),
(798, '9D', 'Ejecutiva', 1900.00, 'VB303'),
(799, '24D', 'Ejecutiva', 1900.00, 'VB303');

-- Boletos Primera 
INSERT INTO Boleto (Boleto_id, Numero_asiento, Clase, Precio, Numero_vuelo) VALUES
(800, '1C', 'Primera', 2800.00, 'VB303'),
(801, '1D', 'Primera', 2800.00, 'VB303'),
(802, '2C', 'Primera', 2800.00, 'VB303'),
(803, '2D', 'Primera', 2800.00, 'VB303'),
(804, '25A', 'Primera', 2800.00, 'VB303'),
(805, '25B', 'Primera', 2800.00, 'VB303'),
(806, '25C', 'Primera', 2800.00, 'VB303'),
(807, '25D', 'Primera', 2800.00, 'VB303'),
(808, '26A', 'Primera', 2800.00, 'VB303'),
(809, '26B', 'Primera', 2800.00, 'VB303');

-- ========================================
-- INSERCIÓN DE COMPRAS (TABLA COMPRAR)
-- ========================================

-- Compras para VO202 (
INSERT INTO Comprar (Cliente_id, Boleto_id, Fecha_compra) VALUES
(14, 524, '2024-12-11'), (15, 525, '2024-12-11'), (16, 526, '2024-12-12'), (17, 527, '2024-12-12'),
(18, 528, '2024-12-13'), (19, 529, '2024-12-13'), (20, 530, '2024-12-14'), (21, 531, '2024-12-14'),
(22, 532, '2024-12-15'), (23, 533, '2024-12-15'), (24, 534, '2024-12-16'), (25, 535, '2024-12-16'),
(26, 536, '2024-12-17'), (27, 537, '2024-12-17'), (28, 538, '2024-12-18'), (29, 539, '2024-12-18'),
(30, 540, '2024-12-19'), (31, 541, '2024-12-19'), (32, 542, '2024-12-20'), (33, 543, '2024-12-20'),
(34, 544, '2024-12-21'), (35, 545, '2024-12-21'), (36, 546, '2024-12-22'), (37, 547, '2024-12-22'),
(38, 548, '2024-12-23'), (39, 549, '2024-12-23'), (40, 550, '2024-12-24'), (41, 551, '2024-12-24'),
(42, 552, '2024-12-25'), (43, 553, '2024-12-25'), (44, 554, '2024-12-26'), (45, 555, '2024-12-26'),
(46, 556, '2024-12-27'), (47, 557, '2024-12-27'), (48, 558, '2024-12-28'), (49, 559, '2024-12-28'),
(50, 560, '2024-12-29'), (51, 561, '2024-12-29'), (52, 562, '2024-12-30'), (53, 563, '2024-12-30'),
(54, 564, '2024-12-31'), (55, 565, '2024-12-31'), (56, 566, '2025-01-01'), (57, 567, '2025-01-01'),
(58, 568, '2025-01-02'), (59, 569, '2025-01-02'), (60, 570, '2025-01-03'), (61, 571, '2025-01-03'),
(62, 572, '2025-01-04'), (63, 573, '2025-01-04'), (64, 574, '2025-01-05'), (65, 575, '2025-01-05'),
(66, 576, '2025-01-06'), (67, 577, '2024-12-11'), (68, 578, '2024-12-12'), (69, 579, '2024-12-13'),
(70, 580, '2024-12-14'), (71, 581, '2024-12-15'), (72, 582, '2024-12-16'), (73, 583, '2024-12-17'),
(74, 584, '2024-12-18'), (75, 585, '2024-12-19'), (76, 586, '2024-12-20'), (77, 587, '2024-12-21'),
(78, 588, '2024-12-22'), (79, 589, '2024-12-23'), (80, 590, '2024-12-24'), (81, 591, '2024-12-25'),
(82, 592, '2024-12-26'), (83, 593, '2024-12-27'), (84, 594, '2024-12-28'), (85, 595, '2024-12-29'),
(86, 596, '2024-12-30'), (87, 597, '2024-12-31'), (88, 598, '2025-01-01'), (89, 599, '2025-01-02'),
(90, 600, '2025-01-03'), (91, 601, '2025-01-04'), (92, 602, '2025-01-05'), (93, 603, '2025-01-06'),
(94, 604, '2024-12-11'), (95, 605, '2024-12-12'), (96, 606, '2024-12-13'), (97, 607, '2024-12-14'),
(98, 608, '2024-12-15'), (99, 609, '2024-12-16'), (1, 610, '2024-12-17'), (2, 611, '2024-12-18'),
(3, 612, '2024-12-19'), (4, 613, '2024-12-20');

-- Compras para VB301 
INSERT INTO Comprar (Cliente_id, Boleto_id, Fecha_compra) VALUES
(5, 614, '2024-12-08'), (6, 615, '2024-12-08'), (7, 616, '2024-12-09'), (8, 617, '2024-12-09'),
(9, 618, '2024-12-10'), (10, 619, '2024-12-10'), (11, 620, '2024-12-11'), (12, 621, '2024-12-11'),
(13, 622, '2024-12-12'), (14, 623, '2024-12-12'), (15, 624, '2024-12-13'), (16, 625, '2024-12-13'),
(17, 626, '2024-12-14'), (18, 627, '2024-12-14'), (19, 628, '2024-12-15'), (20, 629, '2024-12-15'),
(21, 630, '2024-12-16'), (22, 631, '2024-12-16'), (23, 632, '2024-12-17'), (24, 633, '2024-12-17'),
(25, 634, '2024-12-18'), (26, 635, '2024-12-18'), (27, 636, '2024-12-19'), (28, 637, '2024-12-19'),
(29, 638, '2024-12-20'), (30, 639, '2024-12-20'), (31, 640, '2024-12-21'), (32, 641, '2024-12-21'),
(33, 642, '2024-12-22'), (34, 643, '2024-12-22'), (35, 644, '2024-12-23'), (36, 645, '2024-12-23'),
(37, 646, '2024-12-24'), (38, 647, '2024-12-24'), (39, 648, '2024-12-25'), (40, 649, '2024-12-25'),
(41, 650, '2024-12-26'), (42, 651, '2024-12-26'), (43, 652, '2024-12-27'), (44, 653, '2024-12-27'),
(45, 654, '2024-12-28'), (46, 655, '2024-12-28'), (47, 656, '2024-12-29'), (48, 657, '2024-12-29'),
(49, 658, '2024-12-30'), (50, 659, '2024-12-30'), (51, 660, '2024-12-31'), (52, 661, '2024-12-31'),
(53, 662, '2025-01-01'), (54, 663, '2025-01-01'), (55, 664, '2025-01-02'), (56, 665, '2025-01-02'),
(57, 666, '2025-01-03'), (58, 667, '2025-01-03'), (59, 668, '2025-01-04'), (60, 669, '2025-01-04'),
(61, 670, '2025-01-05'), (62, 671, '2024-12-08'), (63, 672, '2024-12-09'), (64, 673, '2024-12-10'),
(65, 674, '2024-12-11'), (66, 675, '2024-12-12'), (67, 676, '2024-12-13'), (68, 677, '2024-12-14'),
(69, 678, '2024-12-15'), (70, 679, '2024-12-16'), (71, 680, '2024-12-17'), (72, 681, '2024-12-18'),
(73, 682, '2024-12-19'), (74, 683, '2024-12-20'), (75, 684, '2024-12-21'), (76, 685, '2024-12-22'),
(77, 686, '2024-12-23'), (78, 687, '2024-12-24'), (79, 688, '2024-12-25'), (80, 689, '2024-12-26'),
(81, 690, '2024-12-27'), (82, 691, '2024-12-28'), (83, 692, '2024-12-29'), (84, 693, '2024-12-30'),
(85, 694, '2024-12-31'), (86, 695, '2025-01-01'), (87, 696, '2025-01-02'), (88, 697, '2025-01-03'),
(89, 698, '2025-01-04'), (90, 699, '2025-01-05'), (91, 700, '2024-12-08'), (92, 701, '2024-12-09'),
(93, 702, '2024-12-10'), (94, 703, '2024-12-11'), (95, 704, '2024-12-12'), (96, 705, '2024-12-13'),
(97, 706, '2024-12-14'), (98, 707, '2024-12-15'), (99, 708, '2024-12-16'), (1, 709, '2024-12-17'),
(2, 710, '2024-12-18'), (3, 711, '2024-12-19');

-- Compras para VB303 
INSERT INTO Comprar (Cliente_id, Boleto_id, Fecha_compra) VALUES
(4, 712, '2024-12-05'), (5, 713, '2024-12-05'), (6, 714, '2024-12-06'), (7, 715, '2024-12-06'),
(8, 716, '2024-12-07'), (9, 717, '2024-12-07'), (10, 718, '2024-12-08'), (11, 719, '2024-12-08'),
(12, 720, '2024-12-09'), (13, 721, '2024-12-09'), (14, 722, '2024-12-10'), (15, 723, '2024-12-10'),
(16, 724, '2024-12-11'), (17, 725, '2024-12-11'), (18, 726, '2024-12-12'), (19, 727, '2024-12-12'),
(20, 728, '2024-12-13'), (21, 729, '2024-12-13'), (22, 730, '2024-12-14'), (23, 731, '2024-12-14'),
(24, 732, '2024-12-15'), (25, 733, '2024-12-15'), (26, 734, '2024-12-16'), (27, 735, '2024-12-16'),
(28, 736, '2024-12-17'), (29, 737, '2024-12-17'), (30, 738, '2024-12-18'), (31, 739, '2024-12-18'),
(32, 740, '2024-12-19'), (33, 741, '2024-12-19'), (34, 742, '2024-12-20'), (35, 743, '2024-12-20'),
(36, 744, '2024-12-21'), (37, 745, '2024-12-21'), (38, 746, '2024-12-22'), (39, 747, '2024-12-22'),
(40, 748, '2024-12-23'), (41, 749, '2024-12-23'), (42, 750, '2024-12-24'), (43, 751, '2024-12-24'),
(44, 752, '2024-12-25'), (45, 753, '2024-12-25'), (46, 754, '2024-12-26'), (47, 755, '2024-12-26'),
(48, 756, '2024-12-27'), (49, 757, '2024-12-27'), (50, 758, '2024-12-28'), (51, 759, '2024-12-28'),
(52, 760, '2024-12-29'), (53, 761, '2024-12-29'), (54, 762, '2024-12-30'), (55, 763, '2024-12-30'),
(56, 764, '2024-12-31'), (57, 765, '2024-12-31'), (58, 766, '2025-01-01'), (59, 767, '2025-01-01'),
(60, 768, '2025-01-02'), (61, 769, '2024-12-05'), (62, 770, '2024-12-06'), (63, 771, '2024-12-07'),
(64, 772, '2024-12-08'), (65, 773, '2024-12-09'), (66, 774, '2024-12-10'), (67, 775, '2024-12-11'),
(68, 776, '2024-12-12'), (69, 777, '2024-12-13'), (70, 778, '2024-12-14'), (71, 779, '2024-12-15'),
(72, 780, '2024-12-16'), (73, 781, '2024-12-17'), (74, 782, '2024-12-18'), (75, 783, '2024-12-19'),
(76, 784, '2024-12-20'), (77, 785, '2024-12-21'), (78, 786, '2024-12-22'), (79, 787, '2024-12-23'),
(80, 788, '2024-12-24'), (81, 789, '2024-12-25'), (82, 790, '2024-12-26'), (83, 791, '2024-12-27'),
(84, 792, '2024-12-28'), (85, 793, '2024-12-29'), (86, 794, '2024-12-30'), (87, 795, '2024-12-31'),
(88, 796, '2025-01-01'), (89, 797, '2025-01-02'), (90, 798, '2024-12-05'), (91, 799, '2024-12-06'),
(92, 800, '2024-12-07'), (93, 801, '2024-12-08'), (94, 802, '2024-12-09'), (95, 803, '2024-12-10'),
(96, 804, '2024-12-11'), (97, 805, '2024-12-12'), (98, 806, '2024-12-13'), (99, 807, '2024-12-14'),
(1, 808, '2024-12-15'), (2, 809, '2024-12-16');












-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ========================================
-- ahora agregamos vuelos en general y de tipo carga
-- ========================================



-- ========================================
-- SCRIPT COMPLEMENTARIO - AVIONES DE CARGA
-- ========================================

INSERT INTO Avion (Matricula_avion, Capacidad_pasajeros, Modelo, Aerolinea_id) VALUES
('XA-CGO', 0, 'Boeing 777F Cargo', 1),
('XA-CG1', 0, 'Boeing 767-300F', 1),
('XB-CG2', 0, 'Airbus A330-200F', 2),
('XB-CG3', 0, 'Boeing 737-800BCF', 2),
('XC-CG1', 0, 'Boeing 737-800BCF', 3),
('XC-CG2', 0, 'Airbus A321-200F', 3),
('N-DLC1', 0, 'Boeing 767-300F', 4),
('N-DLC2', 0, 'Boeing 777F Cargo', 4),
('N-DLC3', 0, 'Airbus A330-200F', 4),
('N-UAC1', 0, 'Boeing 767-300F', 5),
('N-UAC2', 0, 'Boeing 777F Cargo', 5),
('N-AAC1', 0, 'Boeing 767-300F', 6),
('N-AAC2', 0, 'Boeing 777F Cargo', 6);



-- ========================================
-- VUELOS DE CARGA - AEROMÉXICO (AM)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('AMC501', 2, 'Programado', '04:30:00', '2025-10-15', '22:00:00', 'Ciudad de México', 'México', '2025-10-16', '02:30:00', 'Miami', 'Estados Unidos', 'XA-CGO', 1, 6),
('AMC502', 2, 'Programado', '11:45:00', '2025-10-16', '23:30:00', 'Ciudad de México', 'México', '2025-10-17', '11:15:00', 'Madrid', 'España', 'XA-CGO', 1, 7),
('AMC503', 2, 'Programado', '03:15:00', '2025-10-18', '05:00:00', 'Guadalajara', 'México', '2025-10-18', '08:15:00', 'Tijuana', 'México', 'XA-CG1', 3, 5),
('AMC504', 2, 'Completado', '02:45:00', '2025-10-10', '14:30:00', 'Monterrey', 'México', '2025-10-10', '17:15:00', 'Ciudad de México', 'México', 'XA-CG1', 4, 1),
('AMC505', 2, 'Programado', '05:20:00', '2025-10-20', '01:00:00', 'Ciudad de México', 'México', '2025-10-20', '06:20:00', 'Los Angeles', 'Estados Unidos', 'XA-CGO', 1, 8);

-- ========================================
-- VUELOS DE CARGA - VOLARIS (VO)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('VOC301', 2, 'Programado', '02:30:00', '2025-10-17', '03:00:00', 'Ciudad de México', 'México', '2025-10-17', '05:30:00', 'Cancún', 'México', 'XB-CG2', 1, 2),
('VOC302', 2, 'Programado', '03:00:00', '2025-10-18', '06:30:00', 'Tijuana', 'México', '2025-10-18', '09:30:00', 'Guadalajara', 'México', 'XB-CG2', 5, 3),
('VOC303', 2, 'Completado', '01:45:00', '2025-10-12', '11:00:00', 'Monterrey', 'México', '2025-10-12', '12:45:00', 'Ciudad de México', 'México', 'XB-CG3', 4, 1),
('VOC304', 2, 'Programado', '02:15:00', '2025-10-19', '15:30:00', 'Guadalajara', 'México', '2025-10-19', '17:45:00', 'Cancún', 'México', 'XB-CG3', 3, 2);

-- ========================================
-- VUELOS DE CARGA - VIVAAEROBUS (VB)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('VBC401', 2, 'Programado', '02:00:00', '2025-10-16', '07:00:00', 'Monterrey', 'México', '2025-10-16', '09:00:00', 'Ciudad de México', 'México', 'XC-CG1', 4, 1),
('VBC402', 2, 'Programado', '02:45:00', '2025-10-17', '10:15:00', 'Ciudad de México', 'México', '2025-10-17', '13:00:00', 'Tijuana', 'México', 'XC-CG1', 1, 5),
('VBC403', 2, 'Completado', '01:30:00', '2025-10-13', '16:00:00', 'Guadalajara', 'México', '2025-10-13', '17:30:00', 'Monterrey', 'México', 'XC-CG2', 3, 4),
('VBC404', 2, 'Programado', '02:20:00', '2025-10-20', '04:30:00', 'Cancún', 'México', '2025-10-20', '06:50:00', 'Ciudad de México', 'México', 'XC-CG2', 2, 1);

-- ========================================
-- VUELOS DE CARGA - DELTA AIRLINES (DL)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('DLC601', 2, 'Programado', '04:15:00', '2025-10-15', '20:00:00', 'Atlanta', 'Estados Unidos', '2025-10-16', '00:15:00', 'Ciudad de México', 'México', 'N-DLC1', 9, 1),
('DLC602', 2, 'Programado', '03:45:00', '2025-10-17', '08:30:00', 'Ciudad de México', 'México', '2025-10-17', '12:15:00', 'Atlanta', 'Estados Unidos', 'N-DLC1', 1, 9),
('DLC603', 2, 'Programado', '05:30:00', '2025-10-18', '13:00:00', 'Los Angeles', 'Estados Unidos', '2025-10-18', '18:30:00', 'Nueva York', 'Estados Unidos', 'N-DLC2', 8, 10),
('DLC604', 2, 'Completado', '04:00:00', '2025-10-11', '19:30:00', 'Miami', 'Estados Unidos', '2025-10-11', '23:30:00', 'Ciudad de México', 'México', 'N-DLC2', 6, 1),
('DLC605', 2, 'Programado', '06:15:00', '2025-10-19', '22:45:00', 'Nueva York', 'Estados Unidos', '2025-10-20', '05:00:00', 'Londres', 'Reino Unido', 'N-DLC3', 10, 11);

-- ========================================
-- VUELOS DE CARGA - UNITED AIRLINES (UA)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('UAC701', 2, 'Programado', '04:30:00', '2025-10-16', '09:00:00', 'Houston', 'Estados Unidos', '2025-10-16', '13:30:00', 'Ciudad de México', 'México', 'N-UAC1', 12, 1),
('UAC702', 2, 'Programado', '05:00:00', '2025-10-17', '14:15:00', 'Chicago', 'Estados Unidos', '2025-10-17', '19:15:00', 'Ciudad de México', 'México', 'N-UAC1', 13, 1),
('UAC703', 2, 'Completado', '03:30:00', '2025-10-12', '06:45:00', 'San Francisco', 'Estados Unidos', '2025-10-12', '10:15:00', 'Ciudad de México', 'México', 'N-UAC2', 14, 1),
('UAC704', 2, 'Programado', '04:45:00', '2025-10-18', '11:30:00', 'Ciudad de México', 'México', '2025-10-18', '16:15:00', 'Houston', 'Estados Unidos', 'N-UAC2', 1, 12);

-- ========================================
-- VUELOS DE CARGA - AMERICAN AIRLINES (AA)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('AAC801', 2, 'Programado', '04:00:00', '2025-10-15', '07:30:00', 'Dallas', 'Estados Unidos', '2025-10-15', '11:30:00', 'Ciudad de México', 'México', 'N-AAC1', 15, 1),
('AAC802', 2, 'Programado', '03:45:00', '2025-10-17', '12:00:00', 'Ciudad de México', 'México', '2025-10-17', '15:45:00', 'Dallas', 'Estados Unidos', 'N-AAC1', 1, 15),
('AAC803', 2, 'Completado', '05:15:00', '2025-10-13', '16:30:00', 'Miami', 'Estados Unidos', '2025-10-13', '21:45:00', 'Los Angeles', 'Estados Unidos', 'N-AAC2', 6, 8),
('AAC804', 2, 'Programado', '04:30:00', '2025-10-19', '05:00:00', 'Los Angeles', 'Estados Unidos', '2025-10-19', '09:30:00', 'Ciudad de México', 'México', 'N-AAC2', 8, 1);








-- ========================================
-- ========================================
-- ========================================


INSERT INTO Avion (Matricula_avion, Capacidad_pasajeros, Modelo, Aerolinea_id) VALUES
-- Aeroméxico (3 aviones de carga)
('XA-CF01', 0, 'Boeing 777F Cargo', 1),
('XA-CF02', 0, 'Boeing 767-300F', 1),
('XA-CF03', 0, 'Airbus A330-200F', 1),

-- Volaris (2 aviones de carga)
('XB-CF01', 0, 'Boeing 737-800BCF', 2),
('XB-CF02', 0, 'Airbus A321-200F', 2),

-- VivaAerobus (2 aviones de carga)
('XC-CF01', 0, 'Boeing 737-800BCF', 3),
('XC-CF02', 0, 'Airbus A321-200F', 3),

-- Delta (3 aviones de carga)
('N-DLF01', 0, 'Boeing 767-300F', 4),
('N-DLF02', 0, 'Boeing 777F Cargo', 4),
('N-DLF03', 0, 'Airbus A330-200F', 4),

-- United (2 aviones de carga)
('N-UAF01', 0, 'Boeing 767-300F', 5),
('N-UAF02', 0, 'Boeing 777F Cargo', 5),

-- American (3 aviones de carga)
('N-AAF01', 0, 'Boeing 767-300F', 6),
('N-AAF02', 0, 'Boeing 777F Cargo', 6),
('N-AAF03', 0, 'Airbus A330-200F', 6),

-- Iberia (2 aviones de carga)
('EC-IBF01', 0, 'Airbus A330-200F', 7),
('EC-IBF02', 0, 'Boeing 777F Cargo', 7);


-- ========================================
-- VUELOS DE CARGA - AEROMÉXICO (8 VUELOS)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('AMC601', 2, 'Programado', '04:30:00', '2025-10-22', '22:00:00', 'Ciudad de México', 'México', '2025-10-23', '02:30:00', 'Miami', 'Estados Unidos', 'XA-CF01', 1, 6),
('AMC602', 2, 'Programado', '11:45:00', '2025-10-23', '23:30:00', 'Ciudad de México', 'México', '2025-10-24', '11:15:00', 'Madrid', 'España', 'XA-CF02', 1, 7),
('AMC603', 2, 'Completado', '03:15:00', '2025-10-18', '05:00:00', 'Guadalajara', 'México', '2025-10-18', '08:15:00', 'Tijuana', 'México', 'XA-CF03', 3, 5),
('AMC604', 2, 'En vuelo', '02:45:00', '2025-10-20', '14:30:00', 'Monterrey', 'México', '2025-10-20', '17:15:00', 'Ciudad de México', 'México', 'XA-CF01', 4, 1),
('AMC605', 2, 'Programado', '05:20:00', '2025-10-24', '01:00:00', 'Ciudad de México', 'México', '2025-10-24', '06:20:00', 'Los Angeles', 'Estados Unidos', 'XA-CF02', 1, 8),
('AMC606', 2, 'Programado', '03:00:00', '2025-10-25', '03:30:00', 'Cancún', 'México', '2025-10-25', '06:30:00', 'Ciudad de México', 'México', 'XA-CF03', 2, 1),
('AMC607', 2, 'Programado', '04:15:00', '2025-10-26', '18:00:00', 'Ciudad de México', 'México', '2025-10-26', '22:15:00', 'Houston', 'Estados Unidos', 'XA-CF01', 1, 12),
('AMC608', 2, 'Programado', '02:30:00', '2025-10-27', '07:45:00', 'Tijuana', 'México', '2025-10-27', '10:15:00', 'Guadalajara', 'México', 'XA-CF02', 5, 3);

-- ========================================
-- VUELOS DE CARGA - VOLARIS (5 VUELOS)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('VOC401', 2, 'Programado', '02:30:00', '2025-10-22', '03:00:00', 'Ciudad de México', 'México', '2025-10-22', '05:30:00', 'Cancún', 'México', 'XB-CF01', 1, 2),
('VOC402', 2, 'Programado', '03:00:00', '2025-10-23', '06:30:00', 'Tijuana', 'México', '2025-10-23', '09:30:00', 'Guadalajara', 'México', 'XB-CF02', 5, 3),
('VOC403', 2, 'Completado', '01:45:00', '2025-10-19', '11:00:00', 'Monterrey', 'México', '2025-10-19', '12:45:00', 'Ciudad de México', 'México', 'XB-CF01', 4, 1),
('VOC404', 2, 'Programado', '02:15:00', '2025-10-24', '15:30:00', 'Guadalajara', 'México', '2025-10-24', '17:45:00', 'Cancún', 'México', 'XB-CF02', 3, 2),
('VOC405', 2, 'Programado', '02:00:00', '2025-10-25', '20:00:00', 'Ciudad de México', 'México', '2025-10-25', '22:00:00', 'Monterrey', 'México', 'XB-CF01', 1, 4);

-- ========================================
-- VUELOS DE CARGA - VIVAAEROBUS (6 VUELOS)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('VBC501', 2, 'Programado', '02:00:00', '2025-10-22', '07:00:00', 'Monterrey', 'México', '2025-10-22', '09:00:00', 'Ciudad de México', 'México', 'XC-CF01', 4, 1),
('VBC502', 2, 'Programado', '02:45:00', '2025-10-23', '10:15:00', 'Ciudad de México', 'México', '2025-10-23', '13:00:00', 'Tijuana', 'México', 'XC-CF02', 1, 5),
('VBC503', 2, 'Completado', '01:30:00', '2025-10-18', '16:00:00', 'Guadalajara', 'México', '2025-10-18', '17:30:00', 'Monterrey', 'México', 'XC-CF01', 3, 4),
('VBC504', 2, 'Programado', '02:20:00', '2025-10-24', '04:30:00', 'Cancún', 'México', '2025-10-24', '06:50:00', 'Ciudad de México', 'México', 'XC-CF02', 2, 1),
('VBC505', 2, 'Programado', '01:45:00', '2025-10-25', '12:00:00', 'Tijuana', 'México', '2025-10-25', '13:45:00', 'Cancún', 'México', 'XC-CF01', 5, 2),
('VBC506', 2, 'Programado', '02:15:00', '2025-10-26', '18:30:00', 'Ciudad de México', 'México', '2025-10-26', '20:45:00', 'Guadalajara', 'México', 'XC-CF02', 1, 3);

-- ========================================
-- VUELOS DE CARGA - DELTA AIRLINES (7 VUELOS)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('DLC701', 2, 'Programado', '04:15:00', '2025-10-22', '20:00:00', 'Atlanta', 'Estados Unidos', '2025-10-23', '00:15:00', 'Ciudad de México', 'México', 'N-DLF01', 9, 1),
('DLC702', 2, 'Programado', '03:45:00', '2025-10-23', '08:30:00', 'Ciudad de México', 'México', '2025-10-23', '12:15:00', 'Atlanta', 'Estados Unidos', 'N-DLF02', 1, 9),
('DLC703', 2, 'Programado', '05:30:00', '2025-10-24', '13:00:00', 'Los Angeles', 'Estados Unidos', '2025-10-24', '18:30:00', 'Nueva York', 'Estados Unidos', 'N-DLF03', 8, 10),
('DLC704', 2, 'Completado', '04:00:00', '2025-10-17', '19:30:00', 'Miami', 'Estados Unidos', '2025-10-17', '23:30:00', 'Ciudad de México', 'México', 'N-DLF01', 6, 1),
('DLC705', 2, 'Programado', '06:15:00', '2025-10-25', '22:45:00', 'Nueva York', 'Estados Unidos', '2025-10-26', '05:00:00', 'Londres', 'Reino Unido', 'N-DLF02', 10, 11),
('DLC706', 2, 'Programado', '04:30:00', '2025-10-26', '15:00:00', 'Atlanta', 'Estados Unidos', '2025-10-26', '19:30:00', 'Miami', 'Estados Unidos', 'N-DLF03', 9, 6),
('DLC707', 2, 'Programado', '05:00:00', '2025-10-27', '10:30:00', 'Los Angeles', 'Estados Unidos', '2025-10-27', '15:30:00', 'Chicago', 'Estados Unidos', 'N-DLF01', 8, 13);

-- ========================================
-- VUELOS DE CARGA - UNITED AIRLINES (4 VUELOS)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('UAC801', 2, 'Programado', '04:30:00', '2025-10-23', '09:00:00', 'Houston', 'Estados Unidos', '2025-10-23', '13:30:00', 'Ciudad de México', 'México', 'N-UAF01', 12, 1),
('UAC802', 2, 'Programado', '05:00:00', '2025-10-24', '14:15:00', 'Chicago', 'Estados Unidos', '2025-10-24', '19:15:00', 'Ciudad de México', 'México', 'N-UAF02', 13, 1),
('UAC803', 2, 'Completado', '03:30:00', '2025-10-19', '06:45:00', 'San Francisco', 'Estados Unidos', '2025-10-19', '10:15:00', 'Ciudad de México', 'México', 'N-UAF01', 14, 1),
('UAC804', 2, 'Programado', '04:45:00', '2025-10-25', '11:30:00', 'Ciudad de México', 'México', '2025-10-25', '16:15:00', 'Houston', 'Estados Unidos', 'N-UAF02', 1, 12);

-- ========================================
-- VUELOS DE CARGA - AMERICAN AIRLINES (6 VUELOS)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('AAC901', 2, 'Programado', '04:00:00', '2025-10-22', '07:30:00', 'Dallas', 'Estados Unidos', '2025-10-22', '11:30:00', 'Ciudad de México', 'México', 'N-AAF01', 15, 1),
('AAC902', 2, 'Programado', '03:45:00', '2025-10-23', '12:00:00', 'Ciudad de México', 'México', '2025-10-23', '15:45:00', 'Dallas', 'Estados Unidos', 'N-AAF02', 1, 15),
('AAC903', 2, 'Completado', '05:15:00', '2025-10-18', '16:30:00', 'Miami', 'Estados Unidos', '2025-10-18', '21:45:00', 'Los Angeles', 'Estados Unidos', 'N-AAF03', 6, 8),
('AAC904', 2, 'Programado', '04:30:00', '2025-10-24', '05:00:00', 'Los Angeles', 'Estados Unidos', '2025-10-24', '09:30:00', 'Ciudad de México', 'México', 'N-AAF01', 8, 1),
('AAC905', 2, 'Programado', '04:15:00', '2025-10-25', '17:30:00', 'Dallas', 'Estados Unidos', '2025-10-25', '21:45:00', 'Miami', 'Estados Unidos', 'N-AAF02', 15, 6),
('AAC906', 2, 'Programado', '03:30:00', '2025-10-26', '08:45:00', 'Ciudad de México', 'México', '2025-10-26', '12:15:00', 'Dallas', 'Estados Unidos', 'N-AAF03', 1, 15);

-- ========================================
-- VUELOS DE CARGA - IBERIA (5 VUELOS)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('IBC701', 2, 'Programado', '11:30:00', '2025-10-22', '20:00:00', 'Madrid', 'España', '2025-10-23', '07:30:00', 'Ciudad de México', 'México', 'EC-IBF01', 7, 1),
('IBC702', 2, 'Programado', '11:45:00', '2025-10-24', '02:00:00', 'Ciudad de México', 'México', '2025-10-24', '13:45:00', 'Madrid', 'España', 'EC-IBF02', 1, 7),
('IBC703', 2, 'Completado', '10:30:00', '2025-10-16', '22:30:00', 'Madrid', 'España', '2025-10-17', '09:00:00', 'Buenos Aires', 'Argentina', 'EC-IBF01', 7, 18),
('IBC704', 2, 'Programado', '02:15:00', '2025-10-25', '09:00:00', 'Madrid', 'España', '2025-10-25', '11:15:00', 'Londres', 'Reino Unido', 'EC-IBF02', 7, 11),
('IBC705', 2, 'Programado', '01:45:00', '2025-10-26', '14:30:00', 'Barcelona', 'España', '2025-10-26', '16:15:00', 'Madrid', 'España', 'EC-IBF01', 16, 7);











-- ========================================
-- ========================================
-- ========================================


INSERT INTO Avion (Matricula_avion, Capacidad_pasajeros, Modelo, Aerolinea_id) VALUES
('N-DL01', 180, 'Boeing 737-900', 4),
('N-DL02', 220, 'Boeing 767-300', 4),
('N-DL03', 189, 'Airbus A320neo', 4),
('N-UA01', 179, 'Boeing 737-800', 5),
('N-UA02', 186, 'Airbus A320', 5),
('N-UA03', 220, 'Boeing 767-300', 5),
('N-AA01', 180, 'Boeing 737-800', 6),
('N-AA02', 189, 'Airbus A320neo', 6),
('N-AA03', 186, 'Airbus A321', 6),
('EC-IB01', 200, 'Airbus A330-200', 7),
('EC-IB02', 220, 'Airbus A350-900', 7),
('EC-IB03', 189, 'Airbus A321neo', 7);


-- ========================================
-- VUELOS ADICIONALES - AEROMÉXICO (AM)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('AM123', 1, 'Programado', '02:30:00', '2025-10-22', '06:00:00', 'Ciudad de México', 'México', '2025-10-22', '08:30:00', 'Cancún', 'México', 'XA-001', 1, 2),
('AM124', 1, 'Programado', '01:45:00', '2025-10-22', '10:00:00', 'Monterrey', 'México', '2025-10-22', '11:45:00', 'Ciudad de México', 'México', 'XA-002', 4, 1),
('AM125', 1, 'Programado', '03:00:00', '2025-10-23', '13:30:00', 'Ciudad de México', 'México', '2025-10-23', '16:30:00', 'Los Angeles', 'Estados Unidos', 'XA-003', 1, 8),
('AM126', 1, 'Programado', '02:15:00', '2025-10-23', '17:00:00', 'Guadalajara', 'México', '2025-10-23', '19:15:00', 'Tijuana', 'México', 'XA-001', 3, 5),
('AM127', 1, 'Programado', '04:45:00', '2025-10-24', '08:00:00', 'Ciudad de México', 'México', '2025-10-24', '12:45:00', 'Miami', 'Estados Unidos', 'XA-002', 1, 6),
('AM128', 1, 'Programado', '01:30:00', '2025-10-24', '14:00:00', 'Cancún', 'México', '2025-10-24', '15:30:00', 'Ciudad de México', 'México', 'XA-003', 2, 1),
('AM129', 1, 'Programado', '02:00:00', '2025-10-25', '07:30:00', 'Tijuana', 'México', '2025-10-25', '09:30:00', 'Guadalajara', 'México', 'XA-001', 5, 3),
('AM130', 1, 'Programado', '11:30:00', '2025-10-25', '18:00:00', 'Ciudad de México', 'México', '2025-10-26', '05:30:00', 'Madrid', 'España', 'XA-003', 1, 7);

-- ========================================
-- VUELOS ADICIONALES - VOLARIS (VO)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('VO218', 1, 'Programado', '02:15:00', '2025-10-22', '05:30:00', 'Ciudad de México', 'México', '2025-10-22', '07:45:00', 'Cancún', 'México', 'XB-001', 1, 2),
('VO219', 1, 'Programado', '01:45:00', '2025-10-22', '11:00:00', 'Guadalajara', 'México', '2025-10-22', '12:45:00', 'Monterrey', 'México', 'XB-002', 3, 4),
('VO220', 1, 'Programado', '02:30:00', '2025-10-23', '09:15:00', 'Monterrey', 'México', '2025-10-23', '11:45:00', 'Tijuana', 'México', 'XB-003', 4, 5),
('VO221', 1, 'Programado', '02:00:00', '2025-10-23', '14:30:00', 'Cancún', 'México', '2025-10-23', '16:30:00', 'Ciudad de México', 'México', 'XB-001', 2, 1),
('VO222', 1, 'Programado', '01:30:00', '2025-10-24', '06:45:00', 'Ciudad de México', 'México', '2025-10-24', '08:15:00', 'Guadalajara', 'México', 'XB-002', 1, 3),
('VO223', 1, 'Programado', '02:45:00', '2025-10-24', '12:00:00', 'Tijuana', 'México', '2025-10-24', '14:45:00', 'Ciudad de México', 'México', 'XB-003', 5, 1),
('VO224', 1, 'Programado', '01:45:00', '2025-10-25', '16:30:00', 'Guadalajara', 'México', '2025-10-25', '18:15:00', 'Cancún', 'México', 'XB-001', 3, 2),
('VO225', 1, 'Programado', '02:15:00', '2025-10-25', '19:00:00', 'Monterrey', 'México', '2025-10-25', '21:15:00', 'Ciudad de México', 'México', 'XB-002', 4, 1),
('VO226', 1, 'Programado', '02:00:00', '2025-10-26', '07:00:00', 'Ciudad de México', 'México', '2025-10-26', '09:00:00', 'Monterrey', 'México', 'XB-003', 1, 4),
('VO227', 1, 'Programado', '01:30:00', '2025-10-26', '13:45:00', 'Cancún', 'México', '2025-10-26', '15:15:00', 'Guadalajara', 'México', 'XB-001', 2, 3);



-- ========================================
-- VUELOS ADICIONALES - DELTA AIRLINES (DL)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('DL802', 1, 'Programado', '04:15:00', '2025-10-22', '09:00:00', 'Atlanta', 'Estados Unidos', '2025-10-22', '13:15:00', 'Ciudad de México', 'México', 'N-DL01', 9, 1),
('DL803', 1, 'Programado', '04:00:00', '2025-10-23', '14:30:00', 'Ciudad de México', 'México', '2025-10-23', '18:30:00', 'Atlanta', 'Estados Unidos', 'N-DL01', 1, 9),
('DL804', 1, 'Programado', '05:30:00', '2025-10-24', '07:00:00', 'Los Angeles', 'Estados Unidos', '2025-10-24', '12:30:00', 'Nueva York', 'Estados Unidos', 'N-DL02', 8, 10),
('DL805', 1, 'Programado', '03:45:00', '2025-10-24', '16:00:00', 'Miami', 'Estados Unidos', '2025-10-24', '19:45:00', 'Ciudad de México', 'México', 'N-DL03', 6, 1),
('DL806', 1, 'Programado', '04:30:00', '2025-10-25', '10:15:00', 'Ciudad de México', 'México', '2025-10-25', '14:45:00', 'Miami', 'Estados Unidos', 'N-DL01', 1, 6),
('DL807', 1, 'Programado', '05:00:00', '2025-10-26', '08:30:00', 'Nueva York', 'Estados Unidos', '2025-10-26', '13:30:00', 'Los Angeles', 'Estados Unidos', 'N-DL02', 10, 8),
('DL808', 1, 'Programado', '04:15:00', '2025-10-26', '19:00:00', 'Atlanta', 'Estados Unidos', '2025-10-26', '23:15:00', 'Ciudad de México', 'México', 'N-DL03', 9, 1);

-- ========================================
-- VUELOS ADICIONALES - UNITED AIRLINES (UA)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('UA902', 1, 'Programado', '04:30:00', '2025-10-22', '07:30:00', 'Houston', 'Estados Unidos', '2025-10-22', '12:00:00', 'Ciudad de México', 'México', 'N-UA01', 12, 1),
('UA903', 1, 'Programado', '05:00:00', '2025-10-23', '11:00:00', 'Chicago', 'Estados Unidos', '2025-10-23', '16:00:00', 'Ciudad de México', 'México', 'N-UA02', 13, 1),
('UA904', 1, 'Programado', '03:30:00', '2025-10-23', '15:30:00', 'San Francisco', 'Estados Unidos', '2025-10-23', '19:00:00', 'Ciudad de México', 'México', 'N-UA03', 14, 1),
('UA905', 1, 'Programado', '04:45:00', '2025-10-24', '08:15:00', 'Ciudad de México', 'México', '2025-10-24', '13:00:00', 'Houston', 'Estados Unidos', 'N-UA01', 1, 12),
('UA906', 1, 'Programado', '05:15:00', '2025-10-25', '12:30:00', 'Ciudad de México', 'México', '2025-10-25', '17:45:00', 'Chicago', 'Estados Unidos', 'N-UA02', 1, 13),
('UA907', 1, 'Programado', '03:45:00', '2025-10-25', '18:00:00', 'Ciudad de México', 'México', '2025-10-25', '21:45:00', 'San Francisco', 'Estados Unidos', 'N-UA03', 1, 14),
('UA908', 1, 'Programado', '04:00:00', '2025-10-26', '09:30:00', 'Houston', 'Estados Unidos', '2025-10-26', '13:30:00', 'Nueva York', 'Estados Unidos', 'N-UA01', 12, 10),
('UA909', 1, 'Programado', '05:30:00', '2025-10-26', '16:00:00', 'Chicago', 'Estados Unidos', '2025-10-26', '21:30:00', 'Los Angeles', 'Estados Unidos', 'N-UA02', 13, 8);

-- ========================================
-- VUELOS ADICIONALES - AMERICAN AIRLINES (AA)
-- ========================================
INSERT INTO Vuelo (Numero_vuelo, Tipo_vuelo_id, Estado, Duracion, Fecha_salida, Hora_salida, Ciudad_salida, Pais_salida, Fecha_llegada, Hora_llegada, Ciudad_llegada, Pais_llegada, Matricula_avion, Aeropuerto_salida_id, Aeropuerto_llegada_id) VALUES
('AA802', 1, 'Programado', '04:00:00', '2025-10-22', '06:00:00', 'Dallas', 'Estados Unidos', '2025-10-22', '10:00:00', 'Ciudad de México', 'México', 'N-AA01', 15, 1),
('AA803', 1, 'Programado', '03:45:00', '2025-10-22', '13:30:00', 'Ciudad de México', 'México', '2025-10-22', '17:15:00', 'Dallas', 'Estados Unidos', 'N-AA02', 1, 15),
('AA804', 1, 'Programado', '05:15:00', '2025-10-23', '08:00:00', 'Miami', 'Estados Unidos', '2025-10-23', '13:15:00', 'Los Angeles', 'Estados Unidos', 'N-AA03', 6, 8),
('AA805', 1, 'Programado', '04:30:00', '2025-10-23', '15:45:00', 'Los Angeles', 'Estados Unidos', '2025-10-23', '20:15:00', 'Ciudad de México', 'México', 'N-AA01', 8, 1),
('AA806', 1, 'Programado', '04:15:00', '2025-10-24', '07:30:00', 'Ciudad de México', 'México', '2025-10-24', '11:45:00', 'Miami', 'Estados Unidos', 'N-AA02', 1, 6),
('AA807', 1, 'Programado', '05:00:00', '2025-10-25', '10:00:00', 'Dallas', 'Estados Unidos', '2025-10-25', '15:00:00', 'Nueva York', 'Estados Unidos', 'N-AA03', 15, 10),
('AA808', 1, 'Programado', '03:45:00', '2025-10-25', '17:30:00', 'Ciudad de México', 'México', '2025-10-25', '21:15:00', 'Dallas', 'Estados Unidos', 'N-AA01', 1, 15),
('AA809', 1, 'Programado', '04:30:00', '2025-10-26', '09:00:00', 'Miami', 'Estados Unidos', '2025-10-26', '13:30:00', 'Ciudad de México', 'México', 'N-AA02', 6, 1),
('AA810', 1, 'Programado', '05:15:00', '2025-10-26', '14:45:00', 'Los Angeles', 'Estados Unidos', '2025-10-26', '20:00:00', 'Miami', 'Estados Unidos', 'N-AA03', 8, 6);

