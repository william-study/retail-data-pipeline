USE RetailDB;
GO

--Crearemos una tabla temporal porque la tabla original tiene 4 columnas
--una de ellas es identity, es decir se autogenera, no es necesario ingresar datos
--pero para la lectura del csv mediante BULK INSERT se requiere que la tabla origen
--contenga la misma cantidad de columnas que la tabla destino y eso no ocurrira
--porque el archivo csv tiene 3 columnas y la tabla productos tiene 4
--por lo tanto se creara la temporal, luego esa temporal cargara la oficial destino
--Productos

--la tabla productos al ser cargada muchas veces, el identity ha avanzado muchas
--veces y lo ideal es que empiece desde 1

--DBCC CHECKIDENT ('Productos', RESEED, 0);

CREATE TABLE Productos_TEMP(
    Nombre NVARCHAR(100),
    Categoria NVARCHAR(50),
    Precio DECIMAL(10, 2)
); 


--Se inserta la data a la tabla productos, esta informacion
--proviene de una archivo .csv
--La forma de insertar es la siguiente:

BULK INSERT Productos_TEMP
FROM 'D:\Proyecto Retail Data Pipeline End‑to‑End\productos.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001',
    TABLOCK
);

INSERT INTO Productos (Nombre, Categoria, Precio)
SELECT Nombre, Categoria, Precio
FROM Productos_TEMP;

DROP TABLE Productos_TEMP;

SELECT * FROM Productos;

