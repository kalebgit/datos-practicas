
-- ========================================
-- 1. INSERTAR 25 REGISTROS EN CADA TABLA
-- ========================================

INSERT INTO aerolineas (aerolinea_id, razon_social ) VALUES
(1, 'Aeromexico'),
(2, 'Volaris'),
(3, 'VivaAerobus'), -- Corregido de Aeromexico
(4, 'Aeromar'),     -- Corregido de Viva aerobus
(5, 'Calafia Airlines'), -- Nombre único
(6, 'TAR Aerolíneas'),   -- Nombre único
(7, 'Magnicharters'),  -- Corregido de Volaris
(8, 'Interjet'),       -- Nombre único
(9, 'AeroUnion'),      -- Nombre único
(10, 'Aéreo Calafia'),  -- Corregido de Volaris
(11, 'Vuelos Económicos'), -- Nombre único
(12, 'Aerolínea del Pacífico'), -- Nombre único
(13, 'Air Transport'),   -- Nombre único
(14, 'Air Canada'),    -- Corregido de Volaris
(15, 'Alaska Airlines'), -- Nombre único
(16, 'Air France'),    -- Corregido de Viva aerobus
(17, 'Lufthansa'),      -- Nombre único
(18, 'Iberia'),         -- Nombre único
(19, 'Avianca'),        -- Corregido de Volaris
(20, 'Copa Airlines'),  -- Corregido de Viva aerobus
(21, 'LATAM'),          -- Nombre único
(22, 'Delta Airlines'), -- Nombre único
(23, 'United Airlines'),-- Corregido de Volaris
(24, 'American Airlines'),-- Nombre único
(25, 'British Airways');  -- Corregido de Viva aerobus

INSERT INTO telefono_aerolineas (aerolinea_id, numero_telefono) VALUES
(1, '52-55-1234-5678'), (2, '52-55-9876-5432'), (3, '52-81-2345-6789'), (4, '52-55-5555-1234'), (5, '52-55-4444-5678'),
(6, '52-55-3333-9012'), (7, '52-55-2222-3456'), (8, '52-55-1111-7890'), (9, '52-55-6666-2345'), (10, '52-55-7777-6789'),
(11, '52-55-8888-0123'), (12, '52-55-9999-4567'), (13, '52-55-1212-8901'), (14, '52-55-2323-2345'), (15, '52-55-3434-6789'),
(16, '52-55-4545-0123'), (17, '52-55-5656-4567'), (18, '52-55-6767-8901'), (19, '52-55-7878-2345'), (20, '52-55-8989-6789'),
(21, '52-55-9090-0123'), (22, '52-55-1010-3456'), (23, '52-55-2020-7890'), (24, '52-55-3030-1234'), (25, '52-55-4040-5678');

INSERT INTO Correo_aerolineas (aerolinea_id, direccion_correo) VALUES
(1, 'contacto@aeromexico.com'), (2, 'reservaciones@volaris.com'), (3, 'atencion@vivaaerobus.com'), (4, 'info@aeromar.com'), (5, 'servicio@calafiaairlines.com'),
(6, 'consultas@taraerolineas.com'), (7, 'admin@mexicana.com'), (8, 'ventas@interjet.com'), (9, 'soporte@magnicharters.com'), (10, 'clientes@aeroenlaces.com'),
(11, 'info@tropicair.com'), (12, 'reservas@skyairlines.mx'), (13, 'contacto@blueair.com.mx'), (14, 'servicio@sunwing.com.mx'), (15, 'ayuda@flycana.com'),
(16, 'info@jetblue.mx'), (17, 'contacto@delta.com.mx'), (18, 'reservaciones@united.mx'), (19, 'clientes@americanairlines.mx'), (20, 'soporte@airfrance.mx'),
(21, 'info@lufthansa.mx'), (22, 'contacto@iberia.com.mx'), (23, 'servicio@avianca.com.mx'), (24, 'reservas@copa.com.mx'), (25, 'info@aircanada.mx');

