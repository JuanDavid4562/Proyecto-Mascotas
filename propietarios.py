import mysql.connector
from mysql.connector import Error
from conexion import create_connection, close_connection

class Propietarios:
    
    @staticmethod
    def get_propietarios():
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("""
                    SELECT p.*, u.nombre, u.apellido, u.email 
                    FROM propietarios p
                    JOIN usuarios u ON p.id_usuario = u.id_usuario
                """)
                propietarios = cursor.fetchall()
                return propietarios
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def get_propietario_by_codigo(id_usuario):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("""
                    SELECT p.*, u.nombre, u.apellido, u.email 
                    FROM propietarios p
                    JOIN usuarios u ON p.id_usuario = u.id_usuario
                    WHERE p.id_usuario = %s
                """, (id_usuario,))
                propietario = cursor.fetchone()
                return propietario
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def get_propietario_by_nombre(nombre):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("""
                    SELECT p.*, u.nombre, u.apellido, u.email 
                    FROM propietarios p
                    JOIN usuarios u ON p.id_usuario = u.id_usuario
                    WHERE u.nombre LIKE %s
                """, ('%' + nombre + '%',))
                propietarios = cursor.fetchall()
                return propietarios
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def insert_propietario(id_usuario, barrio):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    INSERT INTO propietarios (id_usuario, barrio)
                    VALUES (%s, %s)
                """, (id_usuario, barrio))
                connection.commit()
                print("Propietario insertado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def update_propietario(id_usuario, barrio):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    UPDATE propietarios
                    SET barrio = %s
                    WHERE id_usuario = %s
                """, (barrio, id_usuario))
                connection.commit()
                print("Propietario actualizado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def delete_propietario(id_usuario):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("DELETE FROM mascotas WHERE id_usuario = %s", (id_usuario,))
                cursor.execute("DELETE FROM propietarios WHERE id_usuario = %s", (id_usuario,))
                connection.commit()
                print("Propietario eliminado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)
