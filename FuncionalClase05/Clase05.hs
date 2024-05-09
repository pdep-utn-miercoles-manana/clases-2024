------------------
-- Recursividad --
------------------

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)

fibonacci :: Integer -> Integer
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n =
  fibonacci (n - 1) + fibonacci (n - 2)

sumatoria :: Num a => [a] -> a
sumatoria [] = 0
sumatoria (x:xs) = x + sumatoria xs

productoria :: Num a => [a] -> a
productoria [] = 1
productoria (x:xs) = x * productoria xs

conjuncion :: [Bool] -> Bool
conjuncion [] = True
conjuncion (x:xs) = x && conjuncion xs

disyuncion :: [Bool] -> Bool
disyuncion [] = False
disyuncion (x:xs) = x || disyuncion xs

concatenacion :: [[a]] -> [a]
concatenacion [] = []
concatenacion (x:xs) = x ++ concatenacion xs

longitud :: [a] -> Int
longitud [] = 0
longitud (x:xs) = 1 + longitud xs

-------------------------------------------------------------
-- Generalización de la recursividad TAN parecida de antes --
-------------------------------------------------------------

plegar :: (b -> a -> a) -> a -> [b] -> a
plegar operacion valorInicial [] = valorInicial
plegar operacion valorInicial (x:xs) = x `operacion` plegar operacion valorInicial xs

------------------------------------------------------
-- Redefinicion de las funciones unasdo plegar/fold --
------------------------------------------------------

sumatoriaConPlegar :: Num a => [a] -> a
sumatoriaConPlegar lista = plegar (+) 0 lista

productoriaConPlegar :: Num a => [a] -> a
productoriaConPlegar lista = plegar (*) 1 lista

conjuncionConPlegar :: [Bool] -> Bool
conjuncionConPlegar lista = plegar (&&) True lista

disyuncionConPlegar :: [Bool] -> Bool
disyuncionConPlegar lista = plegar (||) False lista

concatenacionConPlegar :: [[a]] -> [a]
concatenacionConPlegar lista = plegar (++) [] lista

longitudConPlegar :: [a] -> Int
longitudConPlegar lista = plegar (\_ algo -> 1 + algo) 0 lista

----------------------------------------------
-- Más Funciones definidas con recursividad --
----------------------------------------------

tomar :: Int -> [a] -> [a]
tomar _ [] = []
tomar 0 _  = []
tomar n (x:xs) = x : tomar (n-1) xs

descartar :: Int -> [a] -> [a]
descartar _ [] = []
descartar 0 xs = xs
descartar n (x:xs) = descartar (n-1) xs

transformar :: (a -> b) -> [a] -> [b]
transformar funcion [] = []
transformar funcion (elemento:resto) = funcion elemento : transformar funcion resto

filtrar :: (a -> Bool) -> [a] -> [a]
filtrar condicion [] = []
filtrar condicion (elemento:resto)
  | condicion elemento = elemento : filtrar condicion resto
  | otherwise   = filtrar condicion resto

todosCumple :: (a -> Bool) -> [a] -> Bool
todosCumple condicion [] = False
todosCumple condicion (elemento:resto) = condicion elemento && todosCumple condicion resto

algunoCumple :: (a -> Bool) -> [a] -> Bool
algunoCumple condicion [] = False
algunoCumple condicion (elemento:resto) = condicion elemento || algunoCumple condicion resto

------------------------------------------
-- TAREA: Tratar de definirlas con fold --
------------------------------------------
