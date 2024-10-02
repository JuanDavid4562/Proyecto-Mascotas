USE mascotas_db;
DELIMITER //
CREATE PROCEDURE InsertarAdministrador(
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_ciudad VARCHAR(100),
    IN p_direccion VARCHAR(100),
    IN p_telefono VARCHAR(10),
    IN p_email VARCHAR(100),
    IN p_contraseña VARCHAR(255),
    IN p_cargo VARCHAR(100),
    IN p_fecha_ingreso DATE
)
BEGIN
    DECLARE last_id INT;
    START TRANSACTION;
    INSERT INTO usuarios (nombre, apellido, ciudad, direccion, telefono, email, contraseña)
    VALUES (p_nombre, p_apellido, p_ciudad, p_direccion, p_telefono, p_email, p_contraseña);
    SET last_id = LAST_INSERT_ID();
    INSERT INTO administradores (id_usuario, cargo, fecha_ingreso) VALUES (last_id, p_cargo, p_fecha_ingreso);
    COMMIT;
END //
CREATE PROCEDURE BuscarAdministradorPorCodigo(
    IN p_id_usuario INT
)
BEGIN
    SELECT u.*, a.cargo, a.fecha_ingreso
    FROM usuarios u
    INNER JOIN administradores a ON u.id_usuario = a.id_usuario
    WHERE u.id_usuario = p_id_usuario;
END //
CREATE PROCEDURE BuscarAdministradorPorNombre(
    IN p_nombre VARCHAR(100)
)
BEGIN
    SELECT u.*, a.cargo, a.fecha_ingreso
    FROM usuarios u
    INNER JOIN administradores a ON u.id_usuario = a.id_usuario
    WHERE u.nombre LIKE CONCAT('%', p_nombre, '%');
END //
CREATE PROCEDURE BuscarAdministradores()
BEGIN
    SELECT u.*, a.cargo, a.fecha_ingreso
    FROM usuarios u
    INNER JOIN administradores a ON u.id_usuario = a.id_usuario;
END //
CREATE PROCEDURE EliminarAdministrador(
    IN p_id_usuario INT
)
BEGIN
    START TRANSACTION;
    DELETE FROM administradores WHERE id_usuario = p_id_usuario;
    DELETE FROM usuarios WHERE id_usuario = p_id_usuario;
    COMMIT;
END //
CREATE PROCEDURE ActualizarAdministrador(
    IN p_id_usuario INT,
    IN p_cargo VARCHAR(100),
    IN p_fecha_ingreso DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al actualizar el administrador';
    END;
    START TRANSACTION;
    UPDATE administradores
    SET cargo = p_cargo,
        fecha_ingreso = p_fecha_ingreso
    WHERE id_usuario = p_id_usuario;
    COMMIT;
END //