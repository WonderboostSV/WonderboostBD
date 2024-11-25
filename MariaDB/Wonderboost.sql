DROP DATABASE IF EXISTS Wonderboost;

CREATE DATABASE IF NOT EXISTS Wonderboost;

USE Wonderboost;

-- Tabla para definir las secciones dentro de la aplicación
CREATE TABLE
	secciones_sistema (
		id_seccion CHAR(36) NOT NULL PRIMARY KEY,
		nombre_seccion VARCHAR(100) NOT NULL,
		descripcion TEXT NULL,
		CONSTRAINT uq_nombre_seccion_unico UNIQUE (nombre_seccion)
	);

-- Tabla para los roles que se encontraran en el sistema
CREATE TABLE
	roles_administradores (
		id_rol_administrador CHAR(36) NOT NULL PRIMARY KEY,
		rol_administrador VARCHAR(60) NOT NULL,
		CONSTRAINT uq_rol_administrador_unico UNIQUE (rol_administrador)
	);

-- Tabla para los permisos de secciones de los roles que se encontraran en el sistema
CREATE TABLE
	permisos_roles (
		id_permiso_rol CHAR(36) NOT NULL PRIMARY KEY,
		id_rol_administrador CHAR(36) NOT NULL,
		id_seccion CHAR(36) NOT NULL,
		CONSTRAINT fk_permiso_rol_administrador FOREIGN KEY (id_rol_administrador) REFERENCES roles_administradores (id_rol_administrador),
		CONSTRAINT fk_permiso_rol_seccion FOREIGN KEY (id_seccion) REFERENCES secciones_sistema (id_seccion)
	);

-- Tabla para los usuarios administradores que se encontraran en el sistema
CREATE TABLE
	administradores (
		id_administrador CHAR(36) NOT NULL PRIMARY KEY,
		correo_administrador VARCHAR(50) NOT NULL,
		CONSTRAINT uq_correo_administrador_unico UNIQUE (correo_administrador),
		CONSTRAINT chk_correo_administrador_formato CHECK (
			correo_administrador REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$'
		),
		clave_administrador VARCHAR(255) NOT NULL,
		fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP(),
		alias_administrador VARCHAR(25) NOT NULL,
		id_rol_administrador CHAR(36) NOT NULL,
		CONSTRAINT fk_id_rol_administrador FOREIGN KEY (id_rol_administrador) REFERENCES roles_administradores (id_rol_administrador),
		intentos_administrador INT DEFAULT 0,
		estado_administrador BOOLEAN DEFAULT 1,
		tiempo_intento DATETIME NULL,
		fecha_clave DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
		fecha_bloqueo DATETIME NULL
	);

-- Tabla para los datos personales del administrador
CREATE TABLE
	datos_administradores (
		id_dato_administrador CHAR(36) NOT NULL PRIMARY KEY,
		nombre_administrador VARCHAR(50) NOT NULL,
		apellido_administrador VARCHAR(50) NOT NULL,
		telefono_administrador VARCHAR(15) NOT NULL,
		dui_administrador VARCHAR(10) NOT NULL,
		CONSTRAINT uq_dui_administrador_unico UNIQUE (dui_administrador),
		direccion_administrador VARCHAR(200) NOT NULL,
		id_administrador CHAR(36) NOT NULL,
		CONSTRAINT fk_id_administrador_datos FOREIGN KEY (id_administrador) REFERENCES administradores (id_administrador) ON DELETE CASCADE ON UPDATE CASCADE,
		fecha_nacimiento_administrador DATE NULL,
		foto_administrador VARCHAR(50) NULL
	);

-- Tabla para asignar nacionalidades y paises
CREATE TABLE
	paises (
		id_pais CHAR(36) NOT NULL PRIMARY KEY,
		pais VARCHAR(100) NOT NULL,
		nacionalidad VARCHAR(100) NOT NULL,
		imagen_pais VARCHAR(100) NULL
	);

-- Tabla para los distintos tipos de usuarios que pueda tener el sistema
CREATE TABLE
	tipos_usuarios (
		id_tipo_usuario CHAR(36) NOT NULL PRIMARY KEY,
		cargo_usuario ENUM (
			'Cliente',
			'Emprendedor',
			'Distribuidor',
			'Repartidor'
		), -- Evaluar que cargo de usuario posee.
		tipo_usuario VARCHAR(100) NOT NULL, -- Definir el tipo de usuario
		CONSTRAINT uq_tipo_usuario_unico UNIQUE (tipo_usuario)
	);

