-- ########################################################################
-- # CONSULTAS DML AVANZADAS (ANÁLISIS DE NEGOCIO)
-- ########################################################################

-- 1. TOP 5 PRODUCTOS MÁS VENDIDOS POR CANTIDAD DE UNIDADES
-- Muestra qué productos se han vendido más en términos de unidades totales.
SELECT
    pr.nombre_producto,
    pr.categoria,
    SUM(pd.cantidad) AS unidades_totales_vendidas
FROM Pedidos_Detalle pd
JOIN Productos pr ON pd.id_producto = pr.id_producto
GROUP BY pr.nombre_producto, pr.categoria
ORDER BY unidades_totales_vendidas DESC
LIMIT 5;

---

-- 2. TOP 5 CLIENTES POR VALOR TOTAL DE COMPRAS
-- Identifica a los clientes que han generado el mayor ingreso total.
SELECT
    c.nombre_cliente,
    c.email,
    SUM(p.total_pedido) AS gasto_total
FROM Pedidos p
JOIN Clientes c ON p.id_cliente = c.id_cliente
GROUP BY c.nombre_cliente, c.email
ORDER BY gasto_total DESC
LIMIT 5;

---

-- 3. TOTAL DE INGRESOS GENERADOS POR CATEGORÍA DE PRODUCTO
-- Ayuda a identificar las categorías de productos más rentables.
SELECT
    pr.categoria,
    SUM(pd.subtotal) AS ingresos_por_categoria,
    COUNT(DISTINCT pd.id_pedido) AS num_pedidos_afectados
FROM Pedidos_Detalle pd
JOIN Productos pr ON pd.id_producto = pr.id_producto
GROUP BY pr.categoria
ORDER BY ingresos_por_categoria DESC;

---

-- 4. DETALLE DE PEDIDOS MAYORES A UN VALOR ESPECÍFICO (Ej. $500.00)
-- Útil para auditar o dar seguimiento a pedidos de alto valor.
SELECT
    p.id_pedido,
    p.fecha_pedido,
    c.nombre_cliente,
    p.total_pedido,
    p.estado_pedido
FROM Pedidos p
JOIN Clientes c ON p.id_cliente = c.id_cliente
WHERE p.total_pedido > 500.00
ORDER BY p.total_pedido DESC;

---

-- 5. PRODUCTOS QUE NUNCA HAN SIDO VENDIDOS (Si los hubiera)
-- Requiere una unión externa (LEFT JOIN) para encontrar productos sin coincidencias en Pedidos_Detalle.
SELECT
    pr.id_producto,
    pr.nombre_producto,
    pr.categoria
FROM Productos pr
LEFT JOIN Pedidos_Detalle pd ON pr.id_producto = pd.id_producto
WHERE pd.id_producto IS NULL;

