--1-Muestra los clientes ordenados alfabéticamente por el nombre de la compañía.
select *from Customers order by CompanyName ASC;

--2-Mostrar todos los clientes que su nombre empieza con “s”
SELECT *FROM Customers WHERE CompanyName LIKE 'S%';

--3-Encuentra todos los productos cuyo precio unitario sea mayor de 50.

SELECT *FROM Products WHERE UnitPrice >50;


--4-Obtener cuantos productos “Discontinued” que hay.
SELECT *FROM Products WHERE Discontinued = 1;

--5) Obtener el producto de mayor valor unitario
SELECT MAX(UnitPrice) AS MayorPrecioUnitario FROM Products ;

--6)  Obtener el producto de mayor valor unitario y el nombre del producto: (subquery)

SELECT *FROM Products WHERE UnitPrice= (SELECT MAX (UnitPrice) FROM Products);

--7) Obtén una lista de todos los productos con su respectivo nombre de categoría. INNER JOIN
SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN Categories c
    ON p.CategoryID = c.CategoryID;

--8)Obtener todos los clientes junto con los detalles de los pedidos que han realizado.
--Si un cliente no ha realizado ningún pedido, aún debe aparecer en el resultado con los 
--detalles del pedido como NULL. LEFT JOIN
SELECT 
    C.CustomerID,
    C.CompanyName,
    C.ContactName,
    O.OrderID,
    O.OrderDate,
    O.ShipName,
    OD.ProductID,
    OD.UnitPrice,
    OD.Quantity,
    OD.Discount
FROM dbo.Customers C
LEFT JOIN dbo.Orders O
    ON C.CustomerID = O.CustomerID
LEFT JOIN dbo.[Order Details] OD
    ON O.OrderID = OD.OrderID
ORDER BY C.CustomerID, O.OrderID;

--9) Encuentra el número total de órdenes realizadas por cada cliente.
SELECT 
    C.CustomerID,
    C.CompanyName,
    COUNT(O.OrderID) AS TotalOrders
FROM dbo.Customers C
LEFT JOIN dbo.Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName
ORDER BY TotalOrders DESC;

--10)Encontrar los proveedores que han suministrado más de 3 productos. Primero, agrupamos los productos por proveedor y contamos el número de productos suministrados por cada proveedor. Luego, usamos HAVING para filtrar solo aquellos proveedores que han suministrado más de 3 productos.
SELECT 
    S.SupplierID,
    S.CompanyName,
    COUNT(P.ProductID) AS TotalProducts
FROM dbo.Suppliers S
INNER JOIN dbo.Products P
    ON S.SupplierID = P.SupplierID
GROUP BY S.SupplierID, S.CompanyName
HAVING COUNT(P.ProductID) > 3
ORDER BY TotalProducts DESC;

--11)Realizar un procedimiento almacenado que devuelva los clientes (Customers) según el país (Country).
Use Northwind;
GO
CREATE PROCEDURE GetCustomersByCountry
    @Country NVARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        CustomerID,
        CompanyName,
        ContactName,
        ContactTitle,
        Address,
        City,
        Region,
        PostalCode,
        Country,
        Phone,
        Fax
    FROM dbo.Customers
    WHERE Country = @Country;
END;
GO

EXEC GetCustomersByCountry @Country = 'Italy';
