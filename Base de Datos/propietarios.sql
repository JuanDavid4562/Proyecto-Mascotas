USE mascotas_db;
DELIMITER //
CREATE PROCEDURE InsertarPropietario(
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_ciudad VARCHAR(100),
    IN p_direccion VARCHAR(100),
    IN p_telefono VARCHAR(10),
    IN p_email VARCHAR(100),
    IN p_contraseña VARCHAR(255),
    IN p_barrio VARCHAR(100)
)
BEGIN
    DECLARE last_id INT;
    START TRANSACTION;
    INSERT INTO usuarios (nombre, apellido, ciudad, direccion, telefono, email, contraseña)
    VALUES (p_nombre, p_apellido, p_ciudad, p_direccion, p_telefono, p_email, p_contraseña);
    SET last_id = LAST_INSERT_ID();
    INSERT INTO propietarios (id_usuario, barrio) VALUES (last_id, p_barrio);
    COMMIT;
END //
CREATE PROCEDURE BuscarPropietarioPorCodigo(
    IN p_id_usuario INT
)
BEGIN
    SELECT u.*, p.barrio 
    FROM usuarios u
    INNER JOIN propietarios p ON u.id_usuario = p.id_usuario
    WHERE u.id_usuario = p_id_usuario;
END //
CREATE PROCEDURE BuscarPropietarioPorNombre(
    IN p_nombre VARCHAR(100)
)
BEGIN
    SELECT u.*, p.barrio 
    FROM usuarios u
    INNER JOIN propietarios p ON u.id_usuario = p.id_usuario
    WHERE u.nombre LIKE CONCAT('%', p_nombre, '%');
END //
CREATE PROCEDURE BuscarPropietarios()
BEGIN
    SELECT u.*, p.barrio 
    FROM usuarios u
    INNER JOIN propietarios p ON u.id_usuario = p.id_usuario;
END //
CREATE PROCEDURE EliminarPropietario(
    IN p_id_usuario INT
)
BEGIN
    START TRANSACTION;
    DELETE FROM propietarios WHERE id_usuario = p_id_usuario;
    DELETE FROM usuarios WHERE id_usuario = p_id_usuario;
    COMMIT;
END //
CREATE PROCEDURE ActualizarPropietario(
    IN p_id_usuario INT,
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_ciudad VARCHAR(100),
    IN p_direccion VARCHAR(100),
    IN p_telefono VARCHAR(10),
    IN p_email VARCHAR(100),
    IN p_contraseña VARCHAR(255),
    IN p_barrio VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al actualizar el propietario';
    END;
    START TRANSACTION;
    UPDATE usuarios
    SET nombre = p_nombre,
        apellido = p_apellido,
        ciudad = p_ciudad,
        direccion = p_direccion,
        telefono = p_telefono,
        email = p_email,
        contraseña = p_contraseña
    WHERE id_usuario = p_id_usuario;
    UPDATE propietarios
    SET barrio = p_barrio
    WHERE id_usuario = p_id_usuario;
    COMMIT;
END //