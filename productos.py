import mysql.connector
from mysql.connector import Error
from conexion import create_connection, close_connection

class Productos:

    @staticmethod
    def get_productos():
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("SELECT * FROM productos")
                productos = cursor.fetchall()
                return productos
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def get_producto_by_codigo(codigo):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor(dictionary=True)
                cursor.execute("SELECT * FROM productos WHERE codigo = %s", (codigo,))
                producto = cursor.fetchone()
                return producto
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def insert_producto(codigo, nombre, descripcion, precio, stock):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    INSERT INTO productos (codigo, nombre, descripcion, precio, stock)
                    VALUES (%s, %s, %s, %s, %s)
                """, (codigo, nombre, descripcion, precio, stock))
                connection.commit()
                print("Producto insertado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def update_producto(codigo, nombre, descripcion, precio, stock):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    UPDATE productos
                    SET nombre = %s, descripcion = %s, precio = %s, stock = %s
                    WHERE codigo = %s
                """, (nombre, descripcion, precio, stock, codigo))
                connection.commit()
                print("Producto actualizado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)

    @staticmethod
    def delete_producto(codigo):
        connection = create_connection()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("DELETE FROM productos WHERE codigo = %s", (codigo,))
                connection.commit()
                print("Producto eliminado correctamente.")
            except Error as err:
                print(f"Error: {err}")
            finally:
                cursor.close()
                close_connection(connection)
