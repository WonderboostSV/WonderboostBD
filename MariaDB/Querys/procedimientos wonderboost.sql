USE Wonderboost;

-- SECCIONES
DROP PROCEDURE IF EXISTS insertar_seccion;
DELIMITER $$
CREATE PROCEDURE insertar_seccion(
    IN p_nombre_seccion VARCHAR(100),
    IN p_descripcion TEXT
)
BEGIN
    DECLARE nombre_count INT;

    -- Verificar si el nombre de la sección ya existe
    SELECT COUNT(*) INTO nombre_count
    FROM secciones_sistema
    WHERE nombre_seccion = p_nombre_seccion;

    -- Si el nombre ya existe, generar un error
    IF nombre_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre de la sección ya existe';
    ELSE
        -- Insertar la nueva sección
        INSERT INTO secciones_sistema (id_seccion, nombre_seccion, descripcion)
        VALUES (UUID(), p_nombre_seccion, p_descripcion);
    END IF;
END;
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS actualizar_seccion;
DELIMITER $$
CREATE PROCEDURE actualizar_seccion(
    IN p_id_seccion CHAR(36),
    IN p_nombre_seccion VARCHAR(100),
    IN p_descripcion TEXT
)
BEGIN
    DECLARE seccion_count INT;
    DECLARE nombre_count INT;

    -- Verificar si la sección existe
    SELECT COUNT(*) INTO seccion_count
    FROM secciones_sistema
    WHERE id_seccion = p_id_seccion;

    IF seccion_count = 0 THEN
        -- Si no existe, generar un error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La sección no existe';
    ELSE
        -- Verificar si el nombre ya está en uso por otra sección
        SELECT COUNT(*) INTO nombre_count
        FROM secciones_sistema
        WHERE nombre_seccion = p_nombre_seccion
        AND id_seccion <> p_id_seccion;

        IF nombre_count > 0 THEN
            -- Si el nombre está duplicado, generar un error
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre de la sección ya existe';
        ELSE
            -- Actualizar la sección
            UPDATE secciones_sistema
            SET nombre_seccion = p_nombre_seccion,
                descripcion = p_descripcion
            WHERE id_seccion = p_id_seccion;
        END IF;
    END IF;
END;
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS eliminar_seccion;
DELIMITER $$
CREATE PROCEDURE eliminar_seccion(
    IN p_id_seccion CHAR(36)
)
BEGIN
    DECLARE seccion_exists INT;

    -- Verificar si la sección existe
    SELECT COUNT(*) INTO seccion_exists
    FROM secciones_sistema
    WHERE id_seccion = p_id_seccion;

    IF seccion_exists = 0 THEN
        -- Si no existe, generar un error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La sección no existe';
    ELSE
        -- Si existe, proceder a eliminarla
        DELETE FROM secciones_sistema
        WHERE id_seccion = p_id_seccion;
    END IF;
END;
$$
DELIMITER ;

-- Roles administradores
DROP PROCEDURE IF EXISTS insertar_rol_administrador;
DELIMITER $$
CREATE PROCEDURE insertar_rol_administrador(
    IN p_rol_administrador VARCHAR(60)
)
BEGIN
    DECLARE rol_count INT;

    -- Verificar si el nombre del rol ya existe
    SELECT COUNT(*) INTO rol_count
    FROM roles_administradores
    WHERE rol_administrador = p_rol_administrador;

    -- Si el rol ya existe, generar un error
    IF rol_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del rol ya existe';
    ELSE
        -- Insertar el nuevo rol
        INSERT INTO roles_administradores (id_rol_administrador, rol_administrador)
        VALUES (UUID(), p_rol_administrador);
    END IF;
