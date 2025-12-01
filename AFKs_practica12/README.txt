========================================
PRÁCTICA 12: DISPARADORES (TRIGGERS)
FUNDAMENTOS DE BASES DE DATOS
SEMESTRE 2026-1
========================================

EQUIPO: AFKs

INTEGRANTES:
- Lenin Merino
- Emiliano Jiménez

========================================
CONTENIDO DEL ENTREGABLE
========================================

Este archivo comprimido contiene todos los scripts SQL y documentos necesarios
para la correcta implementación y evaluación del sistema de gestión de aeropuertos.

La estructura está organizada de la siguiente manera:

AFKs_practica12/
├── README.txt (este archivo)
├── DOC/
│   ├── Reporte_de_cambios_en_base_de_datos.pdf
│   ├── Reporte_analisis_de_entidades.pdf
│   ├── Reporte_traducción.pdf
│   ├── reporte_restricciones.pdf
│   ├── reporte_funciones_procedimientos.pdf
│   ├── diagrama_ER_actualizao.drawio
│   ├── diagrama_ER_actualizao.drawio.png
│   ├── diagrama_relacional_actualizado.drawio
│   ├── diagrama_relacional_actualizado.drawio.png
│   └── images/ (carpeta con 14 capturas de pantalla)
└── SQL/
    ├── DDL/
    │   ├── 01_DDL.sql
    │   └── 02_DDL_normalizacion.sql
    └── DML/
        ├── 01_DML_inserts.sql
        ├── 02_funciones_aeropuerto.sql
        ├── 03_procedimientos_aeropuerto.sql
        ├── 04_disparadores_aeropuerto.sql
        ├── 05_DML_consultas.sql
        └── 06_diccionario_datos.sql

========================================
ORDEN DE EJECUCIÓN DE SCRIPTS SQL
========================================

Para cargar correctamente la base de datos, ejecute los scripts en el siguiente orden:

1. DDL (Data Definition Language) - Definición de Estructura
   -----------------------------------------------------------
   01_DDL.sql
      - Contiene la definición completa del esquema de base de datos
      - Crea todas las tablas principales del sistema
      - Define las claves primarias iniciales
      - Duración estimada: ~30 segundos

   02_DDL_normalizacion.sql
      - Aplica ajustes de normalización al modelo
      - Crea la tabla Contratar_aeropuerto
      - Renombra la tabla Contratar a Contratar_aerolinea
      - Añade restricciones de integridad (Foreign Keys, Check, Not Null)
      - Modifica tipos de datos para mayor compatibilidad
      - Añade columnas adicionales (salario, fecha_nacimiento, etc.)
      - Duración estimada: ~45 segundos

2. DML (Data Manipulation Language) - Datos y Lógica
   -----------------------------------------------------------
   01_DML_inserts.sql
      - Inserta datos iniciales en todas las tablas
      - Incluye 25+ registros en cada tabla principal
      - Datos de aerolíneas, aeropuertos, empleados, vuelos, etc.
      - Duración estimada: ~1 minuto

   02_funciones_aeropuerto.sql
      - Define funciones PL/pgSQL para operaciones comunes
      - Funciones de cálculo y consulta
      - Incluye funciones como calcular_ocupacion_vuelo, etc.
      - Duración estimada: ~15 segundos

   03_procedimientos_aeropuerto.sql
      - Define procedimientos almacenados
      - Procedimientos para operaciones complejas
      - Incluye registrar_nuevo_vuelo, etc.
      - Duración estimada: ~15 segundos

   04_disparadores_aeropuerto.sql
      - Crea las funciones trigger y los triggers asociados
      - Trigger 1: Prevenir sobreventa de boletos (BEFORE INSERT)
      - Trigger 2: Auditoría de cambios en estado de vuelos (AFTER UPDATE)
      - Trigger 3: Validación de horas de vuelo del piloto (BEFORE INSERT/UPDATE)
      - Crea tabla auditoria_vuelos para registrar cambios
      - Incluye casos de prueba comentados
      - Duración estimada: ~20 segundos

   05_DML_consultas.sql
      - Contiene consultas de agregación y análisis
      - Consultas con GROUP BY, HAVING, funciones agregadas
      - Consultas de prueba del sistema
      - Duración estimada: ~10 segundos (si se ejecutan todas)

   06_diccionario_datos.sql
      - Añade comentarios descriptivos a tablas y columnas
      - Documenta el propósito de cada elemento del esquema
      - Crea índices para optimización de consultas
      - No modifica datos, solo añade metadatos
      - Duración estimada: ~30 segundos

========================================
NOTAS IMPORTANTES
========================================

1. PREREQUISITOS:
   - PostgreSQL 12 o superior instalado
   - Usuario con permisos de creación de tablas y objetos
   - Base de datos creada previamente (nombre sugerido: aeropuerto2026)

