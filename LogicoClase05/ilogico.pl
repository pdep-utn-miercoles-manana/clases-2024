% Punto 1
todosSiguenA(Rey) :-
  personaje(Rey),
  forall(personaje(Personaje), sigueA(Personaje, Rey)).

% Punto 2
ciudadInteresante(Ciudad) :-
  antigua(Ciudad),
  lugaresCopados(Ciudad, Lugares),
  length(Lugares, Cuantos),
  Cuantos > 10.

lugaresCopados(Ciudad, Lugares) :-
  findall(Lugar, lugarCopado(Lugar, Ciudad), Lugares).

lugarCopado(Lugar, Ciudad) :-
  puntoDeInteres(Lugar, Ciudad),
  esCopado(Lugar).

esCopado(bar(CantidadVariedadCerveza)) :-
  CantidadVariedadCerveza > 4.

esCopado(museo(cienciasNaturales)).

esCopado(estadio(Capacidad)) :-
  Capacidad > 40000.

