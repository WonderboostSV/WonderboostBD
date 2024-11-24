-- Índices para tablas críticas
CREATE INDEX idx_correo_usuario ON usuarios(correo_usuario);
CREATE INDEX idx_alias_usuario ON usuarios(alias_usuario);
CREATE INDEX idx_estado_usuario ON usuarios(estado_usuario);

-- Índices en autenticación de administradores
CREATE INDEX idx_correo_administrador ON administradores(correo_administrador);
CREATE INDEX idx_estado_administrador ON administradores(estado_administrador);

-- Índices para tablas relacionadas
CREATE INDEX idx_id_rol_administrador ON administradores(id_rol_administrador);
CREATE INDEX idx_id_administrador_datos ON datos_administradores(id_administrador);

-- Índices para claves foráneas de permisos
CREATE INDEX idx_id_rol_permisos ON permisos_roles(id_rol_administrador);
CREATE INDEX idx_id_seccion_permisos ON permisos_roles(id_seccion);

-- Índices en accesos de usuarios
CREATE INDEX idx_id_tipo_usuario ON accesos_usuario(id_tipo_usuario);
CREATE INDEX idx_id_seccion_accesos ON accesos_usuario(id_seccion);

-- Índices en empresas
CREATE INDEX idx_id_propietario_empresa ON empresas(id_propietario);

-- Índices en usuarios
CREATE INDEX idx_id_empresa_usuario ON datos_usuarios(id_empresa);
CREATE INDEX idx_id_pais_usuario ON datos_usuarios(id_pais);
CREATE INDEX idx_id_tipo_identificacion_usuario ON datos_usuarios(id_tipo_identificacion);
