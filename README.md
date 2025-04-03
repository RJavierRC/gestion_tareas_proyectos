# Sistema de Gestión de Proyectos en Haskell

## Integrantes del equipo:
- Ríos Cruz Roberto Javier
- Pérez Santos Jesús Manuel

Este proyecto implementa un sistema de gestión de proyectos, tareas y empleados utilizando principios de programación funcional en Haskell. El sistema es completamente inmutable y utiliza tipos algebraicos para representar datos y manejar errores.

## Estructura del Proyecto

- `Types.hs`: Definiciones de tipos compartidos (Project, Task, Employee, etc.)
- `Projects.hs`: Funciones para crear y gestionar proyectos
- `Employees.hs`: Funciones para crear y gestionar empleados
- `Tasks.hs`: Funciones para crear y gestionar tareas
- `ErrorHandling.hs`: Funciones especializadas para manejo de errores
- `Main.hs`: Punto de entrada principal y ejemplos de uso

## Cómo ejecutar

1. Asegúrate de tener GHC (Glasgow Haskell Compiler) instalado
2. Clona este repositorio
3. Navega a la carpeta del proyecto
4. Compila el proyecto con: `ghc -o project-manager Main.hs`
5. Ejecuta el programa: `./project-manager`

## Funcionalidades implementadas

### Gestión de Proyectos
- Crear proyectos con nombre, fechas de inicio y fin
- Eliminar proyectos
- Listar todos los proyectos con estadísticas de tareas

### Gestión de Empleados
- Crear empleados
- Asignar empleados a tareas
- Ver tareas asignadas a un empleado específico

### Gestión de Tareas
- Agregar tareas a proyectos
- Asignar tareas a empleados
- Marcar tareas como completadas
- Calcular estadísticas de tareas por proyecto

### Manejo de Errores
- Todas las operaciones que pueden fallar devuelven un tipo `Either` con información del error
- Mensajes de error claros y específicos

## Decisiones de implementación

- Utilizamos tipos algebraicos (Maybe, Either) para manejar casos opcionales y errores
- Cada función es pura y retorna nuevos valores en lugar de modificar los existentes
- Las estructuras de datos son inmutables, respetando principios de programación funcional
- Se utiliza la composición de funciones para operaciones complejas
