USE mascotas_db;
DELIMITER //
CREATE PROCEDURE InsertarProducto(
    IN p_codigo INT UNSIGNED,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(20,2),
    IN p_stock SMALLINT
)
BEGIN
    START TRANSACTION;
    INSERT INTO productos (codigo, nombre, descripcion, precio, stock)
    VALUES (p_codigo, p_nombre, p_descripcion, p_precio, p_stock);
    COMMIT;
END //
CREATE PROCEDURE BuscarProductoPorCodigo(
    IN p_codigo INT UNSIGNED
)
BEGIN
    SELECT * FROM productos WHERE codigo = p_codigo;
END //
CREATE PROCEDURE BuscarProductoPorNombre(
    IN p_nombre VARCHAR(100)
)
BEGIN
    SELECT * FROM productos WHERE nombre LIKE CONCAT('%', p_nombre, '%');
END //
CREATE PROCEDURE BuscarProductos()
BEGIN
    SELECT * FROM productos;
END //
CREATE PROCEDURE EliminarProducto(
    IN p_codigo INT UNSIGNED
)
BEGIN
    START TRANSACTION;
    DELETE FROM productos WHERE codigo = p_codigo;
    COMMIT;
END //
CREATE PROCEDURE ActualizarProducto(
    IN p_codigo INT UNSIGNED,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(20,2),
    IN p_stock SMALLINT
)
BEGIN
    START TRANSACTION;
    UPDATE productos
    SET nombre = p_nombre, descripcion = p_descripcion, precio = p_precio, stock = p_stock
    WHERE codigo = p_codigo;
    COMMIT;
END //