2. COMANDOS PARA EJECUTAR DESDE TERMINAL:

   # Conectarse a PostgreSQL
   psql -U usuario -d aeropuerto2026

   # Ejecutar scripts en orden
   \i SQL/DDL/01_DDL.sql
   \i SQL/DDL/02_DDL_normalizacion.sql
   \i SQL/DML/01_DML_inserts.sql
   \i SQL/DML/02_funciones_aeropuerto.sql
   \i SQL/DML/03_procedimientos_aeropuerto.sql
   \i SQL/DML/04_disparadores_aeropuerto.sql
   \i SQL/DML/05_DML_consultas.sql
   \i SQL/DML/06_diccionario_datos.sql

3. COMANDOS ALTERNATIVOS DESDE BASH/TERMINAL:

   psql -U usuario -d aeropuerto2026 -f SQL/DDL/01_DDL.sql
   psql -U usuario -d aeropuerto2026 -f SQL/DDL/02_DDL_normalizacion.sql
   psql -U usuario -d aeropuerto2026 -f SQL/DML/01_DML_inserts.sql
   psql -U usuario -d aeropuerto2026 -f SQL/DML/02_funciones_aeropuerto.sql
   psql -U usuario -d aeropuerto2026 -f SQL/DML/03_procedimientos_aeropuerto.sql
   psql -U usuario -d aeropuerto2026 -f SQL/DML/04_disparadores_aeropuerto.sql
   psql -U usuario -d aeropuerto2026 -f SQL/DML/05_DML_consultas.sql
   psql -U usuario -d aeropuerto2026 -f SQL/DML/06_diccionario_datos.sql

4. VERIFICACIÓN:
   Después de ejecutar todos los scripts, puede verificar que todo se cargó correctamente:

   -- Ver todas las tablas creadas
   \dt

   -- Ver todos los triggers
   SELECT trigger_name, event_object_table
   FROM information_schema.triggers
   WHERE trigger_schema = 'public';

   -- Ver todas las funciones
   \df

   -- Contar registros en tablas principales
   SELECT COUNT(*) FROM aerolineas;
   SELECT COUNT(*) FROM aeropuerto;
   SELECT COUNT(*) FROM vuelo;
   SELECT COUNT(*) FROM empleado;

5. SOLUCIÓN DE PROBLEMAS:

   - Si encuentra errores de permisos, asegúrese de tener privilegios suficientes
   - Si hay errores de constraint duplicados, algunos scripts incluyen
     DROP CONSTRAINT IF EXISTS para manejar re-ejecuciones
   - Los scripts están diseñados para ser idempotentes en la medida de lo posible
   - Algunos constraints comentados pueden violar datos existentes (ver comentarios en scripts)

========================================
DOCUMENTACIÓN ADICIONAL
========================================

Los documentos en la carpeta DOC contienen:

REPORTES PDF:
- Reporte_de_cambios_en_base_de_datos.pdf
  Documenta los cambios realizados al esquema de base de datos

- Reporte_analisis_de_entidades.pdf
  Análisis de las entidades del modelo

- Reporte_traducción.pdf
  Documentación de la traducción del modelo ER al modelo relacional

- reporte_restricciones.pdf
  Detalles sobre las restricciones de integridad implementadas

- reporte_funciones_procedimientos.pdf
  Documentación de las funciones y procedimientos almacenados

DIAGRAMAS (actualizados - práctica 8):
- diagrama_ER_actualizao.drawio / .png
  Diagrama Entidad-Relación actualizado del sistema (editable y PNG)

- diagrama_relacional_actualizado.drawio / .png
  Diagrama del modelo relacional actualizado (editable y PNG)

IMÁGENES:
- images/ (carpeta con 14 capturas de pantalla)
  Capturas de pantalla de consultas y resultados de prácticas anteriores

========================================
CARACTERÍSTICAS PRINCIPALES DEL SISTEMA
========================================

1. TRIGGERS IMPLEMENTADOS:
   - Prevención de sobreventa de boletos
   - Auditoría automática de cambios de estado de vuelos
   - Validación de experiencia de pilotos según tipo de avión

2. INTEGRIDAD REFERENCIAL:
   - Claves primarias en todas las tablas
   - Claves foráneas con diferentes políticas (CASCADE, RESTRICT, SET NULL)
   - Restricciones CHECK para validación de datos
   - Restricciones UNIQUE para evitar duplicados

3. OPTIMIZACIÓN:
   - Índices en columnas frecuentemente consultadas
   - Funciones para cálculos complejos
   - Procedimientos para operaciones transaccionales

========================================
CONTACTO
========================================

Para dudas o comentarios sobre este entregable:

Profesora: Dra. Amparo López Gaona
Email: alg@ciencias.unam.mx

Laboratorio: Carlos Augusto Escalona Navarro
Email: caen@ciencias.unam.mx

Asunto sugerido: [FBD-2026-1][Practica12][AFKs] - Tema

========================================
FECHA DE ENTREGA
========================================

Semestre: 2026-1
Práctica: 12 - Disparadores (Triggers)
Fecha: Diciembre 2025

========================================
