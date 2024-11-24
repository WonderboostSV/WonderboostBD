DROP DATABASE IF EXISTS Wonderboost;
CREATE DATABASE IF NOT EXISTS Wonderboost;
USE Wonderboost;

-- Tabla para definir las secciones dentro de la aplicación
CREATE TABLE secciones_sistema(
  id_seccion CHAR(36) NOT NULL PRIMARY KEY,
  nombre_seccion VARCHAR(100) NOT NULL,
  descripcion TEXT NULL,
  CONSTRAINT uq_nombre_seccion_unico UNIQUE(nombre_seccion)
);

-- Tabla para los roles que se encontraran en el sistema
CREATE TABLE roles_administradores(
  id_rol_administrador CHAR(36) NOT NULL PRIMARY KEY,
  rol_administrador VARCHAR(60) NOT NULL,
  CONSTRAINT uq_rol_administrador_unico UNIQUE(rol_administrador)
);

-- Tabla para los permisos de secciones de los roles que se encontraran en el sistema
CREATE TABLE permisos_roles (
  id_permiso_rol CHAR(36) NOT NULL PRIMARY KEY,
  id_rol_administrador CHAR(36) NOT NULL,
  id_seccion CHAR(36) NOT NULL,
  CONSTRAINT fk_permiso_rol_administrador FOREIGN KEY (id_rol_administrador) REFERENCES roles_administradores(id_rol_administrador),
  CONSTRAINT fk_permiso_rol_seccion FOREIGN KEY (id_seccion) REFERENCES secciones_sistema(id_seccion)
);

