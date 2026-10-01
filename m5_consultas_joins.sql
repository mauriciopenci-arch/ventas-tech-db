-- ============================================================================
-- PRE-ENTREGA MÓDULO 5: CONSULTAS CON JOINs Y UNION ALL
-- Base de Datos: Ventas_Tech_DB
-- ============================================================================

-- ----------------------------------------------------------------------------
-- CONSULTA 1: Vista base del proyecto (INNER JOIN)
-- Combina la tabla de hechos (ventas) con sus dimensiones descriptivas
-- (clientes, productos y categorias) para generar la vista enriquecida.
-- ----------------------------------------------------------------------------
SELECT 
    v.fecha_venta,
    v.id_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta ASC;


-- ----------------------------------------------------------------------------
-- CONSULTA 2: Clientes sin ventas (LEFT JOIN)
-- Identifica los clientes registrados en la base de datos que no han realizado compras.
-- ----------------------------------------------------------------------------
SELECT 
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


-- ----------------------------------------------------------------------------
-- CONSULTA 3: Productos sin ventas (LEFT JOIN)
-- Identifica productos del catálogo que no registran ninguna transacción de venta.
-- ----------------------------------------------------------------------------
SELECT 
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;


-- ----------------------------------------------------------------------------
-- CONSULTA 4: Consolidado por canal (UNION ALL)
-- Clasifica las ventas en canales simulados ('Online' para compras de bajo volumen
-- <= 2 unidades, y 'Presencial' o 'Mayorista' para compras de volumen > 2 unidades)
-- utilizando UNION ALL, finalizando con la consolidación agrupada por canal.
-- ----------------------------------------------------------------------------
WITH ventas_con_canal AS (
    -- Subconsulta 1: Canal Online
    SELECT 
        id_venta,
        fecha_venta,
        (cantidad * precio_unitario) AS total,
        'Online' AS canal
    FROM ventas
    WHERE cantidad <= 2

    UNION ALL

    -- Subconsulta 2: Canal Presencial
    SELECT 
        id_venta,
        fecha_venta,
        (cantidad * precio_unitario) AS total,
        'Presencial' AS canal
    FROM ventas
    WHERE cantidad > 2
)
SELECT 
    canal,
    COUNT(*) AS total_transacciones,
    SUM(total) AS total_facturado
FROM ventas_con_canal
GROUP BY canal;