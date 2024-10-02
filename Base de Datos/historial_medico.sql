USE mascotas_db;
DELIMITER //
CREATE PROCEDURE InsertarHistorialMedico(
    IN p_codigo INT UNSIGNED,
    IN p_codigo_mascota INT UNSIGNED,
    IN p_fecha DATE,
    IN p_descripcion TEXT,
    IN p_tratamiento TEXT
)
BEGIN
    START TRANSACTION;
    INSERT INTO historiales_medicos (codigo, codigo_mascota, fecha, descripcion, tratamiento)
    VALUES (p_codigo, p_codigo_mascota, p_fecha, p_descripcion, p_tratamiento);
    COMMIT;
END //
CREATE PROCEDURE BuscarHistorialPorMascota(
    IN p_codigo_mascota INT UNSIGNED
)
BEGIN
    SELECT * FROM historiales_medicos WHERE codigo_mascota = p_codigo_mascota;
END //
CREATE PROCEDURE ActualizarHistorialPorCodigo(
    IN p_codigo INT UNSIGNED,
    IN p_codigo_mascota INT UNSIGNED,
    IN p_fecha DATE,
    IN p_descripcion TEXT,
    IN p_tratamiento TEXT
)
BEGIN
    START TRANSACTION;
    UPDATE historiales_medicos
    SET codigo_mascota = p_codigo_mascota, fecha = p_fecha, descripcion = p_descripcion, tratamiento = p_tratamiento
    WHERE codigo = p_codigo;
    COMMIT;
END //
CREATE PROCEDURE EliminarHistorial(
    IN p_codigo INT UNSIGNED
)
BEGIN
    START TRANSACTION;
    DELETE FROM historiales_medicos WHERE codigo = p_codigo;
    COMMIT;
END //
CREATE PROCEDURE ActualizarHistorialMedico(
    IN p_codigo INT UNSIGNED,
    IN p_codigo_mascota INT UNSIGNED,
    IN p_fecha DATE,
    IN p_descripcion TEXT,
    IN p_tratamiento TEXT
)
BEGIN
    START TRANSACTION;
    UPDATE historiales_medicos
    SET codigo_mascota = p_codigo_mascota, fecha = p_fecha, descripcion = p_descripcion, tratamiento = p_tratamiento
    WHERE codigo = p_codigo;
    COMMIT;
END //