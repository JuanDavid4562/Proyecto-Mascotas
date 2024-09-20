from conexion import create_connection, close_connection

class Registros:
    def __init__(self):
        self.connection = create_connection()
        self.cursor = self.connection.cursor(dictionary=True)

    def close(self):
        close_connection(self.connection)

    def ver_propietarios_y_mascotas(self):
        query = """
        SELECT 
            p.id_usuario AS id_propietario, u.nombre AS nombre_propietario, u.apellido AS apellido_propietario,
            m.codigo AS codigo_mascota, m.nombre AS nombre_mascota, m.raza, m.especie, m.edad, m.peso
        FROM 
            propietarios p
        JOIN 
            usuarios u ON p.id_usuario = u.id_usuario
        JOIN 
            mascotas m ON p.id_usuario = m.id_usuario;
        """
        self.cursor.execute(query)
        return self.cursor.fetchall()

    def ver_todos_los_usuarios(self):
        query = """
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
        """
        self.cursor.execute(query)
        return self.cursor.fetchall()

    def ver_veterinarios_y_citas(self):
        query = """
        SELECT 
            v.id_usuario AS id_veterinario, u.nombre AS nombre_veterinario, u.apellido AS apellido_veterinario,
            c.codigo AS codigo_cita, c.fecha, c.hora, c.estado
        FROM 
            veterinarios v
        JOIN 
            usuarios u ON v.id_usuario = u.id_usuario
        JOIN 
            citas c ON v.id_usuario = c.id_veterinario;
        """
        self.cursor.execute(query)
        return self.cursor.fetchall()

    def ver_citas_y_servicios(self):
        query = """
        SELECT 
            c.codigo AS codigo_cita, c.fecha, c.hora, c.estado,
            s.codigo AS codigo_servicio, s.nombre AS nombre_servicio, s.descripcion, s.precio
        FROM 
            citas c
        JOIN 
            servicios s ON c.id_servicio = s.codigo;
        """
        self.cursor.execute(query)
        return self.cursor.fetchall()

    def ver_citas_y_mascotas(self):
        query = """
        SELECT 
            c.codigo AS codigo_cita, c.fecha, c.hora, c.estado,
            m.codigo AS codigo_mascota, m.nombre AS nombre_mascota, m.raza, m.especie, m.edad, m.peso
        FROM 
            citas c
        JOIN 
            mascotas m ON c.codigo_mascota = m.codigo;
        """
        self.cursor.execute(query)
        return self.cursor.fetchall()

    def ver_mascotas_y_historial_medico(self):
        query = """
        SELECT 
            m.codigo AS codigo_mascota, m.nombre AS nombre_mascota, m.raza, m.especie, m.edad, m.peso,
            h.codigo AS codigo_historial, h.fecha, h.descripcion, h.tratamiento
        FROM 
            mascotas m
        JOIN 
            historiales_medicos h ON m.codigo = h.codigo_mascota;
        """
        self.cursor.execute(query)
        return self.cursor.fetchall()

if __name__ == "__main__":
    registros = Registros()
    try:
        propietarios_y_mascotas = registros.ver_propietarios_y_mascotas()
        print(propietarios_y_mascotas)

    finally:
        registros.close()
