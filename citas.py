import mysql.connector
from mysql.connector import Error
from conexion import create_connection, close_connection

class Citas:

    @staticmethod
    def get_citas():
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("SELECT * FROM citas")
                citas = cursor.fetchall()
                return citas
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def get_cita_by_codigo(codigo):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("SELECT * FROM citas WHERE codigo = %s", (codigo,))
                cita = cursor.fetchone()
                return cita
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def insert_cita(codigo, fecha, hora, id_servicio, id_veterinario, codigo_mascota, estado):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    INSERT INTO citas (codigo, fecha, hora, id_servicio, id_veterinario, codigo_mascota, estado)
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                """, (codigo, fecha, hora, id_servicio, id_veterinario, codigo_mascota, estado))
                connection.commit()
                print("Cita insertada correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def update_cita(codigo, estado):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    UPDATE citas
                    SET estado = %s
                    WHERE codigo = %s
                """, (estado, codigo))
                connection.commit()
                print("Cita actualizada correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def delete_cita(codigo):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("DELETE FROM citas WHERE codigo = %s", (codigo,))
                connection.commit()
                print("Cita eliminada correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)
