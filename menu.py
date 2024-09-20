from mascotas import Mascotas
from propietarios import Propietarios
from administradores import Administradores
from veterinarios import Veterinarios
from usuarios import Usuarios
from historial_medico import HistorialMedico
from citas import Citas
from productos import Productos
from servicios import Servicios
from registros import Registros  # Asegúrate de importar la clase Registros

class Menu:
    def __init__(self):
        self.mascotas = Mascotas()
        self.usuarios = Usuarios()
        self.administradores = Administradores()
        self.veterinarios = Veterinarios()
        self.propietarios = Propietarios()
        self.historial_medico = HistorialMedico()
        self.citas = Citas()
        self.productos = Productos()
        self.servicios = Servicios()
        self.registros = Registros()  # Instancia de la clase Registros

    def show_main_menu(self):
        while True:
            print("\nMenú Principal:")
            print("1. Mascotas")
            print("2. Usuarios")
            print("3. Administradores")
            print("4. Veterinarios")
            print("5. Propietarios")
            print("6. Historial médico")
            print("7. Citas")
            print("8. Productos")
            print("9. Servicios")
            print("10. Ver Registros")
            print("11. Salir")
            
            choice = input("Ingrese su opción: ")
            
            if choice == '1':
                self.show_mascota_menu()
                
            elif choice == '2':
                self.show_usuarios_menu()
            
            elif choice == '3':
                self.show_administradores_menu()
            
            elif choice == '4':
                self.show_veterinarios_menu()
            
            elif choice == '5':
                self.show_propietarios_menu()
                
            elif choice == '6':
                self.show_historial_medico_menu()
                
            elif choice == '7':
                self.show_citas_menu()
                
            elif choice == '8':
                self.show_productos_menu()
                
            elif choice == '9':
                self.show_servicios_menu()
                
            elif choice == '10':
                self.show_registros_menu() 
            
            elif choice == '11':
                break
            
            else:
                print("Opción no válida. Inténtelo de nuevo.")

    def show_registros_menu(self):
        while True:
            print("\nMenú de Registros:")
            print("1. Ver Propietarios y Mascotas")
            print("2. Ver Todos los Usuarios")
            print("3. Ver Veterinarios y Citas")
            print("4. Ver Citas y Servicios")
            print("5. Ver Citas y Mascotas")
            print("6. Ver Mascotas y Historial Médico")
            print("7. Volver al menú principal")

            choice = input("Ingrese su opción: ")

            if choice == '1':
                propietarios_y_mascotas = self.registros.ver_propietarios_y_mascotas()
                for registro in propietarios_y_mascotas:
                    print(registro)

            elif choice == '2':
                todos_los_usuarios = self.registros.ver_todos_los_usuarios()
                for usuario in todos_los_usuarios:
                    print(usuario)

            elif choice == '3':
                veterinarios_y_citas = self.registros.ver_veterinarios_y_citas()
                for registro in veterinarios_y_citas:
                    print(registro)

            elif choice == '4':
                citas_y_servicios = self.registros.ver_citas_y_servicios()
                for registro in citas_y_servicios:
                    print(registro)

            elif choice == '5':
                citas_y_mascotas = self.registros.ver_citas_y_mascotas()
                for registro in citas_y_mascotas:
                    print(registro)

            elif choice == '6':
                mascotas_y_historial_medico = self.registros.ver_mascotas_y_historial_medico()
                for registro in mascotas_y_historial_medico:
                    print(registro)

            elif choice == '7':
                break

            else:
                print("Opción no válida. Inténtelo de nuevo.")
    
    def show_mascota_menu(self):
        while True:
            print("\nMenú de Mascotas:")
            print("1. Ver todas las mascotas")
            print("2. Ver mascota por código")
            print("3. Buscar mascotas por nombre")
            print("4. Insertar mascota")
            print("5. Actualizar mascota")
            print("6. Eliminar mascota")
            print("7. Volver al menú principal")

            choice = input("Ingrese su opción: ")

            if choice == '1':
                mascotas = self.mascotas.get_mascotas()
                for mascota in mascotas:
                    print(mascota)
            
            elif choice == '2':
                codigo = int(input("Ingrese el código de la mascota: "))
                mascota = self.mascotas.get_mascota_by_codigo(codigo)
                if mascota:
                    print(mascota)
                else:
                    print("Mascota no encontrada.")

            elif choice == '3':
                nombre = input("Ingrese el nombre de la mascota: ")
                mascotas = self.mascotas.get_mascota_by_nombre(nombre)
                if mascotas:
                    for mascota in mascotas:
                        print(mascota)
                else:
                    print("No se encontraron mascotas con ese nombre.")

            elif choice == '4':
                codigo = int(input("Código de la mascota: "))
                nombre = input("Nombre: ")
                especie = input("Especie: ")
                raza = input("Raza: ")
                edad = float(input("Edad: "))
                peso = float(input("Peso: "))
                id_usuario = int(input("ID del propietario: "))
                self.mascotas.insert_mascota(codigo, nombre, especie, raza, edad, peso, id_usuario)
            
            elif choice == '5':
                codigo = int(input("Código de la mascota a actualizar: "))
                nombre = input("Nuevo nombre: ")
                especie = input("Nueva especie: ")
                raza = input("Nueva raza: ")
                edad = float(input("Nueva edad: "))
                peso = float(input("Nuevo peso: "))
                self.mascotas.update_mascota(codigo, nombre, especie, raza, edad, peso)
            
            elif choice == '6':
                codigo = int(input("Código de la mascota a eliminar: "))
                self.mascotas.delete_mascota(codigo)
            
            elif choice == '7':
                break
            
            else:
                print("Opción no válida. Inténtelo de nuevo.")
    
    def show_usuarios_menu(self):
        while True:
            print("\nMenú de Usuarios:")
            print("1. Ver todos los usuarios")
            print("2. Ver usuario por código")
            print("3. Insertar usuario")
            print("4. Actualizar usuario")
            print("5. Eliminar usuario")
            print("6. Volver al menú principal")

            choice = input("Ingrese su opción: ")

            if choice == '1':
                usuarios = self.usuarios.get_usuarios()
                for usuario in usuarios:
                    print(usuario)
            
            elif choice == '2':
                id_usuario = int(input("Ingrese el código del usuario: "))
                usuario = self.usuarios.get_usuario_by_codigo(id_usuario)
                if usuario:
                    print(usuario)
                else:
                    print("Usuario no encontrado.")

            elif choice == '3':
                nombre = input("Ingrese nombre del usuario: ")
                apellido = input("Ingrese apellido del usuario: ")
                ciudad = input("Ingrese la ciudad del usuario: ")
                direccion = input("Ingrese la dirección del usuario: ")
                telefono = input("Ingrese el teléfono del usuario: ")
                email = input("Ingrese el email del usuario: ")
                contraseña = input("Ingrese la contraseña del usuario: ")

                es_propietario = int(input("¿Es propietario? (1 para Sí, 0 para No): "))
                es_administrador = int(input("¿Es administrador? (1 para Sí, 0 para No): "))
                es_veterinario = int(input("¿Es veterinario? (1 para Sí, 0 para No): "))

                self.usuarios.insert_usuario(nombre, apellido, ciudad, direccion, telefono, es_propietario, es_administrador, es_veterinario, email, contraseña)

                id_usuario = self.usuarios.get_usuarios()[-1]['id_usuario']

                if es_propietario == 1:
                    barrio = input("Ingrese el barrio del propietario: ")
                    self.propietarios.insert_propietario(id_usuario, barrio)
                elif es_administrador == 1:
                    cargo = input("Ingrese el cargo del administrador: ")
                    fecha_ingreso = input("Ingrese la fecha de ingreso (YYYY-MM-DD): ")
                    self.administradores.insert_administrador(id_usuario, cargo, fecha_ingreso)
                elif es_veterinario == 1:
                    especialidad = input("Ingrese la especialidad del veterinario: ")
                    horario = input("Ingrese el horario del veterinario: ")
                    self.veterinarios.insert_veterinario(id_usuario, especialidad, horario)
            
            elif choice == '4':
                id_usuario = int(input("Ingrese código del usuario para actualizar: "))
                nombre = input("Ingrese el nuevo nombre del usuario: ")
                apellido = input("Ingrese el nuevo apellido del usuario: ")
                ciudad = input("Ingrese la nueva ciudad del usuario: ")
                direccion = input("Ingrese la nueva dirección del usuario: ")
                telefono = input("Ingrese el nuevo teléfono del usuario: ")
                email = input("Ingrese el nuevo email del usuario: ")
                contraseña = input("Ingrese la nueva contraseña del usuario: ")
                self.usuarios.update_usuario(id_usuario, nombre, apellido, ciudad, direccion, telefono, email, contraseña)
            
            elif choice == '5':
                id_usuario = int(input("Código del usuario a eliminar: "))
                self.usuarios.delete_usuario(id_usuario)
            
            elif choice == '6':
                break
            
            else:
                print("Opción no válida. Inténtelo de nuevo.")

    def show_administradores_menu(self):
        while True:
            print("\nMenú de Administradores:")
            print("1. Ver todos los administradores")
            print("2. Ver administrador por código")
            print("3. Buscar administradores por nombre")
            print("4. Insertar administrador")
            print("5. Actualizar datos del administrador")
            print("6. Actualizar datos del usuario")
            print("7. Eliminar administrador")
            print("8. Volver al menú principal")

            choice = input("Ingrese su opción: ")

            if choice == '1':
                administradores = self.administradores.get_administradores()
                for administrador in administradores:
                    print(administrador)

            elif choice == '2':
                id_usuario = int(input("Ingrese el código del administrador: "))
                administrador = self.administradores.get_administrador_by_codigo(id_usuario)
                if administrador:
                    print(administrador)
                else:
                    print("Administrador no encontrado.")

            elif choice == '3':
                nombre = input("Ingrese el nombre del administrador: ")
                administradores = self.administradores.get_administrador_by_nombre(nombre)
                if administradores:
                    for administrador in administradores:
                        print(administrador)
                else:
                    print("No se encontraron administradores con ese nombre.")

            elif choice == '4':
                id_usuario = int(input("Ingrese el ID del usuario: "))
                cargo = input("Ingrese el cargo del administrador: ")
                fecha_ingreso = input("Ingrese la fecha de ingreso (YYYY-MM-DD): ")
                self.administradores.insert_administrador(id_usuario, cargo, fecha_ingreso)
                print("Administrador insertado correctamente.")

            elif choice == '5':
                id_usuario = int(input("Ingrese el ID del administrador: "))
                cargo = input("Ingrese el nuevo cargo del administrador: ")
                fecha_ingreso = input("Ingrese la nueva fecha de ingreso (YYYY-MM-DD): ")
                self.administradores.update_administrador(id_usuario, cargo, fecha_ingreso)
                print("Administrador actualizado correctamente.")

            elif choice == '6':
                id_usuario = int(input("Ingrese el ID del usuario: "))
                nombre = input("Ingrese el nombre del usuario: ")
                apellido = input("Ingrese el apellido del usuario: ")
                ciudad = input("Ingrese la ciudad del usuario: ")
                direccion = input("Ingrese la dirección del usuario: ")
                telefono = input("Ingrese el teléfono del usuario: ")
                email = input("Ingrese el email del usuario: ")
                self.usuarios.update_usuario(id_usuario, nombre, apellido, ciudad, direccion, telefono, email)
                print("Datos del usuario actualizados correctamente.")

            elif choice == '7':
                id_usuario = int(input("Ingrese el ID del administrador: "))
                self.administradores.delete_administrador(id_usuario)
                print("Administrador eliminado correctamente.")

            elif choice == '8':
                break

            else:
                print("Opción no válida, por favor intente de nuevo.")

    def show_veterinarios_menu(self):
        while True:
            print("\nMenú de Veterinarios:")
            print("1. Ver todos los veterinarios")
            print("2. Ver veterinario por código")
            print("3. Buscar veterinarios por nombre")
            print("4. Insertar veterinario")
            print("5. Actualizar datos del veterinario")
            print("6. Actualizar datos del usuario")
            print("7. Eliminar veterinario")
            print("8. Volver al menú principal")

            choice = input("Ingrese su opción: ")

            if choice == '1':
                veterinarios = self.veterinarios.get_veterinarios()
                for veterinario in veterinarios:
                    print(veterinario)

            elif choice == '2':
                id_usuario = int(input("Ingrese el código del veterinario: "))
                veterinario = self.veterinarios.get_veterinario_by_codigo(id_usuario)
                if veterinario:
                    print(veterinario)
                else:
                    print("Veterinario no encontrado.")

            elif choice == '3':
                nombre = input("Ingrese el nombre del veterinario: ")
                veterinarios = self.veterinarios.get_veterinario_by_nombre(nombre)
                if veterinarios:
                    for veterinario in veterinarios:
                        print(veterinario)
                else:
                    print("No se encontraron veterinarios con ese nombre.")

            elif choice == '4':
                id_usuario = int(input("Ingrese el ID del usuario: "))
                especialidad = input("Ingrese la especialidad del veterinario: ")
                horario = input("Ingrese el horario del veterinario: ")
                self.veterinarios.insert_veterinario(id_usuario, especialidad, horario)
                print("Veterinario insertado correctamente.")

            elif choice == '5':
                id_usuario = int(input("Ingrese el ID del veterinario: "))
                especialidad = input("Ingrese la nueva especialidad del veterinario: ")
                horario = input("Ingrese el nuevo horario del veterinario: ")
                self.veterinarios.update_veterinario(id_usuario, especialidad, horario)
                print("Veterinario actualizado correctamente.")

            elif choice == '6':
                id_usuario = int(input("Ingrese el ID del usuario: "))
                nombre = input("Ingrese el nombre del usuario: ")
                apellido = input("Ingrese el apellido del usuario: ")
                ciudad = input("Ingrese la ciudad del usuario: ")
                direccion = input("Ingrese la dirección del usuario: ")
                telefono = input("Ingrese el teléfono del usuario: ")
                email = input("Ingrese el email del usuario: ")
                self.usuarios.update_usuario(id_usuario, nombre, apellido, ciudad, direccion, telefono, email)
                print("Datos del usuario actualizados correctamente.")

            elif choice == '7':
                id_usuario = int(input("Ingrese el ID del veterinario: "))
                self.veterinarios.delete_veterinario(id_usuario)
                print("Veterinario eliminado correctamente.")

            elif choice == '8':
                break

            else:
                print("Opción no válida, por favor intente de nuevo.")
    
    def show_propietarios_menu(self):
        while True:
            print("\nMenú de Propietarios:")
            print("1. Ver todos los propietarios")
            print("2. Ver propietario por código")
            print("3. Buscar propietarios por nombre")
            print("4. Insertar propietario")
            print("5. Actualizar datos del propietario")
            print("6. Actualizar datos del usuario")
            print("7. Eliminar propietario")
            print("8. Volver al menú principal")

            choice = input("Ingrese su opción: ")

            if choice == '1':
                propietarios = self.propietarios.get_propietarios()
                for propietario in propietarios:
                    print(propietario)

            elif choice == '2':
                id_usuario = int(input("Ingrese el código del propietario: "))
                propietario = self.propietarios.get_propietario_by_codigo(id_usuario)
                if propietario:
                    print(propietario)
                else:
                    print("Propietario no encontrado.")

            elif choice == '3':
                nombre = input("Ingrese el nombre del propietario: ")
                propietarios = self.propietarios.get_propietario_by_nombre(nombre)
                if propietarios:
                    for propietario in propietarios:
                        print(propietario)
                else:
                    print("No se encontraron propietarios con ese nombre.")

            elif choice == '4':
                id_usuario = int(input("Ingrese el ID del usuario: "))
                barrio = input("Ingrese el barrio del propietario: ")
                self.propietarios.insert_propietario(id_usuario, barrio)
                print("Propietario insertado correctamente.")

            elif choice == '5':
                id_usuario = int(input("Ingrese el ID del propietario: "))
                barrio = input("Ingrese el nuevo barrio del propietario: ")
                self.propietarios.update_propietario(id_usuario, barrio)
                print("Propietario actualizado correctamente.")

            elif choice == '6':
                id_usuario = int(input("Ingrese el ID del usuario: "))
                nombre = input("Ingrese el nombre del usuario: ")
                apellido = input("Ingrese el apellido del usuario: ")
                ciudad = input("Ingrese la ciudad del usuario: ")
                direccion = input("Ingrese la dirección del usuario: ")
                telefono = input("Ingrese el teléfono del usuario: ")
                email = input("Ingrese el email del usuario: ")
                self.usuarios.update_usuario(id_usuario, nombre, apellido, ciudad, direccion, telefono, email)
                print("Datos del usuario actualizados correctamente.")

            elif choice == '7':
                id_usuario = int(input("Ingrese el ID del propietario: "))
                self.propietarios.delete_propietario(id_usuario)
                print("Propietario eliminado correctamente.")
                
            elif choice == '8':
                break

            else:
                print("Opción no válida, por favor intente de nuevo.")
    def show_historial_medico_menu(self):
        while True:
            print("\nMenú de Historial Médico:")
            print("1. Ver todos los historiales médicos")
            print("2. Ver historial médico por código")
            print("3. Insertar historial médico")
            print("4. Actualizar historial médico")
            print("5. Eliminar historial médico")
            print("6. Volver al menú principal")

            choice = input("Ingrese su opción: ")

            if choice == '1':
                historiales = self.historial_medico.get_historiales()
                for historial in historiales:
                    print(historial)

            elif choice == '2':
                codigo = int(input("Ingrese el código del historial médico: "))
                historial = self.historial_medico.get_historial_by_codigo(codigo)
                if historial:
                    print(historial)
                else:
                    print("Historial médico no encontrado.")

            elif choice == '3':
                codigo = int(input("Código del historial médico: "))
                codigo_mascota = int(input("Código de la mascota: "))
                fecha = input("Fecha (YYYY-MM-DD): ")
                descripcion = input("Descripción: ")
                tratamiento = input("Tratamiento: ")
                self.historial_medico.insert_historial(codigo, codigo_mascota, fecha, descripcion, tratamiento)

            elif choice == '4':
                codigo = int(input("Código del historial médico a actualizar: "))
                descripcion = input("Nueva descripción: ")
                tratamiento = input("Nuevo tratamiento: ")
                self.historial_medico.update_historial(codigo, descripcion, tratamiento)

            elif choice == '5':
                codigo = int(input("Código del historial médico a eliminar: "))
                self.historial_medico.delete_historial(codigo)

            elif choice == '6':
                break

            else:
                print("Opción no válida. Inténtelo de nuevo.")
    def show_citas_menu(self):
            while True:
                print("\nMenú de Citas:")
                print("1. Ver todas las citas")
                print("2. Ver cita por código")
                print("3. Insertar cita")
                print("4. Actualizar cita")
                print("5. Eliminar cita")
                print("6. Volver al menú principal")

                choice = input("Ingrese su opción: ")

                if choice == '1':
                    citas = self.citas.get_citas()
                    for cita in citas:
                        print(cita)

                elif choice == '2':
                    codigo = int(input("Ingrese el código de la cita: "))
                    cita = self.citas.get_cita_by_codigo(codigo)
                    if cita:
                        print(cita)
                    else:
                        print("Cita no encontrada.")

                elif choice == '3':
                    codigo = int(input("Código de la cita: "))
                    fecha = input("Fecha (YYYY-MM-DD): ")
                    hora = input("Hora (HH:MM): ")
                    id_servicio = int(input("ID del servicio: "))
                    id_veterinario = int(input("ID del veterinario: "))
                    codigo_mascota = int(input("Código de la mascota: "))
                    estado = input("Estado: ")
                    self.citas.insert_cita(codigo, fecha, hora, id_servicio, id_veterinario, codigo_mascota, estado)

                elif choice == '4':
                    codigo = int(input("Código de la cita a actualizar: "))
                    estado = input("Nuevo estado: ")
                    self.citas.update_cita(codigo, estado)

                elif choice == '5':
                    codigo = int(input("Código de la cita a eliminar: "))
                    self.citas.delete_cita(codigo)

                elif choice == '6':
                    break

                else:
                    print("Opción no válida. Inténtelo de nuevo.")

    def show_productos_menu(self):
        while True:
            print("\nMenú de Productos:")
            print("1. Ver todos los productos")
            print("2. Ver producto por código")
            print("3. Insertar producto")
            print("4. Actualizar producto")
            print("5. Eliminar producto")
            print("6. Volver al menú principal")

            choice = input("Ingrese su opción: ")

            if choice == '1':
                productos = self.productos.get_productos()
                for producto in productos:
                    print(producto)

            elif choice == '2':
                codigo = int(input("Ingrese el código del producto: "))
                producto = self.productos.get_producto_by_codigo(codigo)
                if producto:
                    print(producto)
                else:
                    print("Producto no encontrado.")

            elif choice == '3':
                codigo = int(input("Código del producto: "))
                nombre = input("Nombre del producto: ")
                descripcion = input("Descripción: ")
                precio = float(input("Precio: "))
                stock = int(input("Stock: "))
                self.productos.insert_producto(codigo, nombre, descripcion, precio, stock)

            elif choice == '4':
                codigo = int(input("Código del producto a actualizar: "))
                nombre = input("Nuevo nombre: ")
                descripcion = input("Nueva descripción: ")
                precio = float(input("Nuevo precio: "))
                stock = int(input("Nuevo stock: "))
                self.productos.update_producto(codigo, nombre, descripcion, precio, stock)

            elif choice == '5':
                codigo = int(input("Código del producto a eliminar: "))
                self.productos.delete_producto(codigo)

            elif choice == '6':
                break

            else:
                print("Opción no válida. Inténtelo de nuevo.")
                
    def show_servicios_menu(self):
        while True:
            print("\nMenú de Servicios:")
            print("1. Ver todos los servicios")
            print("2. Ver servicio por código")
            print("3. Insertar servicio")
            print("4. Actualizar servicio")
            print("5. Eliminar servicio")
            print("6. Volver al menú principal")

            choice = input("Ingrese su opción: ")

            if choice == '1':
                servicios = self.servicios.get_servicios()
                for servicio in servicios:
                    print(servicio)

            elif choice == '2':
                codigo = int(input("Ingrese el código del servicio: "))
                servicio = self.servicios.get_servicio_by_codigo(codigo)
                if servicio:
                    print(servicio)
                else:
                    print("Servicio no encontrado.")

            elif choice == '3':
                codigo = int(input("Código del servicio: "))
                nombre = input("Nombre del servicio: ")
                descripcion = input("Descripción: ")
                precio = float(input("Precio: "))
                self.servicios.insert_servicio(codigo, nombre, descripcion, precio)

            elif choice == '4':
                codigo = int(input("Código del servicio a actualizar: "))
                nombre = input("Nuevo nombre: ")
                descripcion = input("Nueva descripción: ")
                precio = float(input("Nuevo precio: "))
                self.servicios.update_servicio(codigo, nombre, descripcion, precio)

            elif choice == '5':
                codigo = int(input("Código del servicio a eliminar: "))
                self.servicios.delete_servicio(codigo)

            elif choice == '6':
                break

            else:
                print("Opción no válida. Inténtelo de nuevo.")