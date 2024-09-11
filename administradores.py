import mysql.connector
from mysql.connector import Error
from conexion import create_connection, close_connection

class Administradores:
    
    @staticmethod
    def get_administradores():
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("""
                    SELECT a.*, u.nombre, u.apellido, u.email
                    FROM administradores a
                    JOIN usuarios u ON a.id_usuario = u.id_usuario
                """)
                administradores = cursor.fetchall()
                return administradores
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def get_administrador_by_codigo(id_usuario):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("""
                    SELECT a.*, u.nombre, u.apellido, u.email
                    FROM administradores a
                    JOIN usuarios u ON a.id_usuario = u.id_usuario
                    WHERE a.id_usuario = %s
                """, (id_usuario,))
                administrador = cursor.fetchone()
                return administrador
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def get_administrador_by_nombre(nombre):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("""
                    SELECT a.*, u.nombre, u.apellido, u.email
                    FROM administradores a
                    JOIN usuarios u ON a.id_usuario = u.id_usuario
                    WHERE u.nombre LIKE %s
                """, ('%' + nombre + '%',))
                administradores = cursor.fetchall()
                return administradores
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def insert_administrador(id_usuario):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("INSERT INTO administradores (id_usuario) VALUES (%s)", (id_usuario,))
                connection.commit()
                print("Administrador insertado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def update_administrador(id_usuario):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    UPDATE administradores
                    SET id_usuario = %s
                    WHERE id_usuario = %s
                """, (id_usuario, id_usuario))
                connection.commit()
                print("Administrador actualizado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def delete_administrador(id_usuario):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("DELETE FROM administradores WHERE id_usuario = %s", (id_usuario,))
                connection.commit()
                print("Administrador eliminado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)
