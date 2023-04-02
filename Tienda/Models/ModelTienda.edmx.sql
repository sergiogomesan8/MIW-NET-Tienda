
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 03/21/2023 18:57:12
-- Generated from EDMX file: C:\Users\sergi\source\repos\Tienda\Tienda\Models\ModelTienda.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [TiendaP];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Pedidos]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Pedidos];
GO
IF OBJECT_ID(N'[dbo].[Productos]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Productos];
GO
IF OBJECT_ID(N'[dbo].[Stocks]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Stocks];
GO
IF OBJECT_ID(N'[dbo].[Ventas]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Ventas];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Pedidos'
CREATE TABLE [dbo].[Pedidos] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Importe] float  NOT NULL,
    [NombreCliente] nchar(20)  NOT NULL,
    [FechaCompra] datetime  NOT NULL
);
GO

-- Creating table 'Productos'
CREATE TABLE [dbo].[Productos] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Nombre] nchar(20)  NOT NULL,
    [Descripcion] nchar(50)  NOT NULL,
    [Cantidad] int  NOT NULL,
    [Precio] float  NOT NULL,
    [Imagen] nchar(100)  NOT NULL
);
GO

-- Creating table 'Stocks'
CREATE TABLE [dbo].[Stocks] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [ReStock] bit  NOT NULL,
    [ProductoId] int  NOT NULL,
    [Producto_Id] int  NOT NULL
);
GO

-- Creating table 'Ventas'
CREATE TABLE [dbo].[Ventas] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Cantidad] int  NOT NULL,
    [PedidoId] nchar(20)  NOT NULL,
    [ProductoId] nchar(20)  NOT NULL,
    [Pedido_Id] int  NOT NULL,
    [Producto_Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Pedidos'
ALTER TABLE [dbo].[Pedidos]
ADD CONSTRAINT [PK_Pedidos]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Productos'
ALTER TABLE [dbo].[Productos]
ADD CONSTRAINT [PK_Productos]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Stocks'
ALTER TABLE [dbo].[Stocks]
ADD CONSTRAINT [PK_Stocks]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Ventas'
ALTER TABLE [dbo].[Ventas]
ADD CONSTRAINT [PK_Ventas]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Pedido_Id] in table 'Ventas'
ALTER TABLE [dbo].[Ventas]
ADD CONSTRAINT [FK_PedidoVenta]
    FOREIGN KEY ([Pedido_Id])
    REFERENCES [dbo].[Pedidos]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PedidoVenta'
CREATE INDEX [IX_FK_PedidoVenta]
ON [dbo].[Ventas]
    ([Pedido_Id]);
GO

-- Creating foreign key on [Producto_Id] in table 'Ventas'
ALTER TABLE [dbo].[Ventas]
ADD CONSTRAINT [FK_ProductoVenta]
    FOREIGN KEY ([Producto_Id])
    REFERENCES [dbo].[Productos]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductoVenta'
CREATE INDEX [IX_FK_ProductoVenta]
ON [dbo].[Ventas]
    ([Producto_Id]);
GO

-- Creating foreign key on [Producto_Id] in table 'Stocks'
ALTER TABLE [dbo].[Stocks]
ADD CONSTRAINT [FK_ProductoStock]
    FOREIGN KEY ([Producto_Id])
    REFERENCES [dbo].[Productos]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductoStock'
CREATE INDEX [IX_FK_ProductoStock]
ON [dbo].[Stocks]
    ([Producto_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------