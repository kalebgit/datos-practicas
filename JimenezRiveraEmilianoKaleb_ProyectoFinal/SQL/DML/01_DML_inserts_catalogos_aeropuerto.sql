-- ========================================
-- SISTEMA DE AEROLÍNEAS - INSERTS DE CATÁLOGOS
-- ========================================

-- ========================================
-- 1. DIRECCION
-- Tabla nueva para cumplir con 3NF
-- Contiene todas las direcciones para Aerolineas, Aeropuertos y Empleados
-- ========================================

INSERT INTO Direccion (Pais, Ciudad, Municipio, Codigo_postal, Calle, Colonia, Numero_exterior, Numero_interior) VALUES
-- Direcciones en México
('México', 'Ciudad de México', 'Cuauhtémoc', '06600', 'Paseo de la Reforma', 'Juárez', '296', NULL),
('México', 'Ciudad de México', 'Miguel Hidalgo', '11590', 'Av. Ejército Nacional', 'Polanco', '843', NULL),
('México', 'Cancún', 'Benito Juárez', '77500', 'Boulevard Kukulcán', 'Zona Hotelera', 'Km 9.5', NULL),
('México', 'Guadalajara', 'Guadalajara', '44100', 'Av. Vallarta', 'Centro', '1500', NULL),
('México', 'Monterrey', 'San Pedro Garza García', '66260', 'Av. Lázaro Cárdenas', 'Del Valle', '2400', NULL),
('México', 'Tijuana', 'Tijuana', '22000', 'Av. Revolución', 'Centro', '1050', NULL),
('México', 'Los Cabos', 'Los Cabos', '23410', 'Carretera Transpeninsular', 'San José del Cabo', 'Km 19.5', NULL),
('México', 'Puerto Vallarta', 'Puerto Vallarta', '48300', 'Blvd. Francisco Medina Ascencio', 'Zona Hotelera', '2500', NULL),
('México', 'Mérida', 'Mérida', '97000', 'Paseo de Montejo', 'Centro', '470', NULL),
('México', 'Mazatlán', 'Mazatlán', '82110', 'Av. del Mar', 'Zona Dorada', '1200', NULL),
('México', 'Acapulco', 'Acapulco de Juárez', '39670', 'Av. Costera Miguel Alemán', 'Icacos', '3800', NULL),
('México', 'Oaxaca', 'Oaxaca de Juárez', '68000', 'Calle de Macedonio Alcalá', 'Centro', '201', NULL),
('México', 'Puebla', 'Puebla', '72000', 'Av. 2 Oriente', 'Centro Histórico', '416', NULL),
('México', 'Querétaro', 'Querétaro', '76000', 'Av. 5 de Febrero', 'Centro', '110', NULL),
('México', 'Toluca', 'Toluca de Lerdo', '50000', 'Av. Morelos', 'Centro', '1205', NULL),
('México', 'Chihuahua', 'Chihuahua', '31000', 'Av. Universidad', 'Santo Niño', '2405', NULL),
('México', 'Hermosillo', 'Hermosillo', '83000', 'Blvd. Luis Encinas', 'Centro', '810', NULL),
('México', 'Culiacán', 'Culiacán', '80000', 'Blvd. Francisco I. Madero', 'Centro', '1550', NULL),
('México', 'La Paz', 'La Paz', '23000', 'Malecón Álvaro Obregón', 'Centro', '750', NULL),
('México', 'Veracruz', 'Veracruz', '91700', 'Av. Miguel Alemán', 'Centro', '640', NULL),
('México', 'Durango', 'Durango', '34000', 'Blvd. Dolores del Río', 'Centro', '201', NULL),
('México', 'León', 'León', '37000', 'Blvd. Adolfo López Mateos', 'Centro', '2010', NULL),
('México', 'Ciudad de México', 'Benito Juárez', '03100', 'Av. Insurgentes Sur', 'Del Valle', '950', '302'),
('México', 'Ciudad de México', 'Álvaro Obregón', '01030', 'Av. Revolución', 'San Ángel', '1245', NULL),
('México', 'Ciudad de México', 'Coyoacán', '04100', 'Av. Francisco Sosa', 'Santa Catarina', '185', NULL),
-- Direcciones en Estados Unidos
('Estados Unidos', 'Nueva York', 'Queens', '11430', 'JFK Airport', 'Jamaica', 'Terminal 1', NULL),
('Estados Unidos', 'Los Ángeles', 'Los Angeles County', '90045', '1 World Way', 'LAX', 'Terminal 4', NULL),
('Estados Unidos', 'Miami', 'Miami-Dade', '33142', 'NW 21st St', 'Miami Springs', '2100', NULL),
('Estados Unidos', 'Chicago', 'Cook County', '60666', 'O''Hare Airport', 'Chicago', 'Terminal 3', NULL),
('Estados Unidos', 'Dallas', 'Dallas County', '75261', 'DFW Airport', 'Irving', 'Terminal E', NULL),
('Estados Unidos', 'Seattle', 'King County', '98158', 'International Blvd', 'SeaTac', '17801', NULL),
('Estados Unidos', 'Atlanta', 'Fulton County', '30320', '6000 N Terminal Pkwy', 'Atlanta', 'Concourse B', NULL),
('Estados Unidos', 'Houston', 'Harris County', '77002', 'Texas Ave', 'Downtown', '1515', NULL),
('Estados Unidos', 'Phoenix', 'Maricopa County', '85034', 'Sky Harbor Blvd', 'Phoenix', '3400', NULL),
('Estados Unidos', 'San Francisco', 'San Mateo County', '94128', 'San Francisco International', 'San Bruno', 'Terminal 2', NULL),
('Estados Unidos', 'Las Vegas', 'Clark County', '89119', 'Wayne Newton Blvd', 'Las Vegas', '5757', NULL),
('Estados Unidos', 'Boston', 'Suffolk County', '02128', 'Harborside Dr', 'East Boston', '1', NULL),
('Estados Unidos', 'Denver', 'Denver County', '80249', 'Peña Blvd', 'Denver', '8500', NULL),
('Estados Unidos', 'Orlando', 'Orange County', '32827', 'Jeff Fuqua Blvd', 'Orlando', '1', NULL),
('Estados Unidos', 'Philadelphia', 'Philadelphia County', '19153', 'Essington Ave', 'Philadelphia', '8000', NULL),
-- Direcciones en Canadá
('Canadá', 'Montreal', 'Quebec', 'H4Y 1H1', 'Rue Romeo-Vachon', 'Dorval', '975', NULL),
('Canadá', 'Toronto', 'Ontario', 'M9W 1K7', 'Silver Dart Dr', 'Mississauga', '6301', NULL),
('Canadá', 'Vancouver', 'British Columbia', 'V7B 0A1', 'Grant McConachie Way', 'Richmond', '3211', NULL),
('Canadá', 'Calgary', 'Alberta', 'T2E 6Z8', '2000 Airport Rd NE', 'Calgary', '2000', NULL),
('Canadá', 'Ottawa', 'Ontario', 'K1V 9B4', '1000 Airport Pkwy', 'Ottawa', '1000', NULL),
-- Direcciones en Europa
('Francia', 'París', 'Val-d''Oise', '95700', 'Terminal 2E', 'Roissy-en-France', '2', NULL),
('Alemania', 'Frankfurt', 'Hesse', '60547', 'Hugo-Eckener-Ring', 'Frankfurt am Main', '1', NULL),
('España', 'Madrid', 'Madrid', '28042', 'Av. de la Hispanidad', 'Barajas', 's/n', NULL),
('Reino Unido', 'Londres', 'Greater London', 'TW6 1EW', 'Longford', 'Hounslow', 'Terminal 5', NULL),
('Italia', 'Roma', 'Lazio', '00054', 'Via dell''Aeroporto di Fiumicino', 'Fiumicino', '320', NULL),
-- Direcciones en América del Sur
('Colombia', 'Bogotá', 'Cundinamarca', '110911', 'Av. El Dorado', 'Fontibón', '103-15', NULL),
('Panamá', 'Panamá', 'Panamá', 'P.O. Box', 'Vía Aeropuerto', 'Tocumen', 's/n', NULL),
('Chile', 'Santiago', 'Región Metropolitana', '9020000', 'Av. Américo Vespucio Norte', 'Pudahuel', '900', NULL),
('Argentina', 'Buenos Aires', 'Buenos Aires', 'C1480', 'Au. Teniente General Pablo Riccheri', 'Ezeiza', 's/n', NULL),
('Brasil', 'São Paulo', 'São Paulo', '07190-100', 'Rod. Hélio Smidt', 'Cumbica', 's/n', NULL),
-- Direcciones adicionales para empleados en México
('México', 'Guadalajara', 'Zapopan', '45010', 'Av. Américas', 'Providencia', '1550', '4B'),
('México', 'Monterrey', 'Monterrey', '64000', 'Av. Constitución', 'Centro', '820', '10'),
('México', 'Puebla', 'Puebla', '72160', 'Calz. Zavaleta', 'La Paz', '3102', NULL),
('México', 'Ciudad de México', 'Azcapotzalco', '02000', 'Av. de las Granjas', 'Santa Bárbara', '650', '201'),
('México', 'Ciudad de México', 'Iztapalapa', '09000', 'Av. Telecomunicaciones', 'Tepalcates', '142', NULL);

