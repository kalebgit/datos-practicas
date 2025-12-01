-- ========================================
-- DICCIONARIO DE DATOS - SISTEMA DE AEROLÍNEAS
-- Base de datos: aeropuerto2026
-- ========================================
-- Este archivo contiene los comentarios y descripciones de todas las tablas
-- y columnas del sistema de gestión de aeropuertos y aerolíneas
-- ========================================

-- ========================================
-- TABLA: AEROLINEAS
-- ========================================
COMMENT ON TABLE Aerolineas IS 'Tabla que almacena información de las aerolíneas registradas en el sistema.';

COMMENT ON COLUMN Aerolineas.Aerolinea_id IS 'Identificador único de la aerolínea.';
COMMENT ON COLUMN Aerolineas.Razon_social IS 'Nombre legal y comercial de la aerolínea.';
COMMENT ON COLUMN Aerolineas.Pais_origen_empresa IS 'País donde se fundó la aerolínea.';

-- ========================================
-- TABLA: AEROPUERTO
-- ========================================
COMMENT ON TABLE Aeropuerto IS 'Tabla que registra información de aeropuertos donde operan las aerolíneas.';

-- ========================================
-- TABLA: AVION
-- ========================================
COMMENT ON TABLE Avion IS 'Tabla que almacena datos de la flota de aviones de cada aerolínea.';

COMMENT ON COLUMN Avion.Matricula_avion IS 'Matrícula única que identifica la aeronave.';
COMMENT ON COLUMN Avion.Capacidad_pasajeros IS 'Número máximo de pasajeros que puede transportar. 0 para aviones de carga.';
COMMENT ON COLUMN Avion.Modelo IS 'Modelo y marca de la aeronave.';

-- ========================================
-- TABLA: VUELO
-- ========================================
COMMENT ON TABLE Vuelo IS 'Tabla que contiene información de vuelos programados y su estado.';

COMMENT ON COLUMN Vuelo.Numero_vuelo IS 'Código único que identifica el vuelo.';
COMMENT ON COLUMN Vuelo.Estado IS 'Estado actual del vuelo (programado, en vuelo, cancelado, completado).';
COMMENT ON COLUMN Vuelo.Duracion IS 'Tiempo estimado de duración del vuelo.';
COMMENT ON COLUMN Vuelo.Ciudad_salida IS 'Ciudad de origen del vuelo.';
COMMENT ON COLUMN Vuelo.Pais_salida IS 'País de origen del vuelo.';
COMMENT ON COLUMN Vuelo.Ciudad_llegada IS 'Ciudad de destino del vuelo.';
COMMENT ON COLUMN Vuelo.Pais_llegada IS 'País de destino del vuelo.';
COMMENT ON COLUMN Vuelo.Aeropuerto_salida_id IS 'Aeropuerto de origen del vuelo.';
COMMENT ON COLUMN Vuelo.Aeropuerto_llegada_id IS 'Aeropuerto de destino del vuelo.';

-- ========================================
-- TABLA: BOLETO
-- ========================================
COMMENT ON TABLE Boleto IS 'Tabla que registra los boletos disponibles para cada vuelo.';

COMMENT ON COLUMN Boleto.Boleto_id IS 'Identificador único del boleto.';
COMMENT ON COLUMN Boleto.Numero_asiento IS 'Número del asiento asignado.';
COMMENT ON COLUMN Boleto.Clase IS 'Clase de servicio (económica, ejecutiva, primera).';
COMMENT ON COLUMN Boleto.Precio IS 'Precio del boleto en la moneda local.';

-- ========================================
-- TABLA: CLIENTE
-- ========================================
COMMENT ON TABLE Cliente IS 'Tabla que almacena información personal de los clientes.';

COMMENT ON COLUMN Cliente.Cliente_id IS 'Identificador único del cliente.';
COMMENT ON COLUMN Cliente.Fecha_nacimiento IS 'Fecha de nacimiento del cliente.';

-- ========================================
-- TABLA: EMPLEADO
-- ========================================
COMMENT ON TABLE Empleado IS 'Tabla que contiene datos personales y de ubicación de todos los empleados.';

COMMENT ON COLUMN Empleado.Empleado_id IS 'Identificador único del empleado.';
COMMENT ON COLUMN Empleado.Nombres IS 'Nombre(s) del empleado.';
COMMENT ON COLUMN Empleado.Apellido_paterno IS 'Apellido paterno del empleado.';
COMMENT ON COLUMN Empleado.Apellido_materno IS 'Apellido materno del empleado.';