INSERT INTO empleado (empleado_id, nombres, apellido_paterno) VALUES
(20, 'María', 'González'), (21, 'Carlos', 'Rodríguez'), (22, 'Ana', 'Martínez'), (23, 'Jorge', 'Pérez'), (24, 'Laura', 'Sánchez'),
(25, 'Miguel Ángel', 'Díaz'), (26, 'Fernanda', 'López'), (27, 'Diego', 'Jiménez'), (28, 'Gabriela', 'Torres'), (29, 'Ricardo', 'Vargas'),
(30, 'Isabel', 'Cruz'), (31, 'Oscar', 'Herrera'), (32, 'Adriana', 'Morales'), (33, 'Sergio', 'Ortega'), (34, 'Patricia', 'Castro'),
(35, 'Francisco', 'Núñez'), (36, 'Lucía', 'Ramírez'), (37, 'José Eduardo', 'Campos'), (38, 'Daniela', 'Reyes'), (39, 'Roberto', 'Silva'),
(40, 'Elena', 'Mendoza'), (41, 'Arturo', 'Delgado'), (42, 'Verónica', 'Rojas'), (43, 'Raúl', 'Medina'), (44, 'Carolina', 'Espinoza'),
(45, 'Guillermo', 'Acosta');

INSERT INTO telefono (empleado_id, numero_telefono) VALUES
(20, '+52-55-10200020'), (21, '+52-55-10210021'), (22, '+52-55-10220022'), (23, '+52-55-10230023'), (24, '+52-55-10240024'),
(25, '+52-55-10250025'), (26, '+52-55-10260026'), (27, '+52-55-10270027'), (28, '+52-55-10280028'), (29, '+52-55-10290029'),
(30, '+52-55-10300030'), (31, '+52-55-10310031'), (32, '+52-55-10320032'), (33, '+52-55-10330033'), (34, '+52-55-10340034'),
(35, '+52-55-10350035'), (36, '+52-55-10360036'), (37, '+52-55-10370037'), (38, '+52-55-10380038'), (39, '+52-55-10390039'),
(40, '+52-55-10400040'), (41, '+52-55-10410041'), (42, '+52-55-10420042'), (43, '+52-55-10430043'), (44, '+52-55-10440044'),
(45, '+52-55-10450045');

INSERT INTO contratar (aerolinea_id, empleado_id) VALUES
(1, 20), (2, 21), (3, 22), (4, 23), (5, 24),
(6, 25), (7, 26), (8, 27), (9, 28), (10, 29),
(11, 30), (12, 31), (13, 32), (14, 33), (15, 34),
(16, 35), (17, 36), (18, 37), (19, 38), (20, 39),
(21, 40), (22, 41), (23, 42), (24, 43), (25, 44);

INSERT INTO aeropuerto (aeropuerto_id, nombre) VALUES
(1, 'Aeropuerto Internacional de la Ciudad de México'), (2, 'Aeropuerto Internacional de Cancún'), (3, 'Aeropuerto Internacional de Guadalajara'),
(4, 'Aeropuerto Internacional de Monterrey'), (5, 'Aeropuerto Internacional de Tijuana'), (6, 'Aeropuerto Internacional de Los Cabos'),
(7, 'Aeropuerto Internacional de Puerto Vallarta'), (8, 'Aeropuerto Internacional de Mérida'), (9, 'Aeropuerto Internacional de Huatulco'),
(10, 'Aeropuerto Internacional de Cozumel'), (11, 'Aeropuerto Internacional de Ixtapa-Zihuatanejo'), (12, 'Aeropuerto Internacional de Mazatlán'),
(13, 'Aeropuerto Internacional de Acapulco'), (14, 'Aeropuerto Internacional de Villahermosa'), (15, 'Aeropuerto Internacional de Oaxaca'),
(16, 'Aeropuerto Internacional de Puebla'), (17, 'Aeropuerto Internacional de Querétaro'), (18, 'Aeropuerto Internacional de Toluca'),
(19, 'Aeropuerto Internacional de Chihuahua'), (20, 'Aeropuerto Internacional de Hermosillo'), (21, 'Aeropuerto Internacional de Culiacán'),
(22, 'Aeropuerto Internacional de La Paz'), (23, 'Aeropuerto Internacional de Veracruz'), (24, 'Aeropuerto Internacional de Durango'),
(25, 'Aeropuerto Internacional de León/Guanajuato');

INSERT INTO avion (matricula_avion, aerolinea_id, capacidad_pasajeros) VALUES
('XA01', 1, 150), ('XA02', 2, 189), ('XA03', 3, 290), ('XA04', 4, 99), ('XA05', 5, 120),
('XA06', 6, 175), ('XA07', 7, 240), ('XA08', 8, 150), ('XA09', 9, 189), ('XA10', 10, 290),
('XA11', 11, 99), ('XA12', 12, 120), ('XA13', 13, 175), ('XA14', 14, 240), ('XA15', 15, 150),
('XA16', 16, 189), ('XA17', 17, 290), ('XA18', 18, 99), ('XA19', 19, 120), ('XA20', 20, 175),
('XA21', 21, 240), ('XA22', 22, 150), ('XA23', 23, 189), ('XA24', 24, 290), ('XA25', 25, 99);

