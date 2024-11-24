USE MASTER; 
GO

DROP DATABASE IF EXISTS bdPrototipoPTC
GO

CREATE DATABASE bdPrototipoPTC
GO

USE bdPrototipoPTC
GO

CREATE TABLE TbTiposUsuario(
idTipoUsuario INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
TipoUsuario VARCHAR(20) NOT NULL
);

INSERT INTO TbTiposUsuario VALUES
('Root'),
('Administrador'),
('Base');

CREATE TABLE TbEstadosUsuario(
idEstadoUsuario INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
EstadoUsuario VARCHAR(20)
);

INSERT INTO TbEstadosUsuario VALUES
('Activo'),
('Inactivo'),
('Bloqueado');

SELECT * FROM TbEstadosUsuario;

CREATE TABLE TbUsuarios(
idUsuarios INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Usuario VARCHAR(50) NOT NULL,
Clave VARCHAR(100) NOT NULL,
Ping INT NULL,
FechaCreacion DATE DEFAULT GETDATE() NOT NULL,
idTipoUsuario INT CONSTRAINT fk_TipoDeUsuarioDeUsuario FOREIGN KEY REFERENCES TbTiposUsuario(IdTipoUsuario) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
idEstadoUsuario INT CONSTRAINT fk_EstadoDeUsuarioDeUsuario FOREIGN KEY REFERENCES TbEstadosUsuario(idEstadoUsuario) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL
);

SELECT * FROM TbUsuarios;

SELECT u.Usuario, tu.TipoUsuario, eu.EstadoUsuario FROM TbUsuarios u INNER JOIN TbTiposUsuario tu ON tu.idTipoUsuario = u.idTipoUsuario INNER JOIN TbEstadosUsuario eu ON eu.idEstadoUsuario = u.idEstadoUsuario;

CREATE TABLE TbPaises(
idPais INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Pais VARCHAR(60) NOT NULL
);

INSERT INTO TbPaises(Pais) VALUES
('Afganistán'),
('Burkina Faso'),
('Albania'),
('Alemania'),
('Andorra'),
('Angola'),
('Antigua y Barbuda'),
('Arabia Saudita'),
('Argelia'),
('Argentina'),
('Armenia'),
('Australia'),
('Austria'),
('Azerbaiyán'),
('Bahamas'),
('Bangladés'),
('Barbados'),
('Baréin'),
('Bélgica'),
('Belice'),
('Benín'),
('Bielorrusia'),
('Birmania'),
('Bolivia'),
('Bosnia y Herzegovina'),
('Botsuana'),
('Brasil'),
('Brunei'),
('Bulgaria'),
('Burundi'),
('Bután'),
('Cabo Verde'),
('Camboya'),
('Camerún'),
('Canadá'),
('Catar'),
('Chad'),
('Chile'),
('China'),
('Chipre'),
('Ciudad del Vaticano'),
('Colombia'),
('Comoras'),
('Corea del Norte'),
('Corea del Sur'),
('Costa de Marfil'),
('Costa Rica'),
('Croacia'),
('Cuba'),
('Dinamarca'),
('Dominica'),
('Ecuador'),
('Egipto'),
('El Salvador'),
('Emiratos Arabes Unidos'),
('Eritrea'),
('Eslovaquia'),
('Eslovenia'),
('España'),
('Estados Unidos'),
('Estonia'),
('Etiopía'),
('Filipinas'),
('Finlandia'),
('Fiyi'),
('Francia'),
('Gabón'),
('Gambia'),
('Georgia'),
('Ghana'),
('Granada'),
('Grecia'),
('Guatemala'),
('Guinea'),
('Guinea Ecuatorial'),
('Guinea-Bisáu'),
('Guyana'),
('Haití'),
('Honduras'),
('Hungría'),
('India'),
('Indonesia'),
('Irak'),
('Irán'),
('Irlanda'),
('Islandia'),
('Islas Marshall'),
('Islas Salomon'),
('Israel'),
('Italia'),
('Jamaica'),
('Japón'),
('Jordania'),
('Kazajistán'),
('Kenia'),
('Kirguistán'),
('Kiribati'),
('Kuwait'),
('Laos'),
('Lesoto'),
('Letonia'),
('Líbano'),
('Liberia'),
('Libia'),
('Liechtenstein'),
('Lituania'),
('Luxemburgo'),
('Macedonia del Norte'),
('Madagascar'),
('Malasia'),
('Malaui'),
('Maldivas'),
('Malí'),
('Malta'),
('Marruecos'),
('Mauricio'),
('Mauritania'),
('México'),
('Micronesia'),
('Moldavia'),
('Mónaco'),
('Mongolia'),
('Montenegro'),
('Mozambique'),
('Namibia'),
('Nauru'),
('Nepal'),
('Nicaragua'),
('Níger'),
('Nigeria'),
('Noruega'),
('Nueva Zelanda'),
('Omán'),
('Países Bajos'),
('Pakistán'),
('Palaos'),
('Panamá'),
('Papúa Nueva Guinea'),
('Paraguay'),
('Perú'),
('Polonia'),
('Portugal'),
('Reino Unido'),
('República Centroafricana'),
('República Checa'),
('República del Congo'),
('República Democrática del Congo'),
('República Dominicana'),
('Ruanda'),
('Rumanía'),
('Rusia'),
('Samoa'),
('San Cristobal y Nieves'),
('San Marino'),
('San Vicente y las Granadinas'),
('Santa Lucía'),
('Santo Tomé y Principe'),
('Senegal'),
('Serbia'),
('Seychelles'),
('Sierra Leona'),
('Singapur'),
('Siria'),
('Somalia'),
('Sri Lanka'),
('Suazilandia'),
('Sudáfrica'),
('Sudán'),
('Sudán del Sur'),
('Suecia'),
('Suiza'),
('Surinam'),
('Tailandia'),
('Tanzania'),
('Tayikistán'),
('Timor Oriental'),
('Togo'),
('Tonga'),
('Trinidad y Tobago'),
('Túnez'),
('Turkmenistán'),
('Turquía'),
('Tuvalu'),
('Ucrania'),
('Uganda'),
('Uruguay'),
('Uzbekistán'),
('Vanuatu'),
('Venezuela'),
('Vietnam'),
('Yemen'),
('Yibuti'),
('Zambia'),
('Zimbabue');

