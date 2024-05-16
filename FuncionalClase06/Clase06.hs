repetir :: a -> [a]
repetir x = x : repetir x

ciclar :: [a] -> [a]
ciclar xs = xs ++ ciclar xs

-- iterate -> [x, f(x), f(f(x)), f(f(f(x)))]
iterar :: (a -> a) -> a -> [a]
iterar f x = x : iterar f (f x)

replicar :: Int -> a -> [a]
replicar n x
  | n == 0 = []
  | otherwise = x : replicar (n - 1) x

replicar' 0 _ = []
replicar' n x = x : replicar' (n - 1) x

-- una versión más que no vimos en clase pero que podemos usar
-- ahora que conocemos la evaluación diferida:
replicar'' n x = (take n . repeat) x
replicar'' n x = take n . repeat $ x
replicar'' n = take n . repeat


-- Disfuncional

tieneNombreLargo mascota = length (fst mascota) > 9 


sumarEnergia (Persona nombre energia edad dni) = (Persona nombre (energia + 5) edad dni)
sumarEnergia persona = persona { energia = energia persona + 5 }


triplicarLosPares numeros = (map (*3) . filter even) numeros
triplicarLosPares numeros = map (*3) . filter even $ numeros
triplicarLosPares         = map (*3) . filter even


sonTodosMamiferos animales = all esMamifero animales
sonTodosMamiferos          = all esMamifero


abrirVentanas :: Casa -> Casa
prenderEstufa :: Casa -> Casa
encenderElAireA :: Casa -> Int -> Casa
mudarseA :: String -> Casa -> Casa
miCasaInteligente = Casa
   { direccion = "Medrano 951",
     temperatura = 16,
     reguladores = [abrirVentanas, prenderEstufa,
                    mudarseA "Enfrente", flip encenderElAireA 24]
   }

abrirVentanas :: Casa -> Casa
prenderEstufa :: Casa -> Casa
encenderElAireA :: Int -> Casa -> Casa
mudarseA :: String -> Casa -> Casa
miCasaInteligente = Casa
   { direccion = "Medrano 951",
     temperatura = 16,
     reguladores = [abrirVentanas, prenderEstufa,
                    mudarseA "Enfrente", encenderElAireA 24]
   }


esBeatle "Ringo" = True
esBeatle "John" = True
esBeatle "George" = True
esBeatle "Paul" = True
esBeatle _ = False


sumaDeLasEdadesRecursiva (persona:personas) =
    edad persona + sumaDeLasEdadesRecursiva personas 

sumaDeLasEdades personas = (sum . map edad) personas
sumaDeLasEdades personas = sum . map edad $ personas
sumaDeLasEdades          = sum . map edad


abrirVentanas casa = casa { temperatura = temperatura casa - 2 }
abrirVentanas (Casa direccion temperatura reguladores) = 
    (Casa direccion (temperatura - 2) reguladores)


agregarValor valor indice lista =
   take (indice - 1) lista ++ (valor : drop indice lista)


sumaDeParesTriplesMenoresA100 = (<100) . sum . map (*3) . filter even
