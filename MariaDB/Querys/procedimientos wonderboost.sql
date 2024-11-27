USE Wonderboost;

DROP PROCEDURE IF EXISTS autenticar_usuario;
DELIMITER $$
CREATE PROCEDURE autenticar_usuario(
    IN p_username VARCHAR(255),
    OUT p_id CHAR(36),
    OUT p_alias VARCHAR(255),
    OUT p_correo VARCHAR(255),
    OUT p_nombreCompleto VARCHAR(255),
    OUT p_clave VARCHAR(255),
    OUT p_foto VARCHAR(255),
    OUT p_estado VARCHAR(255),
    OUT p_apellido VARCHAR(255),
    OUT p_intentos INT,
    OUT p_dias INT,
    OUT p_tiempo DATETIME,
    OUT p_bloqueo DATETIME
)
BEGIN
    SELECT 
        a.id_administrador,
        a.alias_administrador,
        a.correo_administrador,
        CONCAT(d.nombre_administrador, ' ', d.apellido_administrador) AS nombre_completo,
        a.clave_administrador,
        d.foto_administrador,
        CASE 
            WHEN a.estado_administrador = 1 THEN 'Activo'
            WHEN a.estado_administrador = 0 THEN 'Bloqueado'
        END AS estado,
        d.apellido_administrador,
        a.intentos_administrador,
        DATEDIFF(CURRENT_DATE, a.fecha_clave) AS dias_desde_ultima_clave,
        a.tiempo_intento,
        a.fecha_bloqueo
    INTO 
        p_id, p_alias, p_correo, p_nombreCompleto, p_clave, p_foto, p_estado, p_apellido, p_intentos, p_dias, p_tiempo, p_bloqueo
    FROM 
        administradores AS a
    LEFT JOIN 
        datos_administradores AS d
    ON 
        a.id_administrador = d.id_administrador
    WHERE 
        BINARY a.alias_administrador = p_username 
        OR BINARY a.correo_administrador = p_username;
END$$

DELIMITER ;
