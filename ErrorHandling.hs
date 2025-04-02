module ErrorHandling where

import Types

-- Función para manejar errores de forma más amigable
handleError :: ProjectResult a -> String
handleError (Left err) = "Error: " ++ err
handleError (Right _) = "Operación exitosa"

-- Función para validar que un ID no sea negativo
validateId :: Int -> Either ProjectError Int
validateId id
    | id < 0 = Left "El ID no puede ser negativo"
    | otherwise = Right id