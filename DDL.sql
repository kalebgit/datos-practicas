-- ========================================
-- SISTEMA DE AEROLÍNEAS - DDL 
-- Base de datos: aeropuerto2026
-- Usuario: leninmerino
-- ========================================

-- ========================================
-- 1. DEFINICIÓN DE TABLAS (SOLO COLUMNAS)
-- ========================================

-- Tabla Aerolíneas
CREATE TABLE Aerolineas (
    Aerolinea_id INT,
    Razon_social VARCHAR(100) UNIQUE,
    Pais_origen_empresa VARCHAR(50),
    Ciudad VARCHAR(50),
    Municipio VARCHAR(50),
    Codigo_postal VARCHAR(10),
    Calle VARCHAR(100),
    Colonia VARCHAR(50),
    Numero_exterior VARCHAR(10),
    Pais VARCHAR(50)
);

-- Tabla Teléfonos de Aerolíneas
CREATE TABLE Telefono_aerolineas (
    Aerolinea_id INT,
    Numero_telefono VARCHAR(15) UNIQUE
);

-- Tabla Correos de Aerolíneas
CREATE TABLE Correo_aerolineas (
    Aerolinea_id INT,
    Direccion_correo VARCHAR(100) UNIQUE
);

-- Tabla Empleados
CREATE TABLE Empleado (
    Empleado_id INT,
    Nombres VARCHAR(50),
    Apellido_paterno VARCHAR(50),
    Apellido_materno VARCHAR(50),
    Pais VARCHAR(50),
    Ciudad VARCHAR(50),
    Municipio VARCHAR(50),
    Codigo_postal VARCHAR(10),
    Calle VARCHAR(100),
    Colonia VARCHAR(50),
    Numero_exterior VARCHAR(10),
    Numero_interior VARCHAR(10),
    Identificacion_unica_pobla VARCHAR(50) UNIQUE
);

-- Tabla Teléfonos de Empleados
CREATE TABLE Telefono (
    Empleado_id INT,
    Numero_telefono VARCHAR(15) UNIQUE
);

-- Tabla Contratar (Relación Aerolínea-Empleado)
CREATE TABLE Contratar (
    Aerolinea_id INT,
    Empleado_id INT,
    Fecha_ingreso DATE,
    Fecha_egreso DATE
);

-- Tabla Aeropuertos
CREATE TABLE Aeropuerto (
    Aeropuerto_id INT,
    Nombre VARCHAR(100),
    Pais VARCHAR(50),
    Ciudad VARCHAR(50),
    Municipio VARCHAR(50),
    Codigo_postal VARCHAR(10),
    Calle VARCHAR(100),
    Colonia VARCHAR(50),
    Numero_exterior VARCHAR(10)
);

-- Tabla Aviones
CREATE TABLE Avion (
    Matricula_avion VARCHAR(20),
    Capacidad_pasajeros INT,
    Modelo VARCHAR(50),
    Aerolinea_id INT
);

-- Tabla Vuelos
CREATE TABLE Vuelo (
    Numero_vuelo VARCHAR(10),
    Tipo_vuelo VARCHAR(20),
    Estado VARCHAR(20),
    Duracion TIME,
    Fecha_salida DATE,
    Hora_salida TIME,
    Ciudad_salida VARCHAR(50),
    Pais_salida VARCHAR(50),
    Fecha_llegada DATE,
    Hora_llegada TIME,
    Ciudad_llegada VARCHAR(50),
    Pais_llegada VARCHAR(50),
    Matricula_avion VARCHAR(20)
);

-- Tabla Pilotos (Tabla de unión)
CREATE TABLE Piloto_vuelo (
    Empleado_id INT,
    Numero_vuelo VARCHAR(10)
);

-- Tabla Boletos
CREATE TABLE Boleto (
    Boleto_id INT,
    Numero_asiento VARCHAR(5),
    Clase VARCHAR(20),
    Precio DECIMAL(10,2),
    Numero_vuelo VARCHAR(10)
);

-- Tabla Comprar (Relación Cliente-Boleto)
CREATE TABLE Comprar (
    Cliente_id INT,
    Boleto_id INT,
    Fecha_compra DATE
);