CREATE TABLE TbNacionalidades(
idNacionalidad INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idPais INT CONSTRAINT fk_PaisNacionalidad FOREIGN KEY REFERENCES TbPaises(idPais) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL, 
Nacionalidad VARCHAR(60) NOT NULL
);
INSERT INTO TbNacionalidades VALUES
(1, 'Afgano'),
(2, 'Burkines'),
(3, 'Albanies'),
(4, 'Aleman'),
(5, 'Andorrano'),
(6, 'Angoleño'),
(7, 'Antiguano'),
(8, 'Saudi'),
(9, 'Argelino'),
(10, 'Argentino'),
(11, 'Armenio'),
(12, 'Australiano'),
(13, 'Austriaco'),
(14, 'Azerbaiyano'),
(15, 'Bahameño'),
(16, 'Bangladesi'),
(17, 'Barbadense'),
(18, 'Bareini'),
(19, 'Belga'),
(20, 'Beliceño'),
(21, 'Benines'),
(22, 'Bielorruso'),
(23, 'Birmano'),
(24, 'Boliviano'),
(25, 'Bosnio'),
(26, 'Botsuano'),
(27, 'Brasileño'),
(28, 'Bruneano'),
(29, 'Búlgaro'),
(30, 'Burundes'),
(31, 'Butanes'),
(32, 'Caboverdiano'),
(33, 'Camboyano'),
(34, 'Camerunes'),
(35, 'Canadiense'),
(36, 'Catari'),
(37, 'Chadiano'),
(38, 'Chileno'),
(39, 'Chino'),
(40, 'Chipriota'),
(41, 'Vaticano'),
(42, 'Colombiano'),
(43, 'Comorense'),
(44, 'Norcoreano'),
(45, 'Surcoreano'),
(46, 'Marfileño'),
(47, 'Costarricense'),
(48, 'Croata'),
(49, 'Cubano'),
(50, 'Danes'),
(51, 'Dominiques'),
(52, 'Ecuatoriano'),
(53, 'Egipcio'),
(54, 'Salvadoreño'),
(55, 'Emirati'),
(56, 'Eritreo'),
(57, 'Eslovaco'),
(58, 'Esloveno'),
(59, 'Español'),
(60, 'Estadounidense'),
(61, 'Estonio'),
(62, 'Etiope'),
(63, 'Filipino'),
(64, 'Finlandes'),
(65, 'Fiyiano'),
(66, 'Frances'),
(67, 'Gabones'),
(68, 'Gambiano'),
(69, 'Georgiano'),
(70, 'Ghanes'),
(71, 'Granadino'),
(72, 'Griego'),
(73, 'Guatemalteco'),
(74, 'Guineano'),
(75, 'Ecuatoguineano'),
(76, 'Bisauguineano'),
(77, 'Guyanes'),
(78, 'Haitiano'),
(79, 'Hondureño'),
(80, 'Hungaro'),
(81, 'Indio'),
(82, 'Indonesio'),
(83, 'Iraqui'),
(84, 'Irani'),
(85, 'Irlandes'),
(86, 'Islandes'),
(87, 'Marshales'),
(88, 'Salomonense'),
(89, 'Israeli'),
(90, 'Italiano'),
(91, 'Jamaicano'),
(92, 'Japones'),
(93, 'Jordano'),
(94, 'Kazajo'),
(95, 'Keniano'),
(96, 'Kirguiso'),
(97, 'Kiribatiano'),
(98, 'Kuwaiti'),
(99, 'Laosiano'),
(100, 'Lesotense'),
(101, 'Leton'),
(102, 'Libanes'),
(103, 'Liberiano'),
(104, 'Libio'),
(105, 'Liechtensteiniano'),
(106, 'Lituano'),
(107, 'Luxemburgues'),
(108, 'Macedonio'),
(109, 'Malgache'),
(110, 'Malasio'),
(111, 'Malaui'),
(112, 'Maldivo'),
(113, 'Maliense'),
(114, 'Maltes'),
(115, 'Marroqui'),
(116, 'Mauriciano'),
(117, 'Mauritano'),
(118, 'Mexicano'),
(119, 'Micronesio'),
(120, 'Moldavo'),
(121, 'Monegasco'),
(122, 'Mongol'),
(123, 'Montenegrino'),
(124, 'Mozambiqueño'),
(125, 'Namibio'),
(126, 'Naurano'),
(127, 'Nepales'),
(128, 'Nicaraguense'),
(129, 'Nigerino'),
(130, 'Nigeriano'),
(131, 'Noruego'),
(132, 'Neozelandes'),
(133, 'Omani'),
(134, 'Neerlandes'),
(135, 'Pakistani'),
(136, 'Palauano'),
(137, 'Panameño'),
(138, 'Papú'),
(139, 'Paraguayo'),
(140, 'Peruano'),
(141, 'Polaco'),
(142, 'Portugues'),
(143, 'Britanico'),
(144, 'Centroafricano'),
(145, 'Checo'),
(146, 'Congoleño'),
(147, 'Congoleño'),
(148, 'Dominicano'),
(149, 'Ruandes'),
(150, 'Rumano'),
(151, 'Ruso'),
(152, 'Samoano'),
(153, 'Sancristobaleño'),
(154, 'Sanmarinense'),
(155, 'Sanvicentino'),
(156, 'Santalucense'),
(157, 'Santotomense'),
(158, 'Senegales'),
(159, 'Serbio'),
(160, 'Seychellense'),
(161, 'Sierraleones'),
(162, 'Singapurense'),
(163, 'Sirio'),
(164, 'Somalí'),
(165, 'Ceilanes'),
(166, 'Suazi'),
(167, 'Sudafricano'),
(168, 'Sudanes'),
(169, 'Sursudanes'),
(170, 'Sueco'),
(171, 'Suizo'),
(172, 'Surinames'),
(173, 'Tailandes'),
(174, 'Tanzano'),
(175, 'Tayiko'),
(176, 'Timorense'),
(177, 'Togoles'),
(178, 'Tongano'),
(179, 'Trinitense'),
(180, 'Tuneciano'),
(181, 'Turcomano'),
(182, 'Turco'),
(183, 'Tuvaluano'),
(184, 'Ucraniano'),
(185, 'Ugandes'),
(186, 'Uruguayo'),
(187, 'Uzbeko'),
(188, 'Vanuatuense'),
(189, 'Venezolano'),
(190, 'Vietnamita'),
(191, 'Yemeni'),
(192, 'Yibutiano'),
(193, 'Zambiano'),
(194, 'Zimbuabuense');


CREATE TABLE tbIdiomas(
idIdioma INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Idioma VARCHAR(10) NOT NULL
);

INSERT INTO tbIdiomas VALUES
('Español'),
('Ingles');

CREATE TABLE TbPersonas(
idPersonas INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Nombres VARCHAR(60) NOT NULL,
Apellidos VARCHAR(60) NOT NULL,
PermisoVenta BIT NOT NULL,
Genero BIT NOT NULL,
Nacimiento DATE NOT NULL,
Direccion VARCHAR(150) NULL,
Telefono VARCHAR(14) NOT NULL,
Correo VARCHAR(50) NULL,
DUI VARCHAR(10) NULL,
Foto IMAGE NULL,
Descripcion TEXT NULL,
idUsuarios INT CONSTRAINT fk_UsuarioPersona FOREIGN KEY REFERENCES TbUsuarios(idUsuarios) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
idNacionalidad INT CONSTRAINT fk_NacionalidaddePersona FOREIGN KEY REFERENCES TbNacionalidades(idNacionalidad) ON UPDATE CASCADE ON DELETE CASCADE NULL,
ModoColor BIT NOT NULL,
idIdioma INT CONSTRAINT fk_IdiomaPersona FOREIGN KEY REFERENCES tbIdiomas(idIdioma) ON UPDATE CASCADE ON DELETE CASCADE NULL,
);

CREATE TABLE tbPermisoVenta(
idPermisoVenta INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idPersonas INT CONSTRAINT fk_PermisoVentaPersona FOREIGN KEY REFERENCES TbPersonas(idPersonas) ON UPDATE NO ACTION ON DELETE NO ACTION NOT NULL,
DescripcionEmprendimiento TEXT,
NombreEmpresa VARCHAR(50),
NRC VARCHAR(14),
Enfoque VARCHAR(100)
);

CREATE TABLE TbParentesco(
idParentesco INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Parentesco VARCHAR(60)
);

INSERT INTO TbParentesco VALUES
('Madre'),
('Padre'),
('Abuelo'),
('Abuela'),
('Tio'),
('Tia'),
('Hermano'),
('Hermana'),
('Padrastro'),
('Madrastra'),
('Tutor legal'),
('Custodio');


CREATE TABLE TbResponsables(
idResponsable INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
NombresResponsable VARCHAR(60),
ApellidosResponsable VARCHAR(60),
DUIResponsable VARCHAR(10),
TelefonoResponsable VARCHAR(14),
CorreoResponsable VARCHAR(50),
idParentesco INT CONSTRAINT fk_parntenzcoResponasbleMenos FOREIGN KEY REFERENCES TbParentesco(idParentesco) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idNacionalidad INT CONSTRAINT fk_NacionalidaddelResponsable FOREIGN KEY REFERENCES TbNacionalidades(idNacionalidad) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idPersonas INT CONSTRAINT fk_ResponsablePersona FOREIGN KEY REFERENCES TbPersonas(idPersonas) ON UPDATE NO ACTION ON DELETE NO ACTION NOT NULL
);