INSERT INTO vuelo (numero_vuelo, matricula_avion, fecha_salida, hora_salida) VALUES
('AM2501', 'XA01', '2025-10-01', '08:00:00'), ('VO4502', 'XA02', '2025-10-01', '09:30:00'), ('VB3503', 'XA03', '2025-10-01', '10:15:00'),
('AM2504', 'XA04', '2025-10-02', '12:00:00'), ('VO4505', 'XA05', '2025-10-02', '14:30:00'), ('VB3506', 'XA06', '2025-10-02', '16:45:00'),
('AM2507', 'XA07', '2025-10-03', '18:00:00'), ('VO4508', 'XA08', '2025-10-03', '20:10:00'), ('VB3509', 'XA09', '2025-10-04', '07:30:00'),
('AM2510', 'XA10', '2025-10-04', '11:45:00'), ('VO4511', 'XA11', '2025-10-05', '13:00:00'), ('VB3512', 'XA12', '2025-10-05', '15:30:00'),
('AM2513', 'XA13', '2025-10-06', '17:00:00'), ('VO4514', 'XA14', '2025-10-06', '19:45:00'), ('VB3515', 'XA15', '2025-10-07', '06:00:00'),
('AM2516', 'XA16', '2025-10-07', '08:45:00'), ('VO4517', 'XA17', '2025-10-08', '11:00:00'), ('VB3518', 'XA18', '2025-10-08', '14:00:00'),
('AM2519', 'XA19', '2025-10-09', '16:30:00'), ('VO4520', 'XA20', '2025-10-09', '21:00:00'), ('VB3521', 'XA21', '2025-10-10', '08:30:00'),
('AM2522', 'XA22', '2025-10-10', '11:15:00'), ('VO4523', 'XA23', '2025-10-11', '14:00:00'), ('VB3524', 'XA24', '2025-10-11', '18:15:00'),
('AM2525', 'XA25', '2025-10-12', '07:00:00');

INSERT INTO Piloto_vuelo (Empleado_id, Numero_vuelo) VALUES
(20, 'AM2501'), (21, 'VO4502'), (22, 'VB3503'), (23, 'AM2504'), (24, 'VO4505'),
(25, 'VB3506'), (26, 'AM2507'), (27, 'VO4508'), (28, 'VB3509'), (29, 'AM2510'),
(30, 'VO4511'), (31, 'VB3512'), (32, 'AM2513'), (33, 'VO4514'), (34, 'VB3515'),
(35, 'AM2516'), (36, 'VO4517'), (37, 'VB3518'), (38, 'AM2519'), (39, 'VO4520'),
(40, 'VB3521'), (41, 'AM2522'), (42, 'VO4523'), (43, 'VB3524'), (44, 'AM2525');

INSERT INTO Boleto (boleto_id, precio, numero_vuelo) VALUES
(1, 550.00, 'AM2501'), (2, 320.50, 'VO4502'), (3, 180.99, 'VB3503'), (4, 150.00, 'AM2504'), (5, 600.00, 'VO4505'),
(6, 350.50, 'VB3506'), (7, 190.99, 'AM2507'), (8, 160.00, 'VO4508'), (9, 580.00, 'VB3509'), (10, 330.50, 'AM2510'),
(11, 170.99, 'VO4511'), (12, 140.00, 'VB3512'), (13, 590.00, 'AM2513'), (14, 360.50, 'VO4514'), (15, 200.99, 'VB3515'),
(16, 170.00, 'AM2516'), (17, 540.00, 'VO4517'), (18, 310.50, 'VB3518'), (19, 165.99, 'AM2519'), (20, 155.00, 'VO4520'),
(21, 610.00, 'VB3521'), (22, 370.50, 'AM2522'), (23, 195.99, 'VO4523'), (24, 145.00, 'VB3524'), (25, 570.00, 'AM2525');

