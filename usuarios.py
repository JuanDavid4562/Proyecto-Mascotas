import mysql.connector
from mysql.connector import Error
from conexion import create_connection, close_connection

class Usuarios:
    
    @staticmethod
    def get_usuarios():
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute('SELECT * FROM usuarios')
                usuarios = cursor.fetchall()
                return usuarios
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def get_usuario_by_codigo(id_usuario):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("SELECT * FROM usuarios WHERE id_usuario = %s", (id_usuario,))
                usuario = cursor.fetchone()
                return usuario
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def insert_usuario(nombre, apellido, ciudad, direccion, telefono, es_propietario, es_administrador, es_veterinario, email, contraseña):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    INSERT INTO usuarios (nombre, apellido, ciudad, direccion, telefono, es_propietario, es_administrador, es_veterinario, email, contraseña)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """, (nombre, apellido, ciudad, direccion, telefono, es_propietario, es_administrador, es_veterinario, email, contraseña))
                connection.commit()
                print("Usuario insertado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def update_usuario(id_usuario, nombre, apellido, ciudad, direccion, telefono, es_propietario, es_administrador, es_veterinario, email, contraseña):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    UPDATE usuarios
                    SET nombre = %s, apellido = %s, ciudad = %s, direccion = %s, telefono = %s, es_propietario = %s, es_administrador = %s, es_veterinario = %s, email = %s, contraseña = %s
                    WHERE id_usuario = %s
                """, (nombre, apellido, ciudad, direccion, telefono, es_propietario, es_administrador, es_veterinario, email, contraseña, id_usuario))
                connection.commit()
                print("Usuario actualizado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def delete_usuario(id_usuario):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("DELETE FROM usuarios WHERE id_usuario = %s", (id_usuario,))
                connection.commit()
                print("Usuario eliminado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