SELECT * FROM TbUsuarios;
SELECT * FROM TbPersonas;
SELECT * FROM TbResponsables;
CREATE TABLE tbCategorias(
idCategoria INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Categoria VARCHAR(60) NOT NULL
);

INSERT INTO tbCategorias VALUES
('Ropa'),
('Tecnología'),
('Joyería'),
('Decoración'),
('Hogar'),
('Electrodomésticos'),
('Cocina'),
('Juguetes'),
('Juegos'),
('Libros'),
('Electrónicos'),
('Videojuegos'),
('Deportes'),
('Papelería'),
('Alimentos'),
('Botánica'),
('Salud'),
('Turismo'),
('Arte'),
('Entretenimiento'),
('Ecológico'),
('Fiestas'),
('Eventos'),
('Música');

CREATE TABLE tbEstadosProductos(
idEstadoProducto INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
EstadoProducto VARCHAR(50) NOT NULL
);

INSERT INTO tbEstadosProductos VALUES 
('Disponible'),
('En negociacion'),
('Vendido');

CREATE TABLE tbTiposPrecio(
idTipoPrecio INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
TipoPrecio VARCHAR(20) NOT NULL
);

INSERT INTO tbTiposPrecio VALUES 
('Fijo'),
('Negociable');

CREATE TABLE tbProductos(
idProducto INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Producto VARCHAR(50) NOT NULL,
Precio DECIMAL(12, 2) NOT NULL,
FotoProducto IMAGE NULL,
Descripcion TEXT NOT NULL,
Cantidad INT NOT NULL,
GastodeProduccion DECIMAL(12, 2) NULL,
idCategoria INT CONSTRAINT fk_CategoriaProducto FOREIGN KEY REFERENCES tbCategorias(idCategoria) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idEstadoProducto INT CONSTRAINT fk_EstadoDeProducto FOREIGN KEY REFERENCES tbEstadosProductos(idEstadoProducto) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idTipoPrecio INT CONSTRAINT fk_TipoDePrecioDeProducto FOREIGN KEY REFERENCES tbTiposPrecio(idTipoPrecio) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idPersonas INT CONSTRAINT fk_PersonaProducto FOREIGN KEY REFERENCES tbPersonas(idPersonas) ON UPDATE CASCADE ON DELETE CASCADE NULL
);

--SELECT s.Servicio, s.Precio AS 'Precio original', pe.Nombres + ' ' + pe.Apellidos AS 'Vendedor', s.FotoServicio AS Foto, c.Categoria FROM tbServicios s INNER JOIN TbPersonas pe ON pe.idPersonas = s.idPersonas INNER JOIN tbCategorias c ON c.idCategoria = s.idCategoria WHERE s.idServicio = ?;

CREATE TABLE tbEstadosServicios(
idEstadoServicio INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
EstadoServicio VARCHAR(50) NOT NULL
);

INSERT INTO tbEstadosServicios VALUES 
('Disponible'),
('Sin espacio para reserva'),
('Inactivo');

CREATE TABLE tbServicios(
idServicio INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Servicio VARCHAR(50) NOT NULL,
Precio DECIMAL(12, 2) NOT NULL,
FotoServicio IMAGE NULL,
Descripcion TEXT NOT NULL,
idCategoria INT CONSTRAINT fk_CategoriaServicio FOREIGN KEY REFERENCES tbCategorias(idCategoria) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idEstadoServicio INT CONSTRAINT fk_EstadodeServicio FOREIGN KEY REFERENCES tbEstadosServicios(idEstadoServicio) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idTipoPrecio INT CONSTRAINT fk_TipoDePrecioDeServicio FOREIGN KEY REFERENCES tbTiposPrecio(idTipoPrecio) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idPersonas INT CONSTRAINT fk_PersonaServicio FOREIGN KEY REFERENCES tbPersonas(idPersonas) ON UPDATE CASCADE ON DELETE CASCADE NULL
);

SELECT s.idServicio, s.FotoServicio, s.Servicio, s.Precio, es.EstadoServicio, tp.TipoPrecio, pe.Nombres + ' ' + pe.Apellidos AS 'Vendedor' FROM tbServicios s INNER JOIN tbEstadosServicios es ON es.idEstadoServicio = s.idEstadoServicio INNER JOIN tbTiposPrecio tp ON tp.idTipoPrecio = s.idTipoPrecio INNER JOIN tbPersonas pe ON pe.idPersonas = s.idPersonas

SELECT * FROM tbServicios;
SELECT * FROM tbProductos;

CREATE TABLE tbCarrito (
idCarrito INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idPersonas INT CONSTRAINT fk_CarritoPersona FOREIGN KEY REFERENCES tbPersonas(idPersonas) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idProducto INT CONSTRAINT fk_ProductoCarrito FOREIGN KEY REFERENCES tbProductos(idProducto) ON UPDATE NO ACTION ON DELETE NO ACTION NULL,
idServicio INT CONSTRAINT fk_CarritoServicios FOREIGN KEY REFERENCES tbServicios(idServicio) ON UPDATE NO ACTION ON DELETE NO ACTION NULL,
PrecioUnitario DECIMAL(12, 2) NOT NULL,
FechaAgregado DATETIME DEFAULT GETDATE() NOT NULL
);

SELECT COUNT(idCarrito) FROM tbCarrito WHERE idProducto = 2 OR idServicio = 2 AND idPersonas = 2;

SELECT P.Producto AS Nombre, Ca.PrecioUnitario AS Precio, P.FotoProducto AS Foto, EP.EstadoProducto AS Estado, C.Categoria, p.Descripcion 
FROM tbCarrito Ca
INNER JOIN tbProductos P ON Ca.idProducto = P.idProducto
INNER JOIN tbEstadosProductos EP ON P.idEstadoProducto = EP.idEstadoProducto
INNER JOIN tbCategorias C ON P.idCategoria = C.idCategoria WHERE Ca.idPersonas = 1;

SELECT CASE WHEN Ca.idProducto IS NOT NULL THEN P.Producto WHEN Ca.idServicio IS NOT NULL THEN S.Servicio END AS Nombre, Ca.PrecioUnitario AS Precio, CASE WHEN Ca.idProducto IS NOT NULL THEN P.FotoProducto WHEN Ca.idServicio IS NOT NULL THEN S.FotoServicio END AS Foto, CASE WHEN Ca.idProducto IS NOT NULL THEN EP.EstadoProducto WHEN Ca.idServicio IS NOT NULL THEN ES.EstadoServicio END AS Estado, CASE WHEN Ca.idProducto IS NOT NULL THEN PC.Categoria WHEN Ca.idServicio IS NOT NULL THEN SC.Categoria END AS Categoria, CASE WHEN Ca.idProducto IS NOT NULL THEN P.Descripcion WHEN Ca.idServicio IS NOT NULL THEN S.Descripcion END AS Descripcion FROM tbCarrito Ca LEFT JOIN tbProductos P ON Ca.idProducto = P.idProducto LEFT JOIN tbServicios S ON Ca.idServicio = S.idServicio LEFT JOIN tbEstadosProductos EP ON P.idEstadoProducto = EP.idEstadoProducto LEFT JOIN tbEstadosServicios ES ON S.idEstadoServicio = ES.idEstadoServicio LEFT JOIN tbCategorias PC ON P.idCategoria = PC.idCategoria LEFT JOIN tbCategorias SC ON S.idCategoria = SC.idCategoria WHERE Ca.idPersonas = 1;

CREATE TABLE tbEstadoNegociaciones(
idEstadoNegociacion INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
EstadoNegociacion VARCHAR(50) NOT NULL
);

INSERT INTO tbEstadoNegociaciones VALUES 
('Esperando respuesta'),
('Aceptada'),
('Rechazada');

CREATE TABLE tbFormasDePagos(
idFormaPago INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Formadepago VARCHAR(50) NOT NULL
);

