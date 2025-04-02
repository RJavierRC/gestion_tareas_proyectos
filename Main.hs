module Main where

import Types
import Projects
import Employees
-- Las siguientes importaciones serán implementadas por tu compañero
-- import Tasks
-- import ErrorHandling

-- Datos iniciales para pruebas
initialEmployees :: [Employee]
initialEmployees = [
    createEmployee 1 "Juan Pérez",
    createEmployee 2 "María López",
    createEmployee 3 "Carlos Rodríguez"
    ]

initialProjects :: [Project]
initialProjects = [
    createProject 1 "Sistema de inventario" "2023-01-01" "2023-03-31" [],
    createProject 2 "Migración de base de datos" "2023-02-15" "2023-04-30" []
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
    
    -- Aquí tu compañero agregará código para demostrar las
    -- funcionalidades de tareas y manejo de errores
    
    putStrLn ""
    putStrLn "Para interactuar con el sistema completo, implementa una interfaz de usuario o ejecuta funciones específicas."