-- Tabla Clientes
CREATE TABLE Cliente (
    Cliente_id INT,
    Nombres VARCHAR(50),
    Apellido_paterno VARCHAR(50),
    Apellido_materno VARCHAR(50),
    Fecha_nacimiento DATE
);

-- Tabla Teléfonos de Clientes
CREATE TABLE Telefono_cliente (
    Cliente_id INT,
    Numero_telefono VARCHAR(15) UNIQUE
);

-- Tabla Correos de Clientes
CREATE TABLE Correo_cliente (
    Cliente_id INT,
    Direccion_correo VARCHAR(100) UNIQUE
);

-- Tabla Mecánicos
CREATE TABLE Mecanico (
    Empleado_id INT,
    Titulo VARCHAR(100),
    Especializacion VARCHAR(100)
);

-- Tabla Controladores de Abordaje
CREATE TABLE Controlador_de_abordaje (
    Empleado_id INT,
    Certificacion_atencion_cliente VARCHAR(100),
    Fecha_vencimiento_certificacion DATE
);

-- Tabla Sobrecargos
CREATE TABLE Sobrecargo (
    Empleado_id INT
);

-- Tabla Controladores de Vuelos
CREATE TABLE Controlador_de_vuelos (
    Empleado_id INT,
    Licencia_control_trafico VARCHAR(50),
    Sector_asignado VARCHAR(50),
    Fecha_vencimiento_licencia DATE
);

-- Tabla Certificaciones Médicas de Aeronaves
CREATE TABLE Certificacion_medicos_aeronave (
    Nombre VARCHAR(100),
    Mecanico_id INT
);

-- Tabla Certificaciones de Seguridad
CREATE TABLE Certificacion_seguridad (
    Nombre VARCHAR(100),
    Sobrecargo_id INT
);

-- Tabla Idiomas
CREATE TABLE Idioma (
    Nombre VARCHAR(50),
    Sobrecargo_id INT
);

-- Tabla Certificaciones de Tipo de Aeronave
CREATE TABLE Certificacion_tipo_aeronave (
    Nombre VARCHAR(100),
    Piloto_id INT
);

-- ========================================
-- 2. RESTRICCIONES DE INTEGRIDAD
-- ========================================

-- Primary Keys
ALTER TABLE Aerolineas ADD CONSTRAINT PK_Aerolineas PRIMARY KEY (Aerolinea_id);
ALTER TABLE Empleado ADD CONSTRAINT PK_Empleado PRIMARY KEY (Empleado_id);
ALTER TABLE Aeropuerto ADD CONSTRAINT PK_Aeropuerto PRIMARY KEY (Aeropuerto_id);
ALTER TABLE Avion ADD CONSTRAINT PK_Avion PRIMARY KEY (Matricula_avion);
ALTER TABLE Vuelo ADD CONSTRAINT PK_Vuelo PRIMARY KEY (Numero_vuelo);
ALTER TABLE Boleto ADD CONSTRAINT PK_Boleto PRIMARY KEY (Boleto_id);
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY (Cliente_id);
ALTER TABLE Mecanico ADD CONSTRAINT PK_Mecanico PRIMARY KEY (Empleado_id);
ALTER TABLE Controlador_de_abordaje ADD CONSTRAINT PK_Controlador_abordaje PRIMARY KEY (Empleado_id);
ALTER TABLE Sobrecargo ADD CONSTRAINT PK_Sobrecargo PRIMARY KEY (Empleado_id);
ALTER TABLE Controlador_de_vuelos ADD CONSTRAINT PK_Controlador_vuelos PRIMARY KEY (Empleado_id);

