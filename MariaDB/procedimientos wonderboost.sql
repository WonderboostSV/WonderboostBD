USE Wonderboost;

DELIMITER $$

CREATE PROCEDURE autenticar_usuario(
    IN p_username VARCHAR(255),
    OUT p_id INT,
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
        id_administrador,
        alias_administrador,
        correo_administrador,
        CONCAT(nombre_administrador, ' ', apellido_administrador),
        clave_administrador,
        foto_administrador,
        CASE 
            WHEN estado_administrador = 1 THEN 'Activo'
            WHEN estado_administrador = 0 THEN 'Bloqueado'
        END,
        apellido_administrador,
        intentos_administrador,
        DATEDIFF(CURRENT_DATE, fecha_clave),
        tiempo_intento,
        fecha_bloqueo
    INTO 
        p_id, p_alias, p_correo, p_nombreCompleto, p_clave, p_foto, p_estado, p_apellido, p_intentos, p_dias, p_tiempo, p_bloqueo
    FROM 
        administradores
    WHERE 
        BINARY alias_administrador = p_username OR BINARY correo_administrador = p_username;
END$$

DELIMITER ;