END;
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS actualizar_rol_administrador;
DELIMITER $$
CREATE PROCEDURE actualizar_rol_administrador(
    IN p_id_rol_administrador CHAR(36),
    IN p_rol_administrador VARCHAR(60)
)
BEGIN
    DECLARE rol_count INT;
    DECLARE id_count INT;

    -- Verificar si el rol existe
    SELECT COUNT(*) INTO id_count
    FROM roles_administradores
    WHERE id_rol_administrador = p_id_rol_administrador;

    IF id_count = 0 THEN
        -- Si el ID del rol no existe, generar un error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El rol no existe';
    ELSE
        -- Verificar si el nuevo nombre del rol ya está en uso por otro registro
        SELECT COUNT(*) INTO rol_count
        FROM roles_administradores
        WHERE rol_administrador = p_rol_administrador
        AND id_rol_administrador <> p_id_rol_administrador;

        IF rol_count > 0 THEN
            -- Si el nombre está duplicado, generar un error
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del rol ya existe';
        ELSE
            -- Actualizar el rol
            UPDATE roles_administradores
            SET rol_administrador = p_rol_administrador
            WHERE id_rol_administrador = p_id_rol_administrador;
        END IF;
    END IF;
END;
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS eliminar_rol_administrador;
DELIMITER $$
CREATE PROCEDURE eliminar_rol_administrador(
    IN p_id_rol_administrador CHAR(36)
)
BEGIN
    DECLARE rol_exists INT;

    -- Verificar si el rol existe
    SELECT COUNT(*) INTO rol_exists
    FROM roles_administradores
    WHERE id_rol_administrador = p_id_rol_administrador;

    IF rol_exists = 0 THEN
        -- Si no existe, generar un error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El rol no existe';
    ELSE
        -- Si existe, proceder a eliminarlo
        DELETE FROM roles_administradores
        WHERE id_rol_administrador = p_id_rol_administrador;
    END IF;
END;
$$
DELIMITER ;

-- Permisos por rol
DROP PROCEDURE IF EXISTS insertar_permiso_rol;
DELIMITER $$
CREATE PROCEDURE insertar_permiso_rol(
    IN p_id_rol_administrador CHAR(36),
    IN p_id_seccion CHAR(36)
)
BEGIN
    DECLARE rol_count INT;
    DECLARE seccion_count INT;
    DECLARE permiso_count INT;

    -- Verificar si el rol existe
    SELECT COUNT(*) INTO rol_count
    FROM roles_administradores
    WHERE id_rol_administrador = p_id_rol_administrador;

    -- Verificar si la sección existe
    SELECT COUNT(*) INTO seccion_count
    FROM secciones_sistema
    WHERE id_seccion = p_id_seccion;

    -- Verificar si ya existe el permiso para el rol y la sección
    SELECT COUNT(*) INTO permiso_count
    FROM permisos_roles
    WHERE id_rol_administrador = p_id_rol_administrador
    AND id_seccion = p_id_seccion;

    IF rol_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El rol no existe';
    ELSEIF seccion_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La sección no existe';
    ELSEIF permiso_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El permiso ya existe para este rol y sección';
    ELSE
        -- Insertar el nuevo permiso
        INSERT INTO permisos_roles (id_permiso_rol, id_rol_administrador, id_seccion)
        VALUES (UUID(), p_id_rol_administrador, p_id_seccion);
    END IF;
END;
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS actualizar_permiso_rol;
DELIMITER $$
CREATE PROCEDURE actualizar_permiso_rol(
    IN p_id_permiso_rol CHAR(36),
    IN p_id_rol_administrador CHAR(36),
    IN p_id_seccion CHAR(36)
)
BEGIN
    DECLARE permiso_exists INT;
    DECLARE rol_count INT;
    DECLARE seccion_count INT;
    DECLARE duplicado_count INT;

    -- Verificar si el permiso existe
    SELECT COUNT(*) INTO permiso_exists
    FROM permisos_roles
    WHERE id_permiso_rol = p_id_permiso_rol;

    -- Verificar si el rol existe
    SELECT COUNT(*) INTO rol_count
    FROM roles_administradores
    WHERE id_rol_administrador = p_id_rol_administrador;

    -- Verificar si la sección existe
    SELECT COUNT(*) INTO seccion_count
    FROM secciones_sistema
    WHERE id_seccion = p_id_seccion;

    -- Verificar si ya existe un permiso duplicado con el nuevo rol y sección
    SELECT COUNT(*) INTO duplicado_count
    FROM permisos_roles
    WHERE id_rol_administrador = p_id_rol_administrador
    AND id_seccion = p_id_seccion
    AND id_permiso_rol <> p_id_permiso_rol;

    IF permiso_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El permiso no existe';
    ELSEIF rol_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El rol no existe';
    ELSEIF seccion_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La sección no existe';
    ELSEIF duplicado_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya existe un permiso para este rol y sección';
    ELSE
        -- Actualizar el permiso
        UPDATE permisos_roles
        SET id_rol_administrador = p_id_rol_administrador,
            id_seccion = p_id_seccion
        WHERE id_permiso_rol = p_id_permiso_rol;
    END IF;