-- ========================================
-- 2. TIPO_VUELO
-- ========================================

INSERT INTO Tipo_vuelo (Tipo_vuelo_id, Nombre, Descripcion) VALUES
(1, 'Pasajeros', 'Vuelo comercial regular para transporte de pasajeros'),
(2, 'Carga', 'Vuelo dedicado exclusivamente al transporte de carga'),
(3, 'Mixto', 'Vuelo que transporta tanto pasajeros como carga');

-- ========================================
-- 3. AEROLINEAS
-- Actualizado para usar Direccion_id
-- ========================================

INSERT INTO Aerolineas (Aerolinea_id, Razon_social, Pais_origen_empresa, Direccion_id) VALUES
(1, 'Aeromexico', 'México', 1),
(2, 'Volaris', 'México', 2),
(3, 'VivaAerobus', 'México', 5),
(4, 'Aeromar', 'México', 23),
(5, 'Calafia Airlines', 'México', 19),
(6, 'TAR Aerolíneas', 'México', 14),
(7, 'Magnicharters', 'México', 24),
(8, 'Interjet', 'México', 15),
(9, 'AeroUnion', 'México', 25),
(10, 'Aéreo Calafia', 'México', 6),
(11, 'Air Canada', 'Canadá', 40),
(12, 'Alaska Airlines', 'Estados Unidos', 31),
(13, 'Air France', 'Francia', 45),
(14, 'Lufthansa', 'Alemania', 46),
(15, 'Iberia', 'España', 47),
(16, 'Avianca', 'Colombia', 51),
(17, 'Copa Airlines', 'Panamá', 52),
(18, 'LATAM', 'Chile', 53),
(19, 'Delta Airlines', 'Estados Unidos', 32),
(20, 'United Airlines', 'Estados Unidos', 29),
(21, 'American Airlines', 'Estados Unidos', 30),
(22, 'British Airways', 'Reino Unido', 48),
(23, 'Southwest Airlines', 'Estados Unidos', 30),
(24, 'JetBlue', 'Estados Unidos', 26),
(25, 'Spirit Airlines', 'Estados Unidos', 28);

