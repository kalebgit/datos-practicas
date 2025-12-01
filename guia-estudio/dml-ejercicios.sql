--Departamento de "Tecnología" con presupuesto de 500000.00
-- Departamento de "Recursos Humanos" con presupuesto de 200000.00
-- Departamento de "Marketing" con presupuesto de 350000.00

INSERT INTO departamentos VALUES ('Tecnologia', 500000), ('Recursos Humanos', 2000000), ('Marketing', 350000)


-- "Desarrollo App Móvil" del departamento de Tecnología (id=1), inicia hoy, estado ACTIVO
-- "Campaña Redes Sociales" del departamento de Marketing (id=3), inicia mañana, estado ACTIVO
INSERT INTO proyectos VALUES ('Desarrollo App Movil', 1, CURRENT_DATE, 'ACTIVO')
INSERT INTO proyectos VALUES ('Campana Redes Sociales', 3, (CURRENT_DATE + INTERVAL '1 day'), 'ACTIVO')


-- Aumenta el salario de todos los empleados del departamento 1 en un 10%
UPDATE empleados SET salario = salario * 1.1 WHERE id_departamento = 1

-- Cambia el estado del proyecto "Desarrollo App Móvil" a 'COMPLETADO' y establece su fecha_fin como hoy