END;
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS eliminar_permiso_rol;
DELIMITER $$
CREATE PROCEDURE eliminar_permiso_rol(
    IN p_id_permiso_rol CHAR(36)
)
BEGIN
    DECLARE permiso_exists INT;

    -- Verificar si el permiso existe
    SELECT COUNT(*) INTO permiso_exists
    FROM permisos_roles
    WHERE id_permiso_rol = p_id_permiso_rol;

    IF permiso_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El permiso no existe';
    ELSE
        -- Eliminar el permiso
        DELETE FROM permisos_roles
        WHERE id_permiso_rol = p_id_permiso_rol;
    END IF;
END;
$$
DELIMITER ;

-- Administradores

-- Login
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

DROP PROCEDURE IF EXISTS insertar_administrador;
DELIMITER $$
CREATE PROCEDURE insertar_administrador(
    IN p_correo_administrador VARCHAR(50),
    IN p_clave_administrador VARCHAR(255),
    IN p_alias_administrador VARCHAR(25),
    IN p_id_rol_administrador CHAR(36)
)
BEGIN
    DECLARE correo_count INT;
    DECLARE rol_count INT;

    -- Validar si el correo ya existe
    SELECT COUNT(*) INTO correo_count
    FROM administradores
    WHERE correo_administrador = p_correo_administrador;

    -- Validar si el rol existe
    SELECT COUNT(*) INTO rol_count
    FROM roles_administradores
    WHERE id_rol_administrador = p_id_rol_administrador;

    IF correo_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo ya existe';
    ELSEIF rol_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El rol no existe';
    ELSE
        -- Insertar el administrador
        INSERT INTO administradores (id_administrador, correo_administrador, clave_administrador, alias_administrador, id_rol_administrador)
        VALUES (UUID(), p_correo_administrador, p_clave_administrador, p_alias_administrador, p_id_rol_administrador);
    END IF;
END;
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS actualizar_administrador;
DELIMITER $$
CREATE PROCEDURE actualizar_administrador(
    IN p_id_administrador CHAR(36),
    IN p_correo_administrador VARCHAR(50),
    IN p_clave_administrador VARCHAR(255),
    IN p_alias_administrador VARCHAR(25),
    IN p_id_rol_administrador CHAR(36)
)
BEGIN
    DECLARE administrador_exists INT;
    DECLARE correo_count INT;
    DECLARE rol_count INT;

    -- Validar si el administrador existe
    SELECT COUNT(*) INTO administrador_exists
    FROM administradores
    WHERE id_administrador = p_id_administrador;

    -- Validar si el correo ya existe para otro administrador
    SELECT COUNT(*) INTO correo_count
    FROM administradores
    WHERE correo_administrador = p_correo_administrador
    AND id_administrador <> p_id_administrador;

    -- Validar si el rol existe
    SELECT COUNT(*) INTO rol_count
    FROM roles_administradores
    WHERE id_rol_administrador = p_id_rol_administrador;

    IF administrador_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El administrador no existe';
    ELSEIF correo_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo ya está en uso';
    ELSEIF rol_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El rol no existe';
    ELSE
        -- Actualizar el administrador
        UPDATE administradores
        SET correo_administrador = p_correo_administrador,
            clave_administrador = p_clave_administrador,
            alias_administrador = p_alias_administrador,
            id_rol_administrador = p_id_rol_administrador
        WHERE id_administrador = p_id_administrador;
    END IF;