-- ========================================
-- 4. AEROPUERTO
-- Actualizado para usar Direccion_id
-- ========================================

INSERT INTO Aeropuerto (Aeropuerto_id, Nombre, Direccion_id) VALUES
(1, 'Aeropuerto Internacional de la Ciudad de México', 1),
(2, 'Aeropuerto Internacional de Cancún', 3),
(3, 'Aeropuerto Internacional de Guadalajara', 4),
(4, 'Aeropuerto Internacional de Monterrey', 5),
(5, 'Aeropuerto Internacional de Tijuana', 6),
(6, 'Aeropuerto Internacional de Los Cabos', 7),
(7, 'Aeropuerto Internacional de Puerto Vallarta', 8),
(8, 'Aeropuerto Internacional de Mérida', 9),
(9, 'Aeropuerto Internacional de Mazatlán', 10),
(10, 'Aeropuerto Internacional de Acapulco', 11),
(11, 'Aeropuerto Internacional de Oaxaca', 12),
(12, 'Aeropuerto Internacional de Puebla', 13),
(13, 'Aeropuerto Internacional de Querétaro', 14),
(14, 'Aeropuerto Internacional de Toluca', 15),
(15, 'Aeropuerto Internacional de Chihuahua', 16),
(16, 'Aeropuerto Internacional de Hermosillo', 17),
(17, 'Aeropuerto Internacional de Culiacán', 18),
(18, 'Aeropuerto Internacional de La Paz', 19),
(19, 'Aeropuerto Internacional de Veracruz', 20),
(20, 'Aeropuerto Internacional de Durango', 21),
(21, 'Aeropuerto Internacional de León', 22),
(22, 'Aeropuerto John F. Kennedy', 26),
(23, 'Aeropuerto de Los Ángeles', 27),
(24, 'Aeropuerto de Miami', 28),
(25, 'Aeropuerto Charles de Gaulle', 45);

