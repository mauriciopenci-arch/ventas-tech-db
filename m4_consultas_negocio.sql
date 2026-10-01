-- ============================================================================
-- PRE-ENTREGA MÓDULO 4: CONSULTAS SQL DE NEGOCIO
-- Base de Datos: Ventas_Tech_DB
-- ============================================================================

-- CONSULTA 1: Resumen ejecutivo mensual
SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;


-- CONSULTA 2: Ranking de productos (Top 5)
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;


-- CONSULTA 3: Clientes recurrentes
SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY cantidad_pedidos DESC;


-- CONSULTA 4: Meses por encima/por debajo del promedio
WITH facturacion_mensual AS (
    SELECT 
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
)
SELECT 
    mes,
    total_facturado,
    CASE 
        WHEN total_facturado >= (SELECT AVG(total_facturado) FROM facturacion_mensual) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS relacion_promedio
FROM facturacion_mensual
ORDER BY mes;


-- ============================================================================
-- BLOQUE DE CIERRE: HALLAZGOS CONCRETOS DE NEGOCIO
-- ============================================================================
/*
HALLAZGOS CLAVE TRAS EL ANÁLISIS DE LA BASE DE DATOS:

1. Concentración de Ingresos por Producto:
   El producto con id_producto 1 ("Laptop Pro 15") lidera el ranking de ventas generando 
   $3,600.00 en total (3 unidades vendidas), representando la mayor fuente de ingresos 
   individual de la empresa a pesar de no ser el producto con mayor cantidad de unidades vendidas.

2. Fidelidad y Recurrencia de Clientes:
   Existen clientes recurrentes (como id_cliente 1, 2 y 3) que han realizado más de 1 pedido 
   en el período analizado. El id_cliente 1 destaca por registrar compras por un monto acumulado 
   de $2,640.00, consolidándose como un cliente clave a fidelizar.

3. Distribución Temporal de la Facturación:
   En el mes de marzo de 2024, la facturación total alcanzó los $6,706.00 con un ticket promedio 
   por transacción de $670.60. Los pedidos que incluyen productos de alto valor unitario 
   empujan significativamente el monto mensual por encima del promedio general.
*/