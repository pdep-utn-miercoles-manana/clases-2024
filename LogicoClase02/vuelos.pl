% vuelo/3
vuelo(aep, scl, 150000).
vuelo(scl, aep, 160000).
vuelo(eze, gru, 200000).
vuelo(gru, eze, 190000).
vuelo(aep, eze, 10000).
vuelo(eze, aep, 14000).

% costoIdaYVuelta/3
costoIdaYVuelta(Costo, Ida, Vuelta) :-
  vuelo(Ida, Vuelta, CostoIda),
  vuelo(Vuelta, Ida, CostoVuelta),
  Costo is CostoIda + CostoVuelta.

% millasParaIdaYVuelta/3
% Cada milla sale 100 pesos.
millasParaIdaYVuelta(Millas, Ida, Vuelta) :-
  costoIdaYVuelta(Costo, Ida, Vuelta),
  Millas is Costo / 100.

% vueloBarato/2
% Es barato si sale menos de 200000.
vueloBarato(Ida, Vuelta) :-
  costoIdaYVuelta(Costo, Ida, Vuelta),
  Costo < 200000.

% diferenciaEnPesos/3
% Cuánta es la diferencia entre el tramo de ida y el de vuelta
diferenciaEnPesos(Diferencia, Ida, Vuelta) :-
  vuelo(Ida, Vuelta, CostoIda),
  vuelo(Vuelta, Ida, CostoVuelta),
  DiferenciaParcial is CostoIda - CostoVuelta,
  abs(DiferenciaParcial, Diferencia).

aeropuerto(aep, buenosAires).
aeropuerto(eze, buenosAires).
aeropuerto(scl, santiago).
aeropuerto(gru, saoPaulo).
aeropuerto(mdq, marDelPlata).

ciudad(avellaneda, argentina).
ciudad(buenosAires, argentina).
ciudad(marDelPlata, argentina).
ciudad(santiago, chile).
ciudad(saoPaulo, brasil).

% inaccesibleEnAvion/1 -> a una ciudad no se puede llegar en avión
inaccesibleEnAvion(Ciudad) :-
  ciudad(Ciudad, _),
  not(accesibleEnAvion(Ciudad)).

accesibleEnAvion(Ciudad) :-
  aeropuerto(Aeropuerto, Ciudad),
  vuelo(_, Aeropuerto, _).

% imposibleSalir/1 -> ciudad tiene un vuelo de ida pero no de vuelta
imposibleSalir(Ciudad) :-
  accesibleEnAvion(Ciudad),
  not(tieneVueloDeVuelta(Ciudad)).

tieneVueloDeVuelta(Ciudad) :-
  aeropuerto(Aeropuerto, Ciudad),
  vuelo(Aeropuerto, _, _).

% vueloNacional -> para dos aeropuertos, sale y llega a/de Argentina 
% (en la resolución en clase no agregamos vuelo(Aeropuerto1, Aeropuerto2, _),
% pero tendría sentido para que efectivamente hablemos de un *vuelo* nacional).
vueloNacional(Aeropuerto1, Aeropuerto2) :-
  aeropuertoArgentino(Aeropuerto1),
  aeropuertoArgentino(Aeropuerto2).

aeropuertoArgentino(Aeropuerto) :-
  aeropuerto(Aeropuerto, Ciudad),
  ciudad(Ciudad, argentina).

