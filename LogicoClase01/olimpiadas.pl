% esto es un comentario de una línea
/*
esto es un comentario multilínea
*/

% todos los guerreros Z son poderosos
% goku es un guerrero Z
% por lo tanto, goku es poderoso

% guerreroZ/1
guerreroZ(goku).
guerreroZ(krillin).
guerreroZ(gohan).
guerreroZ(feli).
guerreroZ(8).
guerreroZ(lebron).
guerreroZ(messi).

% guerreroZ(unGuerrero) => esPoderoso(unGuerrero).
esPoderoso(Guerrero):-
    guerreroZ(Guerrero).

esPoderoso(galactus).

/*
?- esPoderoso(yo).
=>
esPoderoso(yo):-
    guerreroZ(yo).
guerreroZ(yo).
false
*/

% armaRutina/2
% armaRutina(Atleta, Entrenador).
armaRutina(goku, goku).
armaRutina(jordan, timGrover).
armaRutina(kobe, timGrover).
armaRutina(wade, timGrover).
armaRutina(fede, chatGPT).
armaRutina(jordan, bugsBunny).

esSuPropioCoach(Persona):-
    armaRutina(Persona, Persona).


hizoTrampa(Persona):-
    armaRutina(Persona, chatGPT).


laburador(Entrenador):-
    armaRutina(Persona, Entrenador),
    armaRutina(OtraPersona, Entrenador),
    Persona \= OtraPersona.


% MANU TE AMO
medalla(basquet, argentina, 2004, oro).
medalla(basquet, italia, 2004, plata).
medalla(basquet, eeuu, 2004, bronce).
medalla(levantamientoOlimpico, pyrrosDimas, 1992, oro).
medalla(levantamientoOlimpico, pyrrosDimas, 1996, oro).
medalla(levantamientoOlimpico, pyrrosDimas, 2000, oro).
medalla(levantamientoOlimpico, pyrrosDimas, 2004, bronce).
medalla(levantamientoOlimpico, lyuXiaojun, 2012, oro).
medalla(levantamientoOlimpico, lyuXiaojun, 2016, oro).
medalla(levantamientoOlimpico, lyuXiaojun, 2020, oro).


ganador(Atleta, Disciplina):-
    medalla(Disciplina, Atleta, _, oro).


perdedor(Atleta, Disciplina):-
    medalla(Disciplina, Atleta, _, Medalla),
    Medalla \= oro.

esLaCabra(pyrrosDimas, levantamientoOlimpico).
esLaCabra(lebron, basquet).


fraude(Atleta):-
    esLaCabra(Atleta, Disciplina),
    % fuckin orden superior 🤯
    not(ganador(Atleta, Disciplina)).
