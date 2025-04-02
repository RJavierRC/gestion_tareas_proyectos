# Instrucciones para Desarrollo - Parte 2 del Proyecto

Este documento contiene las instrucciones específicas para implementar la segunda parte del proyecto de gestión de tareas en Haskell.

## Tu Responsabilidad

Tu parte del proyecto consiste en implementar:

1. **Gestión de Tareas**: Todas las funciones relacionadas con la creación, asignación y manejo de tareas.
2. **Sistema de Manejo de Errores**: Implementación de funciones especializadas para el manejo de errores.

## Archivos que debes crear

### 1. Tasks.hs
Este archivo contendrá todas las funciones para manejar tareas. Debes implementar:

- `createTask`: Crear una nueva tarea con descripción, fecha límite, prioridad, etc.
- `addTaskToProject`: Agregar una tarea a un proyecto específico
- `assignTaskToEmployee`: Asignar una tarea a un empleado
- `completeTask`: Marcar una tarea como completada
- `removeTask`: Eliminar una tarea de un proyecto
- `findTask`: Buscar una tarea específica en los proyectos
- Cualquier otra función auxiliar que consideres necesaria

### 2. ErrorHandling.hs (opcional)
Si decides separar el manejo de errores en su propio módulo, puedes crear este archivo con funciones como:

- Funciones para manipular tipos `Either`
- Funciones para validación de datos
- Formateo de mensajes de error

## Pasos para comenzar

1. Clona el repositorio si aún no lo has hecho:
   ```bash
   git clone [URL_DEL_REPOSITORIO]
   ```

2. Crea y cámbiate a tu rama de trabajo:
   ```bash
   git checkout -b tasks-errors
   ```

3. Revisa los archivos ya creados para entender la estructura:
   - `Types.hs`: Contiene todas las definiciones de tipos
   - `Projects.hs`: Funciones para manejar proyectos
   - `Employees.hs`: Funciones para manejar empleados
   - `Main.hs`: Archivo principal con ejemplos básicos

4. Crea tus archivos:
   ```bash
   touch Tasks.hs
   touch ErrorHandling.hs  # Si decides separarlo
   ```

5. Implementa tus funciones siguiendo el mismo estilo y estructura que los otros archivos

## Requisitos técnicos

- **Inmutabilidad**: Todas las funciones deben ser puras y no modificar estructuras existentes
- **Manejo de errores**: Utiliza `Either` para funciones que puedan fallar
- **Tipos algebraicos**: Aprovecha `Maybe`, `Either` y otros tipos algebraicos
- **Consistencia**: Mantén el mismo estilo de código que el resto del proyecto

## Cómo probar tu implementación

1. Edita `Main.hs` para incluir ejemplos de uso de tus funciones
2. Compila el proyecto:
   ```bash
   ghc -o project-manager Main.hs
   ```
3. Ejecuta el programa:
   ```bash
   ./project-manager
   ```

## Comandos Git para subir tu trabajo

Cuando hayas terminado tu implementación:

```bash
# Agregar tus archivos al stage
git add Tasks.hs ErrorHandling.hs

# Si modificaste Main.hs para incluir ejemplos:
git add Main.hs

# Hacer commit
git commit -m "Implementa funciones de gestión de tareas y manejo de errores"

# Subir tu rama al repositorio
git push origin tasks-errors
```

## Integración final

Una vez que ambas partes estén listas:
1. Crea un Pull Request desde tu rama `tasks-errors` a la rama principal
2. Revisa que no haya conflictos
3. Planifica una sesión con tu compañero para integrar y probar el sistema completo
4. Asegúrate de que todas las funcionalidades trabajan correctamente juntas

## Interfaz esperada para tus funciones

Aquí hay algunas signaturas de funciones recomendadas que deberías implementar:

```haskell
-- Crear una nueva tarea
createTask :: Int -> String -> String -> Priority -> Maybe Employee -> Task

-- Añadir una tarea a un proyecto
addTaskToProject :: Int -> Task -> [Project] -> ProjectResult [Project]

-- Asignar una tarea a un empleado
assignTaskToEmployee :: Int -> Int -> Int -> [Project] -> [Employee] -> ProjectResult [Project]

-- Marcar una tarea como completada
completeTask :: Int -> Int -> [Project] -> ProjectResult [Project]

-- Eliminar una tarea
removeTask :: Int -> Int -> [Project] -> ProjectResult [Project]
```

Donde:
- El primer `Int` en las funciones suele ser el ID del proyecto
- El segundo `Int` (cuando aplica) es el ID de la tarea
- El tercer `Int` (cuando aplica) es el ID del empleado

## Contacto

Si tienes dudas sobre la implementación o la integración, consulta con tu compañero antes de seguir adelante.