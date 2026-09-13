-- ========================================
-- SISTEMA DE AEROLÍNEAS - NORMALIZACIÓN Y RESTRICCIONES ADICIONALES
-- ========================================

-- ========================================
-- RENOMBRAMIENTO DE TABLAS Y CONSTRAINTS
-- esto es para remarcar la normazliacion
-- ademas de que los nombres sean mas
-- descriptivos
-- ========================================

ALTER TABLE Contratar RENAME TO Contratar_aerolinea;
ALTER TABLE Contratar_aerolinea RENAME CONSTRAINT PK_Contratar TO PK_Contratar_aerolinea;
ALTER TABLE Contratar_aerolinea RENAME CONSTRAINT FK_Contratar_Aerolinea TO FK_Contratar_Aerolinea_Aero;
ALTER TABLE Contratar_aerolinea RENAME CONSTRAINT FK_Contratar_Empleado TO FK_Contratar_Aerolinea_Emp;

--para debugging y que se acepten mas numeros
ALTER TABLE Direccion
    ALTER COLUMN numero_exterior TYPE VARCHAR(25),
    ALTER COLUMN numero_interior TYPE VARCHAR(25);


-- ========================================
-- RESTRICCIONES: CONTRATAR_AEROPUERTO
-- ========================================

-- Restricciones NOT NULL
ALTER TABLE Contratar_aeropuerto ALTER COLUMN Aeropuerto_id SET NOT NULL;
ALTER TABLE Contratar_aeropuerto ALTER COLUMN Empleado_id SET NOT NULL;
ALTER TABLE Contratar_aeropuerto ALTER COLUMN Fecha_ingreso SET NOT NULL;

-- Fecha_egreso debe ser posterior a Fecha_ingreso
ALTER TABLE Contratar_aeropuerto
ADD CONSTRAINT CHK_Fechas_Aeropuerto
CHECK (Fecha_egreso IS NULL OR Fecha_egreso > Fecha_ingreso);

-- ========================================
-- RESTRICCIONES DE INTEGRIDAD ADICIONALES
-- ========================================

-- ELIMINACIÓN DE RESTRICCIONES EXISTENTES
-- Eliminamos restricción de llave foránea de avion
-- Ya que se reconfigurará con acciones en cascada
ALTER TABLE avion
DROP CONSTRAINT IF EXISTS fk_avion_aerolinea;

-- Eliminamos la restricción de llave foránea de boleto
-- Pues se agregará con ON DELETE CASCADE para eliminar boletos huérfanos
ALTER TABLE boleto
DROP CONSTRAINT IF EXISTS fk_boleto_vuelo;

-- ========================================
-- LLAVES FORÁNEAS CON DIFERENTES CONFIGURACIONES
-- ========================================

-- LLAVE FORÁNEA BÁSICA: avion -> aerolineas
-- Restablece la relación entre avión y aerolínea sin acciones en cascada
-- Uso de RESTRICT para no permitir eliminar una aerolínea si tiene aviones asociados
-- Es util pues protege contra eliminación accidental de aerolíneas en operación
ALTER TABLE avion
ADD CONSTRAINT fk_avion_aerolinea
FOREIGN KEY (aerolinea_id)
REFERENCES aerolineas(aerolinea_id)
ON DELETE RESTRICT
ON UPDATE NO ACTION;

-- LLAVE FORÁNEA CON CASCADE: boleto -> vuelo
-- Si se elimina un vuelo, se eliminan automáticamente sus boletos
-- Uso de CASCADE: Mantiene la integridad eliminando boletos de vuelos cancelados
-- En este caso se usa mucho cuando pues al cancelar un vuelo, sus boletos deben eliminarse del sistema
ALTER TABLE boleto
ADD CONSTRAINT fk_boleto_vuelo
FOREIGN KEY (numero_vuelo)
REFERENCES vuelo(numero_vuelo)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- LLAVE FORÁNEA CON CASCADE: comprar -> cliente
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

-- LLAVE FORÁNEA CON SET NULL: vuelo -> avion
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

-- LLAVE FORÁNEA BÁSICA: piloto_vuelo -> piloto
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

-- ========================================
-- RESTRICCIONES DE DOMINIO
-- ========================================

-- RESTRICCIÓN NOT NULL para Campos críticos de vuelo
-- Para que los vuelos tengan fecha y hora de salida definidas
ALTER TABLE vuelo
ALTER COLUMN fecha_salida SET NOT NULL;

ALTER TABLE vuelo
ALTER COLUMN hora_salida SET NOT NULL;

