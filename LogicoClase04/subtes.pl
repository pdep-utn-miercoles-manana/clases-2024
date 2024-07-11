linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).
combinacion([lima, avMayo]). % A C
combinacion([once, miserere]). % H A
combinacion([pellegrini, diagNorte, nueveJulio]). % B C D
combinacion([independenciaC, independenciaE]). % C E
combinacion([jujuy, humberto1ro]). % E H
combinacion([santaFe, pueyrredonD]). % H D
combinacion([corrientes, pueyrredonB]). % H B


% 1 %
estaEn(Linea, Estacion) :-
  linea(Linea, Estaciones),
  member(Estacion, Estaciones).

% 2 %
distancia(Estacion1, Estacion2, Distancia) :-
  mismaLinea(Estacion1, Estacion2),
  posicion(Estacion1, Posicion1),
  posicion(Estacion2, Posicion2),
  DistanciaRelativa is Posicion1 - Posicion2,
  abs(DistanciaRelativa, Distancia).

mismaLinea(Estacion1, Estacion2) :-
  estaEn(Linea, Estacion1),
  estaEn(Linea, Estacion2).

posicion(Estacion, Posicion) :-
  estaEn(Linea, Estacion),
  linea(Linea, Estaciones),
  nth1(Posicion, Estaciones, Estacion).

% 3 %
mismaAltura(Estacion1, Estacion2) :-
  posicion(Estacion1, Posicion),
  posicion(Estacion2, Posicion).
  % podría agregarse el requisito de que estén en
  % líneas distintas, si se considera necesario

% 4 %
granCombinacion(Estaciones) :-
  combinacion(Estaciones), % *
  length(Estaciones, Cuantas),
  Cuantas > 2.
  % * Esta línea es para 'asegurar' que se le pasa una lista
  %   de combinaciones, ya que sin ese requisito no sólo
  %   funciona con estaciones que no sean combinaciones sino
  %   también con listas que tengan cualquier cosa.
  %   Vale la pena aclarar, sin embargo, que como no estamos
  %   considerando permutaciones en los elementos de la lista,
  %   esto va a funcionar para [pellegrini, diagNorte, nueveJulio]
  %   pero no para [nueveJulio, diagNorte, pellegrini], a pesar
  %   de que son las mismas estaciones en ambos casos.

% 5 %
cuantasCombinan(Linea, Cuantas) :-
  linea(Linea, _),
  findall(Estacion, combinaParaLinea(Estacion, Linea), Estaciones),
  length(Estaciones, Cuantas).

combinaParaLinea(Estacion, Linea) :-
  estaEn(Linea, Estacion),
  combinacion(Estaciones),
  member(Estacion, Estaciones).

% 6 %
lineaMasLarga(Linea) :-
  linea(Linea, Estaciones),
  length(Estaciones, Cuantas),
  forall(linea(_, OtrasEstaciones), menosEstacionesQue(Cuantas, OtrasEstaciones)).

menosEstacionesQue(Cuantas, Estaciones) :-
  length(Estaciones, OtrasCuantas),
  Cuantas >= OtrasCuantas.

% 7 %
viajeFacil(Estacion1, Estacion2) :-
  estaEn(Linea, Estacion1),
  estaEn(Linea, Estacion2).

viajeFacil(Estacion1, Estacion2) :-
  combinacionPara(Estacion1, Combinacion1),
  combinacionPara(Estacion2, Combinacion2),
  mismaCombinacion(Combinacion1, Combinacion2).

combinacionPara(Estacion, Combinacion) :-
  estaEn(Linea, Estacion),
  linea(Linea, Estaciones),
  member(Combinacion, Estaciones).

mismaCombinacion(Estacion1, Estacion2) :-
  combinacion(Combinacion),
  member(Estacion1, Combinacion),
  member(Estacion2, Combinacion).
  % Este nombre de predicado parece engañoso a simple vista,
  % pero atención; no se fija que ambas combinaciones sean la misma,
  % sino que ambas *estaciones* pertenezcan a la misma combinación