USE RetailDB;
GO


-- Metodo 1:
-- Poblar la tabla Clientes proveniente de un archivo .json copiando toda su informacion
-- y colocando toda los registros dentro, para que la variable @json almacene esa informacion
-- y se luego se la pase a la tabla clientes

-- OBS: empleando este metodo, se debe ejcutar todo el bloque desde el declare hasta
-- el Insert, porque ejecutados por separada el proceso falla

DECLARE @jsonClientes NVARCHAR(MAX) = '
[
 { "Nombre": "Juan Pérez", "Email": "juan.perez@gmail.com", "FechaRegistro": "2026-01-15" },
 { "Nombre": "María López", "Email": "maria.lopez@hotmail.com", "FechaRegistro": "2026-02-10" },
 { "Nombre": "William Padilla", "Email": "william.padilla@hotmail.com", "FechaRegistro": "2026-01-02" },
 { "Nombre": "Roberto Guzman", "Email": "roberto.guzman@outlook.com", "FechaRegistro": "2026-04-13" },
 { "Nombre": "Andrea Martinez", "Email": "andrea.martinez@gmail.com", "FechaRegistro": "2026-03-05" },
 { "Nombre": "Christian Gutierrez", "Email": "christian.gutierrez@hotmail.com", "FechaRegistro": "2026-02-20" },
 { "Nombre": "Carmen Maldonado", "Email": "carmen.maldonado@gmail.com", "FechaRegistro": "2026-05-03" },
 { "Nombre": "Teresa Muñoz", "Email": "teresa.muñoz@outlook.com", "FechaRegistro": "2026-01-21" },
 { "Nombre": "Eduardo Ramos", "Email": "eduardo.ramos@outlook.com", "FechaRegistro": "2026-04-07" }
]
';

INSERT INTO Clientes (Nombre, Email, FechaRegistro)
SELECT Nombre, Email, FechaRegistro
FROM OPENJSON(@jsonClientes)
WITH (
    Nombre NVARCHAR(100),
    Email NVARCHAR(100),
    FechaRegistro DATE
);


-- Metodo 2:
-- Habilitar Ad Hoc Distributed Queries si no está activo
-- (solo una vez en el servidor)

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;

--Luego de que se haya habilitado Ad Hoc Distributed ahora si ejecutar todo el siguiente
--bloque hasta el insert

--PREVIO EL ARCHIVO JSON SI TIENE TILDES, CAMBIAR DE FORMATO A UTF-16 LE

DECLARE @jsonClientes NVARCHAR(MAX);

SELECT @jsonClientes = BulkColumn
FROM OPENROWSET(
    BULK 'D:\Proyecto Retail Data Pipeline End‑to‑End\clientes.json',
    SINGLE_NCLOB
) AS j;

INSERT INTO Clientes (Nombre, Email, FechaRegistro)
SELECT Nombre, Email, FechaRegistro
FROM OPENJSON(@jsonClientes)
WITH (
    Nombre NVARCHAR(100),
    Email NVARCHAR(100),
    FechaRegistro DATE
);

--DELETE FROM Clientes;

--DE ESTA FORMA "DBCC CHECKIDENT" PODRE VOLVER A INICIAR EL CODIGO DE CLIENTEID DESDE 1

DBCC CHECKIDENT ('Clientes', RESEED, 0);

--- VALIDAR DATA INGRESADA
SELECT * FROM Clientes;