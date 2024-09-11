import mysql.connector
from mysql.connector import Error
from conexion import create_connection, close_connection

class Servicios:

    @staticmethod
    def get_servicios():
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("SELECT * FROM servicios")
                servicios = cursor.fetchall()
                return servicios
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def get_servicio_by_codigo(codigo):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("SELECT * FROM servicios WHERE codigo = %s", (codigo,))
                servicio = cursor.fetchone()
                return servicio
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def insert_servicio(codigo, nombre, descripcion, precio):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    INSERT INTO servicios (codigo, nombre, descripcion, precio)
                    VALUES (%s, %s, %s, %s)
                """, (codigo, nombre, descripcion, precio))
                connection.commit()
                print("Servicio insertado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def update_servicio(codigo, nombre, descripcion, precio):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    UPDATE servicios
                    SET nombre = %s, descripcion = %s, precio = %s
                    WHERE codigo = %s
                """, (nombre, descripcion, precio, codigo))
                connection.commit()
                print("Servicio actualizado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def delete_servicio(codigo):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("DELETE FROM servicios WHERE codigo = %s", (codigo,))
                connection.commit()
                print("Servicio eliminado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)