END;
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS eliminar_administrador;
DELIMITER $$
CREATE PROCEDURE eliminar_administrador(
    IN p_id_administrador CHAR(36)
)
BEGIN
    DECLARE administrador_exists INT;

    -- Validar si el administrador existe
    SELECT COUNT(*) INTO administrador_exists
    FROM administradores
    WHERE id_administrador = p_id_administrador;

    IF administrador_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El administrador no existe';
    ELSE
        -- Eliminar el administrador
        DELETE FROM administradores
        WHERE id_administrador = p_id_administrador;
    END IF;
END;
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS reiniciar_tiempo_bloqueo;
DELIMITER $$
CREATE PROCEDURE reiniciar_tiempo_bloqueo(
    IN p_alias_administrador VARCHAR(25)
)
BEGIN
    DECLARE alias_exists INT;

    -- Validar si el alias existe
    SELECT COUNT(*) INTO alias_exists
    FROM administradores
    WHERE alias_administrador = p_alias_administrador;

    IF alias_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El alias no existe';
    ELSE
        -- Reiniciar tiempo de intento
        UPDATE administradores
        SET tiempo_intento = NULL
        WHERE alias_administrador = p_alias_administrador;
    END IF;
END;
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS cambiar_estado_bloqueado;
DELIMITER $$
CREATE PROCEDURE cambiar_estado_bloqueado(
    IN p_alias_administrador VARCHAR(25)
)
BEGIN
    DECLARE alias_exists INT;

    -- Validar si el alias existe
    SELECT COUNT(*) INTO alias_exists
    FROM administradores
    WHERE alias_administrador = p_alias_administrador;

    IF alias_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El alias no existe';
    ELSE
        -- Cambiar el estado del administrador
        UPDATE administradores
        SET estado_administrador = 1
        WHERE alias_administrador = p_alias_administrador;
    END IF;
END;
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS reiniciar_intentos;
DELIMITER $$
CREATE PROCEDURE reiniciar_intentos(
    IN p_alias_administrador VARCHAR(25)
)
BEGIN
    DECLARE alias_exists INT;

    -- Validar si el alias existe
    SELECT COUNT(*) INTO alias_exists
    FROM administradores
    WHERE alias_administrador = p_alias_administrador;

    IF alias_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El alias no existe';
    ELSE
        -- Reiniciar intentos
        UPDATE administradores
        SET intentos_administrador = 0
        WHERE alias_administrador = p_alias_administrador;
    END IF;
END;
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sumar_intento;
DELIMITER $$
CREATE PROCEDURE sumar_intento(
    IN p_alias_administrador VARCHAR(25)
)
BEGIN
    DECLARE alias_exists INT;

    -- Validar si el alias existe
    SELECT COUNT(*) INTO alias_exists
    FROM administradores
    WHERE alias_administrador = p_alias_administrador;

    IF alias_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El alias no existe';
    ELSE
        -- Sumar un intento
        UPDATE administradores
        SET intentos_administrador = intentos_administrador + 1
        WHERE alias_administrador = p_alias_administrador;
    END IF;
END;
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS actualizar_estado_administrador;
DELIMITER $$
CREATE PROCEDURE actualizar_estado_administrador(
    IN p_id_administrador CHAR(36)
)
BEGIN
    DECLARE admin_exists INT;

    -- Verificar si el administrador existe
    SELECT COUNT(*) INTO admin_exists 
    FROM administradores 
    WHERE id_administrador = p_id_administrador;

    IF admin_exists = 0 THEN
        -- Si no existe, generar un error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El administrador no existe';
    ELSE
        -- Si existe, proceder a actualizar el estado del administrador alternando su valor
        UPDATE administradores
        SET estado_administrador = NOT estado_administrador
        WHERE id_administrador = p_id_administrador;
    END IF;
END;
$$
DELIMITER ;
