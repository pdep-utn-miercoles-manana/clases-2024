import Text.Show.Functions
import Data.List

--     Tipo  Constructor/Deconstructor
--       ↓       ↓
data Pokemon = Pokemon {
  nombre :: String, 
  familia :: String,
  tipoPokemon :: TipoPokemon
} deriving (Show)

--           Tipo
--             ↓
familia' :: Pokemon -> String
familia' (Pokemon _ unaFamilia _) = unaFamilia
--           ↑
--     Deconstructor

data Elemento = Fuego | Psiquico | Acero deriving (Show, Eq)
-- Podemos hacer que cualquier tipo pertenezca a cualquier Clase/Familia/Restriccion 
-- de tipo de una manera más personalizada, pero necesitamos tomar un poco más de sopa para eso

data TipoPokemon = Unico Elemento | Doble Elemento Elemento deriving (Show)

primario (Unico elemento) = elemento
primario (Doble elemento1 _) = elemento1

secundario (Doble _ elemento2) = elemento2


charmander :: Pokemon
charmander = Pokemon {
  nombre = "Charmander",
  familia = "Salamandra piola",
  tipoPokemon = Unico Fuego
}

victini :: Pokemon
victini = Pokemon "Victini" "Pokemon Peronista" (Doble Fuego Psiquico)

metagross :: Pokemon
metagross = Pokemon "Metagross" "Nunca saltea dia de pierna" (Doble Psiquico Acero)

pokedexDeAle :: [Pokemon]
pokedexDeAle = [charmander, victini, metagross]

-- NO HAY IFs EN HASKELL. ACÁ HAY FUNCIONES PARTIDAS

abs' x
  | x >= 0 =  x
  | x <  0 = -x

signo :: Int -> Int
signo 0 = 0
signo x
  | x >  0    =  1
  | x <  0    = -1
  | otherwise =  0

evaluarPokedex unaPokedex
  | cantidadPokemones <  50 = "Segui participando"
  | cantidadPokemones < 100 = "Venis bien pa!"
  | cantidadPokemones < 150 = "Ahhh! te falta uno"
  | otherwise               = "Completaste la Pokedex!"
  where
    cantidadPokemones = length unaPokedex

familiasDeUnaPokedex :: [Pokemon] -> [String]
familiasDeUnaPokedex pokedex = map familia pokedex

-- sonCompatibles :: Pokemon -> Pokemon -> Bool
-- sonCompatibles pokemon1 pokemon2 = 
--   not (null (intersect (tipoPokemon pokemon1) (tipoPokemon pokemon2)))
  -- COMPONER
  -- Hacer que ande


esVocal letra = elem letra "aeiouAEIOU"

-- Definido con Pattern Matching

esVocal' 'a' = True
esVocal' 'e' = True
esVocal' 'i' = True
esVocal' 'o' = True
esVocal' 'u' = True
esVocal'  _  = False


cabeza :: [a] -> a
cabeza (x:_) = x

cola :: [a] -> [a]
cola (_:xs) = x

-- Los valores concretos son "Patternmatcheables"
-- * Strings
-- * Números
-- * Booleanos
-- * Caracteres
--
-- Patrones sobre Listas
-- * Lista vacia: []
-- * Lista de un elemento: [elemento]
-- * Lista de AL MENOS un elemento: (elemento : colaDeLaLista)
-- * Lista de dos elementos: [elemento1, elemento2]
-- * Lista de AL MENOS dos elementos: (elemento1 : elemento2 : colaDeLaLista)
-- Y así sucesivamente...
-- Recordar que colaDeLaLista es de tipo lista, puede ser vacía o con elementos
--
-- Patrones sobre nuestros datas
-- * Constructor
-- * (Contructor parametro)
-- * (Constructor parametro1 parametro2)
-- Y así sucesivamente...
--
-- Tambien se pueden mezclar todos estos patrones