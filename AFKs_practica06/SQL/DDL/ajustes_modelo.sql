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
