disciplina(masculino, natacion(200, espalda)).
disciplina(femenino, natacion(1000, pecho)).

disciplina(masculino, lanzamiento(jabalina)).
disciplina(masculino, lanzamiento(bala)).
disciplina(femenino, lanzamiento(disco)).

disciplina(masculino, judo([60, 66, 73, 81, 90, 100, masDe100])).
disciplina(femenino, judo([48, 52, 57, 63, 70, 78, masDe78])).

disciplina(femenino, futbol).
disciplina(masculino, futbol).
disciplina(femenino, voley).

disciplinaPorGenero(Genero, Disciplina) :-
  disciplina(Genero, Disciplina).

disciplina(Disciplina) :-
  disciplinaPorGenero(_ , Disciplina).

% cuantasVariedades(Disciplina, Cuantas) :-
%  disciplina(_, Disciplina(_,_)),
%  findall(Disciplina, disciplina(_, Disciplina(_, _)), Disciplinas),
%  length(Disciplinas, Cuantas).
