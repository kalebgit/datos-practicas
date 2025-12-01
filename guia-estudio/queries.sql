CREATE TABLE empleado (
    id_empleado INT SERIAL PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    salario NUMERIC(10, 2) CHECK (salario > 0),
    fecha DATE DEFAULT CURRENT_DATE
)

CREATE TABLE departamento (
    id_departamento INT SERIAL PRIMARY KEY,
    nombre_departamento VARCHAR(100) UNIQUE NOT NULL,
    presupuesto NUMERIC(100, 2)
)

CREATE TABLE proyecto (
    id_proyecto INT SERIAL PRIMARY KEY,
    nombre_proyecto VARCHAR(200) NOT NULL,
    id_departamento INT REFERENCES departamento(id_departamento),
    fecha_inicio DATE, 
    estado VARCHAR(20) CHECK( estado IN ('ACTIVO', 'PAUSADO', 'COMPLETADO'))

)


CREATE TABLE proyecto (
    id_proyecto INT SERIAL PRIMARY KEY,
    nombre_proyecto VARCHAR(200) NOT NULL,
    id_departamento INT 
    fecha_inicio DATE, 
    estado VARCHAR(20) CHECK( estado IN ('ACTIVO', 'PAUSADO', 'COMPLETADO'))

--  seria como si () por si solo especificara la talba actual
    CONSTRAINT fk_proyecto FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento)
)