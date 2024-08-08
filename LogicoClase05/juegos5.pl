disciplina(natacion, caracteristicas(masculino, 200, espalda)).
disciplina(natacion, caracteristicas(femenino, 1000, pecho)).

disciplina(lanzamiento, caracteristicas(masculino, jabalina)).
disciplina(lanzamiento, caracteristicas(masculino, bala)).
disciplina(lanzamiento, caracteristicas(femenino, disco)).

disciplina(judo, caracteristicas(masculino, 60)).
disciplina(judo, caracteristicas(masculino, 66)).
disciplina(judo, caracteristicas(masculino, 73)).
disciplina(judo, caracteristicas(masculino, 81)).
disciplina(judo, caracteristicas(masculino, 90)).
disciplina(judo, caracteristicas(masculino, 100)).
disciplina(judo, caracteristicas(masculino, masDe100kg)).

disciplina(judo, caracteristicas(femenino, 48)).
disciplina(judo, caracteristicas(femenino, 52)).
disciplina(judo, caracteristicas(femenino, 57)).
disciplina(judo, caracteristicas(femenino, 63)).
disciplina(judo, caracteristicas(femenino, 70)).
disciplina(judo, caracteristicas(femenino, 78)).
disciplina(judo, caracteristicas(femenino, masDe78kg)).

disciplina(futbol, caracteristicas(femenino)).
disciplina(futbol, caracteristicas(masculino)).
disciplina(voley, caracteristicas(femenino)).

disciplinaPorGenero(Disciplina, Genero) :-
  disciplina(Disciplina, Caracteristicas),
  generoEnCaracteristicas(Genero, Caracteristicas).

generoEnCaracteristicas(Genero, caracteristicas(Genero)).
generoEnCaracteristicas(Genero, caracteristicas(Genero, _)).
generoEnCaracteristicas(Genero, caracteristicas(Genero, _, _)).

cuantasVariedades(Disciplina, Cuantas) :-
  disciplina(Disciplina, _),
  findall(Disciplina, disciplina(Disciplina, _), Disciplinas),
  length(Disciplinas, Cuantas).
