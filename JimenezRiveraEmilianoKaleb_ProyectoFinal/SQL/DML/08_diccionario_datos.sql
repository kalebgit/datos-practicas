
\echo ''
\echo '╔══════════════════════════════════════════════════════════════════════════════╗'
\echo '║              DICCIONARIO DE DATOS - SISTEMA DE GESTIÓN DE AEROLÍNEAS       ║'
\echo '╚══════════════════════════════════════════════════════════════════════════════╝'
\echo ''

-- ========================================
-- LISTADO DE TABLAS DEL SISTEMA
-- ========================================

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'TABLAS DEL SISTEMA'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    schemaname AS "Esquema",
    tablename AS "Tabla",
    CASE
        WHEN has_table_privilege(quote_ident(schemaname) || '.' || quote_ident(tablename), 'SELECT')
        THEN (SELECT COUNT(*) FROM information_schema.columns
              WHERE table_schema = schemaname AND table_name = tablename)
        ELSE 0
    END AS "Columnas",
    pg_size_pretty(pg_total_relation_size(quote_ident(schemaname) || '.' || quote_ident(tablename))) AS "Tamaño"
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;

\echo ''


-- ========================================
-- ESTRUCTURA DETALLADA DE TABLAS
-- ========================================

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'ESTRUCTURA DETALLADA DE TABLAS'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    c.table_name AS "Tabla",
    c.column_name AS "Columna",
    c.ordinal_position AS "Posición",
    c.data_type AS "Tipo de Dato",
    CASE
        WHEN c.character_maximum_length IS NOT NULL
        THEN c.data_type || '(' || c.character_maximum_length || ')'
        WHEN c.numeric_precision IS NOT NULL
        THEN c.data_type || '(' || c.numeric_precision || ',' || COALESCE(c.numeric_scale::text, '0') || ')'
        ELSE c.data_type
    END AS "Tipo Completo",
    CASE
        WHEN c.is_nullable = 'NO' THEN 'NO'
        ELSE 'SÍ'
    END AS "Permite NULL",
    c.column_default AS "Valor por Defecto"
FROM information_schema.columns c
WHERE c.table_schema = 'public'
ORDER BY c.table_name, c.ordinal_position;

\echo ''


-- ========================================
-- LLAVES PRIMARIAS
-- ========================================

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'LLAVES PRIMARIAS'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    tc.table_name AS "Tabla",
    tc.constraint_name AS "Nombre de Restricción",
    STRING_AGG(kcu.column_name, ', ' ORDER BY kcu.ordinal_position) AS "Columnas PK"
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
WHERE tc.constraint_type = 'PRIMARY KEY'
    AND tc.table_schema = 'public'
GROUP BY tc.table_name, tc.constraint_name
ORDER BY tc.table_name;

\echo ''


-- ========================================
-- LLAVES FORÁNEAS
-- ========================================

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'LLAVES FORÁNEAS (RELACIONES)'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    tc.table_name AS "Tabla Origen",
    kcu.column_name AS "Columna Origen",
    ccu.table_name AS "Tabla Referenciada",
    ccu.column_name AS "Columna Referenciada",
    tc.constraint_name AS "Nombre de Restricción",
    rc.update_rule AS "Regla UPDATE",
    rc.delete_rule AS "Regla DELETE"
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage ccu
    ON ccu.constraint_name = tc.constraint_name
    AND ccu.table_schema = tc.table_schema
JOIN information_schema.referential_constraints rc
    ON tc.constraint_name = rc.constraint_name
    AND tc.table_schema = rc.constraint_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
    AND tc.table_schema = 'public'
ORDER BY tc.table_name, kcu.column_name;

\echo ''


-- ========================================
-- RESTRICCIONES UNIQUE
-- ========================================

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'RESTRICCIONES UNIQUE'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    tc.table_name AS "Tabla",
    tc.constraint_name AS "Nombre de Restricción",
    STRING_AGG(kcu.column_name, ', ' ORDER BY kcu.ordinal_position) AS "Columnas"
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
WHERE tc.constraint_type = 'UNIQUE'
    AND tc.table_schema = 'public'
GROUP BY tc.table_name, tc.constraint_name
ORDER BY tc.table_name;

\echo ''


-- ========================================
-- ÍNDICES
-- ========================================

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'ÍNDICES'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    schemaname AS "Esquema",
    tablename AS "Tabla",
    indexname AS "Nombre del Índice",
    indexdef AS "Definición"
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;

\echo ''


-- ========================================
-- VISTAS
-- ========================================

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'VISTAS'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    table_name AS "Nombre de Vista",
    view_definition AS "Definición"
FROM information_schema.views
WHERE table_schema = 'public'
ORDER BY table_name;

\echo ''


-- ========================================
-- FUNCIONES PERSONALIZADAS
-- ========================================

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'FUNCIONES PERSONALIZADAS'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    p.proname AS "Nombre de Función",
    pg_get_function_result(p.oid) AS "Tipo de Retorno",
    pg_get_function_arguments(p.oid) AS "Argumentos",
    CASE p.provolatile
        WHEN 'i' THEN 'IMMUTABLE'
        WHEN 's' THEN 'STABLE'
        WHEN 'v' THEN 'VOLATILE'
    END AS "Volatilidad",
    obj_description(p.oid, 'pg_proc') AS "Descripción"
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public'
    AND p.prokind = 'f'
