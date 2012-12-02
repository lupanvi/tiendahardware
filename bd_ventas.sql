create database BD_Ventas;
go

use BD_Ventas;
go

/*
use master;
go

drop database BD_Ventas;
go
*/


/* TABLA DOMINIO */
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE TB_Dominio(
	Pk_eDominio integer IDENTITY ( 1,1 ) not null,
	cTipo varchar(50) not null,
	cDescripcion varchar(100) not null,
	
	CONSTRAINT Pk_eDominio PRIMARY KEY CLUSTERED 
	(Pk_eDominio ASC) 
	
	WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
	IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY];

GO
SET ANSI_NULLS ON
GO


/* TABLA PRODUCTO*/

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE TB_Producto(
	Pk_eProducto integer IDENTITY ( 1,1 ) not null,
	Fk_eDominio integer not null,
	cDescripcion varchar(100) not null,
	dPrecio decimal not null,
	cEspecificacion varchar(200) null,
	bImagen varchar(100) null,
	
	CONSTRAINT Pk_eProducto PRIMARY KEY CLUSTERED 
	(Pk_eProducto ASC) 
	
	WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
	IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY];

GO
SET ANSI_NULLS ON
GO


ALTER TABLE TB_Producto
	ADD CONSTRAINT Fk_TB_Producto_TB_Dominio FOREIGN KEY (Fk_eDominio) REFERENCES TB_Dominio(Pk_eDominio);
	

/* TABLA ALMACEN */

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE TB_Almacen(
	Pk_eAlmacen integer IDENTITY ( 1,1 ) not null,
	cSucursal varchar(150) not null,
	cDireccion varchar(150) not null,
	
	CONSTRAINT Pk_eAlmacen PRIMARY KEY CLUSTERED 
	(Pk_eAlmacen ASC) 
	
	WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
	IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY];

GO
SET ANSI_NULLS ON
GO

/* TABLA STOCK */

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE TB_Stock(
	Pk_eStock integer IDENTITY ( 1,1 ) not null,
	Fk_eProducto integer not null,
	Fk_eAlmacen integer not null,
	eStockActual integer not null,
	eStockMinimo integer null,
	
	CONSTRAINT Pk_eStock PRIMARY KEY CLUSTERED 
	(Pk_eStock ASC) 
	
	WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
	IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY];

GO
SET ANSI_NULLS ON
GO

ALTER TABLE TB_Stock
	ADD CONSTRAINT TB_Stock_TB_Producto FOREIGN KEY (Fk_eProducto) REFERENCES TB_Producto(Pk_eProducto);
	
ALTER TABLE TB_Stock
	ADD CONSTRAINT TB_Stock_TB_Almacen FOREIGN KEY (Fk_eAlmacen) REFERENCES TB_Almacen(Pk_eAlmacen);





/* TABLA CLIENTE */

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE TB_Cliente(
	Pk_eCliente integer IDENTITY ( 1,1 ) not null,
	cTelefono varchar(10) not null,
	cDireccion varchar(10) not null,
	cTipCliente varchar(3) not null,
	dFecRegistro datetime not null,
	
	CONSTRAINT Pk_eCliente PRIMARY KEY CLUSTERED 
	(Pk_eCliente ASC) 
	
	WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
	IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY];

GO
SET ANSI_NULLS ON
GO

/* TABLA PERSONA NATURAL */

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE TB_PersonaNatural(
	Pk_ePerNatural integer IDENTITY ( 1,1 ) not null,
	Fk_eCliente integer,
	cDNI varchar(10) not null,
	cNombres varchar(50) not null,
	cApellidos varchar(50) not null,

	CONSTRAINT Pk_ePerNatural PRIMARY KEY CLUSTERED 
	(Pk_ePerNatural ASC) 
	
	WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
	IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY];

GO
SET ANSI_NULLS ON
GO

ALTER TABLE TB_PersonaNatural
	ADD CONSTRAINT TB_PersonaNatural_TB_Cliente FOREIGN KEY (Fk_eCliente) REFERENCES TB_Cliente(Pk_eCliente);


/* TABLA PERSONA JURIDICA */

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE TB_PersonaJuridica(
	Pk_ePerJuridica integer IDENTITY ( 1,1 ) not null,
	Fk_eCliente integer,
	cRuc varchar(10) not null,
	cRazSocial varchar(100) not null,


	CONSTRAINT Pk_ePerJuridica PRIMARY KEY CLUSTERED 
	(Pk_ePerJuridica ASC) 
	
	WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
	IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY];

GO
SET ANSI_NULLS ON
GO

ALTER TABLE TB_PersonaJuridica
	ADD CONSTRAINT TB_PersonaJuridica_TB_Cliente FOREIGN KEY (Fk_eCliente) REFERENCES TB_Cliente(Pk_eCliente);


/* TABLA USUARIO */

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE TB_Usuario(
	Pk_eUsuario integer IDENTITY ( 1,1 ) not null,
	Fk_eCliente integer null,
	cUsuario varchar(50) not null,
	cContrasena varchar(50) not null,
	dFecRegistro datetime not null,

	CONSTRAINT Pk_eUsuario PRIMARY KEY CLUSTERED 
	(Pk_eUsuario ASC) 
	
	WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
	IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY];

