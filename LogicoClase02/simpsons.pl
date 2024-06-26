padreDe(abe, abbie).
padreDe(abe, homero).
padreDe(abe, herbert).
padreDe(clancy, marge).
padreDe(clancy, patty).
padreDe(clancy, selma).
padreDe(homero, bart).
padreDe(homero, hugo).
padreDe(homero, lisa).
padreDe(homero, maggie).
madreDe(edwina, abbie).
madreDe(mona, homero).
madreDe(gaby, herbert).
madreDe(jacqueline, marge).
madreDe(jacqueline, patty).
madreDe(jacqueline, selma).
madreDe(marge, bart).
madreDe(marge, hugo).
madreDe(marge, lisa).
madreDe(marge, maggie).
madreDe(selma, ling).

% tieneHijo/1: Nos dice si un personaje tiene un hijo o hija.
tieneHijo(Progenitora) :-
  madreDe(Progenitora, _).

tieneHijo(Progenitor) :-
  padreDe(Progenitor, _).

% hermanos/2: Relaciona a dos personajes cuando estos comparten madre y padre.
hermanos(Hermano1, Hermano2) :-
  compartenMadre(Hermano1, Hermano2),
  compartenPadre(Hermano1, Hermano2).

compartenMadre(Hermano1, Hermano2) :-
  madreDe(Madre, Hermano1),
  madreDe(Madre, Hermano2),
  Hermano1 \= Hermano2.

compartenPadre(Hermano1, Hermano2) :-
  padreDe(Padre, Hermano1),
  padreDe(Padre, Hermano2),
  Hermano1 \= Hermano2.

% medioHermanos/2: Relaciona a dos personajes cuando estos comparten (exclusivamente) madre o padre.
medioHermanos(Hermano1, Hermano2) :-
  compartenMadre(Hermano1, Hermano2),
  not(compartenPadre(Hermano1, Hermano2)).

medioHermanos(Hermano1, Hermano2) :-
  compartenPadre(Hermano1, Hermano2),
  not(compartenMadre(Hermano1, Hermano2)).

% descendiente/2: Relaciona a dos personajes, en donde uno desciende del otro
% a través de una cantidad no predeterminada de generaciones. 
descendiente(Descendiente, Ancestro) :-
  progenitor(Ancestro, Descendiente).

descendiente(Descendiente, AncestroMaximo) :-
  progenitor(AncestroMaximo, Ancestro),
  descendiente(Descendiente, Ancestro).

progenitor(Padre, Hijo) :-
  padreDe(Padre, Hijo).

progenitor(Madre, Hijo) :-
  madreDe(Madre, Hijo).