INSERT INTO tbFormasDePagos VALUES
('Efectivo'),
('Tarjeta de credito'),
('Tarjeta de debito');

SELECT * FROM tbProductos;
SELECT * FROM tbServicios;

CREATE TABLE tbNegociaciones(
idNegociacion INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idProducto INT CONSTRAINT fk_NegociacionesProducto FOREIGN KEY REFERENCES tbProductos(idProducto) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idServicio INT CONSTRAINT fk_NegociacionesServicios FOREIGN KEY REFERENCES tbServicios(idServicio) ON UPDATE NO ACTION ON DELETE NO ACTION NULL,
idEstadoNegociacion INT CONSTRAINT fk_Estadodenegociaciones FOREIGN KEY REFERENCES tbEstadoNegociaciones(idEstadoNegociacion) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idPersonas INT CONSTRAINT fk_PersonaNegociacion FOREIGN KEY REFERENCES tbPersonas(idPersonas) ON UPDATE NO ACTION ON DELETE NO ACTION NULL,
CantidadPedida INT NULL,
FechaSolicitada DATE NULL,
PrecioOfrecido DECIMAL(12, 2) NULL,
PrecioVenta DECIMAL(12, 2) NULL,
idFormaPago INT CONSTRAINT fk_formapagonegociacion FOREIGN KEY REFERENCES tbFormasDePagos(idFormaPago) ON UPDATE NO ACTION ON DELETE NO ACTION NULL
);
--SELECT n.idNegociacion, CASE WHEN n.idProducto IS NOT NULL THEN p.FotoProducto WHEN n.idServicio IS NOT NULL THEN s.FotoServicio END AS 'Foto', CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Producto o Servicio', CASE WHEN n.idProducto IS NOT NULL THEN PP.Nombres + ' ' + PP.Apellidos WHEN n.idServicio IS NOT NULL THEN SP.Nombres + ' ' + SP.Apellidos END AS Vendedor, p.Precio AS 'Precio original', COALESCE(n.PrecioOfrecido, 0) AS 'Precio ofrecido', COALESCE(n.PrecioVenta, 0) AS 'Precio de venta' FROM tbNegociaciones n LEFT JOIN tbProductos p ON p.idProducto = n.idProducto LEFT JOIN tbServicios s ON s.idServicio = n.idServicio LEFT JOIN TbPersonas PP ON PP.idPersonas = P.idPersonas LEFT JOIN TbPersonas SP ON SP.idPersonas = S.idPersonas WHERE n.idPersonas = ?;

--SELECT idPersonas FROM tbNegociaciones WHERE idNegociacion = ?;
--SELECT CASE WHEN idProducto IS NOT NULL THEN idProducto WHEN idProducto IS NULL THEN 0 END AS idProducto, CantidadPedida FROM tbNegociaciones WHERE idNegociacion = 0
SELECT * FROM tbNegociaciones;
--SELECT n.idNegociacion, CASE WHEN n.idProducto IS NOT NULL THEN p.FotoProducto WHEN n.idServicio IS NOT NULL THEN s.FotoServicio END AS 'Foto', CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Producto o Servicio', CASE WHEN n.idProducto IS NOT NULL THEN PP.Nombres + ' ' + PP.Apellidos WHEN n.idServicio IS NOT NULL THEN SP.Nombres + ' ' + SP.Apellidos END AS Cliente, CASE WHEN n.idProducto IS NOT NULL THEN Pe.Nombres + ' ' + Pe.Apellidos WHEN n.idServicio IS NOT NULL THEN Ps.Nombres + ' ' + ps.Apellidos END AS Vendedor, CASE WHEN n.idProducto IS NOT NULL THEN p.Precio WHEN n.idServicio IS NOT NULL THEN s.Precio END AS 'Precio original', COALESCE(n.PrecioOfrecido, 0) AS 'Precio ofrecido',COALESCE(n.PrecioVenta, 0) AS 'Precio de venta', CASE WHEN n.idProducto IS NOT NULL THEN PC.Categoria WHEN n.idServicio IS NOT NULL THEN SC.Categoria END AS Categoria FROM tbNegociaciones n LEFT JOIN tbProductos p ON p.idProducto = n.idProducto LEFT JOIN tbServicios s ON s.idServicio = n.idServicio LEFT JOIN TbPersonas pe ON pe.idPersonas = p.idPersonas LEFT JOIN TbPersonas ps ON ps.idPersonas = n.idPersonas LEFT JOIN TbPersonas PP ON PP.idPersonas = n.idPersonas LEFT JOIN tbCategorias PC ON P.idCategoria = PC.idCategoria LEFT JOIN tbCategorias SC ON S.idCategoria = SC.idCategoria LEFT JOIN TbPersonas SP ON SP.idPersonas = n.idPersonas WHERE n.idNegociacion = 12;

--SELECT p.idPersonas AS id, 
--p.Producto, 
--p.Precio AS 'Precio original', 
--pe.Nombres + ' ' + pe.Apellidos AS 'Vendedor', 
--p.FotoProducto AS Foto, c.Categoria,
--p.Cantidad, ep.EstadoProducto AS 'Estado'
--FROM tbProductos p INNER JOIN TbPersonas pe 
--ON pe.idPersonas = p.idPersonas 
--INNER JOIN tbCategorias c ON c.idCategoria = p.idCategoria 
--INNER JOIN tbEstadosProductos ep ON ep.idEstadoProducto = p.idEstadoProducto WHERE p.idProducto = ?;

CREATE TABLE tbEstadosEnvio(
idEstadoEnvio INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
estadoEnvio VARCHAR(30) NOT NULL
);

INSERT INTO tbEstadosEnvio VALUES
('En progreso'),
('Pendiente'),
('Entregado'),
('Cancelado');

CREATE TABLE tbEnvios(
idEnvio INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idNegociacion INT CONSTRAINT fk_EnvioNegociacion FOREIGN KEY REFERENCES tbNegociaciones(idNegociacion) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idEstadoEnvio INT CONSTRAINT fk_Estadodeenvio FOREIGN KEY REFERENCES tbEstadosEnvio(idEstadoEnvio) ON UPDATE CASCADE ON DELETE CASCADE NULL,
UbicacionOrigen VARCHAR(60),
UbicacionDestino VARCHAR(60),
FechaEstipulada DATE
);
SELECT * FROM TbEnvios;

--SELECT e.idEnvio, n.idNegociacion, CASE WHEN n.idProducto IS NOT NULL THEN p.FotoProducto WHEN n.idServicio IS NOT NULL THEN s.FotoServicio END AS 'Foto', CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Nombre', ee.estadoEnvio AS 'Estado de envío', ee.estadoEnvio AS 'Estado de envio', p.Precio AS 'Precio original', COALESCE(n.PrecioOfrecido, 0) AS 'Precio ofrecido', COALESCE(n.PrecioVenta, 0) AS 'Precio de venta' FROM  tbEnvios e INNER JOIN tbNegociaciones n ON e.idNegociacion = n.idNegociacion LEFT JOIN tbProductos p ON p.idProducto = n.idProducto LEFT JOIN tbServicios s ON s.idServicio = n.idServicio INNER JOIN tbEstadosEnvio ee ON e.idEstadoEnvio = ee.idEstadoEnvio WHERE (p.idPersonas = ? OR s.idPersonas = ?) AND e.idEstadoEnvio = 3;