-- Primary Keys Compuestas
ALTER TABLE Telefono_aerolineas ADD CONSTRAINT PK_Telefono_aerolineas PRIMARY KEY (Aerolinea_id, Numero_telefono);
ALTER TABLE Correo_aerolineas ADD CONSTRAINT PK_Correo_aerolineas PRIMARY KEY (Aerolinea_id, Direccion_correo);
ALTER TABLE Telefono ADD CONSTRAINT PK_Telefono PRIMARY KEY (Empleado_id, Numero_telefono);
ALTER TABLE Contratar ADD CONSTRAINT PK_Contratar PRIMARY KEY (Aerolinea_id, Empleado_id);
ALTER TABLE Piloto_vuelo ADD CONSTRAINT PK_Piloto_vuelo PRIMARY KEY (Empleado_id, Numero_vuelo);
ALTER TABLE Comprar ADD CONSTRAINT PK_Comprar PRIMARY KEY (Cliente_id, Boleto_id);
ALTER TABLE Telefono_cliente ADD CONSTRAINT PK_Telefono_cliente PRIMARY KEY (Cliente_id, Numero_telefono);
ALTER TABLE Correo_cliente ADD CONSTRAINT PK_Correo_cliente PRIMARY KEY (Cliente_id, Direccion_correo);
ALTER TABLE Certificacion_medicos_aeronave ADD CONSTRAINT PK_Cert_medicos PRIMARY KEY (Nombre, Mecanico_id);
ALTER TABLE Certificacion_seguridad ADD CONSTRAINT PK_Cert_seguridad PRIMARY KEY (Nombre, Sobrecargo_id);
ALTER TABLE Idioma ADD CONSTRAINT PK_Idioma PRIMARY KEY (Nombre, Sobrecargo_id);
ALTER TABLE Certificacion_tipo_aeronave ADD CONSTRAINT PK_Cert_tipo_aeronave PRIMARY KEY (Nombre, Piloto_id);

-- Foreign Keys
ALTER TABLE Telefono_aerolineas ADD CONSTRAINT FK_Tel_Aerolineas FOREIGN KEY (Aerolinea_id) REFERENCES Aerolineas(Aerolinea_id);
ALTER TABLE Correo_aerolineas ADD CONSTRAINT FK_Correo_Aerolineas FOREIGN KEY (Aerolinea_id) REFERENCES Aerolineas(Aerolinea_id);
ALTER TABLE Telefono ADD CONSTRAINT FK_Telefono_Empleado FOREIGN KEY (Empleado_id) REFERENCES Empleado(Empleado_id);
ALTER TABLE Contratar ADD CONSTRAINT FK_Contratar_Aerolinea FOREIGN KEY (Aerolinea_id) REFERENCES Aerolineas(Aerolinea_id);
ALTER TABLE Contratar ADD CONSTRAINT FK_Contratar_Empleado FOREIGN KEY (Empleado_id) REFERENCES Empleado(Empleado_id);
ALTER TABLE Avion ADD CONSTRAINT FK_Avion_Aerolinea FOREIGN KEY (Aerolinea_id) REFERENCES Aerolineas(Aerolinea_id);
ALTER TABLE Vuelo ADD CONSTRAINT FK_Vuelo_Avion FOREIGN KEY (Matricula_avion) REFERENCES Avion(Matricula_avion);
ALTER TABLE Boleto ADD CONSTRAINT FK_Boleto_Vuelo FOREIGN KEY (Numero_vuelo) REFERENCES Vuelo(Numero_vuelo);
ALTER TABLE Piloto_vuelo ADD CONSTRAINT FK_PilotoVuelo_Empleado FOREIGN KEY (Empleado_id) REFERENCES Empleado(Empleado_id);
ALTER TABLE Piloto_vuelo ADD CONSTRAINT FK_PilotoVuelo_Vuelo FOREIGN KEY (Numero_vuelo) REFERENCES Vuelo(Numero_vuelo);
ALTER TABLE Comprar ADD CONSTRAINT FK_Comprar_Cliente FOREIGN KEY (Cliente_id) REFERENCES Cliente(Cliente_id);
ALTER TABLE Comprar ADD CONSTRAINT FK_Comprar_Boleto FOREIGN KEY (Boleto_id) REFERENCES Boleto(Boleto_id);
ALTER TABLE Telefono_cliente ADD CONSTRAINT FK_Tel_Cliente FOREIGN KEY (Cliente_id) REFERENCES Cliente(Cliente_id);
ALTER TABLE Correo_cliente ADD CONSTRAINT FK_Correo_Cliente FOREIGN KEY (Cliente_id) REFERENCES Cliente(Cliente_id);
ALTER TABLE Mecanico ADD CONSTRAINT FK_Mecanico_Empleado FOREIGN KEY (Empleado_id) REFERENCES Empleado(Empleado_id);
ALTER TABLE Controlador_de_abordaje ADD CONSTRAINT FK_Control_Abordaje_Emp FOREIGN KEY (Empleado_id) REFERENCES Empleado(Empleado_id);
ALTER TABLE Sobrecargo ADD CONSTRAINT FK_Sobrecargo_Empleado FOREIGN KEY (Empleado_id) REFERENCES Empleado(Empleado_id);
ALTER TABLE Controlador_de_vuelos ADD CONSTRAINT FK_Control_Vuelos_Emp FOREIGN KEY (Empleado_id) REFERENCES Empleado(Empleado_id);
ALTER TABLE Certificacion_medicos_aeronave ADD CONSTRAINT FK_Cert_Med_Mecanico FOREIGN KEY (Mecanico_id) REFERENCES Mecanico(Empleado_id);
ALTER TABLE Certificacion_seguridad ADD CONSTRAINT FK_Cert_Seg_Sobrecargo FOREIGN KEY (Sobrecargo_id) REFERENCES Sobrecargo(Empleado_id);
ALTER TABLE Idioma ADD CONSTRAINT FK_Idioma_Sobrecargo FOREIGN KEY (Sobrecargo_id) REFERENCES Sobrecargo(Empleado_id);
ALTER TABLE Certificacion_tipo_aeronave ADD CONSTRAINT FK_Cert_Tipo_Piloto FOREIGN KEY (Piloto_id) REFERENCES Empleado(Empleado_id);

