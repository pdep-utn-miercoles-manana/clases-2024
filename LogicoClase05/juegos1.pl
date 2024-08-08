natacion(masculino, 200, espalda).
natacion(femenino, 1000, pecho).

lanzamiento(masculino, jabalina).
lanzamiento(masculino, bala).
lanzamiento(femenino, disco).

judo(masculino, 60).
judo(masculino, 66).
judo(masculino, 73).
judo(masculino, 81).
judo(masculino, 90).
judo(masculino, 100).
judo(masculino, masDe100kg).

judo(femenino, 48).
judo(femenino, 52).
judo(femenino, 57).
judo(femenino, 63).
judo(femenino, 70).
judo(femenino, 78).
judo(femenino, masDe78kg).

futbol(masculino).
futbol(femenino).
voley(femenino).

disciplinaPorGenero(natacion, Genero) :-
  natacion(Genero, _, _).

disciplinaPorGenero(lanzamiento, Genero) :-
  lanzamiento(Genero, _).

disciplinaPorGenero(futbol, Genero) :-
  futbol(Genero).

disciplinaPorGenero(voley, Genero) :-
  voley(Genero).

disciplinaPorGenero(judo, Genero) :-
  judo(Genero, _).

disciplina(Disciplina) :-
  disciplinaPorGenero(Disciplina, _).

cuantasVariedades(natacion, Cuantas) :-
  findall(_, natacion(_, _, _), Variedades),
  length(Variedades, Cuantas).

cuantasVariedades(lanzamiento, Cuantas) :-
  findall(_, lanzamiento(_, _), Variedades),
  length(Variedades, Cuantas).

cuantasVariedades(judo, Cuantas) :-
  findall(_, judo(_, _), Variedades),
  length(Variedades, Cuantas).

cuantasVariedades(futbol, Cuantas) :-
  findall(_, futbol(_), Variedades),
  length(Variedades, Cuantas).

cuantasVariedades(voley, Cuantas) :-
  findall(_, voley(_), Variedades),
  length(Variedades, Cuantas).
