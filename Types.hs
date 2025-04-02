module Types where

-- Tipos básicos compartidos

-- Representa un proyecto con nombre, fechas y lista de tareas
data Project = Project {
    projectId :: Int,
    projectName :: String,
    startDate :: String,  -- Formato YYYY-MM-DD para simplicidad
    endDate :: String,    -- Formato YYYY-MM-DD para simplicidad
    tasks :: [Task]
} deriving (Show, Eq)

-- Representa una tarea dentro de un proyecto
data Task = Task {
    taskId :: Int,
    taskDescription :: String,
    dueDate :: String,    -- Formato YYYY-MM-DD para simplicidad
    priority :: Priority,
    assignedTo :: Maybe Employee,
    completed :: Bool
} deriving (Show, Eq)

-- Representa a un empleado que puede ser asignado a tareas
data Employee = Employee {
    employeeId :: Int,
    employeeName :: String
} deriving (Show, Eq)

-- Niveles de prioridad para las tareas
data Priority = Low | Medium | High deriving (Show, Eq, Ord)

-- Tipos para manejo de errores
type ProjectError = String
type ProjectResult a = Either ProjectError a