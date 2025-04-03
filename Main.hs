module Main where
import Types
import Projects
import Employees
import Tasks
import ErrorHandling

-- Datos iniciales para pruebas
initialEmployees :: [Employee]
initialEmployees = [
    createEmployee 1 "Juan Pérez",
    createEmployee 2 "María López",
    createEmployee 3 "Carlos Rodríguez"
    ]

initialProjects :: [Project]
initialProjects = [
    createProject 1 "Sistema de inventario" "2023-01-01" "2023-03-31",
    createProject 2 "Migración de base de datos" "2023-02-15" "2023-04-30"
    ]

-- Función principal
main :: IO ()
main = do
    putStrLn "Sistema de Gestión de Proyectos en Haskell"
    putStrLn "----------------------------------------"
    putStrLn ""
    
    -- Muestra los proyectos iniciales
    putStrLn "Proyectos iniciales:"
    mapM_ putStrLn (listProjects initialProjects)
    
    putStrLn ""
    putStrLn "Empleados disponibles:"
    mapM_ putStrLn (listEmployees initialEmployees)
    
    -- Demostración de funcionalidades de tareas
    putStrLn "\n-- Demostración de gestión de tareas --"
    
    -- Crear una nueva tarea y añadirla al proyecto 1
    let task1 = createTask 1 "Diseñar interfaz de usuario" "2023-02-10" High Nothing
    let projectsWithTask = case addTaskToProject 1 task1 initialProjects of
                            Right p -> p
                            Left err -> error $ "Error al añadir tarea: " ++ err
    
    putStrLn "\nDespués de añadir tarea de diseño:"
    mapM_ putStrLn (listProjects projectsWithTask)
    
    -- Asignar la tarea a un empleado
    let projectsWithAssignedTask = case assignTaskToEmployee 1 1 2 projectsWithTask initialEmployees of
                                    Right p -> p
                                    Left err -> error $ "Error al asignar tarea: " ++ err
    
    putStrLn "\nDespués de asignar tarea a María López:"
    mapM_ putStrLn (listProjects projectsWithAssignedTask)
    
    -- Marcar la tarea como completada
    let projectsWithCompletedTask = case completeTask 1 1 projectsWithAssignedTask of
                                    Right p -> p
                                    Left err -> error $ "Error al completar tarea: " ++ err
    
    putStrLn "\nDespués de marcar la tarea como completada:"
    mapM_ putStrLn (listProjects projectsWithCompletedTask)
    
    -- Añadir otra tarea
    let task2 = createTask 2 "Implementar base de datos" "2023-02-20" Medium Nothing
    let projectsWith2Tasks = case addTaskToProject 1 task2 projectsWithCompletedTask of
                             Right p -> p
                             Left err -> error $ "Error al añadir segunda tarea: " ++ err
    
    putStrLn "\nDespués de añadir una segunda tarea:"
    mapM_ putStrLn (listProjects projectsWith2Tasks)
    
    -- Listar tareas del proyecto 1
    putStrLn "\nDetalle de tareas en proyecto 1:"
    case listTasksInProject 1 projectsWith2Tasks of
        Right taskList -> mapM_ putStrLn taskList
        Left err -> putStrLn $ "Error: " ++ err
    
    -- Demostración de manejo de errores
    putStrLn "\n-- Demostración de manejo de errores --"
    
    -- Intentar asignar una tarea a un empleado inexistente
    putStrLn "\nIntentando asignar tarea a empleado inexistente (ID 99):"
    case assignTaskToEmployee 1 2 99 projectsWith2Tasks initialEmployees of
        Right _ -> putStrLn "Éxito (esto no debería ocurrir)"
        Left err -> putStrLn $ "Error (esperado): " ++ err
    
    -- Intentar completar una tarea inexistente
    putStrLn "\nIntentando completar tarea inexistente (ID 99):"
    case completeTask 1 99 projectsWith2Tasks of
        Right _ -> putStrLn "Éxito (esto no debería ocurrir)"
        Left err -> putStrLn $ "Error (esperado): " ++ err
    
    putStrLn "\nFin de la demostración."