INSERT INTO Cliente (cliente_id, nombres, apellido_paterno) VALUES
(100, 'Ana', 'González'), (101, 'Carlos', 'Rodríguez'), (102, 'María', 'López'), (103, 'José', 'Pérez'), (104, 'Laura', 'Sánchez'),
(105, 'Miguel', 'Díaz'), (106, 'Fernanda', 'Ortega'), (107, 'Diego', 'Jiménez'), (108, 'Gabriela', 'Torres'), (109, 'Ricardo', 'Vargas'),
(110, 'Isabel', 'Cruz'), (111, 'Oscar', 'Herrera'), (112, 'Adriana', 'Morales'), (113, 'Sergio', 'Vega'), (114, 'Patricia', 'Méndez'),
(115, 'Francisco', 'Núñez'), (116, 'Lucía', 'Ramírez'), (117, 'Eduardo', 'Campos'), (118, 'Daniela', 'Reyes'), (119, 'Roberto', 'Silva'),
(120, 'Elena', 'Mendoza'), (121, 'Arturo', 'Delgado'), (122, 'Verónica', 'Rojas'), (123, 'Raúl', 'Medina'), (124, 'Carolina', 'Espinoza');

INSERT INTO Comprar (cliente_id, boleto_id) VALUES
(100, 1), (101, 2), (102, 3), (103, 4), (104, 5),
(105, 6), (106, 7), (107, 8), (108, 9), (109, 10),
(110, 11), (111, 12), (112, 13), (113, 14), (114, 15),
(115, 16), (116, 17), (117, 18), (118, 19), (119, 20),
(120, 21), (121, 22), (122, 23), (123, 24), (124, 25);

INSERT INTO telefono_cliente (cliente_id, numero_telefono) VALUES
(100, '+52-55-20000100'), (101, '+52-55-20010101'), (102, '+52-55-20020102'), (103, '+52-55-20030103'), (104, '+52-55-20040104'),
(105, '+52-55-20050105'), (106, '+52-55-20060106'), (107, '+52-55-20070107'), (108, '+52-55-20080108'), (109, '+52-55-20090109'),
(110, '+52-55-20100110'), (111, '+52-55-20110111'), (112, '+52-55-20120112'), (113, '+52-55-20130113'), (114, '+52-55-20140114'),
(115, '+52-55-20150115'), (116, '+52-55-20160116'), (117, '+52-55-20170117'), (118, '+52-55-20180118'), (119, '+52-55-20190119'),
(120, '+52-55-20200120'), (121, '+52-55-20210121'), (122, '+52-55-20220122'), (123, '+52-55-20230123'), (124, '+52-55-20240124');

INSERT INTO Correo_cliente (cliente_id, direccion_correo) VALUES
(100, 'ana.garcia@email.com'), (101, 'carlos.martinez@email.com'), (102, 'maria.hernandez@email.com'), (103, 'jose.perez@email.com'), (104, 'laura.diaz@email.com'),
(105, 'miguel.castro@email.com'), (106, 'fernanda.ortega@email.com'), (107, 'diego.jimenez@email.com'), (108, 'gabriela.torres@email.com'), (109, 'ricardo.vargas@email.com'),
(110, 'isabel.nunez@email.com'), (111, 'oscar.herrera@email.com'), (112, 'adriana.morales@email.com'), (113, 'sergio.soto@email.com'), (114, 'patricia.ruiz@email.com'),
(115, 'francisco.guerrero@email.com'), (116, 'lucia.medina@email.com'), (117, 'eduardo.campos@email.com'), (118, 'daniela.reyes@email.com'), (119, 'roberto.silva@email.com'),
(120, 'elena.mendoza@email.com'), (121, 'arturo.delgado@email.com'), (122, 'veronica.rojas@email.com'), (123, 'raul.acosta@email.com'), (124, 'carolina.espinoza@email.com');

INSERT INTO Mecanico (empleado_id, especializacion) VALUES
(20, 'Motores y turbinas'), (21, 'Sistemas hidráulicos'), (22, 'Aviónica y electrónica'), (23, 'Fuselaje y estructura'), (24, 'Sistemas de combustible'),
(25, 'Tren de aterrizaje'), (26, 'Sistemas de presurización'), (27, 'Instrumentos de cabina'), (28, 'Sistemas de navegación'), (29, 'Motores y turbinas'),
(30, 'Sistemas hidráulicos'), (31, 'Aviónica y electrónica'), (32, 'Fuselaje y estructura'), (33, 'Sistemas de combustible'), (34, 'Tren de aterrizaje'),
(35, 'Sistemas de presurización'), (36, 'Instrumentos de cabina'), (37, 'Sistemas de navegación'), (38, 'Motores y turbinas'), (39, 'Sistemas hidráulicos'),
(40, 'Aviónica y electrónica'), (41, 'Fuselaje y estructura'), (42, 'Sistemas de combustible'), (43, 'Tren de aterrizaje'), (44, 'Sistemas de presurización');

