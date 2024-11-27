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

-- Índices para mejorar la búsqueda en "usuarios"
CREATE INDEX idx_id_empresa_usuarios ON usuarios(id_empresa); -- Para filtrar usuarios por empresa.
CREATE INDEX idx_id_tipo_usuario_usuarios ON usuarios(id_tipo_usuario); -- Para optimizar consultas por tipo de usuario.

-- Índices adicionales en "administradores"
CREATE INDEX idx_fecha_creacion_administradores ON administradores(fecha_creacion); -- Para acelerar búsquedas o estadísticas basadas en la fecha de creación.

-- Índices en "datos_administradores"
CREATE INDEX idx_fecha_registro_datos_admin ON datos_administradores(fecha_registro); -- Para facilitar análisis por fecha de registro de datos.

-- Índices adicionales en "permisos_roles"
CREATE INDEX idx_id_permiso_permisos_roles ON permisos_roles(id_permiso); -- Para mejorar el acceso a los permisos específicos asignados a roles.

-- Índices en "accesos_usuario"
CREATE INDEX idx_id_usuario_accesos_usuario ON accesos_usuario(id_usuario); -- Para acelerar búsquedas de accesos por usuario.
CREATE INDEX idx_fecha_acceso_accesos_usuario ON accesos_usuario(fecha_acceso); -- Para optimizar análisis de accesos por fecha.

-- Índices en "empresas"
CREATE INDEX idx_id_sector_empresa ON empresas(id_sector); -- Para filtrar empresas por sector.

-- Índices adicionales en "datos_usuarios"
CREATE INDEX idx_id_ciudad_datos_usuarios ON datos_usuarios(id_ciudad); -- Para búsquedas relacionadas con ubicaciones específicas.
CREATE INDEX idx_fecha_nacimiento_datos_usuarios ON datos_usuarios(fecha_nacimiento); -- Para segmentar o analizar usuarios por rango de edad.
CREATE INDEX idx_genero_datos_usuarios ON datos_usuarios(genero); -- Para optimizar consultas por género.

-- Índices en otras posibles tablas
CREATE INDEX idx_id_categoria_productos ON productos(id_categoria); -- Para mejorar búsquedas en productos por categoría.
CREATE INDEX idx_fecha_creacion_productos ON productos(fecha_creacion); -- Para optimizar análisis de productos por fecha de creación.
CREATE INDEX idx_id_proveedor_productos ON productos(id_proveedor); -- Para filtrar productos según su proveedor.

-- Índices en "transacciones" (si existe)
CREATE INDEX idx_id_usuario_transacciones ON transacciones(id_usuario); -- Para búsquedas rápidas de transacciones por usuario.
CREATE INDEX idx_fecha_transaccion_transacciones ON transacciones(fecha_transaccion); -- Para análisis de transacciones por rango de fechas.

-- Índices en "roles" (si existe una tabla de roles)
CREATE INDEX idx_nombre_rol ON roles(nombre_rol); -- Para optimizar búsquedas por nombre de rol.
