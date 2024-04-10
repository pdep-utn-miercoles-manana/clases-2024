doble :: Int -> Int
doble numero = numero * 2

cuadrado :: Int -> Int
cuadrado numero = numero * numero

siguiente :: Int -> Int
siguiente numero = numero + 1

cuadruple :: Int -> Int
cuadruple numero = (doble . doble) numero

-- elDobleDelSiguiente :: COMPLETAR
elDobleDelSiguiente numero = doble . siguiente $  numero