INSERT INTO Controlador_de_abordaje (empleado_id) VALUES
(20), (21), (22), (23), (24), (25), (26), (27), (28), (29),
(30), (31), (32), (33), (34), (35), (36), (37), (38), (39),
(40), (41), (42), (43), (44);

INSERT INTO Sobrecargo (empleado_id) VALUES
(20), (21), (22), (23), (24), (25), (26), (27), (28), (29),
(30), (31), (32), (33), (34), (35), (36), (37), (38), (39),
(40), (41), (42), (43), (44), (45);

INSERT INTO Controlador_de_vuelos (empleado_id) VALUES
(20), (21), (22), (23), (24), (25), (26), (27), (28), (29),
(30), (31), (32), (33), (34), (35), (36), (37), (38), (39),
(40), (41), (42), (43), (44), (45);

INSERT INTO Certificacion_medicos_aeronave (nombre, mecanico_id) VALUES
('Certificado Médico Clase 1 (A)', 20), ('Certificado Médico Clase 1 (B)', 21), ('Certificado Médico Clase 2 (C)', 22), ('Certificado Médico Clase 2 (D)', 23),
('Certificado Médico Clase 1 (A)', 24), ('Certificado Médico Clase 1 (B)', 25), ('Certificado Médico Clase 2 (C)', 26), ('Certificado Médico Clase 2 (D)', 27),
('Certificado Médico Clase 1 (A)', 28), ('Certificado Médico Clase 1 (B)', 29), ('Certificado Médico Clase 2 (C)', 30), ('Certificado Médico Clase 2 (D)', 31),
('Certificado Médico Clase 1 (A)', 32), ('Certificado Médico Clase 1 (B)', 33), ('Certificado Médico Clase 2 (C)', 34), ('Certificado Médico Clase 2 (D)', 35),
('Certificado Médico Clase 1 (A)', 36), ('Certificado Médico Clase 1 (B)', 37), ('Certificado Médico Clase 2 (C)', 38), ('Certificado Médico Clase 2 (D)', 39),
('Certificado Médico Clase 1 (A)', 40), ('Certificado Médico Clase 1 (B)', 41), ('Certificado Médico Clase 2 (C)', 42), ('Certificado Médico Clase 2 (D)', 43),
('Certificado Médico Clase 1 (A)', 44);

INSERT INTO Certificacion_seguridad (nombre, sobrecargo_id) VALUES
('Primeros Auxilios Avanzados', 20), ('Manejo de Emergencias en Agua', 21), ('Evacuación de Aeronave', 22), ('Prevención de Incendios Clase D', 23),
('Primeros Auxilios Avanzados', 24), ('Manejo de Emergencias en Agua', 25), ('Evacuación de Aeronave', 26), ('Prevención de Incendios Clase D', 27),
('Primeros Auxilios Avanzados', 28), ('Manejo de Emergencias en Agua', 29), ('Evacuación de Aeronave', 30), ('Prevención de Incendios Clase D', 31),
('Primeros Auxilios Avanzados', 32), ('Manejo de Emergencias en Agua', 33), ('Evacuación de Aeronave', 34), ('Prevención de Incendios Clase D', 35),
('Primeros Auxilios Avanzados', 36), ('Manejo de Emergencias en Agua', 37), ('Evacuación de Aeronave', 38), ('Prevención de Incendios Clase D', 39),
('Primeros Auxilios Avanzados', 40), ('Manejo de Emergencias en Agua', 41), ('Evacuación de Aeronave', 42), ('Prevención de Incendios Clase D', 43),
('Primeros Auxilios Avanzados', 44);

INSERT INTO Idioma (sobrecargo_id, nombre) VALUES
(20, 'Alemán'), (21, 'Japonés'), (22, 'Ruso'), (23, 'Portugués'), (24, 'Mandarín'),
(25, 'Francés'), (26, 'Alemán'), (27, 'Japonés'), (28, 'Ruso'), (29, 'Portugués'),
(30, 'Mandarín'), (31, 'Francés'), (32, 'Alemán'), (33, 'Japonés'), (34, 'Ruso'),
(35, 'Portugués'), (36, 'Mandarín'), (37, 'Francés'), (38, 'Alemán'), (39, 'Japonés'),
(40, 'Ruso'), (41, 'Portugués'), (42, 'Mandarín'), (43, 'Francés'), (45, 'Alemán');