-- ========================================
-- 5. EMPLEADO
-- Actualizado para usar Direccion_id
-- ========================================

INSERT INTO Empleado (Empleado_id, Nombres, Apellido_paterno, Apellido_materno, Identificacion_unica_pobla, Direccion_id) VALUES
(1, 'Juan', 'Pérez', 'García', 'PEGJ850315HDFRRN01', 23),
(2, 'María', 'González', 'López', 'GOLM900522MDFNPR02', 24),
(3, 'Carlos', 'Rodríguez', 'Martínez', 'ROMC880710HDFRRL03', 25),
(4, 'Ana', 'Martínez', 'Hernández', 'MAHA920315MDFRRN04', 56),
(5, 'Jorge', 'Pérez', 'Sánchez', 'PESJ870825HDFRRS05', 57),
(6, 'Laura', 'Sánchez', 'Díaz', 'SADL910912MDFNZR06', 1),
(7, 'Miguel', 'Díaz', 'Torres', 'DITM830420HDFRSR07', 2),
(8, 'Fernanda', 'López', 'Ramírez', 'LORF940215MDFPMR08', 4),
(9, 'Diego', 'Jiménez', 'Flores', 'JIFD891105HDFRML09', 5),
(10, 'Gabriela', 'Torres', 'Castro', 'TOCG860630MDFRSB10', 56),
(11, 'Ricardo', 'Vargas', 'Morales', 'VAMR900420HDFRRC11', 57),
(12, 'Isabel', 'Cruz', 'Ramos', 'CURI930815MDFRZS12', 58),
(13, 'Oscar', 'Herrera', 'Ruiz', 'HERO880225HDFRRS13', 23),
(14, 'Adriana', 'Morales', 'Ortega', 'MOOA920710MDFRRR14', 24),
(15, 'Sergio', 'Ortega', 'Silva', 'ORSS851130HDFRRL15', 25),
(16, 'Patricia', 'Castro', 'Méndez', 'CAMP870505MDFSSPT16', 1),
(17, 'Francisco', 'Núñez', 'Reyes', 'NURF940220HDFRFY17', 2),
(18, 'Lucía', 'Ramírez', 'Vega', 'RAVL920915MDFMGC18', 58),
(19, 'Eduardo', 'Campos', 'Guerrero', 'CAGE860810HDFRMD19', 4),
(20, 'Daniela', 'Reyes', 'Medina', 'REMD910525MDFYDN20', 5),
(21, 'Roberto', 'Silva', 'Delgado', 'SIDR880315HDFLVB21', 56),
(22, 'Elena', 'Mendoza', 'Rojas', 'MERE930620MDFNJL22', 57),
(23, 'Arturo', 'Delgado', 'Acosta', 'DEAA870910HDFLGR23', 23),
(24, 'Verónica', 'Rojas', 'Espinoza', 'ROEV901215MDFJSR24', 24),
(25, 'Raúl', 'Medina', 'Navarro', 'MENR850430HDFVVL25', 25),
(26, 'Carolina', 'Espinoza', 'Cruz', 'ESCC920825MDFSRR26', 1),
(27, 'Guillermo', 'Acosta', 'Peña', 'AOPG881010HDFSXL27', 2),
(28, 'Sofía', 'Navarro', 'Luna', 'NALS940305MDFVNN28', 58),
(29, 'Javier', 'Peña', 'Campos', 'PECJ860720HDFÑVM29', 4),
(30, 'Mónica', 'Luna', 'Fuentes', 'LUFM911205MDNNNT30', 5),
(31, 'Alberto', 'Campos', 'Santos', 'CASA870515HDFMPL31', 56),
(32, 'Cristina', 'Fuentes', 'Aguilar', 'FUAC930910MDFTGR32', 57),
(33, 'Luis', 'Santos', 'Jiménez', 'SAJL850225HDFNTL33', 23),
(34, 'Andrea', 'Aguilar', 'Carrillo', 'AUCA920630MDFGLR34', 24),
(35, 'Manuel', 'Carrillo', 'Pacheco', 'CAPM881015HDFRRC35', 25),
(36, 'Claudia', 'Pacheco', 'Muñoz', 'PAMC901220MDFSXL36', 1),
(37, 'Rodrigo', 'Muñoz', 'Cortés', 'MUCR860505HDFÑRS37', 2),
(38, 'Valeria', 'Cortés', 'Maldonado', 'COMV940815MDFRLL38', 58),
(39, 'Héctor', 'Maldonado', 'Guzmán', 'MAGH870310HDFMLZ39', 4),
(40, 'Diana', 'Guzmán', 'Alvarado', 'GUAD911025MDFSLN40', 5),
(41, 'Alejandro', 'Alvarado', 'Bravo', 'ALVA880620HDFLVL41', 56),
(42, 'Mariana', 'Bravo', 'Mendoza', 'BRME930915MDFRVR42', 57),
(43, 'Pablo', 'Mendoza', 'Castillo', 'MECP851130HDFNDB43', 23),
(44, 'Natalia', 'Castillo', 'Mora', 'CAMN920405MDFSTN44', 24),
(45, 'Víctor', 'Mora', 'Herrera', 'MOHV870810HDFRRCT45', 25),
(46, 'Paola', 'Herrera', 'Gil', 'HEGP941215MDFRLP46', 1),
(47, 'Andrés', 'Gil', 'Vargas', 'GIVA861020HDFLRD47', 2),
(48, 'Lorena', 'Vargas', 'Ibarra', 'VAIL900305MDFRBL48', 58),
(49, 'Fernando', 'Ibarra', 'León', 'IBLF890720HDFRLN49', 4),
(50, 'Carmen', 'León', 'Ríos', 'LERC921110MDFÑRS50', 5);

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
-- 8. CLIENTE
-- ========================================