ORDER BY p.proname;

\echo ''


-- ========================================
-- TRIGGERS
-- ========================================

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'TRIGGERS'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    event_object_table AS "Tabla",
    trigger_name AS "Nombre del Trigger",
    event_manipulation AS "Evento",
    action_timing AS "Momento",
    action_statement AS "Acción"
FROM information_schema.triggers
WHERE trigger_schema = 'public'
ORDER BY event_object_table, trigger_name;

\echo ''


-- ========================================
-- SECUENCIAS
-- ========================================

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'SECUENCIAS'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    sequence_schema AS "Esquema",
    sequence_name AS "Nombre de Secuencia",
    data_type AS "Tipo de Dato",
    start_value AS "Valor Inicial",
    minimum_value AS "Valor Mínimo",
    maximum_value AS "Valor Máximo",
    increment AS "Incremento",
    cycle_option AS "Ciclo"
FROM information_schema.sequences
WHERE sequence_schema = 'public'
ORDER BY sequence_name;

\echo ''


-- ========================================
-- ESTADÍSTICAS DE TABLAS
-- ========================================

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'ESTADÍSTICAS DE TABLAS (Conteo de Registros)'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    schemaname AS "Esquema",
    relname AS "Tabla",
    n_live_tup AS "Registros Estimados",
    n_dead_tup AS "Registros Muertos",
    last_vacuum AS "Último VACUUM",
    last_autovacuum AS "Último AUTOVACUUM",
    last_analyze AS "Último ANALYZE",
    last_autoanalyze AS "Último AUTOANALYZE"
FROM pg_stat_user_tables
WHERE schemaname = 'public'
ORDER BY relname;

\echo ''


-- ========================================
-- DIAGRAMA DE DEPENDENCIAS (Relaciones entre Tablas)
-- ========================================

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'DIAGRAMA DE DEPENDENCIAS'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

WITH RECURSIVE dependency_tree AS (
    -- Tablas base (sin dependencias entrantes)
    SELECT DISTINCT
        tc.table_name,
        0 AS nivel,
        tc.table_name::text AS ruta
    FROM information_schema.tables tc
    WHERE tc.table_schema = 'public'
        AND tc.table_type = 'BASE TABLE'
        AND NOT EXISTS (
            SELECT 1
            FROM information_schema.table_constraints fk
            WHERE fk.table_schema = 'public'
                AND fk.constraint_type = 'FOREIGN KEY'
                AND fk.table_name = tc.table_name
        )

    UNION ALL

    -- Tablas dependientes
    SELECT DISTINCT
        fk.table_name,
        dt.nivel + 1,
        dt.ruta || ' -> ' || fk.table_name
    FROM dependency_tree dt
    JOIN information_schema.table_constraints fk
        ON fk.table_schema = 'public'
        AND fk.constraint_type = 'FOREIGN KEY'
    JOIN information_schema.constraint_column_usage ccu
        ON ccu.constraint_name = fk.constraint_name
        AND ccu.table_schema = fk.table_schema
    WHERE ccu.table_name = dt.table_name
        AND dt.nivel < 10  -- Evitar ciclos infinitos
)
SELECT
    nivel AS "Nivel de Dependencia",
    table_name AS "Tabla",
    COUNT(*) AS "Veces en Árbol"
FROM dependency_tree
GROUP BY nivel, table_name
ORDER BY nivel, table_name;

\echo ''


-- ========================================
-- RESUMEN DEL ESQUEMA
-- ========================================

\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'RESUMEN DEL ESQUEMA'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''

SELECT
    'Tablas' AS "Tipo de Objeto",
    COUNT(*)::text AS "Cantidad"
FROM information_schema.tables
WHERE table_schema = 'public' AND table_type = 'BASE TABLE'

UNION ALL

SELECT
    'Vistas',
    COUNT(*)::text
FROM information_schema.views
WHERE table_schema = 'public'

UNION ALL

SELECT
    'Funciones',
    COUNT(*)::text
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public' AND p.prokind = 'f'

UNION ALL

SELECT
    'Triggers',
    COUNT(DISTINCT trigger_name)::text
FROM information_schema.triggers
WHERE trigger_schema = 'public'

UNION ALL

SELECT
    'Restricciones PK',
    COUNT(*)::text
FROM information_schema.table_constraints
WHERE table_schema = 'public' AND constraint_type = 'PRIMARY KEY'

UNION ALL

SELECT
    'Restricciones FK',
    COUNT(*)::text
FROM information_schema.table_constraints
WHERE table_schema = 'public' AND constraint_type = 'FOREIGN KEY'

UNION ALL

SELECT
    'Restricciones CHECK',
    COUNT(*)::text
FROM information_schema.table_constraints
WHERE table_schema = 'public' AND constraint_type = 'CHECK'

UNION ALL

SELECT
    'Restricciones UNIQUE',
    COUNT(*)::text
FROM information_schema.table_constraints
WHERE table_schema = 'public' AND constraint_type = 'UNIQUE'

UNION ALL

SELECT
    'Índices',
    COUNT(*)::text
FROM pg_indexes
WHERE schemaname = 'public'

UNION ALL

SELECT
    'Secuencias',
    COUNT(*)::text
FROM information_schema.sequences
WHERE sequence_schema = 'public';

\echo ''
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo 'FIN DEL DICCIONARIO DE DATOS'
\echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
\echo ''
