CREATE DATABASE IF NOT EXISTS mascotas_db;
USE mascotas_db;
CREATE TABLE usuarios (
    id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    es_propietario TINYINT(1) NOT NULL,
    es_administrador TINYINT(1) NOT NULL,
    es_veterinario TINYINT(1) NOT NULL
);
CREATE TABLE administradores (
    id_usuario INT NOT NULL PRIMARY KEY,
    cargo VARCHAR(100) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE TABLE veterinarios (
    id_usuario INT NOT NULL PRIMARY KEY,
    especialidad VARCHAR(100) NOT NULL,
    horario VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE TABLE propietarios (
    id_usuario INT NOT NULL PRIMARY KEY,
    barrio VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE TABLE mascotas (
    codigo INT UNSIGNED NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especie VARCHAR(100) NOT NULL,
    raza VARCHAR(100) NOT NULL,
    edad DECIMAL(10,2) NOT NULL,
    peso DECIMAL(10,2) NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES propietarios(id_usuario) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE TABLE productos (
    codigo INT UNSIGNED NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(20,2) NOT NULL,
    stock SMALLINT NOT NULL
);
CREATE TABLE servicios (
    codigo INT UNSIGNED NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(20,2) NOT NULL
);
CREATE TABLE citas (
    codigo INT UNSIGNED NOT NULL PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    id_servicio INT UNSIGNED NOT NULL,
    id_veterinario INT NOT NULL,
    codigo_mascota INT UNSIGNED NOT NULL,
    estado ENUM('pendiente', 'completada', 'cancelada') NOT NULL,
    FOREIGN KEY (id_servicio) REFERENCES servicios(codigo),
    FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id_usuario) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
    FOREIGN KEY (codigo_mascota) REFERENCES mascotas(codigo) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE TABLE historiales_medicos (
    codigo INT UNSIGNED NOT NULL PRIMARY KEY,
    codigo_mascota INT UNSIGNED NOT NULL,
    fecha DATE NOT NULL,
    descripcion TEXT NOT NULL,
    tratamiento TEXT NOT NULL,
    FOREIGN KEY (codigo_mascota) REFERENCES mascotas(codigo) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
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
DELIMITER ;
DELIMITER //
CREATE PROCEDURE VerPropietariosYMascotas()
BEGIN
    SELECT 
        p.id_usuario AS id_propietario, u.nombre AS nombre_propietario, u.apellido AS apellido_propietario,
        m.codigo AS codigo_mascota, m.nombre AS nombre_mascota, m.raza, m.especie, m.edad, m.peso
    FROM 
        propietarios p
    JOIN 
        usuarios u ON p.id_usuario = u.id_usuario
    JOIN 
        mascotas m ON p.id_usuario = m.id_usuario;
END //
CREATE PROCEDURE VerTodosLosUsuarios()
BEGIN
    SELECT 
        u.id_usuario, u.nombre, u.apellido, u.ciudad, u.direccion, u.telefono, u.email,
        'Propietario' AS tipo_usuario
    FROM 
        usuarios u
    JOIN 
        propietarios p ON u.id_usuario = p.id_usuario
    UNION
    SELECT 
        u.id_usuario, u.nombre, u.apellido, u.ciudad, u.direccion, u.telefono, u.email,
        'Administrador' AS tipo_usuario
    FROM 
        usuarios u
    JOIN 
        administradores a ON u.id_usuario = a.id_usuario
    UNION
    SELECT 
        u.id_usuario, u.nombre, u.apellido, u.ciudad, u.direccion, u.telefono, u.email,
        'Veterinario' AS tipo_usuario
    FROM 
        usuarios u
    JOIN 
        veterinarios v ON u.id_usuario = v.id_usuario;
END //
CREATE PROCEDURE VerVeterinariosYCitas()
BEGIN
    SELECT 
        v.id_usuario AS id_veterinario, u.nombre AS nombre_veterinario, u.apellido AS apellido_veterinario,
        c.codigo AS codigo_cita, c.fecha, c.hora, c.estado
    FROM 
        veterinarios v
    JOIN 
        usuarios u ON v.id_usuario = u.id_usuario
    JOIN 
        citas c ON v.id_usuario = c.id_veterinario;
END //
CREATE PROCEDURE VerCitasYServicios()
BEGIN
    SELECT 
        c.codigo AS codigo_cita, c.fecha, c.hora, c.estado,
        s.codigo AS codigo_servicio, s.nombre AS nombre_servicio, s.descripcion, s.precio
    FROM 
        citas c
    JOIN 
        servicios s ON c.id_servicio = s.codigo;
END //
CREATE PROCEDURE VerCitasYMascotas()
BEGIN
    SELECT 
        c.codigo AS codigo_cita, c.fecha, c.hora, c.estado,
        m.codigo AS codigo_mascota, m.nombre AS nombre_mascota, m.raza, m.especie, m.edad, m.peso
    FROM 
        citas c
    JOIN 
        mascotas m ON c.codigo_mascota = m.codigo;
END //
CREATE PROCEDURE VerMascotasYHistorialMedico()
BEGIN
    SELECT 
        m.codigo AS codigo_mascota, m.nombre AS nombre_mascota, m.raza, m.especie, m.edad, m.peso,
        h.codigo AS codigo_historial, h.fecha, h.descripcion, h.tratamiento
    FROM 
        mascotas m
    JOIN 
        historiales_medicos h ON m.codigo = h.codigo_mascota;
END //
DELIMITER ;
DELIMITER //
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
DELIMITER ;
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
DELIMITER //	
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
DELIMITER ;
INSERT INTO usuarios (nombre, apellido, ciudad, direccion, telefono, es_propietario, es_administrador, es_veterinario, email, contraseña) VALUES
('Ana', 'García', 'Barcelona', 'Calle Mayor 1', '123456789', 0, 1, 0, 'ana.garcia@example.com', 'password123'),
('Luis', 'Martínez', 'Madrid', 'Avenida de la Constitución 2', '987654321', 0, 1, 0, 'luis.martinez@example.com', 'password123'),
('Marta', 'López', 'Sevilla', 'Plaza de España 3', '555666777', 0, 1, 0, 'marta.lopez@example.com', 'password123'),
('Jorge', 'Fernández', 'Valencia', 'Calle de la Paz 4', '666555444', 0, 1, 0, 'jorge.fernandez@example.com', 'password123'),
('Carmen', 'Rodríguez', 'Bilbao', 'Gran Vía 5', '444333222', 0, 1, 0, 'carmen.rodriguez@example.com', 'password123'),
('Pedro', 'Sánchez', 'Granada', 'Avenida de la Ciencia 6', '333222111', 1, 0, 1, 'pedro.sanchez@example.com', 'password123'),
('Laura', 'Gómez', 'Toledo', 'Calle de la Libertad 7', '222111000', 1, 0, 0, 'laura.gomez@example.com', 'password123'),
('Raúl', 'Jiménez', 'Málaga', 'Calle del Mar 8', '111000999', 1, 0, 0, 'raul.jimenez@example.com', 'password123'),
('Isabel', 'Vázquez', 'Murcia', 'Avenida del Sol 9', '999888777', 0, 0, 1, 'isabel.vazquez@example.com', 'password123'),
('Manuel', 'Alonso', 'Alicante', 'Plaza del Ayuntamiento 10', '888777666', 0, 0, 1, 'manuel.alonso@example.com', 'password123');
INSERT INTO administradores (id_usuario, cargo, fecha_ingreso) VALUES
(1, 'Gerente', '2024-01-01'),
(2, 'Jefe de Finanzas', '2024-01-10'),
(3, 'Coordinador', '2024-01-15'),
(4, 'Encargado de Recursos Humanos', '2024-01-20'),
(5, 'Supervisor de Ventas', '2024-02-01'),
(6, 'Asistente Administrativo', '2024-02-05'),
(7, 'Director de Operaciones', '2024-02-10'),
(8, 'Jefe de Marketing', '2024-02-15'),
(9, 'Administrador de Sistemas', '2024-03-01'),
(10, 'Asesor Legal', '2024-03-05');
INSERT INTO veterinarios (id_usuario, especialidad, horario) VALUES
(1, 'Medicina General', 'Lunes-Viernes 9:00-17:00'),
(2, 'Cirugía Veterinaria', 'Lunes-Viernes 10:00-18:00'),
(3, 'Dermatología', 'Lunes-Viernes 9:00-15:00'),
(4, 'Odontología Veterinaria', 'Lunes-Viernes 11:00-19:00'),
(5, 'Cardiología', 'Lunes-Viernes 9:00-16:00'),
(6, 'Oncología', 'Lunes-Viernes 8:00-14:00'),
(7, 'Medicina Interna', 'Lunes-Viernes 10:00-17:00'),
(8, 'Neurología', 'Lunes-Viernes 12:00-20:00'),
(9, 'Rehabilitación', 'Lunes-Viernes 9:00-13:00'),
(10, 'Medicina Preventiva', 'Lunes-Viernes 10:00-16:00');
INSERT INTO propietarios (id_usuario, barrio) VALUES
(1, 'Centro'),
(2, 'Eixample'),
(3, 'Triana'),
(4, 'Ruzafa'),
(5, 'Abando'),
(6, 'El Palo'),
(7, 'Albaicín'),
(8, 'Centro Histórico'),
(9, 'San Blas'),
(10, 'El Carmen');
INSERT INTO mascotas (codigo, nombre, especie, raza, edad, peso, id_usuario) VALUES
(1, 'Rex', 'Perro', 'Labrador', 5, 30.5, 1),
(2, 'Mia', 'Gato', 'Siamés', 3, 4.2, 2),
(3, 'Max', 'Perro', 'Bulldog', 4, 25.3, 3),
(4, 'Luna', 'Gato', 'Persa', 2, 5.0, 4),
(5, 'Bella', 'Perro', 'Beagle', 6, 20.0, 5),
(6, 'Coco', 'Gato', 'Sphynx', 1, 3.5, 6),
(7, 'Rocky', 'Perro', 'Rottweiler', 7, 40.0, 7),
(8, 'Nina', 'Gato', 'Bengalí', 4, 4.8, 8),
(9, 'Daisy', 'Perro', 'Pomerania', 2, 3.0, 9),
(10, 'Simba', 'Gato', 'Maine Coon', 5, 7.0, 10);
INSERT INTO productos (codigo, nombre, descripcion, precio, stock) VALUES
(1, 'Croquetas para Perro', 'Croquetas nutritivas para perros adultos', 25.50, 100),
(2, 'Arena para Gato', 'Arena de alta absorción para gatos', 15.75, 50),
(3, 'Juguete para Perro', 'Juguete resistente para perros', 10.00, 200),
(4, 'Rascador para Gato', 'Rascador de sisal para gatos', 30.00, 75),
(5, 'Collar para Perro', 'Collar ajustable para perros', 12.00, 150),
(6, 'Comedero para Gato', 'Comedero de acero inoxidable para gatos', 8.50, 120),
(7, 'Shampoo para Perro', 'Shampoo suave para perros', 18.00, 60),
(8, 'Jaula para Gato', 'Jaula para transporte de gatos', 45.00, 30),
(9, 'Hueso para Perro', 'Hueso de nylon para perros', 5.00, 300),
(10, 'Cama para Gato', 'Cama cómoda para gatos', 22.00, 90);
INSERT INTO servicios (codigo, nombre, descripcion, precio) VALUES
(1, 'Consulta General', 'Consulta veterinaria general', 50.00),
(2, 'Vacunación', 'Vacunación contra enfermedades comunes', 30.00),
(3, 'Desparasitación', 'Desparasitación interna y externa', 25.00),
(4, 'Cirugía Menor', 'Cirugía menor para lesiones', 150.00),
(5, 'Examen de Laboratorio', 'Exámenes de laboratorio y pruebas', 70.00),
(6, 'Consulta Nutricional', 'Consulta sobre nutrición y dieta', 40.00),
(7, 'Tratamiento Dental', 'Tratamiento y limpieza dental', 80.00),
(8, 'Radiografía', 'Radiografía para diagnóstico', 90.00),
(9, 'Esterilización', 'Esterilización de mascotas', 120.00),
(10, 'Emergencia', 'Atención veterinaria de emergencia', 200.00);
INSERT INTO citas (codigo, fecha, hora, id_servicio, id_veterinario, codigo_mascota, estado) VALUES
(1, '2024-08-01', '09:00:00', 1, 1, 1, 'pendiente'),
(2, '2024-08-02', '10:00:00', 2, 2, 2, 'completada'),
(3, '2024-08-03', '11:00:00', 3, 3, 3, 'cancelada'),
(4, '2024-08-04', '12:00:00', 4, 4, 4, 'pendiente'),
(5, '2024-08-05', '13:00:00', 5, 5, 5, 'completada'),
(6, '2024-08-06', '14:00:00', 6, 6, 6, 'pendiente'),
(7, '2024-08-07', '15:00:00', 7, 7, 7, 'completada'),
(8, '2024-08-08', '16:00:00', 8, 8, 8, 'cancelada'),
(9, '2024-08-09', '17:00:00', 9, 9, 9, 'pendiente'),
(10, '2024-08-10', '18:00:00', 10, 10, 10, 'completada');
INSERT INTO historiales_medicos (codigo, codigo_mascota, fecha, descripcion, tratamiento) VALUES
(1, 1, '2024-08-01', 'Chequeo general', 'Sin tratamiento necesario'),
(2, 2, '2024-08-02', 'Vacunación anual', 'Vacuna contra la rabia'),
(3, 3, '2024-08-03', 'Desparasitación interna', 'Desparasitante oral'),
(4, 4, '2024-08-04', 'Tratamiento para infección', 'Antibióticos y descanso'),
(5, 5, '2024-08-05', 'Consulta nutricional', 'Cambios en la dieta'),
(6, 6, '2024-08-06', 'Tratamiento dental', 'Limpieza y revisión dental'),
(7, 7, '2024-08-07', 'Radiografía de tórax', 'Revisión de pulmones'),
(8, 8, '2024-08-08', 'Esterilización', 'Procedimiento de esterilización'),
(9, 9, '2024-08-09', 'Emergencia por accidente', 'Atención de emergencia'),
(10, 10, '2024-08-10', 'Chequeo post-cirugía', 'Revisión tras cirugía');