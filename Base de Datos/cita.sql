USE mascotas_db;
DELIMITER //
CREATE PROCEDURE InsertarCita(
    IN p_codigo INT UNSIGNED,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_id_servicio INT UNSIGNED,
    IN p_id_veterinario INT,
    IN p_codigo_mascota INT UNSIGNED,
    IN p_estado ENUM('pendiente', 'completada', 'cancelada')
)
BEGIN
    START TRANSACTION;
    INSERT INTO citas (codigo, fecha, hora, id_servicio, id_veterinario, codigo_mascota, estado)
    VALUES (p_codigo, p_fecha, p_hora, p_id_servicio, p_id_veterinario, p_codigo_mascota, p_estado);
    COMMIT;
END //
CREATE PROCEDURE BuscarCitaPorFecha(
    IN p_fecha DATE
)
BEGIN
    SELECT * FROM citas WHERE fecha = p_fecha;
END //

CREATE PROCEDURE BuscarCitaPorMascota(
    IN p_codigo_mascota INT UNSIGNED
)
BEGIN
    SELECT * FROM citas WHERE codigo_mascota = p_codigo_mascota;
END //
CREATE PROCEDURE BuscarCitas()
BEGIN
    SELECT * FROM citas;
END //
CREATE PROCEDURE EliminarCita(
    IN p_codigo INT UNSIGNED
)
BEGIN
    START TRANSACTION;
    DELETE FROM citas WHERE codigo = p_codigo;
    COMMIT;
END //
CREATE PROCEDURE ActualizarCita(
    IN p_codigo INT UNSIGNED,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_id_servicio INT UNSIGNED,
    IN p_id_veterinario INT,
    IN p_codigo_mascota INT UNSIGNED,
    IN p_estado ENUM('pendiente', 'completada', 'cancelada')
)
BEGIN
    START TRANSACTION;
    UPDATE citas
    SET fecha = p_fecha, hora = p_hora, id_servicio = p_id_servicio, id_veterinario = p_id_veterinario, codigo_mascota = p_codigo_mascota, estado = p_estado
    WHERE codigo = p_codigo;
    COMMIT;
END //
DELIMITER ;