SELECT n.idNegociacion, CASE WHEN n.idProducto IS NOT NULL THEN p.FotoProducto WHEN n.idServicio IS NOT NULL THEN s.FotoServicio END AS 'Foto', CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Producto o Servicio', CASE WHEN n.idProducto IS NOT NULL THEN PP.Nombres + ' ' + PP.Apellidos WHEN n.idServicio IS NOT NULL THEN SP.Nombres + ' ' + SP.Apellidos END AS Cliente, CASE WHEN n.idProducto IS NOT NULL THEN Pe.Nombres + ' ' + Pe.Apellidos WHEN n.idServicio IS NOT NULL THEN Ps.Nombres + ' ' + ps.Apellidos END AS Vendedor, p.Precio AS 'Precio original', COALESCE(n.PrecioOfrecido, 0) AS 'Precio ofrecido', COALESCE(n.PrecioVenta, 0) AS 'Precio de venta', CASE WHEN n.idProducto IS NOT NULL THEN PC.Categoria WHEN n.idServicio IS NOT NULL THEN SC.Categoria END AS Categoria, e.UbicacionOrigen AS Origen, e.UbicacionDestino AS Destino, e.FechaEstipulada AS Fecha, e.idEstadoEnvio FROM tbEnvios e LEFT JOIN tbNegociaciones n ON e.idNegociacion = n.idNegociacion LEFT JOIN tbProductos p ON p.idProducto = n.idProducto LEFT JOIN tbServicios s ON s.idServicio = n.idServicio LEFT JOIN TbPersonas pe ON pe.idPersonas = p.idPersonas LEFT JOIN TbPersonas ps ON ps.idPersonas = n.idPersonas LEFT JOIN TbPersonas PP ON PP.idPersonas = n.idPersonas LEFT JOIN tbCategorias PC ON P.idCategoria = PC.idCategoria LEFT JOIN tbCategorias SC ON S.idCategoria = SC.idCategoria LEFT JOIN TbPersonas SP ON SP.idPersonas = n.idPersonas WHERE e.idEnvio = 1;

SELECT e.idEnvio, n.idNegociacion, CASE WHEN n.idProducto IS NOT NULL THEN p.FotoProducto WHEN n.idServicio IS NOT NULL THEN s.FotoServicio END AS 'Foto', CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Nombre', p.Precio AS 'Precio original', COALESCE(n.PrecioOfrecido, 0) AS 'Precio ofrecido', COALESCE(n.PrecioVenta, 0) AS 'Precio de venta', ee.estadoEnvio AS 'Estado de envío' FROM tbEnvios e INNER JOIN tbNegociaciones n ON e.idNegociacion = n.idNegociacion LEFT JOIN tbProductos p ON p.idProducto = n.idProducto LEFT JOIN tbServicios s ON s.idServicio = n.idServicio INNER JOIN tbEstadosEnvio ee ON e.idEstadoEnvio = ee.idEstadoEnvio WHERE (p.idPersonas = 1 OR s.idPersonas = 1) AND (e.idEstadoEnvio = 2 OR e.idEstadoEnvio = 1);

--INSERT INTO tbEnvios VALUES (?,?,?,?,?,?);
SELECT n.idPersonas, CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Producto o Servicio', COALESCE(n.PrecioVenta, 0) AS 'Precio de venta' FROM tbNegociaciones n LEFT JOIN tbProductos p ON p.idProducto = n.idProducto LEFT JOIN tbServicios s ON s.idServicio = n.idServicio WHERE idNegociacion = 1;

--SELECT e.idEnvio, n.idNegociacion, CASE WHEN n.idProducto IS NOT NULL THEN p.FotoProducto WHEN n.idServicio IS NOT NULL THEN s.FotoServicio END AS 'Foto', CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Nombre', p.Precio AS 'Precio original', COALESCE(n.PrecioOfrecido, 0) AS 'Precio ofrecido', COALESCE(n.PrecioVenta, 0) AS 'Precio de venta', ee.estadoEnvio AS 'Estado de envío' FROM tbEnvios e INNER JOIN tbNegociaciones n ON e.idNegociacion = n.idNegociacion LEFT JOIN tbProductos p ON p.idProducto = n.idProducto LEFT JOIN tbServicios s ON s.idServicio = n.idServicio INNER JOIN tbEstadosEnvio ee ON e.idEstadoEnvio = ee.idEstadoEnvio WHERE (p.idPersonas = ? OR s.idPersonas = ?) AND e.idEstadoEnvio = 2;

--SELECT n.idNegociacion, CASE WHEN n.idProducto IS NOT NULL THEN p.FotoProducto WHEN n.idServicio IS NOT NULL THEN s.FotoServicio END AS 'Foto', CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Nombre', p.Precio AS 'Precio original', COALESCE(n.PrecioOfrecido, 0) AS 'Precio ofrecido', COALESCE(n.PrecioVenta, 0) AS 'Precio de venta' FROM tbNegociaciones n LEFT JOIN tbProductos p ON p.idProducto = n.idProducto LEFT JOIN tbServicios s ON s.idServicio = n.idServicio WHERE p.idPersonas = 1 OR s.idPersonas = 1 AND n.idEstadoNegociacion = 2;

CREATE TABLE tbCalificacionesyOpiniones(
idCalificaciones INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Calificacion INT NOT NULL,
Opinion TEXT NOT NULL,
Fecha DATE NOT NULL,
idPersonas INT CONSTRAINT fk_CalificacionPersona FOREIGN KEY REFERENCES tbPersonas(idPersonas) ON UPDATE NO ACTION ON DELETE NO ACTION NULL,
idProducto INT CONSTRAINT fk_CalificacionProducto FOREIGN KEY REFERENCES tbProductos(idProducto) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idServicio INT CONSTRAINT fk_CalificacionServicio FOREIGN KEY REFERENCES tbServicios(idServicio) ON UPDATE NO ACTION ON DELETE NO ACTION NULL
);

--SELECT p.Nombres + ' ' + p.Apellidos AS 'Nombre perfil', p.Foto, o.Opinion FROM tbCalificacionesyOpiniones o INNER JOIN TbPersonas p ON p.idPersonas = o.idPersonas WHERE idProducto = 1;
--SELECT p.Nombres + ' ' + p.Apellidos AS 'Nombre perfil', p.Foto, o.Opinion FROM tbCalificacionesyOpiniones o INNER JOIN TbPersonas p ON p.idPersonas = o.idPersonas WHERE idServicio = ?;

CREATE TABLE tbEstadosPago(
idEstadoPago INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
EstadoPago VARCHAR(60) NOT NULL
);

INSERT INTO tbEstadosPago VALUES
('Realizado'),
('Suspendido'),
('En Espera');

CREATE TABLE tbSeguimientosPago(
idSeguimientoPago INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idEstadosPago INT CONSTRAINT fk_EstadodeSeguimientodepago FOREIGN KEY REFERENCES tbEstadosPago(idEstadoPago) ON UPDATE CASCADE ON DELETE CASCADE NULL,
fechaPago DATE NULL,
idEnvio INT CONSTRAINT fk_SeguimientodePagodeEnvios FOREIGN KEY REFERENCES tbEnvios(idEnvio) ON UPDATE CASCADE ON DELETE CASCADE NULL
);

--UPDATE tbProductos SET Cantidad = Cantidad - 1 WHERE idProducto = 1;
--SELECT sp.idSeguimientoPago, n.idNegociacion, CASE WHEN n.idProducto IS NOT NULL THEN p.FotoProducto WHEN n.idServicio IS NOT NULL THEN s.FotoServicio END AS 'Foto', CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Nombre', ee.estadoEnvio AS 'Estado de envío', ep.EstadoPago AS 'Estado de pago', p.Precio AS 'Precio original', COALESCE(n.PrecioOfrecido, 0) AS 'Precio ofrecido', COALESCE(n.PrecioVenta, 0) AS 'Precio de venta' FROM tbSeguimientosPago sp INNER JOIN tbEnvios e ON sp.idEnvio = e.idEnvio INNER JOIN tbNegociaciones n ON e.idNegociacion = n.idNegociacion LEFT JOIN tbProductos p ON p.idProducto = n.idProducto LEFT JOIN tbServicios s ON s.idServicio = n.idServicio INNER JOIN tbEstadosEnvio ee ON e.idEstadoEnvio = ee.idEstadoEnvio INNER JOIN tbEstadosPago ep ON sp.idEstadosPago = ep.idEstadoPago WHERE (p.idPersonas = 1 OR s.idPersonas = 1) AND sp.idEstadosPago = 3;

