USE mascotas_db;
DELIMITER //
CREATE PROCEDURE InsertarVeterinario(
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_ciudad VARCHAR(100),
    IN p_direccion VARCHAR(100),
    IN p_telefono VARCHAR(10),
    IN p_email VARCHAR(100),
    IN p_contraseña VARCHAR(255),
    IN p_especialidad VARCHAR(100),
    IN p_horario VARCHAR(255)
)
BEGIN
    DECLARE last_id INT;
    START TRANSACTION;
    INSERT INTO usuarios (nombre, apellido, ciudad, direccion, telefono, email, contraseña)
    VALUES (p_nombre, p_apellido, p_ciudad, p_direccion, p_telefono, p_email, p_contraseña);
    SET last_id = LAST_INSERT_ID();
    INSERT INTO veterinarios (id_usuario, especialidad, horario) VALUES (last_id, p_especialidad, p_horario);
    COMMIT;
END //
CREATE PROCEDURE BuscarVeterinarioPorCodigo(
    IN p_id_usuario INT
)
BEGIN
    SELECT u.*, v.especialidad, v.horario
    FROM usuarios u
    INNER JOIN veterinarios v ON u.id_usuario = v.id_usuario
    WHERE u.id_usuario = p_id_usuario;
END //
CREATE PROCEDURE BuscarVeterinarioPorNombre(
    IN p_nombre VARCHAR(100)
)
BEGIN
    SELECT u.*, v.especialidad, v.horario
    FROM usuarios u
    INNER JOIN veterinarios v ON u.id_usuario = v.id_usuario
    WHERE u.nombre LIKE CONCAT('%', p_nombre, '%');
END //

CREATE PROCEDURE BuscarVeterinarios()
BEGIN
    SELECT u.*, v.especialidad, v.horario
    FROM usuarios u
    INNER JOIN veterinarios v ON u.id_usuario = v.id_usuario;
END //
CREATE PROCEDURE EliminarVeterinario(
    IN p_id_usuario INT
)
BEGIN
    START TRANSACTION;
    DELETE FROM veterinarios WHERE id_usuario = p_id_usuario;
    DELETE FROM usuarios WHERE id_usuario = p_id_usuario;
    COMMIT;
END //
CREATE PROCEDURE ActualizarVeterinario(
    IN p_id_usuario INT,
    IN p_especialidad VARCHAR(100),
    IN p_horario VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al actualizar el veterinario';
    END;
    START TRANSACTION;
    UPDATE veterinarios
    SET especialidad = p_especialidad,
        horario = p_horario
    WHERE id_usuario = p_id_usuario;
    COMMIT;
END //