-- Relación entre accesos de usuario y secciones
CREATE TABLE
	accesos_usuario (
		id_acceso CHAR(36) NOT NULL PRIMARY KEY,
		id_tipo_usuario CHAR(36) NOT NULL,
		id_seccion CHAR(36) NOT NULL,
		estado_acceso BOOLEAN DEFAULT 0, -- Estado del acceso del usuario
		estado_seccion BOOLEAN NOT NULL, -- Si la sección es del sistema o personalizada
		CONSTRAINT fk_accesos_del_tipo_de_usuario FOREIGN KEY (id_tipo_usuario) REFERENCES tipos_usuarios (id_tipo_usuario),
		CONSTRAINT fk_permiso_seccion FOREIGN KEY (id_seccion) REFERENCES secciones_sistema (id_seccion)
	);

-- Tabla para los usuarios del sistema
CREATE TABLE
	usuarios (
		id_usuario CHAR(36) NOT NULL PRIMARY KEY,
		alias_usuario VARCHAR(50) NOT NULL,
		correo_usuario VARCHAR(50) NOT NULL,
		CONSTRAINT uq_correo_usuario_unico UNIQUE (correo_usuario),
		CONSTRAINT chk_correo_usuario_formato CHECK (
			correo_usuario REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$'
		),
		clave_usuario VARCHAR(255) NOT NULL,
		pin_usuario CHAR(4) NULL,
		fecha_creacion DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
		id_tipo_usuario CHAR(36),
		CONSTRAINT fk_tipo_del_usuario FOREIGN KEY (id_tipo_usuario) REFERENCES tipos_usuarios (id_tipo_usuario),
		estado_usuario BOOLEAN DEFAULT 1
	);

CREATE TABLE
	permisos_usuarios (
		id_permisos_usuarios CHAR(36) NOT NULL PRIMARY KEY,
		id_usuario CHAR(36) NOT NULL,
		CONSTRAINT fk_id_usuario_permisos FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
		permiso_compra BOOLEAN DEFAULT 1, -- Permiso estándar para un cliente normal
		permiso_venta BOOLEAN DEFAULT 0, -- Permiso para un emprendedor
		permiso_distribuidor BOOLEAN DEFAULT 0, -- Permiso para una distribuidora
		permiso_repartidor BOOLEAN DEFAULT 0 -- Permiso para un repartidor
	);

-- Tabla para los distintos tipos de empresas que hay
CREATE TABLE
	tipos_empresas (
		id_tipo_empresa CHAR(36) NOT NULL PRIMARY KEY,
		tipo_empresa VARCHAR(50) NOT NULL,
		CONSTRAINT uq_tipo_empresa_unico UNIQUE (tipo_empresa)
	);

-- Tabla para registrar las empresas de los emprendedores
CREATE TABLE
	empresas (
		id_empresa CHAR(36) NOT NULL PRIMARY KEY,
		nombre_empresa VARCHAR(200) NOT NULL,
		id_tipo_empresa CHAR(36),
		CONSTRAINT fk_tipo_de_la_empresa FOREIGN KEY (id_tipo_empresa) REFERENCES tipos_empresas (id_tipo_empresa),
		logo_empresa VARCHAR(255) NULL,
		descripcion_empresa TEXT NULL,
		fecha_registro DATE DEFAULT CURRENT_TIMESTAMP,
		numero_registro_fiscal VARCHAR(20) NULL UNIQUE,
		estado_empresa BOOLEAN DEFAULT 1,
		pagina_web_empresa VARCHAR(255) NULL,
		id_propietario CHAR(36) NOT NULL,
		CONSTRAINT fk_propietario_empresa FOREIGN KEY (id_propietario) REFERENCES usuarios (id_usuario)
	);

-- Tabla para los tipos de identificadores alternativos
CREATE TABLE
	tipos_identificaciones_alternativas (
		id_tipo_identificacion CHAR(36) NOT NULL PRIMARY KEY,
		tipo_identificacion VARCHAR(50) NOT NULL,
		CONSTRAINT uq_tipo_identificacion_unico UNIQUE (tipo_identificacion)
	);

