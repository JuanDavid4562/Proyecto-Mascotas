USE mascotas_db;
DELIMITER //
CREATE PROCEDURE InsertarUsuario(
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_ciudad VARCHAR(50),
    IN p_direccion VARCHAR(50),
    IN p_telefono VARCHAR(10),
    IN p_email VARCHAR(50),
    IN p_contraseña VARCHAR(255)
)
BEGIN
    INSERT INTO usuarios (nombre, apellido, ciudad, direccion, telefono, email, contraseña)
    VALUES (p_nombre, p_apellido, p_ciudad, p_direccion, p_telefono, p_email, p_contraseña);
END //
CREATE PROCEDURE ActualizarUsuario(
    IN p_id_usuario INT,
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_ciudad VARCHAR(50),
    IN p_direccion VARCHAR(50),
    IN p_telefono VARCHAR(10),
    IN p_email VARCHAR(50),
    IN p_contraseña VARCHAR(255)
)
BEGIN
    UPDATE usuarios
    SET nombre = p_nombre,
        apellido = p_apellido,
        ciudad = p_ciudad,
        direccion = p_direccion,
        telefono = p_telefono,
        email = p_email,
        contraseña = p_contraseña
    WHERE id_usuario = p_id_usuario;
END //
CREATE PROCEDURE ConsultarUsuarioPorCodigo(
    IN p_id_usuario INT
)
BEGIN
    SELECT *
    FROM usuarios
    WHERE id_usuario = p_id_usuario;
END //
CREATE PROCEDURE ConsultarUsuarioPorEmail(
    IN p_email VARCHAR(50)
)
BEGIN
    SELECT *
    FROM usuarios
    WHERE email = p_email;
END //
CREATE PROCEDURE ConsultarTodosUsuarios()
BEGIN
    SELECT *
    FROM usuarios;
END //
CREATE PROCEDURE EliminarUsuario(
    IN p_id_usuario INT
)
BEGIN
    DELETE FROM usuarios
    WHERE id_usuario = p_id_usuario;
END //
DELIMITER ;
