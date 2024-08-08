disciplina(natacion200Espalda, masculino).
disciplina(natacion1000Pecho, femenino).

disciplina(lanzamientoJabalina, masculino).
disciplina(lanzamientoBala, masculino).
disciplina(lanzamientoDisco, femenino).

disciplina(judo60kg, masculino).
disciplina(judo66kg, masculino).
disciplina(judo73kg, masculino).
disciplina(judo81kg, masculino).
disciplina(judo90kg, masculino).
disciplina(judo100kg, masculino).
disciplina(judoMasDe100kg, masculino).

disciplina(judo48kg, femenino).
disciplina(judo52kg, femenino).
disciplina(judo57kg, femenino).
disciplina(judo63kg, femenino).
disciplina(judo70kg, femenino).
disciplina(judo78kg, femenino).
disciplina(judoMasDe78kg, femenino).

disciplina(futbol, masculino).
disciplina(futbol, femenino).
disciplina(voley, femenino).

disciplinaPorGenero(Disciplina, Genero) :-
  disciplina(Disciplina, Genero).

% cuantasVariedades(Disciplina, Cuantas) :-
  % ...?