-- Tabla para los datos personales del usuario
CREATE TABLE
	datos_usuarios (
		id_dato_usuario CHAR(36) NOT NULL PRIMARY KEY,
		id_usuario CHAR(36) NOT NULL,
		CONSTRAINT fk_id_usuario_datos FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
		nombre_usuario VARCHAR(50) NULL,
		apellido_usuario VARCHAR(50) NULL,
		telefono_usuario VARCHAR(15) NOT NULL,
		telefono_alternativo VARCHAR(15) NULL,
		genero_usuario ENUM ('Masculino', 'Femenino', 'Otro'),
		fecha_nacimiento_usuario DATE NULL,
		dui_usuario VARCHAR(10) NULL,
		CONSTRAINT uq_dui_usuario_unico UNIQUE (dui_usuario),
		direccion_usuario VARCHAR(200) NULL,
		id_pais CHAR(36) NULL,
		CONSTRAINT fk_pais_del_usuario FOREIGN KEY (id_pais) REFERENCES paises (id_pais),
		id_empresa CHAR(36) NULL,
		CONSTRAINT fk_empresa_del_usuario FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa),
		foto_usuario VARCHAR(50) NULL,
		perfil_red_social VARCHAR(255) NULL,
		id_tipo_identificacion CHAR(36) NULL,
		CONSTRAINT fk_tipo_identificacion_alternativa_del_usuario FOREIGN KEY (id_tipo_identificacion) REFERENCES tipos_identificaciones_alternativas (id_tipo_identificacion),
		numero_identificacion_alternativa VARCHAR(30) NULL,
		CONSTRAINT uq_numero_identificacion_alternativa_unico UNIQUE (numero_identificacion_alternativa),
		puntos_usuario INT DEFAULT 0,
		estado_civil ENUM (
			'Soltero',
			'Casado',
			'Divorciado',
			'Viudo',
			'Otro'
		) NULL,
		cargo_actual VARCHAR(50) NULL
	);

-- Tabla para manejar detalles específicos de distribuidores
CREATE TABLE
	distribuidores (
		id_distribuidor CHAR(36) NOT NULL PRIMARY KEY,
		id_usuario CHAR(36) NOT NULL,
		id_empresa CHAR(36) NOT NULL,
		estado_distribuidor BOOLEAN DEFAULT 1, -- 1: Activo, 0: Inactivo
		experiencia_años INT DEFAULT 0,
		CONSTRAINT fk_distribuidor_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
		CONSTRAINT fk_distribuidor_empresa FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa)
	);

-- Tabla para manejar detalles específicos de repartidores
CREATE TABLE
	repartidores (
		id_repartidor CHAR(36) NOT NULL PRIMARY KEY,
		id_usuario CHAR(36) NOT NULL,
		licencia_conduccion VARCHAR(50) NOT NULL,
		tipo_transporte ENUM ('Moto', 'Bicicleta', 'Carro', 'Otro') NOT NULL,
		estado_repartidor BOOLEAN DEFAULT 1, -- 1: Activo, 0: Inactivo
		id_pais CHAR(36) NULL,
		CONSTRAINT fk_repartidor_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
		CONSTRAINT fk_repartidor_pais FOREIGN KEY (id_pais) REFERENCES paises (id_pais)
	);

-- Tabla para solicitar el permiso de venta
CREATE TABLE
	solicitudes_permisos_venta (
		id_solicitud CHAR(36) NOT NULL PRIMARY KEY,
		id_usuario CHAR(36) NOT NULL,
		id_empresa CHAR(36) NOT NULL,
		fecha_solicitud DATETIME DEFAULT CURRENT_TIMESTAMP,
		estado_solicitud ENUM ('Pendiente', 'Aprobado', 'Rechazado') DEFAULT 'Pendiente',
		observaciones TEXT NULL,
		CONSTRAINT fk_solicitud_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
		CONSTRAINT fk_solicitud_empresa FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa)
	);

-- Tabla principal para las categorias
CREATE TABLE
	categorias (
		id_categoria CHAR(36) NOT NULL PRIMARY KEY,
		nombre_categoria VARCHAR(100) NOT NULL,
		descripcion_categoria TEXT NULL,
		CONSTRAINT uq_nombre_categoria_unico UNIQUE (nombre_categoria)
	);

