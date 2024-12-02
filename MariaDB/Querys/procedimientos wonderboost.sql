USE Wonderboost;

DROP PROCEDURE IF EXISTS autenticar_administrador;
DELIMITER $$
CREATE PROCEDURE autenticar_administrador(
    IN p_username VARCHAR(255)
)
BEGIN
    SELECT 
        a.id_administrador AS ID,
        a.alias_administrador AS ALIAS,
        a.correo_administrador AS CORREO,
        CONCAT(d.nombre_administrador, ' ', d.apellido_administrador) AS NOMBRECOMPLETO,
        a.clave_administrador AS CLAVE,
        d.foto_administrador AS FOTO,
        CASE 
            WHEN a.estado_administrador = 1 THEN 'Activo'
            WHEN a.estado_administrador = 0 THEN 'Bloqueado'
        END AS ESTADO,
        d.apellido_administrador AS APELLIDO,
        a.intentos_administrador AS INTENTOS,
        DATEDIFF(CURRENT_DATE, a.fecha_clave) AS DIAS,
        a.tiempo_intento AS TIEMPO,
        a.fecha_bloqueo AS BLOQUEO
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
