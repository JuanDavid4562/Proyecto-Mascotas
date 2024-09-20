from conexion import create_connection, close_connection

class Registros:
    def __init__(self):
        self.connection = create_connection()
        self.cursor = self.connection.cursor(dictionary=True)

    def close(self):
        close_connection(self.connection)

    def ver_propietarios_y_mascotas(self):
        self.cursor.callproc('VerPropietariosYMascotas')
        results = []
        for result in self.cursor.stored_results():
            results = result.fetchall()
        return results

    def ver_todos_los_usuarios(self):
        self.cursor.callproc('VerTodosLosUsuarios')
        results = []
        for result in self.cursor.stored_results():
            results = result.fetchall()
        return results

    def ver_veterinarios_y_citas(self):
        self.cursor.callproc('VerVeterinariosYCitas')
        results = []
        for result in self.cursor.stored_results():
            results = result.fetchall()
        return results

    def ver_citas_y_servicios(self):
        self.cursor.callproc('VerCitasYServicios')
        results = []
        for result in self.cursor.stored_results():
            results = result.fetchall()
        return results

    def ver_citas_y_mascotas(self):
        self.cursor.callproc('VerCitasYMascotas')
        results = []
        for result in self.cursor.stored_results():
            results = result.fetchall()
        return results

    def ver_mascotas_y_historial_medico(self):
        self.cursor.callproc('VerMascotasYHistorialMedico')
        results = []
        for result in self.cursor.stored_results():
            results = result.fetchall()
        return results

if __name__ == "__main__":
    registros = Registros()
    try:
        propietarios_y_mascotas = registros.ver_propietarios_y_mascotas()
        print(propietarios_y_mascotas)

    finally:
        registros.close()
