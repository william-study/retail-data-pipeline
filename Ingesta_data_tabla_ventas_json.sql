USE RetailDB;
GO

--Emplearemos el segundo metodo como cuando cargamos en la tabla clientes
--el archivo json

DECLARE @jsonVentas NVARCHAR(MAX);

SELECT @jsonVentas = BulkColumn
FROM OPENROWSET(
    BULK 'D:\Proyecto Retail Data Pipeline End‑to‑End\ventas.json',
    SINGLE_NCLOB
) AS j;

INSERT INTO Ventas (ClienteID, Cantidad, PrecioVenta, FechaVenta, ProductoID)
SELECT ClienteID, Cantidad, PrecioVenta, FechaVenta, ProductoID
FROM OPENJSON(@jsonVentas)
WITH (
    ClienteID INT,
    Cantidad INT,
    PrecioVenta DECIMAL(10, 2),
    FechaVenta DATE,
    ProductoID INT
);

--DELETE FROM Clientes;

--DE ESTA FORMA "DBCC CHECKIDENT" PODRE VOLVER A INICIAR EL CODIGO DE CLIENTEID DESDE 1

--DBCC CHECKIDENT ('Ventas', RESEED, 0);

--DELETE FROM Ventas;

--- VALIDAR DATA INGRESADA
SELECT * FROM Ventas;