-- RESTRICCIÓN NOT NULL: Email de cliente
-- Nos da la tranquilidad de que cada cliente tenga al menos un email registrado
ALTER TABLE correo_cliente
ALTER COLUMN direccion_correo SET NOT NULL;

-- RESTRICCIÓN CHECK: Capacidad de pasajeros positiva
-- Un avión no puede tener capacidad negativa o cero (menos el de tipo carga)
-- Rango válido: 1 a 850 (Airbus A380 es el más grande con con arpox 850 asientos)
ALTER TABLE avion
ADD CONSTRAINT chk_capacidad_pasajeros
CHECK (capacidad_pasajeros >= 0 AND capacidad_pasajeros <= 1000);

-- RESTRICCIÓN CHECK: Precio de boleto válido
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

-- RESTRICCIÓN CHECK: Salario de empleado
-- El salario debe ser mayor que el salario mínimo y razonable
-- Rango: 5000 a 1000000 (considerando que hay diferentes monedas y posiciones)
ALTER TABLE empleado
ADD CONSTRAINT chk_salario_empleado
CHECK (salario >= 5000 AND salario <= 5000000);

-- Agregar columna: Fecha de nacimiento de empleado
-- Fecha de nacimiento para validar edad legal de trabajo
ALTER TABLE empleado
ADD COLUMN fecha_nacimiento DATE;

-- RESTRICCIÓN CHECK: Fecha de nacimiento de empleado
-- El empleado debe tener edad legal para trabajar (18 años)
-- No puede nacer en el futuro xd ni ser demasiado antiguo
ALTER TABLE empleado
ADD CONSTRAINT chk_fecha_nacimiento_empleado
CHECK (fecha_nacimiento >= '1940-01-01' AND fecha_nacimiento <= CURRENT_DATE - INTERVAL '18 years');

-- RESTRICCIÓN CHECK: Horas de experiencia de piloto
-- Las horas de vuelo no pueden ser negativas
ALTER TABLE piloto
ADD CONSTRAINT chk_horas_experiencia
CHECK (horas_vuelo >= 0 AND horas_vuelo <= 50000);

-- RESTRICCIÓN CHECK: Fecha de salida antes de llegada
-- Un vuelo no puede llegar antes de salir (seria muy loco)
ALTER TABLE vuelo
ADD CONSTRAINT chk_fechas_vuelo
CHECK (
    (fecha_salida < fecha_llegada) OR
    (fecha_salida = fecha_llegada AND hora_salida < hora_llegada)
);

-- ========================================
-- MODIFICACIONES AL DDL
-- ========================================

-- AGREGAR COLUMNA: Estado del vuelo
-- Permite rastrear el estado actual del vuelo
-- Valores: programado, abordando, en_vuelo, aterrizado, cancelado, retrasado
ALTER TABLE vuelo
ADD COLUMN estado_vuelo VARCHAR(20) DEFAULT 'programado';

-- AGREGAR RESTRICCIÓN CHECK para el nuevo campo
ALTER TABLE vuelo
ADD CONSTRAINT chk_estado_vuelo
CHECK (estado_vuelo IN ('programado', 'abordando', 'en_vuelo', 'aterrizado', 'cancelado', 'retrasado'));

-- AGREGAR COLUMNA: Duración estimada del vuelo
-- Duración en minutos del vuelo
ALTER TABLE vuelo
ADD COLUMN duracion_minutos INTEGER;

-- AGREGAR RESTRICCIÓN CHECK: Duración válida
-- Un vuelo comercial típico dura entre 30 minutos y 20 horas
ALTER TABLE vuelo
ADD CONSTRAINT chk_duracion_minutos
CHECK (duracion_minutos > 0 AND duracion_minutos <= 1500);

-- MODIFICAR TIPO DE DATO: Código postal
-- Ampliar el código postal para soportar formatos internacionales
-- pues no solo deberiamos pensar en Meixco
-- NOTA: Este cambio ya está reflejado en la tabla Direccion (01_DDL.sql)
-- Las tablas Aeropuerto y Aerolineas ahora usan Direccion_id

-- AGREGAR COLUMNA: Fecha de último mantenimiento del avión
-- Rastrea el mantenimiento para seguridad y cumplimiento regulatorio
ALTER TABLE avion
ADD COLUMN fecha_ultimo_mantenimiento DATE;

-- AGREGAR RESTRICCIÓN: La fecha de mantenimiento no puede ser futura
ALTER TABLE avion
ADD CONSTRAINT chk_fecha_mantenimiento
CHECK (fecha_ultimo_mantenimiento <= CURRENT_DATE);

