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

ALTER TABLE Contratar RENAME TO Contratar_aerolinea;
ALTER TABLE Contratar_aerolinea RENAME CONSTRAINT PK_Contratar TO PK_Contratar_aerolinea;
ALTER TABLE Contratar_aerolinea RENAME CONSTRAINT FK_Contratar_Aerolinea TO FK_Contratar_Aerolinea_Aero;
ALTER TABLE Contratar_aerolinea RENAME CONSTRAINT FK_Contratar_Empleado TO FK_Contratar_Aerolinea_Emp;

-- ESTRUCTURA DE TABLA: CONTRATAR_AEROPUERTO
CREATE TABLE Contratar_aeropuerto (
    Aeropuerto_id INT,
    Empleado_id INT,
    Fecha_ingreso DATE,
    Fecha_egreso DATE
);

-- ========================================
-- RESTRICCIONES: CONTRATAR_AEROPUERTO
-- ========================================

-- Primary Key compuesta
ALTER TABLE Contratar_aeropuerto 
ADD CONSTRAINT PK_Contratar_aeropuerto 
PRIMARY KEY (Aeropuerto_id, Empleado_id);

-- Foreign Keys
ALTER TABLE Contratar_aeropuerto 
ADD CONSTRAINT FK_Contratar_Aero_Aeropuerto 
FOREIGN KEY (Aeropuerto_id) 
REFERENCES Aeropuerto(Aeropuerto_id);

ALTER TABLE Contratar_aeropuerto 
ADD CONSTRAINT FK_Contratar_Aero_Empleado 
FOREIGN KEY (Empleado_id) 
REFERENCES Empleado(Empleado_id);

-- Restricciones NOT NULL
ALTER TABLE Contratar_aeropuerto ALTER COLUMN Aeropuerto_id SET NOT NULL;
ALTER TABLE Contratar_aeropuerto ALTER COLUMN Empleado_id SET NOT NULL;
ALTER TABLE Contratar_aeropuerto ALTER COLUMN Fecha_ingreso SET NOT NULL;

-- Fecha_egreso debe ser posterior a Fecha_ingreso
ALTER TABLE Contratar_aeropuerto 
ADD CONSTRAINT CHK_Fechas_Aeropuerto 
CHECK (Fecha_egreso IS NULL OR Fecha_egreso > Fecha_ingreso);


-- ========================================
-- COMENTARIOS: CONTRATAR_AEROPUERTO
-- ========================================

COMMENT ON TABLE Contratar_aeropuerto IS 
'Tabla de relación que registra la contratación de empleados por aeropuertos. La especialización del empleado (Controlador de Vuelo, Mecánico, etc.) se determina consultando las tablas correspondientes.';

COMMENT ON COLUMN Contratar_aeropuerto.Aeropuerto_id IS 
'Identificador del aeropuerto empleador.';

COMMENT ON COLUMN Contratar_aeropuerto.Empleado_id IS 
'Identificador del empleado contratado por el aeropuerto.';

COMMENT ON COLUMN Contratar_aeropuerto.Fecha_ingreso IS 
'Fecha en que el empleado inició labores en el aeropuerto.';

COMMENT ON COLUMN Contratar_aeropuerto.Fecha_egreso IS
'Fecha en que el empleado terminó su relación laboral con el aeropuerto. NULL indica que aún está activo.';


-- =====================================================================
-- RESTRICCIONES DE INTEGRIDAD ADICIONALES (Práctica 8)
-- =====================================================================

-- ELIMINACIÓN DE RESTRICCIONES EXISTENTES
-- 1 Eliminamos restricción de llave foránea de avion
-- Ya que se reconfigurará con acciones en cascada
ALTER TABLE avion
DROP CONSTRAINT IF EXISTS fk_avion_aerolinea;

-- 2 Eliminamos la restricción de llave foránea de boleto
-- Pues se agregará con ON DELETE CASCADE para eliminar boletos huérfanos
ALTER TABLE boleto
DROP CONSTRAINT IF EXISTS fk_boleto_vuelo;