--SELECT TOP 10 P.idPersonas AS idCliente, CONCAT(P.Nombres, ' ', P.Apellidos) AS Cliente, COUNT(SP.idSeguimientoPago) AS TotalCompras FROM tbSeguimientosPago SP INNER JOIN tbEnvios E ON SP.idEnvio = E.idEnvio INNER JOIN tbEstadosPago EP ON SP.idEstadosPago = EP.idEstadoPago INNER JOIN tbNegociaciones N ON E.idNegociacion = N.idNegociacion INNER JOIN tbProductos pro ON pro.idProducto = N.idProducto INNER JOIN tbServicios ser ON ser.idServicio = N.idServicio INNER JOIN tbPersonas P ON N.idPersonas = P.idPersonas WHERE EP.EstadoPago = 'Realizado' AND (pro.idPersonas = ? OR ser.idPersonas = ?) GROUP BY P.idPersonas, P.Nombres, P.Apellidos ORDER BY TotalCompras DESC;

--SELECT  P.idPersonas AS idVendedor, CONCAT(P.Nombres, ' ', P.Apellidos) AS Vendedor, COUNT(DISTINCT N.idNegociacion) AS TotalVentas, SUM(N.PrecioVenta) AS TotalDinero FROM tbSeguimientosPago SP INNER JOIN tbEnvios E ON SP.idEnvio = E.idEnvio INNER JOIN tbEstadosPago EP ON SP.idEstadosPago = EP.idEstadoPago INNER JOIN tbNegociaciones N ON E.idNegociacion = N.idNegociacion INNER JOIN tbProductos pro ON pro.idProducto = N.idProducto INNER JOIN tbServicios ser ON ser.idServicio = N.idServicio INNER JOIN tbPersonas P ON N.idPersonas = P.idPersonas WHERE EP.EstadoPago = 'Realizado' AND (pro.idPersonas = ? OR ser.idPersonas = ?) GROUP BY P.idPersonas, P.Nombres, P.Apellidos ORDER BY TotalVentas DESC;

CREATE TABLE tbEstadoNotificaciones(
idEstadoNotificacion INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
EstadoNotificacion VARCHAR(30) NOT NULL
);

INSERT INTO tbEstadoNotificaciones VALUES
('Activo'),
('Inactivo');

CREATE TABLE tbCalendario(
idCalendario INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Fecha DATE NOT NULL, 
NombreEvento VARCHAR(50) NOT NULL,
HoraDeEvento TIME NOT NULL,
DescripcionEvento TEXT NULL,
idPersonas INT CONSTRAINT fk_CalendariodePersona FOREIGN KEY REFERENCES tbPersonas(idPersonas) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idEstadoNotificacion INT CONSTRAINT fk_NotificacionesdeCalendario FOREIGN KEY REFERENCES tbEstadoNotificaciones (idEstadoNotificacion) ON UPDATE CASCADE ON DELETE CASCADE NULL
);
SELECT Fecha, NombreEvento, HoraDeEvento, DescripcionEvento FROM tbCalendario WHERE idCalendario = 1;
SELECT * FROM tbCalendario;
--SELECT idCalendario, Fecha, NombreEvento, HoraDeEvento, DescripcionEvento FROM tbCalendario WHERE idPersonas = ? AND Fecha = ?;

SELECT s.Servicio, s.Precio, pe.Nombres + ' ' + pe.Apellidos AS 'Vendedor' FROM tbServicios s INNER JOIN TbPersonas pe ON pe.idPersonas = s.idPersonas WHERE s.idServicio = 1;

CREATE TABLE tbActividadUsuarios(
idActividadUsuario INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idPersonas INT CONSTRAINT fk_ActividaddePersona FOREIGN KEY REFERENCES tbPersonas(idPersonas) ON UPDATE CASCADE ON DELETE CASCADE NULL,
FechaInicioActividad DATE NULL DEFAULT GETDATE(),
HoraInicioActividad TIME NULL DEFAULT GETDATE(),
FechaFinActividad DATE NULL,
HoraFinActividad TIME NULL
);

--INSERT INTO tbActividadUsuarios VALUES(1, '2005-02-13');

CREATE TABLE tbTiposReporte(
idTipoReporte INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
TipoReporte VARCHAR(160) NOT NULL
);

INSERT INTO tbTiposReporte VALUES
('Conducta inadecuada'),
('Acoso Sexual'),
('Ingreso de contenido inadecuado'),
('Extorsion'),
('Estafa'),
('Falta a un termino o condicion del sistema');

CREATE TABLE tbReportesUsuarios(
idReporteUsuario INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
idTipoReporte INT CONSTRAINT fk_Tipodereporte FOREIGN KEY REFERENCES tbTiposReporte(idTipoReporte) ON UPDATE CASCADE ON DELETE CASCADE NULL,
idAcusador INT CONSTRAINT fk_Acusadordereporte FOREIGN KEY REFERENCES tbPersonas(idPersonas) ON UPDATE NO ACTION ON DELETE NO ACTION NULL,
idAcusado INT CONSTRAINT fk_Acusadodereporte FOREIGN KEY REFERENCES tbPersonas(idPersonas) ON UPDATE NO ACTION ON DELETE NO ACTION NULL,
Fecha DATE DEFAULT GETDATE() NOT NULL,
Descripcion TEXT NOT NULL,
Pruebas IMAGE NULL
);

SELECT R.idReporteUsuario, A.Nombres + ' ' + A.Apellidos AS Acusador, C.Nombres + ' ' + C.Apellidos AS Acusado, TR.TipoReporte, R.Descripcion, R.Pruebas FROM tbReportesUsuarios R INNER JOIN TbPersonas A ON R.idAcusador = A.idPersonas INNER JOIN TbPersonas C ON R.idAcusado = C.idPersonas INNER JOIN tbTiposReporte TR ON R.idTipoReporte = TR.idTipoReporte;

SELECT CASE WHEN Ca.idProducto IS NOT NULL THEN P.Producto WHEN Ca.idServicio IS NOT NULL THEN S.Servicio END AS Nombre,
CASE WHEN Ca.idProducto IS NOT NULL THEN PP.Nombres + ' ' + PP.Apellidos WHEN Ca.idServicio IS NOT NULL THEN SP.Nombres + ' ' + SP.Apellidos END AS Vendedor,
Ca.PrecioUnitario AS Precio, 
CASE WHEN Ca.idProducto IS NOT NULL THEN P.FotoProducto WHEN Ca.idServicio IS NOT NULL THEN S.FotoServicio END AS Foto, 
CASE WHEN Ca.idProducto IS NOT NULL THEN EP.EstadoProducto WHEN Ca.idServicio IS NOT NULL THEN ES.EstadoServicio END AS Estado, 
CASE WHEN Ca.idProducto IS NOT NULL THEN PC.Categoria WHEN Ca.idServicio IS NOT NULL THEN SC.Categoria END AS Categoria, 
CASE WHEN Ca.idProducto IS NOT NULL THEN P.Descripcion WHEN Ca.idServicio IS NOT NULL THEN S.Descripcion END AS Descripcion 
FROM tbCarrito Ca 
LEFT JOIN tbProductos P ON Ca.idProducto = P.idProducto 
LEFT JOIN tbServicios S ON Ca.idServicio = S.idServicio 
LEFT JOIN tbEstadosProductos EP ON P.idEstadoProducto = EP.idEstadoProducto 
LEFT JOIN tbEstadosServicios ES ON S.idEstadoServicio = ES.idEstadoServicio 
LEFT JOIN tbCategorias PC ON P.idCategoria = PC.idCategoria LEFT JOIN tbCategorias SC ON S.idCategoria = SC.idCategoria 
LEFT JOIN TbPersonas PP ON PP.idPersonas = P.idPersonas 
LEFT JOIN TbPersonas SP ON SP.idPersonas = S.idPersonas 
WHERE Ca.idPersonas = 2;
	
