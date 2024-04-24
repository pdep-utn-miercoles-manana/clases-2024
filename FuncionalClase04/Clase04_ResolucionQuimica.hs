{-
¡Excelsior! ¡Encontramos la manera de convertir la tierra en oro mágicamente! O eso creían los alquimistas, aunque en realidad no era magia, si no que era ciencia, química para ser exactos.
Hoy en día, las sustancias químicas abundan. Es por ello que, para llevar un mejor recuento de las sustancias ya existentes y las nuevas creadas, nos decidimos a hacer un sistema con dicho fin, en Haskell.
En nuestro análisis, nos encontramos con que las sustancias pueden clasificarse en dos tipos: compuestas o sencillas. 
Las sustancias sencillas son aquellas que se corresponden directamente a un elemento de la tabla periódica, de allí su otro nombre, elemento. De los elementos conocemos su nombre, símbolo químico y número atómico.
Las sustancias compuestas, o simplemente compuestos, son aquellas que tienen una serie de componentes. Un componente es un par formado por una sustancia y la cantidad de moléculas de esa sustancia. La sustancia del componente puede ser un elemento o un compuesto. Además, los compuestos, al igual que las sustancias simples, tienen un nombre, pero no número atómico. También poseen un símbolo o fórmula química, la cual no nos interesa conocer en todo momento, ya que es deducible a partir de las sustancias que la componen.
Ah, nos olvidábamos, también sabemos que todas las sustancias poseen un grupo o especie, que puede ser metal, no metal, halógeno o gas noble.
-}

{-
Se pide, entonces
1. Modelar las siguientes sustancias:
  * El hidrógeno y el oxígeno
  * El agua, sustancia compuesta por 2 hidrógenos y 1 un oxígeno.
-}

hidrogeno :: Sustancia
hidrogeno = Elemento "Hidrogeno" "H" 1 NoMetal

oxigeno :: Sustancia
oxigeno = Elemento "Oxigeno" "O" 8 NoMetal

agua :: Sustancia
agua = Compuesto "Agua" NoMetal [Componente hidrogeno 2, Componente oxigeno 1]

data Sustancia 
  = Elemento {
    nombre :: String,
    simbolo :: String,
    numeroAtomico :: Int,
    grupo :: Grupo
  } 
  | Compuesto {
    nombre :: String,
    grupo :: Grupo,
    componentes :: [Componente]
  }
  deriving (Show)

data Grupo = Metal | NoMetal | Halogeno | GasNoble deriving (Show, Eq)

data Componente = Componente {
  sustancia :: Sustancia,
  cantidad :: Int
} deriving (Show)

{-
2. Poder saber si una sustancia conduce bien según un criterio. Los criterios actuales son electricidad y calor, pero podría haber más. Los metales conducen bien cualquier criterio, sean compuestos o elementos. Los elementos que sean gases nobles conducen bien la electricidad, y los compuestos halógenos conducen bien el calor. Para el resto, no son buenos conductores.
-}

data Criterio = Electricidad | Calor deriving (Show)

conduceBien :: Criterio -> Sustancia -> Bool
conduceBien Electricidad (Elemento _ _ _ GasNoble) = True
conduceBien Calor (Compuesto _ Halogeno _) = True
conduceBien _ sustancia = esMetal sustancia

esMetal :: Sustancia -> Bool
esMetal = (== Metal) . grupo

{-
3. Obtener el nombre de unión de un nombre. Esto se logra añadiendo “uro” al final del nombre, pero solo si el nombre termina en consonante. Si termina en vocal, se busca hasta la última consonante y luego sí, se le concatena “uro”. Por ejemplo, el nombre de unión del Fluor es “fluoruro”, mientras que el nombre de unión del mercurio es “mercururo”.
-}

nombreDeUnion :: String -> String
nombreDeUnion nombre = sinVocalesAlFinal nombre ++ "uro"

sinVocalesAlFinal :: String -> String
sinVocalesAlFinal palabra = reverse . dropWhile esVocal . reverse $ palabra

esVocal :: Char -> Bool
esVocal unaLetra = elem unaLetra "aeiou"

{-
4. Combinar 2 nombres. Al nombre de unión del primero lo concatenamos con el segundo, agregando un “ de “ entre medio. Por ejemplo, si combino “cloro” y “sodio” debería obtener “cloruro de sodio”.
-}

combinar :: String -> String -> String
combinar nombreSustancia1 nombreSustancia2 = nombreDeUnion nombreSustancia1 ++ " de " ++ nombreSustancia2

{-
5. Mezclar una serie de componentes entre sí. El resultado de dicha mezcla será un compuesto. Sus componentes serán los componentes mezclados. El nombre se forma de combinar los nombres de la sustancia de cada componente. La especie será, arbitrariamente, un no metal.
-}

mezclar :: [Componente] -> Sustancia
mezclar componentes = Compuesto (nombreDelCompuesto componentes) NoMetal componentes

nombreDelCompuesto :: [Componente] -> String
nombreDelCompuesto = nombreDeUniones . map (nombre . sustancia)

nombreDeUniones :: [String] -> String
nombreDeUniones [nombre] = nombre
nombreDeUniones (nombre1 : nombre2 : nombres) =
  nombreDeUniones (combinar nombre1 nombre2 : nombres)

{-
6. Obtener la fórmula de una sustancia:
    - para los elementos es su símbolo químico
    - para los compuestos es la concatenación de las representaciones de sus componentes y se pone entre paréntesis
      * La representación de un componente depende de la cantidad de moléculas:
        - si tiene una, entonces solo es la fórmula de su sustancia
        - si tiene más, entonces es la fórmula de su sustancia y la cantidad
Por ejemplo, la fórmula del agua debería ser (H2O). ¡Recuerden que una sustancia compuesta puede estar compuesta por otras sustancias compuestas!
-}


formula :: Sustancia -> String
formula (Elemento _ simboloQuimico _ _) = simboloQuimico
formula (Compuesto _ _ componentes) = concat (map representacion componentes)

representacion (Componente sustancia 1) = formula sustancia
representacion (Componente sustancia numero) = formula sustancia ++ show numero