-- =====================================================================
-- LLAVES FORÁNEAS CON DIFERENTES CONFIGURACIONES
-- =====================================================================

--  LLAVE FORÁNEA BÁSICA: avion -> aerolineas
-- Restablece la relación entre avión y aerolínea sin acciones en cascada
-- Uso de RESTRICT para no permitir eliminar una aerolínea si tiene aviones asociados
-- Es util pues protege contra eliminación accidental de aerolíneas en operación
ALTER TABLE avion
ADD CONSTRAINT fk_avion_aerolinea
FOREIGN KEY (aerolinea_id)
REFERENCES aerolineas(aerolinea_id)
ON DELETE RESTRICT
ON UPDATE NO ACTION;

-- 2 LLAVE FORÁNEA CON CASCADE: boleto -> vuelo
-- Si se elimina un vuelo, se eliminan automáticamente sus boletos
-- Uso de CASCADE: Mantiene la integridad eliminando boletos de vuelos cancelados
-- En este caso se usa mucho cuando pues al cancelar un vuelo, sus boletos deben eliminarse del sistema
ALTER TABLE boleto
ADD CONSTRAINT fk_boleto_vuelo
FOREIGN KEY (numero_vuelo)
REFERENCES vuelo(numero_vuelo)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- 3 LLAVE FORÁNEA CON CASCADE: comprar -> cliente
-- Si se elimina un cliente, se eliminan sus compras
-- Ayuda con el cumplimiento con derecho al olvido que es algo comun y pasa jiji
ALTER TABLE comprar
DROP CONSTRAINT IF EXISTS fk_comprar_cliente;