INSERT INTO Cliente (Cliente_id, Nombres, Apellido_paterno, Apellido_materno, Fecha_nacimiento) VALUES
(1, 'Juan', 'López', 'Martínez', '1988-05-15'), (2, 'María', 'García', 'Rodríguez', '1992-11-03'), (3, 'Carlos', 'Hernández', 'Pérez', '1985-07-22'),
(4, 'Ana', 'Rodríguez', 'González', '1990-02-17'), (5, 'Laura', 'Díaz', 'Torres', '1992-09-18'), (6, 'Miguel', 'Castro', 'Ramírez', '1983-02-25'),
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
(61, 'Regina', 'Galván', 'Montes', '1991-06-26'), (62, 'Enrique', 'Escobar', 'Zárate', '1986-03-19'),
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
-- 9. ESPECIALIDADES DE EMPLEADOS
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
-- 10. CERTIFICACIONES
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
-- 11. TELÉFONOS Y CORREOS
-- ========================================

INSERT INTO Telefono_aerolineas (Aerolinea_id, Numero_telefono) VALUES
(1, '55-5133-4000'), (1, '800-021-4000'),
(2, '55-1102-8000'), (2, '800-122-8000'),
(3, '818-215-0150'), (3, '800-122-0156'),
(4, '55-5133-1111'), (5, '612-125-5555'),
(6, '442-229-0000'), (7, '55-5133-1122'),
(8, '722-273-8888'), (9, '55-5785-8900'),
(10, '664-634-9000'), (11, '55-9138-0300'),
(12, '55-5241-1000'), (13, '55-5627-6060'),
(14, '55-5230-0000'), (15, '55-5387-6000'),
(16, '55-5284-2920'), (17, '55-5283-3200'),
(18, '55-5283-4300'), (19, '800-123-4567'),
(20, '800-864-8331'), (21, '800-433-7300'),
(22, '800-247-9297'), (23, '800-435-9792'),
(24, '800-538-2583'), (25, '801-401-2200');

