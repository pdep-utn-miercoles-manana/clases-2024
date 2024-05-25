import Text.Show.Functions

-------------
-- Punto 1 --
-------------
data Heroe = Heroe {
  epiteto        :: String,
  reconocimiento :: Int,
  artefactos     :: [Artefacto],
  tareas         :: [Tarea]
} deriving (Show)

data Artefacto = Artefacto {
  nombre :: String,
  rareza :: Int
} deriving (Show)

-------------
-- Punto 2 --
-------------
pasarALaHistoria :: Heroe -> Heroe
pasarALaHistoria unHeroe
  | reconocimiento unHeroe > 1000 = cambiarEpiteto "El mítico" unHeroe
  | reconocimiento unHeroe >= 500 = cambiarEpiteto "El magnífico" . agregarArtefacto lanzaDelOlimpo $ unHeroe
  | reconocimiento unHeroe >  100 = cambiarEpiteto "Hoplita" . agregarArtefacto xiphos $ unHeroe
  | otherwise                     = unHeroe

lanzaDelOlimpo :: Artefacto
lanzaDelOlimpo = Artefacto "Lanza del Olimpo" 100

xiphos :: Artefacto
xiphos = Artefacto "Xiphos" 50

cambiarEpiteto :: String -> Heroe -> Heroe
cambiarEpiteto unEpiteto unHeroe = unHeroe {epiteto = unEpiteto}

agregarArtefacto :: Artefacto -> Heroe -> Heroe
agregarArtefacto unArtefacto = cambiarArtefactos (unArtefacto :)

-------------
-- Punto 3 --
-------------

type Tarea = Heroe -> Heroe

encontrarUnArtefacto :: Artefacto -> Tarea
encontrarUnArtefacto unArtefacto = ganarReconocimiento (rareza unArtefacto) . agregarArtefacto unArtefacto

ganarReconocimiento :: Int -> Heroe -> Heroe
ganarReconocimiento cantidad unHeroe = unHeroe {reconocimiento = cantidad + reconocimiento unHeroe}

escalarElOlimpo :: Tarea
escalarElOlimpo = agregarArtefacto relampagoDeZeus . desecharArtefactosComunes . triplicarRarezaArtefactos . ganarReconocimiento 500

relampagoDeZeus :: Artefacto
relampagoDeZeus = Artefacto "Relámpago de Zeus" 1000

triplicarRarezaArtefactos :: Tarea
triplicarRarezaArtefactos = cambiarArtefactos (map triplicarRarezaArtefacto)

triplicarRarezaArtefacto :: Artefacto -> Artefacto
triplicarRarezaArtefacto unArtefacto = unArtefacto {rareza = (*3) . rareza $ unArtefacto}

desecharArtefactosComunes :: Tarea
desecharArtefactosComunes = cambiarArtefactos (filter (not . esComun))

esComun :: Artefacto -> Bool
esComun unArtefacto = rareza unArtefacto < 1000
esComun' = (< 1000) . rareza

cambiarArtefactos :: ([Artefacto] -> [Artefacto]) -> Heroe -> Heroe 
cambiarArtefactos modificador unHeroe = unHeroe {artefactos = modificador (artefactos unHeroe)}


ayudarACruzarLaCalle :: Int -> Tarea
ayudarACruzarLaCalle cantidadDeCuadras = cambiarEpiteto ("Gros" ++ replicate cantidadDeCuadras 'o')

matarUnaBestia :: Bestia -> Tarea
matarUnaBestia unaBestia unHeroe
  | (debilidad unaBestia) unHeroe = cambiarEpiteto ("El asesino de " ++ nombreBestia unaBestia) unHeroe
  | otherwise                     = cambiarEpiteto "El cobarde" . cambiarArtefactos (drop 1) $ unHeroe

-- drop 2 [1,2,3,4] = [3,4]
-- drop 120 [] = []

data Bestia = Bestia {
  nombreBestia :: String,
  debilidad    :: Debilidad
} deriving (Show)

type Debilidad = Heroe -> Bool

-------------
-- Punto 4 --
-------------
heracles :: Heroe
heracles = Heroe "Guardián del Olimpo" 700 [pistolaRara, relampagoDeZeus] [matarUnaBestia leonDeNemea]

pistolaRara :: Artefacto
pistolaRara = Artefacto "Fierro de la antigua Grecia" 1000

-------------
-- Punto 5 --
-------------
leonDeNemea :: Bestia
leonDeNemea = Bestia "León de Nemea" ((> 20) . length . epiteto)

-------------
-- Punto 6 --
-------------

hacerUnaTarea :: Tarea -> Heroe -> Heroe
hacerUnaTarea unaTarea unHeroe = agregarTarea unaTarea (unaTarea unHeroe)
hacerUnaTarea' unaTarea unHeroe = agregarTarea unaTarea . unaTarea $ unHeroe

agregarTarea :: Tarea -> Heroe -> Heroe
agregarTarea unaTarea unHeroe = unHeroe {tareas = unaTarea : tareas unHeroe}

-------------
-- Punto 7 --
-------------
-- Podría estar mucho mejor...
-- presumir :: Heroe -> Heroe -> (Heroe, Heroe)
-- presumir unHeroe otroHeroe
--   | reconocimiento unHeroe > reconocimiento otroHeroe = (unHeroe, otroHeroe)
--   | reconocimiento unHeroe < reconocimiento otroHeroe = (otroHeroe, unHeroe)
--   | sumatoriaRarezas unHeroe > sumatoriaRarezas otroHeroe = (unHeroe, otroHeroe)
--   | sumatoriaRarezas unHeroe < sumatoriaRarezas otroHeroe = (otroHeroe, unHeroe)
--   | otherwise = presumir (realizarLabor (tareas otroHeroe) unHeroe) (realizarLabor (tareas unHeroe) otroHeroe)

presumir' heroe1 heroe2
  | gana heroe1 heroe2 = (heroe1, heroe2)
  | gana heroe2 heroe1 = (heroe2, heroe1)
  | otherwise          = presumir' (realizarTareasDe heroe1 heroe2) (realizarTareasDe heroe2 heroe1)

realizarTareasDe :: Heroe -> Heroe -> Heroe
realizarTareasDe unHeroe otroHeroe = realizarLabor (tareas otroHeroe) unHeroe

gana :: Heroe -> Heroe -> Bool
gana ganador perdedor =
  reconocimiento ganador > reconocimiento perdedor ||
  reconocimiento ganador == reconocimiento perdedor && sumatoriaRarezas ganador > sumatoriaRarezas perdedor

sumatoriaRarezas = sum . map rareza . artefactos
-------------
-- Punto 8 --
-------------
{-

-}

-------------
-- Punto 9 --
-------------
realizarLabor :: [Tarea] -> Heroe -> Heroe
realizarLabor unasTareas unHeroe = foldl (flip hacerUnaTarea) unHeroe unasTareas

--------------
-- Punto 10 --
--------------
