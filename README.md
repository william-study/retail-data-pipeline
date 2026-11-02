# Retail Data Pipeline (Bronze–Silver–Gold)

## 📌 Introducción
Este proyecto implementa un **pipeline de datos end-to-end** para un caso de retail, siguiendo la arquitectura **Lakehouse** en Azure Databricks.  
El objetivo es demostrar habilidades en **ingesta, transformación, almacenamiento y visualización** de datos usando capas **Bronze, Silver y Gold**.

---

## 🗂️ Fases del proyecto

### 1. Preparación del entorno
- Azure Databricks (cuenta gratuita)
- SQL Server Express / PostgreSQL en Docker
- VS Code con extensión MSSQL
- GitHub para versionar el proyecto
- Power BI para visualización
- Airflow en Docker (pendiente de integración)

### 2. Ingesta de datos (Bronze Layer)
- Archivos fuente: `clientes.json`, `ventas.json`, `productos.csv`
- Cargados en tablas Delta dentro del catálogo `retail_catalog.bronze`

### 3. Transformación (Silver Layer)
- Limpieza y normalización de datos con PySpark:
  - **Clientes Silver**: eliminación de duplicados, último registro por fecha, correos válidos.
  - **Productos Silver**: precios > 0 y nombres no nulos.
  - **Ventas Silver**: integridad referencial con clientes y productos, cálculo de columna `Total`.
- Pruebas locales con **pandas** (pendiente).

### 4. Orquestación
- **Airflow (Docker)**: DAG para automatizar Bronze → Silver → Gold (pendiente).
- **Azure Data Factory**: pipeline de integración con Databricks (pendiente).

### 5. Almacenamiento (Gold Layer)
- Tablas finales listas para consumo:
  - `ventas_categoria`: ventas agregadas por categoría.
  - `top_clientes`: clientes con mayor gasto.
  - `productos_mas_vendidos`: productos más vendidos por cantidad.

### 6. Visualización y análisis
- Conexión de Power BI a Databricks (pendiente).
- Dashboards con KPIs: ventas por categoría, top clientes, productos más vendidos.

### 7. Control de versiones y documentación
- Repositorio GitHub con notebooks, datos y documentación.
- Este README describe cada fase y resultados.

---

## 📊 Resultados Gold
Ejemplos de métricas generadas:

![Ventas por categoría](Ventas%20por%20categoría.PNG)
![Top clientes](Top%20clientes%20por%20gasto.PNG)
![Productos más vendidos](Productos%20más%20vendidos.PNG)

---

## 🚀 Próximos pasos
- Completar pruebas locales con pandas.  
- Implementar DAG en Airflow y pipeline en Data Factory.  
- Crear dashboards en Power BI.  
- Documentar todo en GitHub con screenshots.

---

## 👨‍💻 Autor
**William** – Proyecto de práctica para Data Engineer Junior.  
Objetivo: demostrar experiencia práctica en pipelines de datos y Lakehouse.  
# retail-data-pipeline