-- Restricciones NOT NULL
ALTER TABLE Aerolineas ALTER COLUMN Aerolinea_id SET NOT NULL;
ALTER TABLE Aerolineas ALTER COLUMN Razon_social SET NOT NULL;
ALTER TABLE Empleado ALTER COLUMN Empleado_id SET NOT NULL;
ALTER TABLE Empleado ALTER COLUMN Nombres SET NOT NULL;
ALTER TABLE Empleado ALTER COLUMN Apellido_paterno SET NOT NULL;
ALTER TABLE Aeropuerto ALTER COLUMN Aeropuerto_id SET NOT NULL;
ALTER TABLE Aeropuerto ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Avion ALTER COLUMN Matricula_avion SET NOT NULL;
ALTER TABLE Avion ALTER COLUMN Capacidad_pasajeros SET NOT NULL;
ALTER TABLE Vuelo ALTER COLUMN Numero_vuelo SET NOT NULL;
ALTER TABLE Vuelo ALTER COLUMN Fecha_salida SET NOT NULL;
ALTER TABLE Vuelo ALTER COLUMN Hora_salida SET NOT NULL;
ALTER TABLE Boleto ALTER COLUMN Boleto_id SET NOT NULL;
ALTER TABLE Boleto ALTER COLUMN Precio SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN Cliente_id SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN Nombres SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN Apellido_paterno SET NOT NULL;

-- ========================================
-- 3. COMENTARIOS EN TABLAS Y COLUMNAS
-- ========================================