INSERT INTO Correo_aerolineas (Aerolinea_id, Direccion_correo) VALUES
(1, 'contacto@aeromexico.com'), (2, 'info@volaris.com'),
(3, 'atencion@vivaaerobus.com'), (4, 'servicios@aeromar.mx'),
(5, 'reservaciones@calafia.com'), (6, 'contacto@tarmexico.com'),
(7, 'info@magnicharters.com'), (8, 'servicio@interjet.com'),
(9, 'carga@aerounion.com'), (10, 'reservas@calafiaair.com'),
(11, 'canada@aircanada.com'), (12, 'info@alaskaair.com'),
(13, 'mx@airfrance.fr'), (14, 'contact@lufthansa.com'),
(15, 'servicio@iberia.com'), (16, 'info@avianca.com'),
(17, 'reservas@copaair.com'), (18, 'contacto@latam.com'),
(19, 'mexico@delta.com'), (20, 'info@united.com'),
(21, 'mx@aa.com'), (22, 'contact@ba.com'),
(23, 'customer@southwest.com'), (24, 'help@jetblue.com'),
(25, 'support@spirit.com');

INSERT INTO Telefono (Empleado_id, Numero_telefono) VALUES
(1, '55-1234-5678'), (2, '55-2345-6789'), (3, '55-3456-7890'),
(4, '81-1234-5678'), (5, '81-2345-6789'), (6, '55-4567-8901'),
(7, '55-5678-9012'), (8, '33-1234-5678'), (9, '81-3456-7890'),
(10, '81-4567-8901'), (11, '81-5678-9012'), (12, '22-1234-5678'),
(13, '55-6789-0123'), (14, '55-7890-1234'), (15, '55-8901-2345'),
(16, '55-9012-3456'), (17, '55-0123-4567'), (18, '22-2345-6789'),
(19, '33-2345-6789'), (20, '81-6789-0123'), (21, '81-7890-1234'),
(22, '81-8901-2345'), (23, '55-1111-2222'), (24, '55-2222-3333'),
(25, '55-3333-4444'), (26, '55-4444-5555'), (27, '55-5555-6666'),
(28, '22-3456-7890'), (29, '33-3456-7890'), (30, '81-9012-3456'),
(31, '81-0123-4567'), (32, '81-1111-2222'), (33, '55-6666-7777'),
(34, '55-7777-8888'), (35, '55-8888-9999'), (36, '55-9999-0000'),
(37, '55-0000-1111'), (38, '22-4567-8901'), (39, '33-4567-8901'),
(40, '81-2222-3333'), (41, '81-3333-4444'), (42, '81-4444-5555'),
(43, '55-1212-1212'), (44, '55-3434-3434'), (45, '55-5656-5656'),
(46, '55-7878-7878'), (47, '55-9090-9090'), (48, '22-5678-9012'),
(49, '33-5678-9012'), (50, '81-5555-6666');