GO
SET ANSI_NULLS ON
GO

ALTER TABLE TB_Usuario
	ADD CONSTRAINT TB_Usuario_TB_Cliente FOREIGN KEY (Fk_eCliente) REFERENCES TB_Cliente(Pk_eCliente);

/* 
http://www.pccomponentes.com/impresoras.html
*/



-- INSERT TABLA DOMINIO

INSERT INTO TB_Dominio(cTipo, cDescripcion) VALUES ('MON', 'Monitor LED');
INSERT INTO TB_Dominio(cTipo, cDescripcion) VALUES ('MON', 'Monitor LED IPS');
INSERT INTO TB_Dominio(cTipo, cDescripcion) VALUES ('MON', 'Monitor LCD');
INSERT INTO TB_Dominio(cTipo, cDescripcion) VALUES ('TEC', 'Teclado con Cable');
INSERT INTO TB_Dominio(cTipo, cDescripcion) VALUES ('TEC', 'Teclado Inalambrico');
INSERT INTO TB_Dominio(cTipo, cDescripcion) VALUES ('TEC', 'Teclado Gaming');
INSERT INTO TB_Dominio(cTipo, cDescripcion) VALUES ('TEC', 'Teclado Mediacenter');
INSERT INTO TB_Dominio(cTipo, cDescripcion) VALUES ('IMP', 'Impresoras');
INSERT INTO TB_Dominio(cTipo, cDescripcion) VALUES ('ALT', 'Altavoz');
INSERT INTO TB_Dominio(cTipo, cDescripcion) VALUES ('CAM', 'Camara Web');
INSERT INTO TB_Dominio(cTipo, cDescripcion) VALUES ('AUD', 'Audifono');
INSERT INTO TB_Dominio(cTipo, cDescripcion) VALUES ('ESC', 'Escaners');

-- INSERT TABLA PRODUCTO
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (1,'Asus VH168D 15.6"', 55.5, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (1,'Samsung LS19B150NS 18.5"', 45.6, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (1,'Asus VS197D 18.5"', 79.95, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (1,'LG E1942C 19"', 84.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (1,'HP W1972A 18.5"', 85.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (1,'Samsung S22B150N 21.5"', 99.95, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (2,'Asus VS229H 21.5"', 125.9, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (2,'BenQ G2320HDBL 23"', 132.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (2,'LG IPS224V-BN 22"', 136.5, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (2,'Asus VS229HR 21.5"', 139.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (2,'Asus VS239H 23"', 149.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (4,'HP Standard Keyboard Teclado', 7.95, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (4,'Microsoft Wired Keyboard 200 Business Teclado', 9.25, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (4,'Teclado Flexible de Silicona USB Negro Teclado', 8.95, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (4,'Logitech Keyboard K120 Teclado', 9.95, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (10,'Soyntec Inpput Combo 350 Yellow', 14.95, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (10,'Logitech Wireless Keyboard K230', 15.5, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (10,'TVisto Bluetooth Keyboard', 16.75, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (10,'Microsoft Wireless Desktop 800 ', 21.95, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (10,'Logitech Wireless Keyboard K360 Flower Versión Inglesa', 27, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (8,'Creative Live! Cam Sync Negra', 13.25, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (8,'Logitech HD Webcam C270 Rosa', 27, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (8,'Logitech Webcam C170', 16.75, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (8,'Hercules HD Twist Negro', 24.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (8,'Trust eLight Full HD 1080p', 30.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (8,'Creative Live! Cam Chat HD', 55.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (5,'Samsung ML-2160 Láser Monocromo', 25.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (5,'HP Deskjet 3000 WiFi', 68.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (5,'Brother HL-2135W Láser Monocromo W', 74.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (5,'HP Officejet Pro 8100 ePrint WiFi', 130.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (7,'Mini Altavoz portátil Negro', 7.25, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (7,'Genius SP-U115 1.5W RMS Negro', 7.95, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (7,'Mini Altavoz Cápsula Amarillo', 7.95, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (7,'QooPro Altavoces 2.0 USB Negro', 7.95, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (7,'B-Move 2.0 B-Blast 200 Blancos', 12.25, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (9,'B-Move Kit Auriculares Con Microfono ', 2.25, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (9,'QooPro Auriculares Botón con manos Libres', 2.95, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (9,'Soyntec Netsound 270', 5.25, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (9,'Phoenix Stereo Ergonomic Urban Earphones', 5.50, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (9,'Star Auricular Plegable Rojo', 8.95, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (13,'Canon CanoScan LiDE 110', 64.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (13,'IRIScan Book 2 Escaner Portátil ', 79.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (13,'Unotec Kadok Conversor digital de diapositivas', 79.95, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (13,'Canon CanoScan LiDE 210',80.00, NULL,NULL);
INSERT INTO TB_Producto (Fk_eDominio,cDescripcion,dPrecio,bImagen,cEspecificacion) VALUES (13,'Fujitsu ScanSnap S1500 Escaner Documental', 465, NULL,NULL);