-- Tabla principal para las subcategorias
CREATE TABLE
	subcategorias (
		id_subcategoria CHAR(36) NOT NULL PRIMARY KEY,
		nombre_subcategoria VARCHAR(100) NOT NULL,
		id_categoria CHAR(36) NOT NULL,
		descripcion_subcategoria TEXT NULL,
		CONSTRAINT fk_subcategoria_categoria FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria),
		CONSTRAINT uq_nombre_subcategoria_unico UNIQUE (nombre_subcategoria)
	);

-- Tabla principal para los filtros de las subcategorias
CREATE TABLE
	filtros (
		id_filtro CHAR(36) NOT NULL PRIMARY KEY,
		nombre_filtro VARCHAR(100) NOT NULL, -- Ejemplo: "Color", "Tamaño", "Material"
		tipo_filtro ENUM ('Texto', 'Numérico', 'Lista') NOT NULL, -- Tipo de filtro (texto, numérico o lista)
		id_subcategoria CHAR(36) NOT NULL,
		CONSTRAINT fk_filtro_subcategoria FOREIGN KEY (id_subcategoria) REFERENCES subcategorias (id_subcategoria)
	);

-- Tabla para las opciones de los filtros de las subcategorias
CREATE TABLE
	opciones_filtro (
		id_opcion_filtro CHAR(36) NOT NULL PRIMARY KEY,
		valor_opcion_filtro VARCHAR(100) NOT NULL, -- Ejemplo: "Rojo", "Azul", "S/M", etc.
		id_filtro CHAR(36) NOT NULL,
		CONSTRAINT fk_opcion_filtro FOREIGN KEY (id_filtro) REFERENCES filtros (id_filtro)
	);

-- Tabla principal para los productos
CREATE TABLE
	productos (
		id_producto CHAR(36) NOT NULL PRIMARY KEY,
		nombre_producto VARCHAR(100) NOT NULL,
		descripcion_producto TEXT NOT NULL,
		precio_producto DECIMAL(10, 2) UNSIGNED NOT NULL,
		tipo_precio_producto ENUM ('Fijo', 'Negociable') DEFAULT 'Fijo',
		estado_producto BOOLEAN DEFAULT 1,
		id_subcategoria CHAR(36) NOT NULL, -- Relación con la subcategoría
		id_empresa CHAR(36) NOT NULL, -- Relación con el emprendimiento al que pertenece el producto
		CONSTRAINT fk_producto_subcategoria FOREIGN KEY (id_subcategoria) REFERENCES subcategorias (id_subcategoria),
		CONSTRAINT fk_producto_empresa FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa)
	);

-- Tabla para relacionar los filtros con los productos
CREATE TABLE
	producto_filtro (
		id_producto CHAR(36) NOT NULL,
		id_filtro CHAR(36) NOT NULL,
		valor_filtro VARCHAR(100) NOT NULL, -- El valor asociado al filtro
		PRIMARY KEY (id_producto, id_filtro),
		CONSTRAINT fk_producto_filtro FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
		CONSTRAINT fk_filtro_producto FOREIGN KEY (id_filtro) REFERENCES filtros (id_filtro)
	);

-- Tabla para los detalles de productos
CREATE TABLE
	detalles_producto (
		id_detalle_producto CHAR(36) NOT NULL PRIMARY KEY,
		id_producto CHAR(36) NOT NULL,
		foto_producto VARCHAR(50) NULL,
		id_opcion_filtro CHAR(36) NOT NULL, -- Relacionado con las opciones de filtro (por ejemplo, un color o talla específica)
		valor_detalle_producto VARCHAR(100) NOT NULL, -- El valor de la opción (por ejemplo, "Rojo", "M", etc.)
		cantidad_disponible INT UNSIGNED NOT NULL, -- Cuántas unidades de esta opción hay disponibles
		CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
		CONSTRAINT fk_detalle_opcion_filtro FOREIGN KEY (id_opcion_filtro) REFERENCES opciones_filtro (id_opcion_filtro)
	);

-- Tabla para los tipos de servicio
CREATE TABLE
	tipos_servicios (
		id_tipo_servicio CHAR(36) NOT NULL PRIMARY KEY,
		nombre_tipo_servicio VARCHAR(100) NOT NULL,
		descripcion_tipo_servicio TEXT NULL,
		CONSTRAINT uq_nombre_tipo_servicio UNIQUE (nombre_tipo_servicio)
	);