--SELECT n.idNegociacion, 
--CASE WHEN n.idProducto IS NOT NULL THEN p.FotoProducto WHEN n.idServicio IS NOT NULL THEN s.FotoServicio END AS 'Foto', 
--CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Producto o Servicio', 
--CASE WHEN n.idProducto IS NOT NULL THEN PP.Nombres + ' ' + PP.Apellidos WHEN n.idServicio IS NOT NULL THEN SP.Nombres + ' ' + SP.Apellidos END AS Vendedor,
--p.Precio AS 'Precio original', COALESCE(n.PrecioOfrecido, 0) AS 'Precio ofrecido',
--COALESCE(n.PrecioVenta, 0) AS 'Precio de venta' FROM tbNegociaciones n 
--LEFT JOIN tbProductos p ON p.idProducto = n.idProducto LEFT JOIN tbServicios s ON s.idServicio = n.idServicio LEFT JOIN TbPersonas PP ON PP.idPersonas = P.idPersonas LEFT JOIN TbPersonas SP ON SP.idPersonas = S.idPersonas WHERE p.idPersonas = ? OR s.idPersonas = ?;


SELECT * FROM TbUsuarios;
SELECT * FROM TbPersonas;
SELECT * FROM tbPermisoVenta;
SELECT * FROM tbProductos;
SELECT * FROM tbServicios;
SELECT * FROM tbCarrito;
SELECT * FROM tbEstadoNegociaciones;
SELECT * FROM tbNegociaciones;
SELECT * FROM tbEnvios;
SELECT * FROM tbSeguimientosPago;
SELECT * FROM tbReportesUsuarios;


SELECT e.idEnvio, n.idNegociacion, CASE WHEN n.idProducto IS NOT NULL THEN p.FotoProducto WHEN n.idServicio IS NOT NULL THEN s.FotoServicio END AS 'Foto', CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Nombre', ee.estadoEnvio AS 'Estado de envio', p.Precio AS 'Precio original', COALESCE(n.PrecioOfrecido, 0) AS 'Precio ofrecido', COALESCE(n.PrecioVenta, 0) AS 'Precio de venta' FROM  tbEnvios e INNER JOIN tbNegociaciones n ON e.idNegociacion = n.idNegociacion LEFT JOIN tbProductos p ON p.idProducto = n.idProducto LEFT JOIN tbServicios s ON s.idServicio = n.idServicio INNER JOIN tbEstadosEnvio ee ON e.idEstadoEnvio = ee.idEstadoEnvio WHERE (p.idPersonas = 1 OR s.idPersonas = 1) AND e.idEstadoEnvio = 3;

SELECT pv.idPermisoVenta, pv.idPersonas, p.Nombres + ' ' + p.Apellidos AS 'Nombre completo', CASE WHEN p.PermisoVenta = 0 THEN 'No tiene permiso' WHEN p.PermisoVenta = 1 THEN 'Tiene permiso' END AS permiso FROM tbPermisoVenta pv INNER JOIN TbPersonas p ON pv.idPersonas = p.idPersonas;
SELECT sp.idSeguimientoPago, n.idNegociacion, CASE WHEN n.idProducto IS NOT NULL THEN p.FotoProducto WHEN n.idServicio IS NOT NULL THEN s.FotoServicio END AS 'Foto', CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Nombre', ee.estadoEnvio AS 'Estado de envío', ep.EstadoPago AS 'Estado de pago', p.Precio AS 'Precio original', COALESCE(n.PrecioOfrecido, 0) AS 'Precio ofrecido', COALESCE(n.PrecioVenta, 0) AS 'Precio de venta' FROM tbSeguimientosPago sp INNER JOIN tbEnvios e ON sp.idEnvio = e.idEnvio INNER JOIN tbNegociaciones n ON e.idNegociacion = n.idNegociacion LEFT JOIN tbProductos p ON p.idProducto = n.idProducto LEFT JOIN tbServicios s ON s.idServicio = n.idServicio INNER JOIN tbEstadosEnvio ee ON e.idEstadoEnvio = ee.idEstadoEnvio INNER JOIN tbEstadosPago ep ON sp.idEstadosPago = ep.idEstadoPago WHERE (p.idPersonas = 1 OR s.idPersonas = 1) AND sp.idEstadosPago = 1;
SELECT S.Servicio AS Nombre, S.Precio, S.FotoServicio AS Foto, ES.EstadoServicio AS Estado, C.Categoria, S.Descripcion FROM tbServicios S INNER JOIN tbEstadosServicios ES ON S.idEstadoServicio = ES.idEstadoServicio INNER JOIN tbCategorias C ON S.idCategoria = C.idCategoria;

SELECT TOP 10 P.idPersonas AS idCliente, CONCAT(P.Nombres, ' ', P.Apellidos) AS Cliente, COUNT(SP.idSeguimientoPago) AS TotalCompras FROM tbSeguimientosPago SP LEFT JOIN tbEnvios E ON SP.idEnvio = E.idEnvio LEFT JOIN tbEstadosPago EP ON SP.idEstadosPago = EP.idEstadoPago LEFT JOIN tbNegociaciones N ON E.idNegociacion = N.idNegociacion LEFT JOIN tbProductos pro ON pro.idProducto = N.idProducto LEFT JOIN tbServicios ser ON ser.idServicio = N.idServicio LEFT JOIN tbPersonas P ON N.idPersonas = P.idPersonas WHERE EP.idEstadoPago = 1 AND (pro.idPersonas = 1 OR ser.idPersonas = 1) GROUP BY P.idPersonas, P.Nombres, P.Apellidos ORDER BY TotalCompras DESC;

SELECT TOP 5 pro.idProducto, pro.Producto,
COUNT(SP.idSeguimientoPago) 
AS TotalCompras FROM tbSeguimientosPago SP LEFT JOIN tbEnvios E ON SP.idEnvio = E.idEnvio 
LEFT JOIN tbEstadosPago EP ON SP.idEstadosPago = EP.idEstadoPago LEFT JOIN tbNegociaciones N ON E.idNegociacion = N.idNegociacion 
LEFT JOIN tbProductos pro ON pro.idProducto = N.idProducto LEFT JOIN tbServicios ser ON ser.idServicio = N.idServicio 
LEFT JOIN tbPersonas P ON N.idPersonas = P.idPersonas WHERE EP.idEstadoPago = 1 AND (pro.idPersonas = 1 OR ser.idPersonas = 1) 
GROUP BY pro.idProducto, pro.Producto ORDER BY TotalCompras DESC;

SELECT TOP 5 pro.idProducto, pro.Producto, SUM(N.CantidadPedida) AS TotalCompras FROM tbSeguimientosPago SP LEFT JOIN tbEnvios E ON SP.idEnvio = E.idEnvio LEFT JOIN tbEstadosPago EP ON SP.idEstadosPago = EP.idEstadoPago LEFT JOIN tbNegociaciones N ON E.idNegociacion = N.idNegociacion LEFT JOIN tbProductos pro ON pro.idProducto = N.idProducto LEFT JOIN tbServicios ser ON ser.idServicio = N.idServicio LEFT JOIN tbPersonas P ON N.idPersonas = P.idPersonas WHERE EP.idEstadoPago = 1 AND N.idProducto IS NOT NULL GROUP BY pro.idProducto, pro.Producto ORDER BY TotalCompras DESC;

