USE Wonderboost;
-- Insertar secciones
INSERT INTO secciones_sistema (id_seccion, nombre_seccion, descripcion)
VALUES (UUID(), 'Gestión administrativa', 'Sección que contiene las pantallas de administración del sistema');
INSERT INTO secciones_sistema (id_seccion, nombre_seccion, descripcion)
VALUES (UUID(), 'Gestión de usuarios', 'Sección que contiene las pantallas de gestión de usuarios del sistema');
INSERT INTO secciones_sistema (id_seccion, nombre_seccion, descripcion)
VALUES (UUID(), 'Gestión de empresas', 'Sección que contiene las pantallas de gestión de empresas del sistema');
INSERT INTO secciones_sistema (id_seccion, nombre_seccion, descripcion)
VALUES (UUID(), 'Gestión de productos', 'Sección que contiene las pantallas de gestión de productos del sistema');
INSERT INTO secciones_sistema (id_seccion, nombre_seccion, descripcion)
VALUES (UUID(), 'Gestión de servicios', 'Sección que contiene las pantallas de gestión de servicios del sistema');
INSERT INTO secciones_sistema (id_seccion, nombre_seccion, descripcion)
VALUES (UUID(), 'Gestión de distribuidores', 'Sección que contiene las pantallas de gestión de distribuidores del sistema');
INSERT INTO secciones_sistema (id_seccion, nombre_seccion, descripcion)
VALUES (UUID(), 'Gestión de repartidores', 'Sección que contiene las pantallas de gestión de repartidores del sistema');

-- Insertar roles
INSERT INTO roles_administradores (id_rol_administrador, rol_administrador)
VALUES (UUID(), 'Root');

-- Insertar el nuevo permiso
INSERT INTO permisos_roles (id_permiso_rol, id_rol_administrador, id_seccion) VALUES 
(UUID(), 
(SELECT id_rol_administrador FROM roles_administradores WHERE rol_administrador = 'Root'), 
(SELECT id_seccion FROM secciones_sistema WHERE nombre_seccion = 'Gestión administrativa')),
(UUID(), 
(SELECT id_rol_administrador FROM roles_administradores WHERE rol_administrador = 'Root'), 
(SELECT id_seccion FROM secciones_sistema WHERE nombre_seccion = 'Gestión de usuarios')),
(UUID(), 
(SELECT id_rol_administrador FROM roles_administradores WHERE rol_administrador = 'Root'), 
(SELECT id_seccion FROM secciones_sistema WHERE nombre_seccion = 'Gestión de empresas')),
(UUID(), 
(SELECT id_rol_administrador FROM roles_administradores WHERE rol_administrador = 'Root'), 
(SELECT id_seccion FROM secciones_sistema WHERE nombre_seccion = 'Gestión de productos')),
(UUID(), 
(SELECT id_rol_administrador FROM roles_administradores WHERE rol_administrador = 'Root'), 
(SELECT id_seccion FROM secciones_sistema WHERE nombre_seccion = 'Gestión de servicios')),
(UUID(), 
(SELECT id_rol_administrador FROM roles_administradores WHERE rol_administrador = 'Root'), 
(SELECT id_seccion FROM secciones_sistema WHERE nombre_seccion = 'Gestión de distribuidores')),
(UUID(), 
(SELECT id_rol_administrador FROM roles_administradores WHERE rol_administrador = 'Root'), 
(SELECT id_seccion FROM secciones_sistema WHERE nombre_seccion = 'Gestión de repartidores'));


