USE mascotas_db;
DELIMITER //
CREATE PROCEDURE InsertarServicio(
    IN p_codigo INT UNSIGNED,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(20,2)
)
BEGIN
    START TRANSACTION;
    INSERT INTO servicios (codigo, nombre, descripcion, precio)
    VALUES (p_codigo, p_nombre, p_descripcion, p_precio);
    COMMIT;
END //
CREATE PROCEDURE BuscarServicioPorCodigo(
    IN p_codigo INT UNSIGNED
)
BEGIN
    SELECT * FROM servicios WHERE codigo = p_codigo;
END //

CREATE PROCEDURE BuscarServicioPorNombre(
    IN p_nombre VARCHAR(100)
)
BEGIN
    SELECT * FROM servicios WHERE nombre LIKE CONCAT('%', p_nombre, '%');
END //
CREATE PROCEDURE BuscarServicios()
BEGIN
    SELECT * FROM servicios;
END //
CREATE PROCEDURE EliminarServicio(
    IN p_codigo INT UNSIGNED
)
BEGIN
    START TRANSACTION;
    DELETE FROM servicios WHERE codigo = p_codigo;
    COMMIT;
END //
CREATE PROCEDURE ActualizarServicio(
    IN p_codigo INT UNSIGNED,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(20,2)
)
BEGIN
    START TRANSACTION;
    UPDATE servicios
    SET nombre = p_nombre, descripcion = p_descripcion, precio = p_precio
    WHERE codigo = p_codigo;
    COMMIT;
END //