INSERT INTO Telefono_cliente (Cliente_id, Numero_telefono) VALUES
(1, '55-1000-0001'), (2, '55-1000-0002'), (3, '55-1000-0003'),
(4, '55-1000-0004'), (5, '55-1000-0005'), (6, '55-1000-0006'),
(7, '55-1000-0007'), (8, '55-1000-0008'), (9, '55-1000-0009'),
(10, '55-1000-0010'), (11, '55-1000-0011'), (12, '55-1000-0012'),
(13, '55-1000-0013'), (14, '55-1000-0014'), (15, '55-1000-0015'),
(16, '55-1000-0016'), (17, '55-1000-0017'), (18, '55-1000-0018'),
(19, '55-1000-0019'), (20, '55-1000-0020'), (21, '55-1000-0021'),
(22, '55-1000-0022'), (23, '55-1000-0023'), (24, '55-1000-0024'),
(25, '55-1000-0025'), (26, '55-1000-0026'), (27, '55-1000-0027'),
(28, '55-1000-0028'), (29, '55-1000-0029'), (30, '55-1000-0030'),
(31, '55-1000-0031'), (32, '55-1000-0032'), (33, '55-1000-0033'),
(34, '55-1000-0034'), (35, '55-1000-0035'), (36, '55-1000-0036'),
(37, '55-1000-0037'), (38, '55-1000-0038'), (39, '55-1000-0039'),
(40, '55-1000-0040'), (41, '55-1000-0041'), (42, '55-1000-0042'),
(43, '55-1000-0043'), (44, '55-1000-0044'), (45, '55-1000-0045'),
(46, '55-1000-0046'), (47, '55-1000-0047'), (48, '55-1000-0048'),
(49, '55-1000-0049'), (50, '55-1000-0050'), (51, '55-1000-0051'),
(52, '55-1000-0052'), (53, '55-1000-0053'), (54, '55-1000-0054'),
(55, '55-1000-0055'), (56, '55-1000-0056'), (57, '55-1000-0057'),
(58, '55-1000-0058'), (59, '55-1000-0059'), (60, '55-1000-0060'),
(61, '55-1000-0061'), (62, '55-1000-0062'), (63, '55-1000-0063'),
(64, '55-1000-0064'), (65, '55-1000-0065'), (66, '55-1000-0066'),
(67, '55-1000-0067'), (68, '55-1000-0068'), (69, '55-1000-0069'),
(70, '55-1000-0070'), (71, '55-1000-0071'), (72, '55-1000-0072'),
(73, '55-1000-0073'), (74, '55-1000-0074'), (75, '55-1000-0075'),
(76, '55-1000-0076'), (77, '55-1000-0077'), (78, '55-1000-0078'),
(79, '55-1000-0079'), (80, '55-1000-0080'), (81, '55-1000-0081'),
(82, '55-1000-0082'), (83, '55-1000-0083'), (84, '55-1000-0084'),
(85, '55-1000-0085'), (86, '55-1000-0086'), (87, '55-1000-0087'),
(88, '55-1000-0088'), (89, '55-1000-0089'), (90, '55-1000-0090'),
(91, '55-1000-0091'), (92, '55-1000-0092'), (93, '55-1000-0093'),
(94, '55-1000-0094'), (95, '55-1000-0095'), (96, '55-1000-0096'),
(97, '55-1000-0097'), (98, '55-1000-0098'), (99, '55-1000-0099'),
(100, '55-1000-0100');

