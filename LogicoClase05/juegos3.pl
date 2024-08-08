disciplina(natacion, masculino, [espalda200]).
disciplina(natacion, femenino, [pecho1000]).

disciplina(lanzamiento, masculino, [jabalina, bala]).
disciplina(lanzamiento, femenino, [disco]).

disciplina(judo, masculino, [60, 66, 73, 81, 90, 100, masDe100]).
disciplina(judo, femenino, [48, 52, 57, 63, 70, 78, masDe78]).

disciplina(futbol, masculino).
disciplina(futbol, femenino).
disciplina(voley, femenino).

disciplinaPorGenero(Disciplina, Genero) :-
  disciplina(Disciplina, Genero, _).

disciplinaPorGenero(Disciplina, Genero) :-
  disciplina(Disciplina, Genero).

cuantasVariedades(Disciplina, Cuantas) :-
  disciplina(Disciplina, _, _),
  findall(Categorias, disciplina(Disciplina, _, Categorias), CategoriasPorGenero),
  flatten(CategoriasPorGenero, TodasCategoriasJuntas),
  length(TodasCategoriasJuntas, Cuantas).

cuantasVariedades(Disciplina, Cuantas) :-
  disciplina(Disciplina, _),
  findall(Genero, disciplina(Disciplina, Genero), Generos),
  length(Generos, Cuantas).
 