ALTER TABLE comprar
ADD CONSTRAINT fk_comprar_cliente
FOREIGN KEY (cliente_id)
REFERENCES cliente(cliente_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- 4 LLAVE FORÁNEA CON SET NULL: vuelo -> avion
-- Si se da de baja un avión, los vuelos quedan sin asignar (i..e NULL)
-- Para reasignar vuelos a otro avión sin perder el registro del vuelo
ALTER TABLE vuelo
DROP CONSTRAINT IF EXISTS fk_vuelo_avion;

ALTER TABLE vuelo
ADD CONSTRAINT fk_vuelo_avion
FOREIGN KEY (matricula_avion)
REFERENCES avion(matricula_avion)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- 5 LLAVE FORÁNEA BÁSICA: piloto_vuelo -> piloto
-- Restricción que previene eliminar pilotos asignados a vuelos
-- Evita que se pueda eliminar un piloto si tiene vuelos programados
ALTER TABLE piloto_vuelo
DROP CONSTRAINT IF EXISTS fk_pilotovuelo_piloto;

ALTER TABLE piloto_vuelo
ADD CONSTRAINT fk_pilotovuelo_piloto
FOREIGN KEY (piloto_id)
REFERENCES piloto(piloto_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;


-- =====================================================================
-- RESTRICCIONES DE DOMINIO
-- =====================================================================

-- 1 RESTRICCIÓN NOT NULL para Campos críticos de vuelo
-- Para que los vuelos tengan fecha y hora de salida definidas
ALTER TABLE vuelo
ALTER COLUMN fecha_salida SET NOT NULL;

ALTER TABLE vuelo
ALTER COLUMN hora_salida SET NOT NULL;

-- 2 RESTRICCIÓN NOT NULL: Email de cliente
-- Nos da la tranquilidad de que cada cliente tenga al menos un email registrado
ALTER TABLE correo_cliente
ALTER COLUMN direccion_correo SET NOT NULL;

-- 3 RESTRICCIÓN CHECK: Capacidad de pasajeros positiva
-- Un avión no puede tener capacidad negativa o cero (menos el de tipo carga)
-- Rango válido: 1 a 850 (Airbus A380 es el más grande con con arpox 850 asientos)
ALTER TABLE avion
ADD CONSTRAINT chk_capacidad_pasajeros
CHECK (capacidad_pasajeros >= 0 AND capacidad_pasajeros <= 1000);

-- 4 RESTRICCIÓN CHECK: Precio de boleto válido
-- Los boletos deben tener precio positivo
-- No puede haber boletos gratis o con precio negativo
ALTER TABLE boleto
ADD CONSTRAINT chk_precio_boleto
CHECK (precio > 0 AND precio <= 1000000);

-- Agregar columna: Salario de empleado
-- Almacena el salario mensual o anual del empleado
-- Necesario para aplicar restricción de rango salarial válido
ALTER TABLE empleado
ADD COLUMN salario NUMERIC(10,2);


-- 6 RESTRICCIÓN CHECK: Salario de empleado
-- El salario debe ser mayor que el salario mínimo y razonable
-- Rango: 5000 a 1000000 (considerando que hay diferentes monedas y posiciones)
ALTER TABLE empleado
ADD CONSTRAINT chk_salario_empleado
CHECK (salario >= 5000 AND salario <= 5000000);


-- Agregar columna: Fecha de nacimiento de empleado
-- Fecha de nacimiento para validar edad legal de trabajo
ALTER TABLE empleado
ADD COLUMN fecha_nacimiento DATE;

-- 7 RESTRICCIÓN CHECK: Fecha de nacimiento de empleado
-- El empleado debe tener edad legal para trabajar (18 años)
-- No puede nacer en el futuro xd ni ser demasiado antiguo
ALTER TABLE empleado
ADD CONSTRAINT chk_fecha_nacimiento_empleado
CHECK (fecha_nacimiento >= '1940-01-01' AND fecha_nacimiento <= CURRENT_DATE - INTERVAL '18 years');

-- 8 RESTRICCIÓN CHECK: Horas de experiencia de piloto
-- Las horas de vuelo no pueden ser negativas
ALTER TABLE piloto
ADD CONSTRAINT chk_horas_experiencia
CHECK (horas_vuelo >= 0 AND horas_vuelo <= 50000);

-- 9 RESTRICCIÓN CHECK: Fecha de salida antes de llegada
-- Un vuelo no puede llegar antes de salir (seria muy loco)
ALTER TABLE vuelo
ADD CONSTRAINT chk_fechas_vuelo
CHECK (
    (fecha_salida < fecha_llegada) OR
    (fecha_salida = fecha_llegada AND hora_salida < hora_llegada)
);


-- =====================================================================
-- MODIFICACION EN EL DDL
-- =====================================================================

-- 1 AGREGAR COLUMNA: Estado del vuelo
-- Permite rastrear el estado actual del vuelo
-- Valores: programado, abordando, en_vuelo, aterrizado, cancelado, retrasado
ALTER TABLE vuelo
ADD COLUMN estado_vuelo VARCHAR(20) DEFAULT 'programado';

-- 2 AGREGAR RESTRICCIÓN CHECK para el nuevo campo
ALTER TABLE vuelo
ADD CONSTRAINT chk_estado_vuelo
CHECK (estado_vuelo IN ('programado', 'abordando', 'en_vuelo', 'aterrizado', 'cancelado', 'retrasado'));

-- 3 AGREGAR COLUMNA: Duración estimada del vuelo
-- Duración en minutos del vuelo
ALTER TABLE vuelo
ADD COLUMN duracion_minutos INTEGER;

-- 4 AGREGAR RESTRICCIÓN CHECK: Duración válida
-- Un vuelo comercial típico dura entre 30 minutos y 20 horas
ALTER TABLE vuelo
ADD CONSTRAINT chk_duracion_minutos
CHECK (duracion_minutos > 0 AND duracion_minutos <= 1500);

-- 5 MODIFICAR TIPO DE DATO: Código postal
-- Ampliar el código postal para soportar formatos internacionales
-- pues no solo deberiamos pensar en Meixco
ALTER TABLE aeropuerto
ALTER COLUMN codigo_postal TYPE VARCHAR(20);

ALTER TABLE aerolineas
ALTER COLUMN codigo_postal TYPE VARCHAR(20);

-- 6 AGREGAR COLUMNA: Fecha de último mantenimiento del avión
-- Rastrea el mantenimiento para seguridad y cumplimiento regulatorio
ALTER TABLE avion
ADD COLUMN fecha_ultimo_mantenimiento DATE;

-- 7 AGREGAR RESTRICCIÓN: La fecha de mantenimiento no puede ser futura
ALTER TABLE avion
ADD CONSTRAINT chk_fecha_mantenimiento
CHECK (fecha_ultimo_mantenimiento <= CURRENT_DATE);

-- 8 ELIMINAR COLUMNA: Ejemplo de eliminación
-- Primero agregamos una columna temporal para luego eliminarla
ALTER TABLE vuelo
ADD COLUMN columna_temporal VARCHAR(50);

-- Ahora la eliminamos
ALTER TABLE vuelo
DROP COLUMN columna_temporal;

-- 9 MODIFICAR TIPO DE DATO: Número de asiento
-- Ampliar para soportar diferentes formatos de asientos
ALTER TABLE boleto
ALTER COLUMN numero_asiento TYPE VARCHAR(10);

-- 10 AGREGAR COLUMNA: Estado del boleto
-- Permite rastrear el estado actual del boleto (activo, cancelado, reembolsado, usado)
ALTER TABLE boleto
ADD COLUMN estado_boleto VARCHAR(20) DEFAULT 'activo';

-- 11 AGREGAR RESTRICCIÓN CHECK: Estado válido del boleto
-- Solo permite estados predefinidos para mantener integridad
ALTER TABLE boleto
ADD CONSTRAINT chk_estado_boleto
CHECK (estado_boleto IN ('activo', 'cancelado', 'reembolsado', 'usado'));


-- === OTROS CONSTRAINTS

-- 1 UNIQUE: Garantiza que no haya asientos duplicados en un vuelo
-- Un asiento solo puede ser asignado una vez por vuelo
ALTER TABLE boleto
DROP CONSTRAINT IF EXISTS uq_asiento_vuelo;

-- UNIQUE: Email único por cliente
-- Un email no puede pertenecer a múltiples clientes
ALTER TABLE correo_cliente
DROP CONSTRAINT IF EXISTS uq_correo_cliente;

ALTER TABLE correo_cliente
ADD CONSTRAINT uq_correo_cliente
UNIQUE (direccion_correo);


-- =====================================================================
-- NUEVOS CAMBIOS PARA PRÁCTICA 12 - TRIGGERS AVANZADOS
-- =====================================================================

-- ========================================
-- TABLAS NUEVAS PARA SOPORTE DE TRIGGERS
-- ========================================

-- Tabla: creditos
-- Propósito: Almacenar créditos otorgados a clientes por reembolsos y compensaciones
CREATE TABLE IF NOT EXISTS creditos (
    credito_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    monto NUMERIC(10,2) NOT NULL,
    fecha_emision TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_vencimiento DATE,
    usado BOOLEAN DEFAULT FALSE,
    origen VARCHAR(50)
);

-- Tabla: notificaciones_pendientes
-- Propósito: Almacenar notificaciones pendientes para envío a clientes
CREATE TABLE IF NOT EXISTS notificaciones_pendientes (
    notificacion_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    tipo VARCHAR(50),
    mensaje TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    enviada BOOLEAN DEFAULT FALSE
);

-- Tabla: historial_precios_boleto
-- Propósito: Auditoría de cambios de precio en boletos
CREATE TABLE IF NOT EXISTS historial_precios_boleto (
    historial_id SERIAL PRIMARY KEY,
    boleto_id INT NOT NULL,
    precio_anterior NUMERIC(10,2),
    precio_nuevo NUMERIC(10,2),
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    motivo VARCHAR(100)
);

-- Tabla: reporte_ingresos_vuelo
-- Propósito: Mantener cálculo actualizado de ingresos proyectados por vuelo
CREATE TABLE IF NOT EXISTS reporte_ingresos_vuelo (
    numero_vuelo VARCHAR(10) PRIMARY KEY,
    ingreso_proyectado NUMERIC(12,2) DEFAULT 0,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- LLAVES FORÁNEAS PARA TABLAS NUEVAS
-- ========================================

ALTER TABLE creditos
ADD CONSTRAINT fk_creditos_cliente
FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
ON DELETE CASCADE;

ALTER TABLE notificaciones_pendientes
ADD CONSTRAINT fk_notificaciones_cliente
FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
ON DELETE CASCADE;

ALTER TABLE historial_precios_boleto
ADD CONSTRAINT fk_historial_boleto
FOREIGN KEY (boleto_id) REFERENCES boleto(boleto_id)
ON DELETE CASCADE;

ALTER TABLE reporte_ingresos_vuelo
ADD CONSTRAINT fk_reporte_vuelo
FOREIGN KEY (numero_vuelo) REFERENCES vuelo(numero_vuelo)
ON DELETE CASCADE;

-- ========================================
-- RESTRICCIONES NOT NULL PARA TABLAS NUEVAS
-- ========================================

ALTER TABLE creditos ALTER COLUMN cliente_id SET NOT NULL;
ALTER TABLE creditos ALTER COLUMN monto SET NOT NULL;

ALTER TABLE notificaciones_pendientes ALTER COLUMN cliente_id SET NOT NULL;

ALTER TABLE historial_precios_boleto ALTER COLUMN boleto_id SET NOT NULL;

-- ========================================
-- RESTRICCIONES CHECK PARA TABLAS NUEVAS
-- ========================================

-- Validar origen de créditos
ALTER TABLE creditos
ADD CONSTRAINT chk_origen_credito
CHECK (origen IN ('cancelacion_vuelo', 'compensacion', 'promocion', 'devolucion'));

-- Validar tipo de notificación
ALTER TABLE notificaciones_pendientes
ADD CONSTRAINT chk_tipo_notificacion
CHECK (tipo IN ('cancelacion', 'reembolso', 'cambio_vuelo', 'promocion', 'recordatorio'));

-- Validar que el monto de crédito sea positivo
ALTER TABLE creditos
ADD CONSTRAINT chk_monto_credito_positivo
CHECK (monto > 0);

-- Validar que el ingreso proyectado no sea negativo
ALTER TABLE reporte_ingresos_vuelo
ADD CONSTRAINT chk_ingreso_no_negativo
CHECK (ingreso_proyectado >= 0);

-- ========================================
-- ÍNDICES PARA OPTIMIZACIÓN
-- ========================================

CREATE INDEX IF NOT EXISTS idx_creditos_cliente ON creditos(cliente_id);
CREATE INDEX IF NOT EXISTS idx_creditos_usado ON creditos(usado);
CREATE INDEX IF NOT EXISTS idx_creditos_origen ON creditos(origen);

CREATE INDEX IF NOT EXISTS idx_notificaciones_cliente ON notificaciones_pendientes(cliente_id);
CREATE INDEX IF NOT EXISTS idx_notificaciones_enviada ON notificaciones_pendientes(enviada);
CREATE INDEX IF NOT EXISTS idx_notificaciones_tipo ON notificaciones_pendientes(tipo);

CREATE INDEX IF NOT EXISTS idx_historial_precios_boleto ON historial_precios_boleto(boleto_id);
CREATE INDEX IF NOT EXISTS idx_historial_precios_fecha ON historial_precios_boleto(fecha_cambio);

-- ========================================
-- COMENTARIOS EN TABLAS Y COLUMNAS NUEVAS
-- ========================================

COMMENT ON TABLE creditos IS
'Tabla que almacena créditos otorgados a clientes por reembolsos, compensaciones y promociones.';

COMMENT ON COLUMN creditos.credito_id IS 'Identificador único del crédito.';
COMMENT ON COLUMN creditos.cliente_id IS 'Identificador del cliente que recibe el crédito.';
COMMENT ON COLUMN creditos.monto IS 'Monto del crédito en la moneda del sistema.';
COMMENT ON COLUMN creditos.fecha_emision IS 'Fecha y hora en que se emitió el crédito.';
COMMENT ON COLUMN creditos.fecha_vencimiento IS 'Fecha de vencimiento del crédito. NULL si no vence.';
COMMENT ON COLUMN creditos.usado IS 'Indica si el crédito ya fue utilizado por el cliente.';
COMMENT ON COLUMN creditos.origen IS 'Origen del crédito: cancelacion_vuelo, compensacion, promocion, devolucion.';

COMMENT ON TABLE notificaciones_pendientes IS
'Tabla que almacena notificaciones pendientes de envío a clientes.';

COMMENT ON COLUMN notificaciones_pendientes.notificacion_id IS 'Identificador único de la notificación.';
COMMENT ON COLUMN notificaciones_pendientes.cliente_id IS 'Identificador del cliente destinatario.';
COMMENT ON COLUMN notificaciones_pendientes.tipo IS 'Tipo de notificación: cancelacion, reembolso, cambio_vuelo, promocion, recordatorio.';
COMMENT ON COLUMN notificaciones_pendientes.mensaje IS 'Contenido del mensaje de la notificación.';
COMMENT ON COLUMN notificaciones_pendientes.fecha_creacion IS 'Fecha y hora de creación de la notificación.';
COMMENT ON COLUMN notificaciones_pendientes.enviada IS 'Indica si la notificación ya fue enviada al cliente.';

COMMENT ON TABLE historial_precios_boleto IS
'Tabla que registra todos los cambios de precio en boletos para auditoría.';

COMMENT ON COLUMN historial_precios_boleto.historial_id IS 'Identificador único del registro de cambio.';
COMMENT ON COLUMN historial_precios_boleto.boleto_id IS 'Identificador del boleto que cambió de precio.';
COMMENT ON COLUMN historial_precios_boleto.precio_anterior IS 'Precio del boleto antes del cambio.';
COMMENT ON COLUMN historial_precios_boleto.precio_nuevo IS 'Precio del boleto después del cambio.';
COMMENT ON COLUMN historial_precios_boleto.fecha_cambio IS 'Fecha y hora del cambio de precio.';
COMMENT ON COLUMN historial_precios_boleto.motivo IS 'Motivo del cambio: Recargo última hora, Ajuste por demanda, Descuento aplicado.';

COMMENT ON TABLE reporte_ingresos_vuelo IS
'Tabla que mantiene el cálculo actualizado de ingresos proyectados por vuelo.';

COMMENT ON COLUMN reporte_ingresos_vuelo.numero_vuelo IS 'Número del vuelo.';
COMMENT ON COLUMN reporte_ingresos_vuelo.ingreso_proyectado IS 'Suma total de precios de boletos activos y usados del vuelo.';
COMMENT ON COLUMN reporte_ingresos_vuelo.ultima_actualizacion IS 'Fecha y hora de la última actualización del cálculo.';




-- ==========================================
-- nuevos cambiso para practica 12
-- ==========================================

-- ========================================
-- TABLAS AUXILIARES PARA TRIGGERS
-- ========================================

-- en estas tablas los constraints deben ir aparte como en la definicion del ddl

-- tabla para almacenar creditos de clientes por reembolsos y compensaciones
CREATE TABLE IF NOT EXISTS creditos (
    credito_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    monto NUMERIC(10,2) NOT NULL,
    fecha_emision TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_vencimiento DATE, -- mientras no ponemos vencimiento para los reembolsos
    usado BOOLEAN DEFAULT FALSE,
    origen VARCHAR(50) -- 'cancelacion_vuelo', 'compensacion', 'promocion', 'devolucion'
);

-- tabla para almacenar notificaciones que se deben enviar a los clientes
CREATE TABLE IF NOT EXISTS notificaciones_pendientes (
    notificacion_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    tipo VARCHAR(50), -- 'cancelacion', 'reembolso', 'cambio_vuelo', 'promocion', 'recordatorio'
    mensaje TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    enviada BOOLEAN DEFAULT FALSE -- para saber si ya se envio o no
);

-- tabla para guardar el historial de cambios de precios de boletos (para auditoria)
CREATE TABLE IF NOT EXISTS historial_precios_boleto (
    historial_id SERIAL PRIMARY KEY,
    boleto_id INT NOT NULL,
    precio_anterior NUMERIC(10,2),
    precio_nuevo NUMERIC(10,2),
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    motivo VARCHAR(100) -- 'Recargo última hora', 'Ajuste por demanda', 'Descuento aplicado'
);

-- tabla para mantener el calculo de ingresos proyectados por vuelo
-- se actualiza automaticamente con triggers cada vez que cambia el precio de un boleto
CREATE TABLE IF NOT EXISTS reporte_ingresos_vuelo (
    numero_vuelo VARCHAR(10) PRIMARY KEY,
    ingreso_proyectado NUMERIC(12,2) DEFAULT 0,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- LLAVES FORÁNEAS
-- ========================================

-- los creditos son de un cliente especifico
ALTER TABLE creditos
ADD CONSTRAINT fk_creditos_cliente
FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
ON DELETE CASCADE;

-- las notificaciones son para un cliente especifico
ALTER TABLE notificaciones_pendientes
ADD CONSTRAINT fk_notificaciones_cliente
FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
ON DELETE CASCADE;

-- el historial de precios es de un boleto especifico
ALTER TABLE historial_precios_boleto
ADD CONSTRAINT fk_historial_boleto
FOREIGN KEY (boleto_id) REFERENCES boleto(boleto_id)
ON DELETE CASCADE;

-- el reporte de ingresos es de un vuelo especifico
ALTER TABLE reporte_ingresos_vuelo
ADD CONSTRAINT fk_reporte_vuelo
FOREIGN KEY (numero_vuelo) REFERENCES vuelo(numero_vuelo)
ON DELETE CASCADE;

-- ========================================
-- RESTRICCIONES NOT NULL
-- ========================================

ALTER TABLE creditos ALTER COLUMN cliente_id SET NOT NULL;
ALTER TABLE creditos ALTER COLUMN monto SET NOT NULL;

ALTER TABLE notificaciones_pendientes ALTER COLUMN cliente_id SET NOT NULL;

ALTER TABLE historial_precios_boleto ALTER COLUMN boleto_id SET NOT NULL;

-- ========================================
-- RESTRICCIONES CHECK
-- ========================================

-- validar que el origen del credito sea uno de los valores permitidos
ALTER TABLE creditos
DROP CONSTRAINT IF EXISTS chk_origen_credito;

ALTER TABLE creditos
ADD CONSTRAINT chk_origen_credito
CHECK (origen IN ('cancelacion_vuelo', 'compensacion', 'promocion', 'devolucion'));

-- validar que el tipo de notificacion sea uno de los valores permitidos
ALTER TABLE notificaciones_pendientes
DROP CONSTRAINT IF EXISTS chk_tipo_notificacion;

ALTER TABLE notificaciones_pendientes
ADD CONSTRAINT chk_tipo_notificacion
CHECK (tipo IN ('cancelacion', 'reembolso', 'cambio_vuelo', 'promocion', 'recordatorio'));

-- el monto del credito debe ser positivo
ALTER TABLE creditos
ADD CONSTRAINT chk_monto_credito_positivo
CHECK (monto > 0);

-- el ingreso proyectado no puede ser negativo
ALTER TABLE reporte_ingresos_vuelo
ADD CONSTRAINT chk_ingreso_no_negativo
CHECK (ingreso_proyectado >= 0);

-- -- ========================================
-- -- ÍNDICES PARA OPTIMIZACIÓN
-- -- ========================================

-- -- indices para buscar creditos por cliente mas rapido
-- CREATE INDEX IF NOT EXISTS idx_creditos_cliente ON creditos(cliente_id);
-- CREATE INDEX IF NOT EXISTS idx_creditos_usado ON creditos(usado);
-- CREATE INDEX IF NOT EXISTS idx_creditos_origen ON creditos(origen);

-- -- indices para buscar notificaciones mas rapido
-- CREATE INDEX IF NOT EXISTS idx_notificaciones_cliente ON notificaciones_pendientes(cliente_id);
-- CREATE INDEX IF NOT EXISTS idx_notificaciones_enviada ON notificaciones_pendientes(enviada);
-- CREATE INDEX IF NOT EXISTS idx_notificaciones_tipo ON notificaciones_pendientes(tipo);

-- -- indices para el historial de precios
-- CREATE INDEX IF NOT EXISTS idx_historial_precios_boleto ON historial_precios_boleto(boleto_id);
-- CREATE INDEX IF NOT EXISTS idx_historial_precios_fecha ON historial_precios_boleto(fecha_cambio);

-- ========================================
-- COMENTARIOS EN TABLAS Y COLUMNAS
-- ========================================

COMMENT ON TABLE creditos IS
'Tabla que almacena créditos otorgados a clientes por reembolsos, compensaciones y promociones.';

COMMENT ON COLUMN creditos.credito_id IS 'Identificador único del crédito.';
COMMENT ON COLUMN creditos.cliente_id IS 'Identificador del cliente que recibe el crédito.';
COMMENT ON COLUMN creditos.monto IS 'Monto del crédito en la moneda del sistema.';
COMMENT ON COLUMN creditos.fecha_emision IS 'Fecha y hora en que se emitió el crédito.';
COMMENT ON COLUMN creditos.fecha_vencimiento IS 'Fecha de vencimiento del crédito. NULL si no vence.';
COMMENT ON COLUMN creditos.usado IS 'Indica si el crédito ya fue utilizado por el cliente.';
COMMENT ON COLUMN creditos.origen IS 'Origen del crédito: cancelacion_vuelo, compensacion, promocion, devolucion.';

COMMENT ON TABLE notificaciones_pendientes IS
'Tabla que almacena notificaciones pendientes de envío a clientes.';

COMMENT ON COLUMN notificaciones_pendientes.notificacion_id IS 'Identificador único de la notificación.';
COMMENT ON COLUMN notificaciones_pendientes.cliente_id IS 'Identificador del cliente destinatario.';
COMMENT ON COLUMN notificaciones_pendientes.tipo IS 'Tipo de notificación: cancelacion, reembolso, cambio_vuelo, promocion, recordatorio.';
COMMENT ON COLUMN notificaciones_pendientes.mensaje IS 'Contenido del mensaje de la notificación.';
COMMENT ON COLUMN notificaciones_pendientes.fecha_creacion IS 'Fecha y hora de creación de la notificación.';
COMMENT ON COLUMN notificaciones_pendientes.enviada IS 'Indica si la notificación ya fue enviada al cliente.';

COMMENT ON TABLE historial_precios_boleto IS
'Tabla que registra todos los cambios de precio en boletos para auditoría.';

COMMENT ON COLUMN historial_precios_boleto.historial_id IS 'Identificador único del registro de cambio.';
COMMENT ON COLUMN historial_precios_boleto.boleto_id IS 'Identificador del boleto que cambió de precio.';
COMMENT ON COLUMN historial_precios_boleto.precio_anterior IS 'Precio del boleto antes del cambio.';
COMMENT ON COLUMN historial_precios_boleto.precio_nuevo IS 'Precio del boleto después del cambio.';
COMMENT ON COLUMN historial_precios_boleto.fecha_cambio IS 'Fecha y hora del cambio de precio.';
COMMENT ON COLUMN historial_precios_boleto.motivo IS 'Motivo del cambio: Recargo última hora, Ajuste por demanda, Descuento aplicado.';

COMMENT ON TABLE reporte_ingresos_vuelo IS
'Tabla que mantiene el cálculo actualizado de ingresos proyectados por vuelo.';

COMMENT ON COLUMN reporte_ingresos_vuelo.numero_vuelo IS 'Número del vuelo.';
COMMENT ON COLUMN reporte_ingresos_vuelo.ingreso_proyectado IS 'Suma total de precios de boletos activos y usados del vuelo.';
COMMENT ON COLUMN reporte_ingresos_vuelo.ultima_actualizacion IS 'Fecha y hora de la última actualización del cálculo.';