-- Comentarios en tablas
COMMENT ON TABLE Aerolineas IS 'Tabla que almacena información de las aerolíneas registradas en el sistema.';
COMMENT ON TABLE Empleado IS 'Tabla que contiene datos personales y de ubicación de todos los empleados.';
COMMENT ON TABLE Aeropuerto IS 'Tabla que registra información de aeropuertos donde operan las aerolíneas.';
COMMENT ON TABLE Avion IS 'Tabla que almacena datos de la flota de aviones de cada aerolínea.';
COMMENT ON TABLE Vuelo IS 'Tabla que contiene información de vuelos programados y su estado.';
COMMENT ON TABLE Boleto IS 'Tabla que registra los boletos disponibles para cada vuelo.';
COMMENT ON TABLE Cliente IS 'Tabla que almacena información personal de los clientes.';
COMMENT ON TABLE Contratar IS 'Tabla de relación que registra la contratación de empleados por aerolíneas.';
COMMENT ON TABLE Comprar IS 'Tabla de relación que registra la compra de boletos por clientes.';
COMMENT ON TABLE Telefono_aerolineas IS 'Tabla que almacena los números telefónicos de las aerolíneas.';
COMMENT ON TABLE Correo_aerolineas IS 'Tabla que almacena las direcciones de correo electrónico de las aerolíneas.';
COMMENT ON TABLE Telefono IS 'Tabla que almacena los números telefónicos de los empleados.';
COMMENT ON TABLE Piloto_vuelo IS 'Tabla de unión que asigna pilotos a los vuelos, modelando la relación muchos a muchos.';
COMMENT ON TABLE Telefono_cliente IS 'Tabla que almacena los números telefónicos de los clientes.';
COMMENT ON TABLE Correo_cliente IS 'Tabla que almacena las direcciones de correo electrónico de los clientes.';
COMMENT ON TABLE Mecanico IS 'Tabla que almacena información específica de los mecánicos, siendo un subtipo de Empleado.';
COMMENT ON TABLE Controlador_de_abordaje IS 'Tabla que almacena información específica de controladores de abordaje, siendo un subtipo de Empleado.';
COMMENT ON TABLE Sobrecargo IS 'Tabla que almacena información específica de sobrecargos, siendo un subtipo de Empleado.';
COMMENT ON TABLE Controlador_de_vuelos IS 'Tabla que almacena información específica de controladores de vuelo, siendo un subtipo de Empleado.';
COMMENT ON TABLE Certificacion_medicos_aeronave IS 'Tabla que almacena las certificaciones médicas de los mecánicos.';
COMMENT ON TABLE Certificacion_seguridad IS 'Tabla que almacena las certificaciones de seguridad de los sobrecargos.';
COMMENT ON TABLE Idioma IS 'Tabla que almacena los idiomas que hablan los sobrecargos.';
COMMENT ON TABLE Certificacion_tipo_aeronave IS 'Tabla que almacena las certificaciones de tipo de aeronave de los pilotos.';

-- Comentarios en columnas principales
COMMENT ON COLUMN Aerolineas.Aerolinea_id IS 'Identificador único de la aerolínea.';
COMMENT ON COLUMN Aerolineas.Razon_social IS 'Nombre legal y comercial de la aerolínea.';
COMMENT ON COLUMN Aerolineas.Pais_origen_empresa IS 'País donde se fundó la aerolínea.';
COMMENT ON COLUMN Empleado.Empleado_id IS 'Identificador único del empleado.';
COMMENT ON COLUMN Empleado.Nombres IS 'Nombre(s) del empleado.';
COMMENT ON COLUMN Empleado.Apellido_paterno IS 'Apellido paterno del empleado.';
COMMENT ON COLUMN Empleado.Apellido_materno IS 'Apellido materno del empleado.';
COMMENT ON COLUMN Vuelo.Numero_vuelo IS 'Código único que identifica el vuelo.';
COMMENT ON COLUMN Vuelo.Tipo_vuelo IS 'Clasificación del vuelo (doméstico, internacional).';
COMMENT ON COLUMN Vuelo.Estado IS 'Estado actual del vuelo (programado, en vuelo, cancelado, completado).';
COMMENT ON COLUMN Vuelo.Duracion IS 'Tiempo estimado de duración del vuelo.';
COMMENT ON COLUMN Vuelo.Ciudad_salida IS 'Ciudad de origen del vuelo.';
COMMENT ON COLUMN Vuelo.Pais_salida IS 'País de origen del vuelo.';
COMMENT ON COLUMN Vuelo.Ciudad_llegada IS 'Ciudad de destino del vuelo.';
COMMENT ON COLUMN Vuelo.Pais_llegada IS 'País de destino del vuelo.';
COMMENT ON COLUMN Boleto.Boleto_id IS 'Identificador único del boleto.';
COMMENT ON COLUMN Boleto.Numero_asiento IS 'Número del asiento asignado.';
COMMENT ON COLUMN Boleto.Clase IS 'Clase de servicio (económica, ejecutiva, primera).';
COMMENT ON COLUMN Boleto.Precio IS 'Precio del boleto en la moneda local.';
COMMENT ON COLUMN Cliente.Cliente_id IS 'Identificador único del cliente.';
COMMENT ON COLUMN Cliente.Fecha_nacimiento IS 'Fecha de nacimiento del cliente.';
COMMENT ON COLUMN Avion.Matricula_avion IS 'Matrícula única que identifica la aeronave.';
COMMENT ON COLUMN Avion.Capacidad_pasajeros IS 'Número máximo de pasajeros que puede transportar.';
COMMENT ON COLUMN Avion.Modelo IS 'Modelo y marca de la aeronave.';