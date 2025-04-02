module Employees where
import Types
import Data.List (find)
-- Crea un nuevo empleado
createEmployee :: Int -> String -> Employee
createEmployee id name = Employee id name
-- Busca un empleado por su ID
findEmployee :: Int -> [Employee] -> ProjectResult Employee
findEmployee _ [] = Left "Empleado no encontrado"
findEmployee id employees = 
    case find (\e -> employeeId e == id) employees of
        Just employee -> Right employee
        Nothing -> Left $ "Empleado con ID " ++ show id ++ " no encontrado"
-- Elimina un empleado por ID
removeEmployee :: Int -> [Employee] -> ProjectResult [Employee]
removeEmployee id employees = 
    if any (\e -> employeeId e == id) employees
        then Right $ filter (\e -> employeeId e /= id) employees
        else Left $ "No se puede eliminar: empleado con ID " ++ show id ++ " no encontrado"
-- Actualiza un empleado específico en la lista de empleados
updateEmployee :: Employee -> [Employee] -> [Employee]
updateEmployee updatedEmployee = map (\e -> if employeeId e == employeeId updatedEmployee then updatedEmployee else e)
-- Lista todos los empleados
listEmployees :: [Employee] -> [String]
listEmployees [] = ["No hay empleados registrados"]
listEmployees employees = map formatEmployee employees
  where
    formatEmployee e = "Empleado: " ++ employeeName e ++ " (ID: " ++ show (employeeId e) ++ ")"
-- Obtiene las tareas asignadas a un empleado específico
getEmployeeTasks :: Int -> [Project] -> ProjectResult [Task]
getEmployeeTasks empId projects = 
    Right $ concatMap (filter isAssignedToEmployee . tasks) projects
  where
    isAssignedToEmployee task = 
        case assignedTo task of
            Just employee -> employeeId employee == empId
            Nothing -> False