import mysql.connector
from mysql.connector import Error
from conexion import create_connection, close_connection

class HistorialMedico:

    @staticmethod
    def get_historiales():
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("SELECT * FROM historiales_medicos")
                historiales = cursor.fetchall()
                return historiales
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def get_historial_by_codigo(codigo):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("SELECT * FROM historiales_medicos WHERE codigo = %s", (codigo,))
                historial = cursor.fetchone()
                return historial
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def insert_historial(codigo, codigo_mascota, fecha, descripcion, tratamiento):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    INSERT INTO historiales_medicos (codigo, codigo_mascota, fecha, descripcion, tratamiento)
                    VALUES (%s, %s, %s, %s, %s)
                """, (codigo, codigo_mascota, fecha, descripcion, tratamiento))
                connection.commit()
                print("Historial médico insertado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def update_historial(codigo, descripcion, tratamiento):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    UPDATE historiales_medicos
                    SET descripcion = %s, tratamiento = %s
                    WHERE codigo = %s
                """, (descripcion, tratamiento, codigo))
                connection.commit()
                print("Historial médico actualizado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def delete_historial(codigo):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("DELETE FROM historiales_medicos WHERE codigo = %s", (codigo,))
                connection.commit()
                print("Historial médico eliminado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)