-- Tabla para registrar los servicios
CREATE TABLE
	servicios (
		id_servicio CHAR(36) NOT NULL PRIMARY KEY,
		nombre_servicio VARCHAR(100) NOT NULL,
		descripcion_servicio TEXT NOT NULL,
		id_tipo_servicio CHAR(36) NOT NULL, -- Relación con el tipo de servicio
		id_empresa CHAR(36) NOT NULL, -- Relación con la empresa que ofrece el servicio
		estado_servicio BOOLEAN DEFAULT 1, -- 1: Activo, 0: Inactivo
		fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
		CONSTRAINT fk_servicio_tipo_servicio FOREIGN KEY (id_tipo_servicio) REFERENCES tipos_servicios (id_tipo_servicio),
		CONSTRAINT fk_servicio_empresa FOREIGN KEY (id_empresa) REFERENCES empresas (id_empresa)
	);

-- Tabla para manejar precios de los servicios
CREATE TABLE
	precios_servicio (
		id_precio_servicio CHAR(36) NOT NULL PRIMARY KEY,
		id_servicio CHAR(36) NOT NULL, -- Relación con el servicio
		modalidad_precio ENUM ('Por hora', 'Por sesión', 'Mensual', 'Anual') NOT NULL,
		tipo_precio_servicio ENUM ('Fijo', 'Negociable') DEFAULT 'Fijo',
		precio_servicio DECIMAL(10, 2) UNSIGNED NOT NULL,
		CONSTRAINT fk_precio_servicio FOREIGN KEY (id_servicio) REFERENCES servicios (id_servicio)
	);

-- Tabla para almacenar detalles adicionales del servicio
CREATE TABLE
	detalles_servicio (
		id_detalle_servicio CHAR(36) NOT NULL PRIMARY KEY,
		id_servicio CHAR(36) NOT NULL, -- Relación con el servicio
		nombre_atributo VARCHAR(100) NOT NULL, -- Ejemplo: "Duración", "Incluye materiales"
		valor_atributo VARCHAR(255) NOT NULL,
		CONSTRAINT fk_detalle_servicio FOREIGN KEY (id_servicio) REFERENCES servicios (id_servicio)
	);

-- Tabla para registrar los pedidos
CREATE TABLE
	pedidos (
		id_pedido CHAR(36) NOT NULL PRIMARY KEY,
		estado_pedido ENUM (
			'Pendiente',
			'Enviado',
			'En camino',
			'Cancelado',
			'Negociando'
		) DEFAULT 'Pendiente',
		fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
		direccion_pedido VARCHAR(255) NOT NULL,
		id_cliente CHAR(36) NOT NULL,
		CONSTRAINT fk_cliente_pedido FOREIGN KEY (id_cliente) REFERENCES usuarios (id_usuario)
	);

-- Tabla para los detalles de los pedidos (aplica tanto a productos como servicios)
CREATE TABLE
	detalles_pedidos (
		id_detalle_pedido CHAR(36) NOT NULL PRIMARY KEY,
		id_pedido CHAR(36) NOT NULL,
		id_producto CHAR(36),
		id_servicio CHAR(36),
		cantidad INT NOT NULL,
		precio_unitario DECIMAL(10, 2) NOT NULL,
		CONSTRAINT chk_precio_unitario_positive CHECK (precio_unitario > 0),
		CONSTRAINT chk_cantidad_positive CHECK (cantidad > 0),
		CONSTRAINT fk_detalle_pedido_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido),
		CONSTRAINT fk_detalle_pedido_producto FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
		CONSTRAINT fk_detalle_pedido_servicio FOREIGN KEY (id_servicio) REFERENCES servicios (id_servicio)
	);