INSERT INTO Certificacion_tipo_aeronave (nombre, piloto_id) VALUES
('Airbus A320 Rating', 20), ('Boeing 737NG Rating', 21), ('Embraer E190 Rating', 22), ('Cessna Citation XLS', 23), ('Airbus A320 Rating', 24),
('Boeing 737NG Rating', 25), ('Embraer E190 Rating', 26), ('Cessna Citation XLS', 27), ('Airbus A320 Rating', 28), ('Boeing 737NG Rating', 29),
('Embraer E190 Rating', 30), ('Cessna Citation XLS', 31), ('Airbus A320 Rating', 32), ('Boeing 737NG Rating', 33), ('Embraer E190 Rating', 34),
('Cessna Citation XLS', 35), ('Airbus A320 Rating', 36), ('Boeing 737NG Rating', 37), ('Embraer E190 Rating', 38), ('Cessna Citation XLS', 39),
('Airbus A320 Rating', 40), ('Boeing 737NG Rating', 41), ('Embraer E190 Rating', 42), ('Cessna Citation XLS', 43), ('Airbus A320 Rating', 44);

-- ========================================
-- 1. MODIFIRCAR INFORMACION DE ALMENOS 8 REGISTOS 
-- ========================================
UPDATE aerolineas SET 
    pais_origen_empresa = 'méxico',
    ciudad = 'guadalajara',
    municipio = 'guadalajara',
    codigo_postal = '44600',
    calle = 'av. adolfo lópez mateos nte.',
    colonia = 'ladrón de guevara',
    numero_exterior = '1000',
    pais = 'méxico'
WHERE aerolinea_id = 1;

UPDATE aerolineas SET 
    pais_origen_empresa = 'estados unidos',
    ciudad = 'austin',
    municipio = 'travis',
    codigo_postal = '78701',
    calle = 'congress ave',
    colonia = 'downtown',
    numero_exterior = '110',
    pais = 'estados unidos'
WHERE aerolinea_id = 2;

UPDATE aerolineas SET 
    pais_origen_empresa = 'méxico',
    ciudad = 'monterrey',
    municipio = 'san pedro garza garcía',
    codigo_postal = '66260',
    calle = 'av. roble',
    colonia = 'valle del campestre',
    numero_exterior = '660',
    pais = 'méxico'
WHERE aerolinea_id = 3;

UPDATE contratar SET fecha_ingreso ='2010-09-01', fecha_egreso = '2024-03-20' WHERE empleado_id = 2;

UPDATE contratar SET fecha_ingreso ='2015-09-01', fecha_egreso = '2025-06-20' WHERE empleado_id = 2;

UPDATE contratar SET fecha_ingreso ='2010-09-01', fecha_egreso = null WHERE empleado_id = 3;


UPDATE Boleto SET clase = 'primera', numero_asiento = '15B' 
WHERE Boleto_id = 1;

UPDATE Boleto SET clase = 'primera', numero_asiento = '02A' 
WHERE Boleto_id = 1;

UPDATE Boleto SET clase = 'ejecutiva', numero_asiento = '12C' 
WHERE Boleto_id = 2;

UPDATE Boleto SET clase = 'economica', numero_asiento = '35F' 
WHERE Boleto_id = 3;

-- ========================================
-- 1. ELIMINAR 5 REGISTROS DE PRUEBA
-- ========================================

DELETE FROM Controlador_de_vuelos WHERE empleado_id = 2;
DELETE FROM telefono_cliente WHERE numero_telefono like '%7';
DELETE FROM correo_cliente WHERE direccion_correo like 'a%';
DELETE FROM telefono_cliente WHERE cliente_id = 2;
DELETE FROM correo_cliente WHERE cliente_id = 8;

-- ========================================
-- 1. REALIZAR 8 CONSULTAS USANDO SELECT
-- ========================================

SELECT * FROM Mecanico;
SELECT razon_social FROM aerolineas;
SELECT * FROM Certificacion_tipo_aeronave WHERE piloto_id > 35;	
SELECT * FROM Idioma WHERE nombre ='Alemán';
SELECT * FROM Certificacion_seguridad WHERE nombre ='Prevención de Incendios Clase D' AND sobrecargo_id > 30;
SELECT * FROM Boleto WHERE numero_vuelo LIKE 'A%' OR precio > 300;
SELECT * FROM Correo_cliente WHERE cliente_id > 22;
SELECT * FROM aeropuerto ORDER BY nombre;
SELECT * FROM vuelo ORDER BY Fecha_salida, Hora_salida;
