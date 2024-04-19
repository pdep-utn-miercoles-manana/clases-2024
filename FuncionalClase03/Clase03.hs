-- Cálculo lambda de Church & Kleene

-- Versión Normal
doble :: Int -> Int
doble numero = numero + numero

suma :: Int -> Int -> Int
suma numero1 numero2 = numero1 + numero2

esAesthetic :: Int -> Bool
esAesthetic numero = 42 == length (show (numero))

esMultiploDe :: Int -> Int -> Bool
esMultiploDe numerador denominador = 0 == mod numerador denominador

esFraseCheta :: String -> Bool
esFraseCheta frase = esMultiploDe (length frase) 5


--Versión con Composición y/o Aplicación Parcial

doble' :: Int -> Int
doble' = (*2)

suma' :: Int -> Int -> Int
suma' = (+)

esAesthetic' :: Int -> Bool
esAesthetic' numero = ((== 42) . length . show) numero
{-
También puede ser
esAesthetic' = (== 42) . length . show
-}

esMultiploDe' :: Int -> Int -> Bool
esMultiploDe' numerador denominador = ((==0) . mod numerador) denominador
{-
También puede ser
esMultiploDe' numerador = (==0) . mod numerador
-}

esFraseCheta' :: String -> Bool
esFraseCheta' frase = (flip esMultiploDe' 5 . length) frase
{-
También puede ser
esFraseCheta' = flip esMultiploDe' 5 . length
-}


--Versión con expresiones lambda
doble'' :: Int -> Int
doble'' = \numero -> numero + numero

suma'' :: Int -> Int -> Int
suma'' = \numero1 numero2 -> numero1 + numero2

esAesthetic'' :: Int -> Bool
esAesthetic'' = \numero -> 42 == length (show (numero))
{-
Tambien puede ser con Expresiones lambda, composición y aplicación parcial
esAesthetic'' = \numero -> ((== 42) . length . show) numero
-}

esMultiploDe'' :: Int -> Int -> Bool
esMultiploDe'' = \numerador denominador -> 0 == mod numerador denominador
{-
Tambien puede ser con Expresiones lambda, composición y aplicación parcial
esMultiploDe'' = \numerador denominador -> ((==0) . mod numerador) denominador

o bien
esMultiploDe'' = \numerador -> (==0) . mod numerador
-}

esFraseCheta'' :: String -> Bool
esFraseCheta'' = \frase -> esMultiploDe (length frase) 5
{-
Tambien puede ser con Expresiones lambda, composición y aplicación parcial
esFraseCheta'' = \frase -> (flip esMultiploDe'' 5 . length) frase
-}


-- Versiones currificadas (como lo ve Haskell)
suma''' :: Int -> Int -> Int
suma''' = \numero1 -> \numero2 -> numero1 + numero2

esMultiploDe''' :: Int -> Int -> Bool
esMultiploDe''' = \numerador -> \denominador -> 0 == mod numerador denominador


-- Listas

numeros :: [Int]
numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

saludo :: String -- Es más común verlo como String en lugar de [Char]
saludo = "hola como estas"

palabras :: [String] -- Es más común verlo como [String] en lugar de [[Char]]
palabras = words saludo

-- words :: String -> [String]
-- Es una funcion que ya viene con Haskell que toma un string y devuelve la lista de palabras
-- También está su versión unwords que toma una lista de strings y devuelve un string separado por espacios