-- Tabla para registrar los envíos
CREATE TABLE
	envios (
		id_envio CHAR(36) NOT NULL PRIMARY KEY,
		id_pedido CHAR(36) NOT NULL,
		id_repartidor CHAR(36) NULL, -- Puede no tener repartidor asignado inicialmente
		id_distribuidor CHAR(36) NULL, -- Puede involucrar a un distribuidor si aplica
		estado_envio ENUM (
			'Pendiente',
			'En camino',
			'Entregado',
			'Cancelado'
		) DEFAULT 'Pendiente',
		fecha_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
		fecha_entrega DATETIME NULL,
		direccion_envio VARCHAR(255) NOT NULL,
		CONSTRAINT fk_envio_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido),
		CONSTRAINT fk_envio_repartidor FOREIGN KEY (id_repartidor) REFERENCES repartidores (id_repartidor),
		CONSTRAINT fk_envio_distribuidor FOREIGN KEY (id_distribuidor) REFERENCES distribuidores (id_distribuidor)
	);

-- Tabla para registrar el seguimiento de envíos
CREATE TABLE
	seguimiento_envios (
		id_seguimiento CHAR(36) NOT NULL PRIMARY KEY,
		id_envio CHAR(36) NOT NULL,
		estado_actual ENUM (
			'Preparando',
			'En tránsito',
			'En entrega',
			'Entregado'
		) NOT NULL,
		descripcion_estado TEXT NULL,
		fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP,
		CONSTRAINT fk_seguimiento_envio FOREIGN KEY (id_envio) REFERENCES envios (id_envio)
	);

-- Tabla para registrar los pagos
CREATE TABLE
	pagos (
		id_pago CHAR(36) NOT NULL PRIMARY KEY,
		id_pedido CHAR(36) NOT NULL,
		metodo_pago ENUM ('Efectivo', 'Tarjeta', 'Transferencia', 'Otro') NOT NULL,
		estado_pago ENUM ('Pendiente', 'Pagado', 'Rechazado') DEFAULT 'Pendiente',
		monto_pago DECIMAL(10, 2) NOT NULL,
		fecha_pago DATETIME NULL,
		CONSTRAINT fk_pago_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido)
	);

-- Tabla para seguimiento de pagos
CREATE TABLE
	seguimiento_pagos (
		id_seguimiento_pago CHAR(36) NOT NULL PRIMARY KEY,
		id_pago CHAR(36) NOT NULL,
		estado_pago ENUM (
			'En proceso',
			'Completado',
			'Fallido',
			'Reembolsado'
		) NOT NULL,
		fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP,
		observaciones TEXT NULL,
		CONSTRAINT fk_seguimiento_pago FOREIGN KEY (id_pago) REFERENCES pagos (id_pago)
	);

-- Tabla para registrar favoritos de usuarios (aplica tanto a productos como servicios)
CREATE TABLE
	favoritos (
		id_favorito CHAR(36) NOT NULL PRIMARY KEY,
		id_usuario CHAR(36) NOT NULL,
		id_producto CHAR(36),
		id_servicio CHAR(36),
		fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
		CONSTRAINT fk_favorito_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
		CONSTRAINT fk_favorito_producto FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
		CONSTRAINT fk_favorito_servicio FOREIGN KEY (id_servicio) REFERENCES servicios (id_servicio)
	);

-- Tabla para registrar likes/dislikes (aplica tanto a productos como servicios)
CREATE TABLE
	valoraciones (
		id_valoracion CHAR(36) NOT NULL PRIMARY KEY,
		id_usuario CHAR(36) NOT NULL,
		id_producto CHAR(36),
		id_servicio CHAR(36),
		es_like BOOLEAN NOT NULL,
		fecha_valoracion DATETIME DEFAULT CURRENT_TIMESTAMP,
		CONSTRAINT fk_valoracion_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
		CONSTRAINT fk_valoracion_producto FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
		CONSTRAINT fk_valoracion_servicio FOREIGN KEY (id_servicio) REFERENCES servicios (id_servicio)
	);

-- Tabla para registrar comentarios (aplica tanto a productos como servicios)
CREATE TABLE
	comentarios (
		id_comentario CHAR(36) NOT NULL PRIMARY KEY,
		id_usuario CHAR(36) NOT NULL,
		id_producto CHAR(36),
		id_servicio CHAR(36),
		comentario TEXT NOT NULL,
		fecha_comentario DATETIME DEFAULT CURRENT_TIMESTAMP,
		estado_comentario BOOLEAN DEFAULT 1, -- 1: Visible, 0: Oculto
		CONSTRAINT fk_comentario_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
		CONSTRAINT fk_comentario_producto FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
		CONSTRAINT fk_comentario_servicio FOREIGN KEY (id_servicio) REFERENCES servicios (id_servicio)
	);