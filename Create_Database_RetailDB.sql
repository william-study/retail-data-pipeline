USE RetailDB;
GO

--tabla de clientes

CREATE TABLE Clientes(
    ClienteID INT PRIMARY KEY IDENTITY(1, 1),
    Nombre NVARCHAR(100),
    Email NVARCHAR(100),
    FechaRegistro DATE
);

--tabla de ventas

CREATE TABLE Ventas(
    VentaID INT PRIMARY KEY IDENTITY(1, 1),
    ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
    Producto NVARCHAR(100),
    Cantidad INT,
    Precio DECIMAL(10, 2),
    FechaVenta DATE
);

--tabla de productos

CREATE TABLE Productos(
    ProductoID INT PRIMARY KEY IDENTITY(1, 1),
    Nombre NVARCHAR(100),
    Categoria NVARCHAR(50),
    Precio DECIMAL(10, 2)
);


--alteracion de la tabla ventas, agregacion de llave foranea ProductoID

ALTER TABLE Ventas
DROP COLUMN Producto;

ALTER TABLE Ventas
ADD ProductoID INT;

ALTER TABLE Ventas
ADD CONSTRAINT FK_Ventas_Productos
FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID);


--para modificar el nombre de la columna precio por precioventas
EXEC sp_rename 'Ventas.Precio', 'PrecioVenta', 'COLUMN';
--