INSERT INTO Correo_cliente (Cliente_id, Direccion_correo) VALUES
(1, 'juan.lopez@email.com'), (2, 'maria.garcia@email.com'), (3, 'carlos.hernandez@email.com'),
(4, 'ana.rodriguez@email.com'), (5, 'laura.diaz@email.com'), (6, 'miguel.castro@email.com'),
(7, 'fernanda.ortega@email.com'), (8, 'diego.jimenez@email.com'),
(9, 'gabriela.torres@email.com'), (10, 'ricardo.vargas@email.com'),
(11, 'isabel.nunez@email.com'), (12, 'oscar.herrera@email.com'),
(13, 'adriana.morales@email.com'), (14, 'sergio.soto@email.com'),
(15, 'patricia.ruiz@email.com'), (16, 'francisco.guerrero@email.com'),
(17, 'lucia.medina@email.com'), (18, 'eduardo.campos@email.com'),
(19, 'daniela.reyes@email.com'), (20, 'roberto.silva@email.com'),
(21, 'elena.mendoza@email.com'), (22, 'arturo.delgado@email.com'),
(23, 'veronica.rojas@email.com'), (24, 'raul.acosta@email.com'),
(25, 'carolina.espinoza@email.com'), (26, 'guillermo.navarro@email.com'),
(27, 'sofia.pena@email.com'), (28, 'javier.luna@email.com'),
(29, 'monica.campos@email.com'), (30, 'alberto.fuentes@email.com'),
(31, 'cristina.santos@email.com'), (32, 'luis.aguilar@email.com'),
(33, 'andrea.carrillo@email.com'), (34, 'manuel.pacheco@email.com'),
(35, 'claudia.munoz@email.com'), (36, 'rodrigo.cortes@email.com'),
(37, 'valeria.maldonado@email.com'), (38, 'hector.guzman@email.com'),
(39, 'diana.alvarado@email.com'), (40, 'alejandro.bravo@email.com'),
(41, 'mariana.mendoza@email.com'), (42, 'pablo.castillo@email.com'),
(43, 'natalia.mora@email.com'), (44, 'victor.herrera@email.com'),
(45, 'paola.gil@email.com'), (46, 'andres.vargas@email.com'),
(47, 'lorena.ibarra@email.com'), (48, 'fernando.leon@email.com'),
(49, 'carmen.rios@email.com'), (50, 'ignacio.dominguez@email.com'),
(51, 'beatriz.vazquez@email.com'), (52, 'emilio.roman@email.com'),
(53, 'alejandra.ponce@email.com'), (54, 'gustavo.lara@email.com'),
(55, 'silvia.sandoval@email.com'), (56, 'oscar.bautista@email.com'),
(57, 'melissa.corona@email.com'), (58, 'antonio.valencia@email.com'),
(59, 'cecilia.figueroa@email.com'), (60, 'felipe.cabrera@email.com'),
(61, 'regina.galvan@email.com'), (62, 'enrique.escobar@email.com'),
(63, 'karla.olvera@email.com'), (64, 'ramon.solis@email.com'),
(65, 'angelica.montes@email.com'), (66, 'martin.zarate@email.com'),
(67, 'norma.portillo@email.com'), (68, 'ruben.meza@email.com'),
(69, 'claudia.rivas@email.com'), (70, 'sergio.cervantes@email.com'),
(71, 'victoria.salazar@email.com'), (72, 'gerardo.tellez@email.com'),
(73, 'rosa.aranda@email.com'), (74, 'daniel.avila@email.com'),
(75, 'sandra.benitez@email.com'), (76, 'armando.cano@email.com'),
(77, 'liliana.duarte@email.com'), (78, 'jorge.escalante@email.com'),
(79, 'gabriela.franco@email.com'), (80, 'raul.garza@email.com'),
(81, 'monica.hinojosa@email.com'), (82, 'hugo.iniguez@email.com'),
(83, 'susana.jaramillo@email.com'), (84, 'ricardo.kristal@email.com'),
(85, 'patricia.ledesma@email.com'), (86, 'alfredo.macias@email.com'),
(87, 'yolanda.nava@email.com'), (88, 'victor.ochoa@email.com'),
(89, 'teresa.palacios@email.com'), (90, 'manuel.quintero@email.com'),
(91, 'veronica.robledo@email.com'), (92, 'pedro.soto@email.com'),
(93, 'laura.trejo@email.com'), (94, 'javier.uribe@email.com'),
(95, 'estela.valdez@email.com'), (96, 'tomas.wolff@email.com'),
(97, 'gloria.ximenez@email.com'), (98, 'julio.yanez@email.com'),
(99, 'irma.zavala@email.com'), (100, 'salvador.arias@email.com');
