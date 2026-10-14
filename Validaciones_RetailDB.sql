USE RetailDB;
GO

--Cantidad de registros en de las diversas tablas

WITH 
Cant_Regis AS (
    SELECT COUNT(*) AS CANT_CLIENTES
    FROM Clientes
),
Cant_Prod AS (
    SELECT COUNT(*) AS CANT_PRODUCTOS
    FROM Productos
),
Cant_Vent AS (
    SELECT COUNT(*) AS CANT_VENTAS
    FROM Ventas
)

SELECT  CANT_CLIENTES,
        CANT_PRODUCTOS,
        CANT_VENTAS
FROM Cant_Regis, Cant_Prod, Cant_Vent

--optimizado sin with:

SELECT 
    (SELECT COUNT(*) FROM Clientes)   AS CANT_CLIENTES,
    (SELECT COUNT(*) FROM Productos)  AS CANT_PRODUCTOS,
    (SELECT COUNT(*) FROM Ventas)     AS CANT_VENTAS;


--forma de mostrar las cantidades de registro por tabla

SELECT 'Clientes' AS 'Tabla', COUNT(*) AS 'CANTIDAD' FROM Clientes
UNION ALL
SELECT 'Productos' AS 'Tabla', COUNT(*) AS 'CANTIDAD' FROM Productos
UNION ALL
SELECT 'Ventas' AS 'Tabla', COUNT(*) AS 'CANTIDAD' FROM Ventas

--forma optimizada

SELECT v.Tabla, v.Cantidad
FROM (
    VALUES 
        ('Clientes',  (SELECT COUNT(*) FROM Clientes)),
        ('Productos', (SELECT COUNT(*) FROM Productos)),
        ('Ventas',    (SELECT COUNT(*) FROM Ventas))
) AS v(Tabla, Cantidad);


--Calcular cuantos productos  

SELECT DISTINCT P.Nombre, V.ProductoID 
FROM Ventas V INNER JOIN Productos P ON V.ProductoID = P.ProductoID

--CALCULAR CUANTOS PRODUCTOS COMPRO CADA CLIENTE

SELECT 
C.Nombre AS CLIENTE,
COUNT(V.FechaVenta) AS DIAS_COMPRA,
SUM(V.Cantidad) AS CANT_PROD,
SUM(V.Cantidad * P.Precio) AS PAGO_TOTAL
FROM Clientes C INNER JOIN Ventas V ON C.ClienteID = V.ClienteID 
INNER JOIN Productos P ON V.ProductoID = P.ProductoID
GROUP BY C.Nombre
ORDER BY C.Nombre