{- ¿Qué probamos con listas en la consola?


-- CONCATENACION DE DOS LISTAS

*Main> :t (++)
(++) :: [a] -> [a] -> [a]

*Main> numeros ++ [11, 12, 13]
[1,2,3,4,5,6,7,8,9,10,11,12,13]

*Main> saludo ++ ", bienvenid@ al paradigma funcional"
"hola como estas, bienvenid@ al paradigma funcional"

*Main> palabras ++ ["espero que", "todo bien", "!!!"]
["hola","como","estas","espero que","todo bien","!!!"]


-- "AGREGAR" UN ELEMENTO AL PRINCIPIO

*Main> :t (:)
(:) :: a -> [a] -> [a]

*Main> 678 : numeros
[678,1,2,3,4,5,6,7,8,9,10]

*Main> 'h' : "ola, como estas?"
"hola, como estas?"

*Main> "estimado" : palabras
["estimado","hola","como","estas"]


-- CONOCER EL PRIMER ELEMENTO DE UNA LISTA

*Main> :t head
head :: [a] -> a

*Main> head numeros
1

*Main> head saludo
'h'

*Main> head palabras
"hola"

*Main> head []
*** Exception: Prelude.head: empty list
-- Está perfecto que falle, porque no tiene sentido preguntarle el primer elemento a una lista vacía.


-- CONOCER LA COLA DE UNA LISTA

*Main> :t tail
tail :: [a] -> [a]

*Main> tail numeros
[2,3,4,5,6,7,8,9,10]

*Main> tail saludo
"ola como estas"

*Main> tail palabras
["como","estas"]

*Main> tail []
*** Exception: Prelude.tail: empty list
-- Está perfecto que falle, porque no tiene sentido preguntarle la cola a una lista vacía.


-- CONOCER EL ELEMENTO DE UNA LISTA QUE SE ENCUENTRA EN CIERTA POSICION (EMPIEZA EN BASE CERO)

*Main> :t (!!)
(!!) :: [a] -> Int -> a

*Main> saludo !! 0
'h'

*Main> saludo !! 1
'o'

*Main> saludo !! 2
'l'

*Main> saludo !! 3
'a'

*Main> saludo !! 100
*** Exception: Prelude.!!: index too large

*Main> saludo !! (-1)
*** Exception: Prelude.!!: negative index

*Main> :t length
length :: [a] -> Int

*Main> length numeros
10

*Main> length saludo
15

*Main> length []
0

*Main> length [even, odd, ((== 0) . flip mod 5)]
3

-- Hay muchas mas funciones conocidas en la Guía de Lenguajes
-- https://docs.google.com/document/d/e/2PACX-1vTlLkakSbp6ubcIq00PU4-Z96tg8CUSc8bO793_uftmiGjfkSn7Ug-F_y0-ieIWG6aWfuoHLJrRL8Fd/pub


-- FUNCIONES DE ORDEN SUPERIOR SOBRE LISTAS

-- TRASNFORMAR UNA LISTA

*Main> :t map
map :: (a -> b) -> [a] -> [b]

*Main> map (+1) numeros
[2,3,4,5,6,7,8,9,10,11]

*Main> map negate numeros
[-1,-2,-3,-4,-5,-6,-7,-8,-9,-10]

*Main> map (^2) numeros
[1,4,9,16,25,36,49,64,81,100]

*Main> map (doble . suma 3) numeros
[8,10,12,14,16,18,20,22,24,26]

*Main> map length palabras
[4,4,5]


-- FILTRAR LOS ELEMENTOS DE UNA LISTA

*Main> :t filter
filter :: (a -> Bool) -> [a] -> [a]

*Main Data.Char> filter (flip esMultiploDe 3) numeros
[3,6,9]

*Main> filter (even . length) palabras
["hola","como"]

*Main> import Data.Char  -- Esto para importar funciones para el manejo de caracteres

*Main Data.Char> filter isLower saludo
"holacomoestas"

*Main Data.Char> saludo
"hola como estas"

*Main Data.Char> filter isUpper "Hola Como Estas, QUERIDO"
"HCEQUERIDO"

*Main Data.Char> filter isLower "Hola Como Estas, QUERIDO"
"olaomostas"

*Main Data.Char> filter isSpace "Hola Como Estas, QUERIDO"
"   "

*Main Data.Char> length . filter isUpper $ "Hola Como Estas, QUERIDO"
10

*Main Data.Char> length . filter isSpace $ "Hola Como Estas, QUERIDO"
3

*Main Data.Char> length . filter isLower $ "Hola Como Estas, QUERIDO"
10


-- SABER SI TODOS LOS ELEMENTOS DE UNA LISTA CUMPLEN UNA CONDICIÓN

*Main> :t all
all :: (a -> Bool) -> [a] -> Bool

*Main Data.Char> all isLower "Hola Como Estas, QUERIDO"
False

*Main Data.Char> all isLower "holacomoestas"
True

*Main Data.Char> all (< 100) numeros
True

*Main Data.Char> all (> 2) numeros
False


-- SABER SI ALGÚN ELEMENTO DE LA LISTA CUMPLE CON UNA CONDICION

*Main> :t any
any :: (a -> Bool) -> [a] -> Bool

*Main Data.Char> any (> 2) numeros
True

*Main Data.Char> any isUpper "Hola Como Estas, QUERIDO"
True

*Main Data.Char> any isSpace "Hola Como Estas, QUERIDO"
True

*Main Data.Char> any isLower "Hola Como Estas, QUERIDO"
True

-}