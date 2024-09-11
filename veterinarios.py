import mysql.connector
from mysql.connector import Error
from conexion import create_connection, close_connection

class Veterinarios:
    
    @staticmethod
    def get_veterinarios():
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("""
                    SELECT v.*, u.nombre, u.apellido, u.contraseña
                    FROM veterinarios v
                    JOIN usuarios u ON v.id_usuario = u.id_usuario
                """)
                veterinarios = cursor.fetchall()
                return veterinarios
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def get_veterinario_by_codigo(id_usuario):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("""
                    SELECT v.*, u.nombre, u.apellido, u.contraseña
                    FROM veterinarios v
                    JOIN usuarios u ON v.id_usuario = u.id_usuario
                    WHERE v.id_usuario = %s
                """, (id_usuario,))
                veterinario = cursor.fetchone()
                return veterinario
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def get_veterinario_by_nombre(nombre):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("""
                    SELECT v.*, u.nombre, u.apellido, u.contraseña
                    FROM veterinarios v
                    JOIN usuarios u ON v.id_usuario = u.id_usuario
                    WHERE u.nombre LIKE %s
                """, ('%' + nombre + '%',))
                veterinarios = cursor.fetchall()
                return veterinarios
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def insert_veterinario(id_usuario, especialidad, horario):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    INSERT INTO veterinarios (id_usuario, especialidad, horario)
                    VALUES (%s, %s, %s)
                """, (id_usuario, especialidad, horario))
                connection.commit()
                print("Veterinario insertado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def update_veterinario(id_usuario, especialidad, horario):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    UPDATE veterinarios
                    SET especialidad = %s, horario = %s
                    WHERE id_usuario = %s
                """, (especialidad, horario, id_usuario))
                connection.commit()
                print("Veterinario actualizado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def delete_veterinario(id_usuario):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("DELETE FROM veterinarios WHERE id_usuario = %s", (id_usuario,))
                connection.commit()
                print("Veterinario eliminado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)
