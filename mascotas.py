import mysql.connector
from mysql.connector import Error
from conexion import create_connection, close_connection

class Mascotas:
    
    @staticmethod
    def get_mascotas():
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("SELECT * FROM mascotas")
                mascotas = cursor.fetchall()
                return mascotas
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def get_mascota_by_codigo(codigo):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("SELECT * FROM mascotas WHERE codigo = %s", (codigo,))
                mascota = cursor.fetchone()
                return mascota
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def get_mascota_by_nombre(nombre):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("SELECT * FROM mascotas WHERE nombre LIKE %s", ('%' + nombre + '%',))
                mascotas = cursor.fetchall()
                return mascotas
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def insert_mascota(codigo, nombre, especie, raza, edad, peso, id_usuario):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    INSERT INTO mascotas (codigo, nombre, especie, raza, edad, peso, id_usuario)
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                """, (codigo, nombre, especie, raza, edad, peso, id_usuario))
                connection.commit()
                print("Mascota insertada correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def update_mascota(codigo, nombre, especie, raza, edad, peso):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    UPDATE mascotas
                    SET nombre = %s, especie = %s, raza = %s, edad = %s, peso = %s
                    WHERE codigo = %s
                """, (nombre, especie, raza, edad, peso, codigo))
                connection.commit()
                print("Mascota actualizada correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def delete_mascota(codigo):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("DELETE FROM mascotas WHERE codigo = %s", (codigo,))
                connection.commit()
                print("Mascota eliminada correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)
