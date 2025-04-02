module Projects where

import Types
import Data.List (find, deleteBy)

-- Crea un nuevo proyecto con lista de tareas vacía
createProject :: Int -> String -> String -> String -> Project
createProject id name start end = Project id name start end []

-- Busca un proyecto por su ID
findProject :: Int -> [Project] -> ProjectResult Project
findProject _ [] = Left "Proyecto no encontrado"
findProject id projects = 
    case find (\p -> projectId p == id) projects of
        Just project -> Right project
        Nothing -> Left $ "Proyecto con ID " ++ show id ++ " no encontrado"

-- Elimina un proyecto por ID
removeProject :: Int -> [Project] -> ProjectResult [Project]
removeProject id projects = 
    if any (\p -> projectId p == id) projects
        then Right $ filter (\p -> projectId p /= id) projects
        else Left $ "No se puede eliminar: proyecto con ID " ++ show id ++ " no encontrado"

-- Actualiza un proyecto específico en la lista de proyectos
updateProject :: Project -> [Project] -> [Project]
updateProject updatedProject = map (\p -> if projectId p == projectId updatedProject then updatedProject else p)

-- Obtiene todas las tareas de un proyecto específico
getProjectTasks :: Int -> [Project] -> ProjectResult [Task]
getProjectTasks projectId projects = do
    project <- findProject projectId projects
    Right $ tasks project

-- Lista todos los proyectos con información sobre tareas completadas/pendientes
listProjects :: [Project] -> [String]
listProjects [] = ["No hay proyectos registrados"]
listProjects projects = map formatProject projects
  where
    formatProject p = 
        "Proyecto: " ++ projectName p ++ 
        " (ID: " ++ show (projectId p) ++ ")" ++
        "\n  Fecha inicio: " ++ startDate p ++ 
        "\n  Fecha fin: " ++ endDate p ++
        "\n  Tareas: " ++ show (length (tasks p)) ++
        "\n  Completadas: " ++ show (length (filter completed (tasks p))) ++
        "\n  Pendientes: " ++ show (length (filter (not . completed) (tasks p)))

-- Calcula estadísticas de tareas completadas y pendientes para un proyecto
getProjectStats :: Int -> [Project] -> ProjectResult (Int, Int)
getProjectStats projectId projects = do
    project <- findProject projectId projects
    let projectTasks = tasks project
        completedTasks = length $ filter completed projectTasks
        pendingTasks = length projectTasks - completedTasks
    Right (completedTasks, pendingTasks)