USE Wonderboost;

DELIMITER $$
CREATE TRIGGER before_insert_datos_usuarios
BEFORE INSERT ON datos_usuarios
FOR EACH ROW
BEGIN
  IF NEW.fecha_nacimiento_usuario > CURDATE() THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'La fecha de nacimiento no puede ser posterior a la fecha actual';
  END IF;
END$$
DELIMITER ;