-- Tabla para los usuarios administradores que se encontraran en el sistema
CREATE TABLE administradores(
  id_administrador CHAR(36) NOT NULL PRIMARY KEY,
  correo_administrador VARCHAR(50) NOT NULL,
  CONSTRAINT uq_correo_administrador_unico UNIQUE(correo_administrador),
  CONSTRAINT chk_correo_administrador_formato CHECK (correo_administrador REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$'),
  clave_administrador VARCHAR(255) NOT NULL,
  fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP(),
  alias_administrador VARCHAR(25) NOT NULL,
  id_rol_administrador CHAR(36) NOT NULL,
  CONSTRAINT fk_id_rol_administrador FOREIGN KEY (id_rol_administrador) REFERENCES roles_administradores(id_rol_administrador),
  intentos_administrador INT DEFAULT 0,
  estado_administrador BOOLEAN DEFAULT 1,
  tiempo_intento DATETIME NULL,
  fecha_clave DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  fecha_bloqueo DATETIME NULL
);

-- Tabla para los datos personales del administrador
CREATE TABLE datos_administradores(
  id_dato_administrador CHAR(36) NOT NULL PRIMARY KEY,
  nombre_administrador VARCHAR(50) NOT NULL,
  apellido_administrador VARCHAR(50) NOT NULL,
  telefono_administrador VARCHAR(15) NOT NULL,
  dui_administrador VARCHAR(10) NOT NULL,
  CONSTRAINT uq_dui_administrador_unico UNIQUE(dui_administrador),
  direccion_administrador VARCHAR(200) NOT NULL,
  id_administrador CHAR(36) NOT NULL,
  CONSTRAINT fk_id_administrador_datos FOREIGN KEY (id_administrador) REFERENCES administradores(id_administrador) ON DELETE CASCADE ON UPDATE CASCADE,
  fecha_nacimiento_administrador DATE NULL,
  foto_administrador VARCHAR(50) NULL
);

-- Tabla para asignar nacionalidades y paises
CREATE TABLE paises(
  id_pais CHAR(36) NOT NULL PRIMARY KEY,
  pais VARCHAR(100) NOT NULL,
  nacionalidad VARCHAR(100) NOT NULL,
  imagen_pais VARCHAR(100) NULL
);

-- Tabla para los distintos tipos de usuarios que pueda tener el sistema
CREATE TABLE tipos_usuarios(
  id_tipo_usuario CHAR(36) NOT NULL PRIMARY KEY,
  cargo_usuario ENUM('Cliente','Emprendedor','Distribuidor','Repartidor'), -- Evaluar que cargo de usuario posee.
  tipo_usuario VARCHAR(100) NOT NULL, -- Definir el tipo de usuario
  CONSTRAINT uq_tipo_usuario_unico UNIQUE(tipo_usuario)
);

-- Relación entre accesos de usuario y secciones
CREATE TABLE accesos_usuario(
  id_acceso CHAR(36) NOT NULL PRIMARY KEY,
  id_tipo_usuario CHAR(36) NOT NULL,
  id_seccion CHAR(36) NOT NULL,
  estado_acceso BOOLEAN DEFAULT 0, -- Estado del acceso del usuario
  estado_seccion BOOLEAN NOT NULL, -- Si la sección es del sistema o personalizada
  CONSTRAINT fk_accesos_del_tipo_de_usuario FOREIGN KEY (id_tipo_usuario) REFERENCES tipos_usuarios(id_tipo_usuario),
  CONSTRAINT fk_permiso_seccion FOREIGN KEY (id_seccion) REFERENCES secciones_sistema(id_seccion)
);

-- Tabla para los usuarios del sistema
CREATE TABLE usuarios(
  id_usuario CHAR(36) NOT NULL PRIMARY KEY,
  alias_usuario VARCHAR(50) NOT NULL,
  correo_usuario VARCHAR(50) NOT NULL, 
  CONSTRAINT uq_correo_usuario_unico UNIQUE(correo_usuario),
  CONSTRAINT chk_correo_usuario_formato CHECK (correo_usuario REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$'),
  clave_usuario VARCHAR(255) NOT NULL,
  pin_usuario CHAR(4) NULL,
  fecha_creacion DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  id_tipo_usuario CHAR(36),
  CONSTRAINT fk_tipo_del_usuario FOREIGN KEY (id_tipo_usuario) REFERENCES tipos_usuarios(id_tipo_usuario),
  estado_usuario BOOLEAN DEFAULT 1
);

CREATE TABLE permisos_usuarios(
  id_permisos_usuarios CHAR(36) NOT NULL PRIMARY KEY,
  id_usuario CHAR(36) NOT NULL,
  CONSTRAINT fk_id_usuario_permisos FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  permiso_compra BOOLEAN DEFAULT 1, -- Permiso estándar para un cliente normal
  permiso_venta BOOLEAN DEFAULT 0, -- Permiso para un emprendedor
  permiso_distribuidor BOOLEAN DEFAULT 0, -- Permiso para una distribuidora
  permiso_repartidor BOOLEAN DEFAULT 0 -- Permiso para un repartidor
);

-- Tabla para los distintos tipos de empresas que hay
CREATE TABLE tipos_empresas(
  id_tipo_empresa CHAR(36) NOT NULL PRIMARY KEY,
  tipo_empresa VARCHAR(50) NOT NULL,
  CONSTRAINT uq_tipo_empresa_unico UNIQUE(tipo_empresa)
);

-- Tabla para registrar las empresas de los emprendedores
CREATE TABLE empresas(
  id_empresa CHAR(36) NOT NULL PRIMARY KEY,
  nombre_empresa VARCHAR(200) NOT NULL,
  id_tipo_empresa CHAR(36),
  CONSTRAINT fk_tipo_de_la_empresa FOREIGN KEY (id_tipo_empresa) REFERENCES tipos_empresas(id_tipo_empresa),
  logo_empresa VARCHAR(255) NULL,
  descripcion_empresa TEXT NULL,
  fecha_registro DATE DEFAULT CURRENT_TIMESTAMP,
  numero_registro_fiscal VARCHAR(20) NULL UNIQUE,
  estado_empresa BOOLEAN DEFAULT 1,
  pagina_web_empresa VARCHAR(255) NULL,
  id_propietario CHAR(36) NOT NULL,
  CONSTRAINT fk_propietario_empresa FOREIGN KEY (id_propietario) REFERENCES usuarios(id_usuario)
);

-- Tabla para los tipos de identificadores alternativos
CREATE TABLE tipos_identificaciones_alternativas(
  id_tipo_identificacion CHAR(36) NOT NULL PRIMARY KEY,
  tipo_identificacion VARCHAR(50) NOT NULL,
  CONSTRAINT uq_tipo_identificacion_unico UNIQUE(tipo_identificacion)
);

-- Tabla para los datos personales del usuario
CREATE TABLE datos_usuarios(
  id_dato_usuario CHAR(36) NOT NULL PRIMARY KEY,
  id_usuario CHAR(36) NOT NULL,
  CONSTRAINT fk_id_usuario_datos FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
  nombre_usuario VARCHAR(50) NULL,
  apellido_usuario VARCHAR(50) NULL,
  telefono_usuario VARCHAR(15) NOT NULL,
  telefono_alternativo VARCHAR(15) NULL,
  genero_usuario ENUM('Masculino', 'Femenino', 'Otro'),
  fecha_nacimiento_usuario DATE NULL,
  dui_usuario VARCHAR(10) NULL,
  CONSTRAINT uq_dui_usuario_unico UNIQUE(dui_usuario),
  direccion_usuario VARCHAR(200) NULL,
  id_pais CHAR(36) NULL,
  CONSTRAINT fk_pais_del_usuario FOREIGN KEY (id_pais) REFERENCES paises(id_pais), 
  id_empresa CHAR(36) NULL,
  CONSTRAINT fk_empresa_del_usuario FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa), 
  foto_usuario VARCHAR(50) NULL,
  perfil_red_social VARCHAR(255) NULL,
  id_tipo_identificacion CHAR(36) NULL,
  CONSTRAINT fk_tipo_identificacion_alternativa_del_usuario FOREIGN KEY (id_tipo_identificacion) REFERENCES tipos_identificaciones_alternativas(id_tipo_identificacion), 
  numero_identificacion_alternativa VARCHAR(30) NULL,
  CONSTRAINT uq_numero_identificacion_alternativa_unico UNIQUE(numero_identificacion_alternativa),
  puntos_usuario INT DEFAULT 0,
  estado_civil ENUM('Soltero', 'Casado', 'Divorciado', 'Viudo', 'Otro') NULL,
  cargo_actual VARCHAR(50) NULL
);

