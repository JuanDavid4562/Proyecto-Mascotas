USE mascotas_db;
DELIMITER //
CREATE PROCEDURE InsertarMascota(
    IN p_codigo INT UNSIGNED,
    IN p_nombre VARCHAR(100),
    IN p_especie VARCHAR(100),
    IN p_raza VARCHAR(100),
    IN p_edad DECIMAL(10,2),
    IN p_peso DECIMAL(10,2),
    IN p_id_usuario INT
)
BEGIN
    START TRANSACTION;
    INSERT INTO mascotas (codigo, nombre, especie, raza, edad, peso, id_usuario)
    VALUES (p_codigo, p_nombre, p_especie, p_raza, p_edad, p_peso, p_id_usuario);
    COMMIT;
END //
CREATE PROCEDURE BuscarMascotaPorCodigo(
    IN p_codigo INT UNSIGNED
)
BEGIN
    SELECT * FROM mascotas WHERE codigo = p_codigo;
END //
CREATE PROCEDURE BuscarMascotaPorNombre(
    IN p_nombre VARCHAR(100)
)
BEGIN
    SELECT * FROM mascotas WHERE nombre LIKE CONCAT('%', p_nombre, '%');
END //
CREATE PROCEDURE BuscarMascotas()
BEGIN
    SELECT * FROM mascotas;
END //
CREATE PROCEDURE EliminarMascota(
    IN p_codigo INT UNSIGNED
)
BEGIN
    START TRANSACTION;
    DELETE FROM mascotas WHERE codigo = p_codigo;
    COMMIT;
END //
CREATE PROCEDURE ActualizarMascota(
    IN p_codigo INT UNSIGNED,
    IN p_nombre VARCHAR(100),
    IN p_especie VARCHAR(100),
    IN p_raza VARCHAR(100),
    IN p_edad DECIMAL(10,2),
    IN p_peso DECIMAL(10,2),
    IN p_id_usuario INT
)
BEGIN
    START TRANSACTION;
    UPDATE mascotas
    SET nombre = p_nombre, especie = p_especie, raza = p_raza, edad = p_edad, peso = p_peso, id_usuario = p_id_usuario
    WHERE codigo = p_codigo;
    COMMIT;
END //