-- ========================================
-- TABLA: PILOTO
-- ========================================
COMMENT ON TABLE Piloto IS 'Tabla que almacena información específica de los pilotos, siendo un subtipo de Empleado.';

COMMENT ON COLUMN Piloto.Piloto_id IS 'Identificador único del piloto.';
COMMENT ON COLUMN Piloto.Empleado_id IS 'Referencia al empleado que es piloto.';
COMMENT ON COLUMN Piloto.Licencia IS 'Número de licencia del piloto.';
COMMENT ON COLUMN Piloto.Horas_vuelo IS 'Total de horas de vuelo acumuladas por el piloto.';
COMMENT ON COLUMN Piloto.Fecha_vencimiento_licencia IS 'Fecha de vencimiento de la licencia del piloto.';

-- ========================================
-- TABLA: SOBRECARGO
-- ========================================
COMMENT ON TABLE Sobrecargo IS 'Tabla que almacena información específica de sobrecargos, siendo un subtipo de Empleado.';

-- ========================================
-- TABLA: MECANICO
-- ========================================
COMMENT ON TABLE Mecanico IS 'Tabla que almacena información específica de los mecánicos, siendo un subtipo de Empleado.';

-- ========================================
-- TABLA: CONTROLADOR_DE_VUELOS
-- ========================================
COMMENT ON TABLE Controlador_de_vuelos IS 'Tabla que almacena información específica de controladores de vuelo, siendo un subtipo de Empleado.';

-- ========================================
-- TABLA: CONTROLADOR_DE_ABORDAJE
-- ========================================
COMMENT ON TABLE Controlador_de_abordaje IS 'Tabla que almacena información específica de controladores de abordaje, siendo un subtipo de Empleado.';

-- ========================================
-- TABLA: PILOTO_VUELO
-- ========================================
COMMENT ON TABLE Piloto_vuelo IS 'Tabla de unión que asigna pilotos a los vuelos, modelando la relación muchos a muchos.';

COMMENT ON COLUMN Piloto_vuelo.Piloto_id IS 'Identificador del piloto asignado.';
COMMENT ON COLUMN Piloto_vuelo.Numero_vuelo IS 'Número del vuelo al que está asignado el piloto.';

-- ========================================
-- TABLA: COMPRAR
-- ========================================
COMMENT ON TABLE Comprar IS 'Tabla de relación que registra la compra de boletos por clientes.';

-- ========================================
-- TABLA: CONTRATAR_AEROLINEA
-- ========================================
COMMENT ON TABLE Contratar_aerolinea IS 'Tabla de relación que registra la contratación de empleados por aerolíneas.';

-- ========================================
-- TABLA: TIPO_VUELO
-- ========================================
COMMENT ON TABLE Tipo_vuelo IS 'Tabla catálogo que define los tipos de vuelo disponibles en el sistema.';

COMMENT ON COLUMN Tipo_vuelo.Tipo_vuelo_id IS 'Identificador único del tipo de vuelo.';
COMMENT ON COLUMN Tipo_vuelo.Nombre IS 'Nombre del tipo de vuelo (ej. Pasajeros, Carga, Mixto).';
COMMENT ON COLUMN Tipo_vuelo.Descripcion IS 'Descripción detallada del tipo de vuelo.';

-- ========================================
-- TABLA: AUDITORIA_VUELOS (NUEVA - PRÁCTICA 12)
-- ========================================
COMMENT ON TABLE Auditoria_vuelos IS 'Tabla de auditoría que registra automáticamente todos los cambios de estado de los vuelos mediante triggers.';

COMMENT ON COLUMN Auditoria_vuelos.Id_log IS 'Identificador único del registro de auditoría.';
COMMENT ON COLUMN Auditoria_vuelos.Numero_vuelo IS 'Número del vuelo que cambió de estado.';
COMMENT ON COLUMN Auditoria_vuelos.Estado_anterior IS 'Estado del vuelo antes del cambio.';
COMMENT ON COLUMN Auditoria_vuelos.Estado_nuevo IS 'Estado del vuelo después del cambio.';
COMMENT ON COLUMN Auditoria_vuelos.Usuario IS 'Usuario de la base de datos que realizó el cambio.';
COMMENT ON COLUMN Auditoria_vuelos.Fecha IS 'Fecha y hora en que se realizó el cambio de estado.';

