--DDL
--1) Crear una base de datos.
CREATE DATABASE PRACTICA

--2) Crear las siguientes tablas:
--a. Una tabla “Cuentas” con los siguientes campos:
-- ID : not null, AutoIncrement, primary key
-- Descripcion: varchar (50) not null
-- Saldo – decimal not null

USE PRACTICA
CREATE TABLE CUENTAS(
ID_CUENTA INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
DESCRIPCION VARCHAR(50) NOT NULL,
SALDO DECIMAL NOT NULL
)

--b. Una tabla “Transacciones” con los siguientes campos:
-- ID : not null, AutoIncrement, primary key
-- CuentaID : int, not null, foreing key
-- Monto : not null decimal
-- Fecha: DateTime not null
-- DescripcionMotivo: varchar(100)
USE PRACTICA
CREATE TABLE TRANSACCIONES(
ID_TRANSACCIONES INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
ID_CUENTA INT, 
MONTO DECIMAL NOT NULL,
DATE DATETIME NOT NULL,
DESCRIPCION_MOTIVO VARCHAR(100)
CONSTRAINT FK_ID_CUENTA
FOREIGN KEY (ID_CUENTA) 
REFERENCES CUENTAS(ID_CUENTA)
);


--3) Agregar una columna “Nombre” a la cuenta, del tipo varchar(50)
ALTER TABLE CUENTAS
ADD NOMBRE VARCHAR(50);

--4) Cambiar la longitud del campo varchar(50) a varchar(70)
ALTER TABLE CUENTAS
ALTER COLUMN NOMBRE VARCHAR(70);

--5) Eliminar la columna DescripcionMotivo de la tabla Transacciones
ALTER TABLE TRANSACCIONES 
DROP COLUMN DESCRIPCION_MOTIVO


--DML:
--1) INSERTAR 3 registros en la tabla “cuentas”


INSERT INTO CUENTAS( DESCRIPCION, SALDO, NOMBRE)
VALUES ( 'Cuenta Ahorro', '1500.00', 'CHESTER BENINGTON');

INSERT INTO CUENTAS ( DESCRIPCION, SALDO, NOMBRE)
VALUES ( 'Cuenta Ahorro', '1700000.00', 'DARREN HAYES');

INSERT INTO CUENTAS ( DESCRIPCION, SALDO, NOMBRE)
VALUES ( 'Cuenta Ahorro', '28000.00', 'Emily Armstrong');

--2) MODIFICAR El campo descripción cuya cuenta tiene ID = 1

UPDATE CUENTAS
SET Descripcion = 'MODIFICACION 1'
WHERE ID_CUENTA = 1; 

--3) ELIMINAR la cuenta cuyo id es 3

DELETE FROM CUENTAS
WHERE ID_CUENTA= 3