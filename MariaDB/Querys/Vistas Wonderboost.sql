USE Wonderboost;

CREATE VIEW vista_tabla_roles_administradores AS
SELECT id_rol_administrador AS ID,
rol_administrador AS ROL
FROM roles_administradores;

CREATE VIEW vista_tabla_administradores AS
SELECT 
    da.id_dato_administrador AS ID_DATO,
    da.nombre_administrador AS NOMBRE,
    da.apellido_administrador AS APELLIDO,
    da.telefono_administrador AS TELEFONO,
    da.dui_administrador AS DUI,
    da.direccion_administrador AS DIRECCION,
    da.fecha_nacimiento_administrador AS FECHA_NACIMIENTO,
    da.foto_administrador AS FOTO,
    a.id_administrador AS ID_ADMINISTRADOR,
    a.correo_administrador AS CORREO,
    a.alias_administrador AS ALIAS,
    a.fecha_creacion AS FECHA_CREACION,
    a.intentos_administrador AS INTENTOS,
    a.estado_administrador AS ESTADO,
    a.tiempo_intento AS TIEMPO_INTENTO,
    a.fecha_clave AS FECHA_CLAVE,
    a.fecha_bloqueo AS FECHA_BLOQUEO,
    ra.id_rol_administrador AS ID_ROL,
    ra.rol_administrador AS TIPO
FROM 
    administradores a
JOIN 
    datos_administradores da ON a.id_administrador = da.id_administrador
JOIN 
    roles_administradores ra ON a.id_rol_administrador = ra.id_rol_administrador;
    
SELECT * FROM vista_tabla_administradores;