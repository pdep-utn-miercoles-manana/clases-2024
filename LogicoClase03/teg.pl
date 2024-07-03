paisContinente(americaDelSur, argentina).
paisContinente(americaDelSur, bolivia).
paisContinente(americaDelSur, brasil).
paisContinente(americaDelSur, chile).
paisContinente(americaDelSur, ecuador).
paisContinente(europa, alemania).
paisContinente(europa, espania).
paisContinente(europa, francia).
paisContinente(europa, inglaterra).
paisContinente(asia, aral).
paisContinente(asia, china).
paisContinente(asia, india).
paisContinente(asia, afganistan).
paisContinente(asia, nepal).

paisImportante(argentina).
paisImportante(alemania).

limitrofes(argentina, brasil).
limitrofes(bolivia, brasil).
limitrofes(bolivia, argentina).
limitrofes(argentina, chile).
limitrofes(espania, francia).
limitrofes(alemania, francia).
limitrofes(nepal, india).
limitrofes(china, india).
limitrofes(nepal, china).
limitrofes(afganistan, china).

ocupa(argentina, azul).
ocupa(bolivia, rojo).
ocupa(brasil, verde).
ocupa(chile, negro).
ocupa(ecuador, rojo).
ocupa(alemania, azul).
ocupa(espania, azul).
ocupa(francia, azul).
ocupa(inglaterra, azul).
ocupa(aral, verde).
ocupa(china, negro).
ocupa(india, verde).
ocupa(afganistan, verde).

continente(americaDelSur).
continente(europa).
continente(asia).

% estaEnContinente/2: relaciona un jugador y un continente si el jugador ocupa al menos un país en el continente.
estaEnContinente(Jugador, Continente) :-
  paisContinente(Continente, Pais),
  ocupa(Pais, Jugador).

% ocupaContinente/2: relaciona un jugador y un continente si el jugador ocupa totalmente el continente.
ocupaContinente(Jugador, Continente) :-
  jugador(Jugador),
  continente(Continente),
  forall(paisContinente(Continente, Pais), ocupa(Pais, Jugador)).

jugador(Jugador) :-
  ocupa(_, Jugador).

% cubaLibre/1: es verdadero para un país si nadie lo ocupa.
cubaLibre(Pais) :-
  pais(Pais),
  not(ocupa(Pais, _)).

pais(Pais) :-
  paisContinente(_, Pais).

% leFaltaMucho/2: relaciona a un jugador si está en un continente pero le falta ocupar otros 2 países o más.
leFaltaMucho(Jugador, Continente) :-
  estaEnContinente(Jugador, Continente),
  noOcupaPaisDe(Continente, Pais1, Jugador),
  noOcupaPaisDe(Continente, Pais2, Jugador),
  Pais1 \= Pais2.

noOcupaPaisDe(Continente, Pais, Jugador) :-
  paisContinente(Continente, Pais),
  not(ocupa(Pais, Jugador)).

% sonLimitrofes/2: relaciona 2 países si son limítrofes considerando que si A es limítrofe de B, entonces B también es limítrofe de A.
sonLimitrofes(Pais1, Pais2) :-
  limitrofes(Pais1, Pais2).

sonLimitrofes(Pais1, Pais2) :-
  limitrofes(Pais2, Pais1).

% tipoImportante/1: un jugador es importante si ocupa todos los países importantes.
tipoImportante(Jugador) :-
  jugador(Jugador),
  forall(paisImportante(Pais), ocupa(Pais, Jugador)).

% estaEnElHorno/1: un país está en el horno si todos sus países limítrofes están ocupados por el mismo jugador que no es el mismo que ocupa ese país.
estaEnElHorno(Pais) :-
  ocupa(Pais, Jugador),
  jugador(JugadorOcupador),
  Jugador \= JugadorOcupador,
  sonLimitrofes(Pais, _), % esta línea es para que no considere en el forall los países sin limítrofes, pero podría omitirse
  forall(sonLimitrofes(Pais, Limitrofe), ocupa(Limitrofe, JugadorOcupador)).

% esCompartido/1: un continente es compartido si hay dos o más jugadores en él.
esCompartido(Continente) :-
  estaEnContinente(Jugador1, Continente),
  estaEnContinente(Jugador2, Continente),
  Jugador1 \= Jugador2.

esCompartido2(Continente) :-
  continente(Continente),
  not(ocupaContinente(_, Continente)).

