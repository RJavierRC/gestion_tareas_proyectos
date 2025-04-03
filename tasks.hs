module Tasks where

import Types
import Projects
import Employees
import Data.List (find)

-- Crear una nueva tarea
createTask :: Int -> String -> String -> Priority -> Maybe Employee -> Task
createTask id description dueDate priority assignedTo = Task id description dueDate priority assignedTo False

-- Añadir una tarea a un proyecto
addTaskToProject :: Int -> Task -> [Project] -> ProjectResult [Project]
addTaskToProject projectId task projects = do
    project <- findProject projectId projects
    let updatedProject = project { tasks = task : tasks project }
    Right $ updateProject updatedProject projects

-- Asignar una tarea a un empleado
assignTaskToEmployee :: Int -> Int -> Int -> [Project] -> [Employee] -> ProjectResult [Project]
assignTaskToEmployee projectId tId employeeId projects employees = do
    employee <- findEmployee employeeId employees
    project <- findProject projectId projects
    let updatedTasks = map (\task -> if taskId task == tId
                                    then task { assignedTo = Just employee }
                                    else task) (tasks project)
    let updatedProject = project { tasks = updatedTasks }
    Right $ updateProject updatedProject projects

-- Marcar una tarea como completada
completeTask :: Int -> Int -> [Project] -> ProjectResult [Project]
completeTask projectId tId projects = do
    project <- findProject projectId projects
    let taskExists = any (\task -> taskId task == tId) (tasks project)
    if not taskExists
        then Left $ "Tarea con ID " ++ show tId ++ " no encontrada en el proyecto con ID " ++ show projectId
        else do
            let updatedTasks = map (\task -> if taskId task == tId
                                            then task { completed = True }
                                            else task) (tasks project)
            let updatedProject = project { tasks = updatedTasks }
            Right $ updateProject updatedProject projects

-- Eliminar una tarea
removeTask :: Int -> Int -> [Project] -> ProjectResult [Project]
removeTask projectId tId projects = do
    project <- findProject projectId projects
    let taskExists = any (\task -> taskId task == tId) (tasks project)
    if not taskExists
        then Left $ "Tarea con ID " ++ show tId ++ " no encontrada en el proyecto con ID " ++ show projectId
        else do
            let updatedTasks = filter (\task -> taskId task /= tId) (tasks project)
            let updatedProject = project { tasks = updatedTasks }
            Right $ updateProject updatedProject projects

-- Buscar una tarea específica en los proyectos
findTask :: Int -> Int -> [Project] -> ProjectResult Task
findTask projectId tId projects = do
    project <- findProject projectId projects
    case find (\task -> taskId task == tId) (tasks project) of
        Just task -> Right task
        Nothing -> Left $ "Tarea con ID " ++ show tId ++ " no encontrada en el proyecto con ID " ++ show projectId

-- Listar todas las tareas de un proyecto
listTasksInProject :: Int -> [Project] -> ProjectResult [String]
listTasksInProject projectId projects = do
    project <- findProject projectId projects
    let projectTasks = tasks project
    if null projectTasks
        then Right ["No hay tareas en este proyecto"]
        else Right $ map formatTask projectTasks
  where
    formatTask task = 
        "Tarea: " ++ taskDescription task ++ 
        " (ID: " ++ show (taskId task) ++ ")" ++
        "\n  Fecha límite: " ++ dueDate task ++
        "\n  Prioridad: " ++ show (priority task) ++
        "\n  Asignado a: " ++ (case assignedTo task of
            Nothing -> "Sin asignar"
            Just emp -> employeeName emp) ++
        "\n  Estado: " ++ (if completed task then "Completada" else "Pendiente")

-- Obtener tareas por prioridad
getTasksByPriority :: Priority -> [Project] -> [Task]
getTasksByPriority prio projects = 
    concatMap (filter (\task -> priority task == prio) . tasks) projects

-- Obtener tareas pendientes
getPendingTasks :: [Project] -> [Task]
getPendingTasks projects = 
    concatMap (filter (not . completed) . tasks) projects

-- Obtener tareas completadas
getCompletedTasks :: [Project] -> [Task]
getCompletedTasks projects = 
    concatMap (filter completed . tasks) projects