--------------
-- Punto 01 --
--------------

ferrari = Auto "Ferrari" "F50" (0, 0) 65 0
lambo = Auto "Lamborghini" "Diablo" (7, 4) 73 0
fitito = Auto "Fiat" "600" (33, 27) 44 0

data Auto = Auto {
  marca :: String,
  modelo :: String,
  desgaste :: Desgaste,
  velocidadMaxima :: Float,
  tiempo :: Float
} deriving (Show)

type Desgaste = (Float, Float)

chasis :: Desgaste -> Float
chasis = fst

ruedas :: Desgaste -> Float
ruedas = snd

--------------
-- Punto 02 --
--------------

-- a --
estaEnBuenEstado :: Auto -> Bool
estaEnBuenEstado = estaBien . desgaste

estaBien :: Desgaste -> Bool
estaBien unDesgate = chasis unDesgate < 40 && ruedas unDesgate < 60

-- b --
noDaMas :: Auto -> Bool
noDaMas = estaMuyMal . desgaste

estaMuyMal :: Desgaste -> Bool
estaMuyMal unDesgaste = chasis unDesgaste > 80 || ruedas unDesgaste > 80


--------------
-- Punto 03 --
--------------

reparar :: Auto -> Auto
reparar = cambiarDesgasteChasis (* 0.15) . cambiarDesgasteRuedas (const 0)

cambiarDesgasteChasis :: (Float -> Float) -> Auto -> Auto
cambiarDesgasteChasis f unAuto = unAuto {
  desgaste = ((f . chasis . desgaste) unAuto, ruedas (desgaste unAuto))
}

cambiarDesgasteRuedas :: (Float -> Float) -> Auto -> Auto
cambiarDesgasteRuedas f unAuto = unAuto {
  desgaste = (chasis (desgaste unAuto), (f . ruedas . desgaste) unAuto)
}

--------------
-- Punto 04 --
--------------

type Tramo = Auto -> Auto

-- a --
curva :: Float -> Float -> Tramo
curva unAngulo unaLongitud unAuto = 
  cambiarDesgasteRuedas (+ desgasteCurva) . aumentarTiempo segundos $ unAuto
  where
    desgasteCurva = 3 * unaLongitud / unAngulo
    segundos = unaLongitud / velocidadMaxima unAuto / 2

aumentarTiempo :: Float -> Auto -> Auto
aumentarTiempo unosSegundos unAuto = unAuto {
  tiempo = tiempo unAuto + unosSegundos
}

-- a.i --
curvaPeligrosa :: Tramo
curvaPeligrosa = curva 60 300

-- a.ii --
curvaTranca :: Tramo
curvaTranca = curva 110 550

-- b --
recta :: Float -> Tramo
recta unaLongitud unAuto =
  cambiarDesgasteChasis (+ (unaLongitud / 100)) . aumentarTiempo segundos $ unAuto
  where
    segundos = unaLongitud / velocidadMaxima unAuto

-- b.i --
rectaClassic :: Tramo
rectaClassic = recta 750

-- b.ii --
tramito :: Tramo
tramito = recta 280

-- c --
boxes :: Tramo -> Tramo
boxes unTramo unAuto
  | estaEnBuenEstado unAuto = unTramo unAuto
  | otherwise               = aumentarTiempo 10 . reparar $ unAuto

-- d --
mojar :: Tramo -> Tramo
mojar unTramo unAuto =
  aumentarTiempo segundosPorMojado . unTramo $ unAuto
  where
    segundosPorMojado = (tiempo (unTramo unAuto) - tiempo unAuto) / 2

-- e --
ripio :: Tramo -> Tramo
ripio unTramo = unTramo . unTramo

-- f --
obstruccion :: Tramo -> Float -> Tramo
obstruccion unTramo unaLongitud unAuto =
  cambiarDesgasteRuedas (+ (unaLongitud * 2)) . unTramo $ unAuto


--------------
-- Punto 05 --
--------------

pasarPorTramo :: Auto -> Tramo -> Auto
pasarPorTramo unAuto unTramo
  | noDaMas unAuto = unAuto
  | otherwise      = unTramo unAuto

--------------
-- Punto 06 --
--------------

type Pista = [Tramo]

-- a --
superpista :: Pista
superpista = [
    rectaClassic,
    curvaTranca,
    (tramito . mojar tramito),
    obstruccion (curva 80 400) 2,
    curva 115 650,
    recta 970,
    curvaPeligrosa,
    ripio tramito,
    boxes (recta 800)
  ]

-- b --
peganLaVuelta :: Pista -> [Auto] -> [Auto]
peganLaVuelta unaPista = filter (not . noDaMas) . map (pegaUnaVuelta unaPista)

pegaUnaVuelta :: Pista -> Auto -> Auto
pegaUnaVuelta unaPista unAuto = foldl pasarPorTramo unAuto unaPista

--------------
-- Punto 07 --
--------------

-- a --
data Carrera = Carrera {
  pista :: Pista,
  vueltas :: Int
}

-- b-- 
tourDeBuenosAires :: Carrera
tourDeBuenosAires = Carrera superpista 20

-- c --
correr :: [Auto] -> Carrera -> [[Auto]]
correr unosAutos unaCarrera =
  take (vueltas unaCarrera) . iterate (peganLaVuelta (pista unaCarrera)) $ unosAutos