-- ========================================
-- TABLAS DE CONTACTO
-- ========================================

COMMENT ON TABLE Telefono_aerolineas IS 'Tabla que almacena los números telefónicos de las aerolíneas.';
COMMENT ON TABLE Correo_aerolineas IS 'Tabla que almacena las direcciones de correo electrónico de las aerolíneas.';
COMMENT ON TABLE Telefono_cliente IS 'Tabla que almacena los números telefónicos de los clientes.';
COMMENT ON TABLE Correo_cliente IS 'Tabla que almacena las direcciones de correo electrónico de los clientes.';

-- ========================================
-- TABLAS DE CERTIFICACIONES
-- ========================================

COMMENT ON TABLE Certificacion_tipo_aeronave IS 'Tabla que almacena las certificaciones de tipo de aeronave de los pilotos.';
COMMENT ON COLUMN Certificacion_tipo_aeronave.Nombre IS 'Nombre de la certificación de tipo de aeronave.';
COMMENT ON COLUMN Certificacion_tipo_aeronave.Piloto_id IS 'Identificador del piloto certificado para ese tipo de aeronave.';

COMMENT ON TABLE Certificacion_mecanico_aeronave IS 'Tabla que almacena las certificaciones de mecánicos de aeronaves.';
COMMENT ON COLUMN Certificacion_mecanico_aeronave.Nombre IS 'Nombre de la certificación de mecánico de aeronaves.';
COMMENT ON COLUMN Certificacion_mecanico_aeronave.Mecanico_id IS 'Identificador del mecánico certificado.';

COMMENT ON TABLE Certificacion_seguridad IS 'Tabla que almacena las certificaciones de seguridad de los sobrecargos.';

COMMENT ON TABLE Idioma IS 'Tabla que almacena los idiomas que hablan los sobrecargos.';

-- ========================================
-- ÍNDICES Y OPTIMIZACIÓN
-- ========================================

-- Índices para mejorar el rendimiento de consultas frecuentes
CREATE INDEX IF NOT EXISTS idx_vuelo_fecha_salida ON Vuelo(Fecha_salida);
CREATE INDEX IF NOT EXISTS idx_vuelo_estado ON Vuelo(Estado_vuelo);
CREATE INDEX IF NOT EXISTS idx_boleto_numero_vuelo ON Boleto(Numero_vuelo);
CREATE INDEX IF NOT EXISTS idx_comprar_cliente ON Comprar(Cliente_id);
CREATE INDEX IF NOT EXISTS idx_piloto_vuelo_numero ON Piloto_vuelo(Numero_vuelo);

COMMENT ON INDEX idx_vuelo_fecha_salida IS 'Índice para optimizar búsquedas de vuelos por fecha de salida.';
COMMENT ON INDEX idx_vuelo_estado IS 'Índice para optimizar consultas filtradas por estado del vuelo.';
COMMENT ON INDEX idx_boleto_numero_vuelo IS 'Índice para acelerar la búsqueda de boletos por número de vuelo.';
COMMENT ON INDEX idx_comprar_cliente IS 'Índice para optimizar consultas de compras por cliente.';
COMMENT ON INDEX idx_piloto_vuelo_numero IS 'Índice para agilizar búsquedas de pilotos asignados a vuelos específicos.';

-- ========================================
-- CONSULTA DEL DICCIONARIO DE DATOS
-- ========================================

-- Consulta para ver todos los comentarios de tablas
-- SELECT
--     tablename as tabla,
--     obj_description((schemaname||'.'||tablename)::regclass) as descripcion
-- FROM pg_tables
-- WHERE schemaname = 'public'
-- ORDER BY tablename;

-- Consulta para ver todos los comentarios de columnas de una tabla específica
-- SELECT
--     cols.column_name as columna,
--     pgd.description as descripcion,
--     cols.data_type as tipo_dato,
--     cols.is_nullable as permite_null
-- FROM pg_catalog.pg_statio_all_tables as st
-- INNER JOIN pg_catalog.pg_description pgd ON (pgd.objoid = st.relid)
-- INNER JOIN information_schema.columns cols ON (
--     pgd.objsubid = cols.ordinal_position AND
--     cols.table_schema = st.schemaname AND
--     cols.table_name = st.relname
-- )
-- WHERE st.schemaname = 'public' AND st.relname = 'vuelo';
