# RetailPro - Analytics & Data Modeling Solution

## 📌 Descripción del Proyecto
RetailPro es una solución de Inteligencia de Negocios diseñada para consolidar transacciones comerciales, analizar ventas por canal y monitorear el crecimiento interanual mediante modelado multidimensional.

## 🛠️ Herramientas Utilizadas
- **SQL (PostgreSQL / SQL Server):** Consultas avanzadas con INNER JOINs, LEFT JOINs, CTEs y agregaciones (GROUP BY, HAVING).
- **Power BI Desktop:** Modelado de datos en esquema en estrella.
- **DAX (Data Analysis Expressions):** Creación de KPIs y Time Intelligence.

## 📐 Estructura del Modelo
- **Tabla de Hechos:** `Fact_Ventas` (ventas)
- **Tablas de Dimensiones:** `Dim_Clientes`, `Dim_Productos`, `Dim_Categorias`, `Dim_Fechas`
- **Contenedor Especializado:** `_Medidas` (contiene la totalidad de las medidas DAX calculadas)

## 🚀 Instrucciones de Ejecución
1. Ejecutar los scripts contenidos en `/SQL/m4_consultas_negocio.sql` y `/SQL/m5_consultas_joins.sql`.
2. Abrir el archivo `Penci_Mauricio_Checkpoint2.pbix` en Power BI Desktop.
3. Verificar las relaciones activas (1:N) en la Vista de Modelo.