SELECT n.idNegociacion, CASE WHEN n.idProducto IS NOT NULL THEN p.FotoProducto WHEN n.idServicio IS NOT NULL THEN s.FotoServicio END AS 'Foto', CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Nombre', CASE WHEN n.idProducto IS NOT NULL THEN p.Precio WHEN n.idServicio IS NOT NULL THEN s.Precio END AS 'Precio original', COALESCE(n.PrecioOfrecido, 0) AS 'Precio ofrecido', COALESCE(n.PrecioVenta, 0) AS 'Precio de venta', CASE WHEN n.idProducto IS NOT NULL THEN PP.Nombres + ' ' + PP.Apellidos WHEN n.idServicio IS NOT NULL THEN SP.Nombres + ' ' + SP.Apellidos END AS Cliente FROM tbNegociaciones n LEFT JOIN tbProductos p ON p.idProducto = n.idProducto LEFT JOIN tbServicios s ON s.idServicio = n.idServicio LEFT JOIN TbPersonas PP ON PP.idPersonas = n.idPersonas LEFT JOIN TbPersonas SP ON SP.idPersonas = n.idPersonas WHERE (p.idPersonas = 1 OR s.idPersonas = 1) AND n.idEstadoNegociacion = 2;

--SELECT SUM(N.PrecioVenta) AS Ganancias FROM tbSeguimientosPago SP LEFT JOIN tbEnvios E ON SP.idEnvio = E.idEnvio LEFT JOIN tbEstadosPago EP ON SP.idEstadosPago = EP.idEstadoPago LEFT JOIN tbNegociaciones N ON E.idNegociacion = N.idNegociacion LEFT JOIN tbProductos pro ON pro.idProducto = N.idProducto LEFT JOIN tbServicios ser ON ser.idServicio = N.idServicio LEFT JOIN tbPersonas P ON N.idPersonas = P.idPersonas WHERE EP.idEstadoPago = 1 AND N.idProducto IS NOT NULL AND (pro.idPersonas = ? OR ser.idPersonas = ?);
SELECT COALESCE(SUM(N.PrecioVenta), 0) AS Ganancias FROM tbSeguimientosPago SP LEFT JOIN tbEnvios E ON SP.idEnvio = E.idEnvio LEFT JOIN tbEstadosPago EP ON SP.idEstadosPago = EP.idEstadoPago LEFT JOIN tbNegociaciones N ON E.idNegociacion = N.idNegociacion LEFT JOIN tbProductos pro ON pro.idProducto = N.idProducto LEFT JOIN tbServicios ser ON ser.idServicio = N.idServicio LEFT JOIN tbPersonas P ON N.idPersonas = P.idPersonas WHERE EP.idEstadoPago = 1 AND N.idProducto IS NOT NULL AND pro.idPersonas = 1;
SELECT pro.idProducto, pro.Producto, COALESCE(SUM(N.PrecioVenta), 0) AS Ganancias FROM tbSeguimientosPago SP LEFT JOIN tbEnvios E ON SP.idEnvio = E.idEnvio LEFT JOIN tbEstadosPago EP ON SP.idEstadosPago = EP.idEstadoPago LEFT JOIN tbNegociaciones N ON E.idNegociacion = N.idNegociacion LEFT JOIN tbProductos pro ON pro.idProducto = N.idProducto LEFT JOIN tbServicios ser ON ser.idServicio = N.idServicio LEFT JOIN tbPersonas P ON N.idPersonas = P.idPersonas WHERE EP.idEstadoPago = 1 AND N.idProducto IS NOT NULL AND pro.idPersonas = 1 GROUP BY pro.idProducto, pro.Producto ORDER BY Ganancias DESC;
SELECT COALESCE(SUM(N.PrecioVenta), 0) AS Ganancias, COALESCE(SUM(pro.GastodeProduccion), 0) AS Perdidas, (COALESCE(SUM(N.PrecioVenta), 0) - COALESCE(SUM(pro.GastodeProduccion),0)) AS Balance FROM tbSeguimientosPago SP LEFT JOIN tbEnvios E ON SP.idEnvio = E.idEnvio LEFT JOIN tbEstadosPago EP ON SP.idEstadosPago = EP.idEstadoPago LEFT JOIN tbNegociaciones N ON E.idNegociacion = N.idNegociacion LEFT JOIN tbProductos pro ON pro.idProducto = N.idProducto LEFT JOIN tbServicios ser ON ser.idServicio = N.idServicio LEFT JOIN tbPersonas P ON N.idPersonas = P.idPersonas WHERE EP.idEstadoPago = 1 AND N.idProducto IS NOT NULL AND pro.idPersonas = 2;
SELECT COALESCE(SUM(N.PrecioVenta), 0) AS Ganancias, CASE WHEN SUM(N.PrecioVenta) > 500 THEN SUM(N.PrecioVenta) * 0.05 ELSE 0 END AS 'Tasa economica' FROM tbSeguimientosPago SP LEFT JOIN tbEnvios E ON SP.idEnvio = E.idEnvio LEFT JOIN tbEstadosPago EP ON SP.idEstadosPago = EP.idEstadoPago LEFT JOIN tbNegociaciones N ON E.idNegociacion = N.idNegociacion LEFT JOIN tbProductos pro ON pro.idProducto = N.idProducto LEFT JOIN tbServicios ser ON ser.idServicio = N.idServicio LEFT JOIN tbPersonas P ON N.idPersonas = P.idPersonas WHERE EP.idEstadoPago = 1 AND N.idProducto IS NOT NULL AND pro.idPersonas = 1;

SELECT e.idEnvio, n.idNegociacion, CASE WHEN n.idProducto IS NOT NULL THEN p.FotoProducto WHEN n.idServicio IS NOT NULL THEN s.FotoServicio END AS 'Foto', CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Nombre', CASE WHEN n.idProducto IS NOT NULL THEN p.Precio WHEN n.idServicio IS NOT NULL THEN s.Precio END AS 'Precio original', COALESCE(n.PrecioOfrecido, 0) AS 'Precio ofrecido', COALESCE(n.PrecioVenta, 0) AS 'Precio de venta', ee.estadoEnvio AS 'Estado de envío' FROM tbEnvios e INNER JOIN tbNegociaciones n ON e.idNegociacion = n.idNegociacion LEFT JOIN tbProductos p ON p.idProducto = n.idProducto LEFT JOIN tbServicios s ON s.idServicio = n.idServicio INNER JOIN tbEstadosEnvio ee ON e.idEstadoEnvio = ee.idEstadoEnvio WHERE (p.idPersonas = 1 OR s.idPersonas = 1) AND (e.idEstadoEnvio = 2 OR e.idEstadoEnvio = 1);

--SELECT idNegociacion FROM tbEnvios WHERE idEnvio = ?;

SELECT sp.idSeguimientoPago, 
n.idNegociacion, 
sp.fechaPago AS Fecha,
n.CantidadPedida AS 'Cantidad comprada',
CASE WHEN n.idProducto IS NOT NULL THEN p.FotoProducto WHEN n.idServicio IS NOT NULL THEN s.FotoServicio END AS 'Foto', 
CASE WHEN n.idProducto IS NOT NULL THEN p.Producto WHEN n.idServicio IS NOT NULL THEN s.Servicio END AS 'Nombre', 
ee.estadoEnvio AS 'Estado de envío', ep.EstadoPago AS 'Estado de pago', 
CASE WHEN n.idProducto IS NOT NULL THEN p.Precio WHEN n.idServicio IS NOT NULL THEN s.Precio END AS 'Precio original', 
COALESCE(n.PrecioVenta, 0) AS 'Precio de venta' 
FROM tbSeguimientosPago sp 
INNER JOIN tbEnvios e ON sp.idEnvio = e.idEnvio 
INNER JOIN tbNegociaciones n ON e.idNegociacion = n.idNegociacion 
LEFT JOIN tbProductos p ON p.idProducto = n.idProducto 
LEFT JOIN tbServicios s ON s.idServicio = n.idServicio 
INNER JOIN tbEstadosEnvio ee ON e.idEstadoEnvio = ee.idEstadoEnvio 
INNER JOIN tbEstadosPago ep ON sp.idEstadosPago = ep.idEstadoPago 
WHERE (p.idPersonas = 1 OR s.idPersonas = 1) AND sp.idEstadosPago = 1 AND sp.idSeguimientoPago = 1;
