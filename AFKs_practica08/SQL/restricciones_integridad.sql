-- =====================================================================
-- ELIMINACIÓN DE RESTRICCIONES EXISTENTES
-- =====================================================================

-- 1 Eliminamos restricción de llave foránea de avion
-- Ya que se reconfigurará con acciones en cascada
ALTER TABLE avion
DROP CONSTRAINT IF EXISTS fk_avion_aerolinea;

-- 2 Eliminamos la restricción de llave foránea de boleto
-- Pues se agregará con ON DELETE CASCADE para eliminar boletos huérfanos
ALTER TABLE boleto
DROP CONSTRAINT IF EXISTS fk_boleto_vuelo;


-- =====================================================================
-- Llaves primarias
-- comentamos todas las sentencias pues ya existen
-- =====================================================================

-- 1 Llave primaria para tabla aerolineas
-- ALTER TABLE aerolineas ADD CONSTRAINT pk_aerolineas PRIMARY KEY (aerolinea_id);
-- Nota: Ya está definida en el esquema original

-- 2 Llave primaria para tabla aeropuerto
--  Garantiza que cada aeropuerto tenga un identificador único
-- ALTER TABLE aeropuerto ADD CONSTRAINT pk_aeropuerto PRIMARY KEY (aeropuerto_id);
-- Nota: Ya está definida en el esquema original

-- 3 Llave primaria para tabla empleado
-- Identifica de forma única a cada empleado del sistema
-- Esta es importante para todas las especializaciones que creamos (piloto, mecánico, sobrecargo)
-- ALTER TABLE empleado ADD CONSTRAINT pk_empleado PRIMARY KEY (empleado_id);
-- Nota: Ya está definida en el esquema original

-- 2.4 Llave primaria compuesta para tabla comprar
-- Un cliente puede comprar múltiples boletos en diferentes momentos
-- La combinación de cliente_id, boleto_id y fecha_compra garantiza que en conjunto sean unicos
-- ALTER TABLE comprar ADD CONSTRAINT pk_comprar PRIMARY KEY (cliente_id, boleto_id, fecha_compra);
-- Nota: Ya está definida en el esquema original


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



-- ======================================================
-- ======================================================
-- ======================================================
-- ======================================================
-- ======================================================
    -- este no se puede ejecutar pues ya hay datos que violan la condicion
-- ======================================================
-- ======================================================
-- ======================================================
-- ======================================================
-- 5 RESTRICCIÓN CHECK: Clase de servicio válida
-- Limita las clases a las opciones estándar de la industria
-- Valores permitidos o validos: economica, premium, ejecutiva, primera
-- ALTER TABLE boleto
-- ADD CONSTRAINT chk_clase_valida
-- CHECK (clase IN ('economica', 'premium', 'ejecutiva', 'primera'));


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


-- === OTROS CONSTRAINST

-- 1 UNIQUE: Garantiza que no haya asientos duplicados en un vuelo
-- Un asiento solo puede ser asignado una vez por vuelo
ALTER TABLE boleto
DROP CONSTRAINT IF EXISTS uq_asiento_vuelo;



-- ======================================================
-- ======================================================
-- ======================================================
-- este no se puede ejecutar pues ya hay datos que violan la condicion
-- ======================================================
-- ======================================================
-- ======================================================
-- ======================================================
-- ALTER TABLE boleto
-- ADD CONSTRAINT uq_asiento_vuelo
-- UNIQUE (numero_vuelo, numero_asiento);

-- UNIQUE: Email único por cliente
-- Un email no puede pertenecer a múltiples clientes
ALTER TABLE correo_cliente
DROP CONSTRAINT IF EXISTS uq_correo_cliente;

ALTER TABLE correo_cliente
ADD CONSTRAINT uq_correo_cliente
UNIQUE (direccion_correo);


-- ======================================================
-- ======================================================
-- ======================================================
-- este no se puede ejecutar pues ya hay datos que violan la condicion
-- ======================================================
-- ======================================================
-- ======================================================
-- 5 CHECK: Validar formato de matrícula de avión
-- Las matrículas siguen estándares internacionales (ej: N12345, XA-ABC)
-- ALTER TABLE avion
-- ADD CONSTRAINT chk_formato_matricula
-- CHECK (matricula_avion ~ '^[A-Z]{1,2}[-]?[A-Z0-9]{3,6}$');



-- ======
-- CONSULTAS QUE DEBERIAN TIRAR ERROR CON NUESTROS NUEVAS RESTRICCIONES
-- ===== solo descomentar y usar

-- INSERT INTO boleto (boleto_id, numero_asiento, clase, precio, numero_vuelo)
-- VALUES (99999, '1A', 'economica', -500, 'AA123');

-- INSERT INTO avion (matricula_avion, capacidad_pasajeros, modelo, aerolinea_id)
-- VALUES ('XA-TEST', -50, 'Boeing 737', 1);

-- INSERT INTO boleto (boleto_id, numero_asiento, clase, precio, numero_vuelo)
-- VALUES (99998, '1B', 'vip_premium', 1000, 'AA123');

-- INSERT INTO vuelo (numero_vuelo, fecha_salida, hora_salida, fecha_llegada, hora_llegada)
-- VALUES ('TEST001', '2025-10-30', '14:00:00', '2025-10-30', '10:00:00');

-- Eliminar aerolínea con aviones (DEBE FALLAR por RESTRICT)
-- DELETE FROM aerolineas WHERE aerolinea_id = 1;

-- Eliminar vuelo con boletos (DEBE ELIMINAR EN CASCADA)
-- DELETE FROM vuelo WHERE numero_vuelo = 'AA123';


-- INSERT INTO empleado (empleado_id, nombre, apellido_paterno, fecha_nacimiento, salario)
-- VALUES (99999, 'Juan', 'Pérez', '2015-01-01', 10000);