-- ELIMINAR COLUMNA: Ejemplo de eliminación
-- Primero agregamos una columna temporal para luego eliminarla
ALTER TABLE vuelo
ADD COLUMN columna_temporal VARCHAR(50);

-- Ahora la eliminamos
ALTER TABLE vuelo
DROP COLUMN columna_temporal;

-- MODIFICAR TIPO DE DATO: Número de asiento
-- Ampliar para soportar diferentes formatos de asientos
ALTER TABLE boleto
ALTER COLUMN numero_asiento TYPE VARCHAR(10);

-- AGREGAR COLUMNA: Estado del boleto
-- Permite rastrear el estado actual del boleto (activo, cancelado, reembolsado, usado)
ALTER TABLE boleto
ADD COLUMN estado_boleto VARCHAR(20) DEFAULT 'activo';

-- AGREGAR RESTRICCIÓN CHECK: Estado válido del boleto
-- Solo permite estados predefinidos para mantener integridad
ALTER TABLE boleto
ADD CONSTRAINT chk_estado_boleto
CHECK (estado_boleto IN ('activo', 'cancelado', 'reembolsado', 'usado'));

-- ========================================
-- OTROS CONSTRAINTS
-- ========================================

-- UNIQUE: Garantiza que no haya asientos duplicados en un vuelo
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

-- ========================================
-- LLAVES FORÁNEAS PARA TABLAS ADICIONALES
-- ========================================

-- ALTER TABLE creditos
-- ADD CONSTRAINT fk_creditos_cliente
-- FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
-- ON DELETE CASCADE;

-- ALTER TABLE notificaciones_pendientes
-- ADD CONSTRAINT fk_notificaciones_cliente
-- FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
-- ON DELETE CASCADE;

-- ALTER TABLE historial_precios_boleto
-- ADD CONSTRAINT fk_historial_boleto
-- FOREIGN KEY (boleto_id) REFERENCES boleto(boleto_id)
-- ON DELETE CASCADE;

-- ALTER TABLE reporte_ingresos_vuelo
-- ADD CONSTRAINT fk_reporte_vuelo
-- FOREIGN KEY (numero_vuelo) REFERENCES vuelo(numero_vuelo)
-- ON DELETE CASCADE;

-- ========================================
-- RESTRICCIONES NOT NULL PARA TABLAS ADICIONALES
-- ========================================

ALTER TABLE creditos ALTER COLUMN cliente_id SET NOT NULL;
ALTER TABLE creditos ALTER COLUMN monto SET NOT NULL;

ALTER TABLE notificaciones_pendientes ALTER COLUMN cliente_id SET NOT NULL;

ALTER TABLE historial_precios_boleto ALTER COLUMN boleto_id SET NOT NULL;

-- ========================================
-- RESTRICCIONES CHECK PARA TABLAS ADICIONALES
-- ========================================

-- Validar origen de créditos
ALTER TABLE creditos
DROP CONSTRAINT IF EXISTS chk_origen_credito;

ALTER TABLE creditos
ADD CONSTRAINT chk_origen_credito
CHECK (origen IN ('cancelacion_vuelo', 'compensacion', 'promocion', 'devolucion'));

-- Validar tipo de notificación
ALTER TABLE notificaciones_pendientes
DROP CONSTRAINT IF EXISTS chk_tipo_notificacion;

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
-- ÍNDICES PARA OPTIMIZACIÓN (muy util para las consultas cuando hay
-- muchos registros en alguna tabla)
-- ========================================

CREATE INDEX IF NOT EXISTS idx_creditos_cliente ON creditos(cliente_id);
CREATE INDEX IF NOT EXISTS idx_creditos_usado ON creditos(usado);
CREATE INDEX IF NOT EXISTS idx_creditos_origen ON creditos(origen);

CREATE INDEX IF NOT EXISTS idx_notificaciones_cliente ON notificaciones_pendientes(cliente_id);
CREATE INDEX IF NOT EXISTS idx_notificaciones_enviada ON notificaciones_pendientes(enviada);
CREATE INDEX IF NOT EXISTS idx_notificaciones_tipo ON notificaciones_pendientes(tipo);

CREATE INDEX IF NOT EXISTS idx_historial_precios_boleto ON historial_precios_boleto(boleto_id);
CREATE INDEX IF NOT EXISTS idx_historial_precios_fecha ON historial_precios_boleto(fecha_cambio);
