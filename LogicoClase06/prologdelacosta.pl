%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%
puestoDeComida(hamburguesa, 2000).
puestoDeComida(lomitoCompleto, 2500).
puestoDeComida(panchitoConPapas, 1500).
puestoDeComida(caramelos, 0).

atraccion(autitosChocadores, tranquila(chicosYAdultos)).
atraccion(casaEmbrujada, tranquila(chicosYAdultos)).
atraccion(laberinto, tranquila(chicosYAdultos)).
atraccion(tobogan, tranquila(chicos)).
atraccion(calesita, tranquila(chicos)).

% atraccion(nombre, intensa(coeficienteDeLanzamiento)).
atraccion(barcoPirata, intensa(14)).
atraccion(tazasChinas, intensa(6)).
atraccion(simulador3D, intensa(2)).

% atracccion(nombre, montaniaRusa(giros, duracion)).
atraccion(abismoMortalRecargada, montaniaRusa(3, 134)).
atraccion(paseoPorElBosque, montaniaRusa(0, 45)).

atraccion(torpedoSalpicon, acuatica).
atraccion(esperoQueHayasTraidoUnaMudaDeRopa, acuatica).

% TODO: agregar meses de atracciones acuaticas

% visitante(nombre, datosSuperficiales(edad, dinero), sentimiento(hambre, aburrimiento))
% grupo(nombre, grupo).

visitante(eusebio, datosSuperficiales(80, 3000), sentimiento(50, 0)).
visitante(carmela, datosSuperficiales(80,    0), sentimiento(0, 25)).

visitante(joaco, datosSuperficiales(22,    0), sentimiento(100, 100)).
visitante(fede,  datosSuperficiales(36, 1000), sentimiento( 50,   0)).

grupo(eusebio, viejitos).
grupo(carmela, viejitos).

%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%
% bienestar(Visitante, Bienestar)
% bienestar(Visitante, felicidadPlena) :-
%     visitante(Visitante, _, sentimiento(0, 0)).

% bienestar(Visitante, podriaEstarMejor) :-
%     visitante(Visitante, _, sentimiento(Hambre, Aburrimiento)),
%     Suma is Hambre + Aburrimiento,
%     between(1, 50, Suma).

% bienestar(Visitante, necesitaEntretenerse) :-
%     visitante(Visitante, _, sentimiento(Hambre, Aburrimiento)),
%     Suma is Hambre + Aburrimiento,
%     between(51, 99, Suma).

% bienestar(Visitante, quiereIrseACasa) :-
%     visitante(Visitante, _, sentimiento(Hambre, Aburrimiento)),
%     Suma is Hambre + Aburrimiento,
%     Suma >= 100.

% %%%%%%%

visitante(Visitante) :-
    visitante(Visitante, _, _).

vieneSolo(Visitante) :-
    visitante(Visitante),
    not(vieneAcompaniado(Visitante)).

vieneAcompaniado(Visitante) :-
    grupo(Visitante, _).

bienestar(Visitante, felicidadPlena) :-
    sumaSentimientos(Visitante, 0),
    vieneAcompaniado(Visitante).

bienestar(Visitante, podriaEstarMejor) :-
    sumaSentimientos(Visitante, 0),
    vieneSolo(Visitante).

bienestar(Visitante, podriaEstarMejor) :-
    sumaSentimientosEntre(Visitante, 1, 50).

bienestar(Visitante, necesitaEntretenerse) :-
    sumaSentimientosEntre(Visitante, 51, 99).

bienestar(Visitante, quiereIrseACasa) :-
    sumaSentimientos(Visitante, Suma),
    Suma >= 100.

sumaSentimientosEntre(Visitante, Base, Tope) :-
    sumaSentimientos(Visitante, Suma),
    between(Base, Tope, Suma).

sumaSentimientos(Visitante, Suma) :-
    visitante(Visitante, _, sentimiento(Hambre, Aburrimiento)),
    Suma is Hambre + Aburrimiento.

% TODO: ejercicio para casa!
% Abstraer los sentimientos y evitar la sutil repeticion de logica.

%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%
comida(Comida) :-
    puestoDeComida(Comida, _).

grupo(Grupo) :-
    grupo(_, Grupo).

puedeSatisfacer(Grupo, Comida) :-
    comida(Comida),
    grupo(Grupo),
    todosPuedenComprar(Grupo, Comida),
    leQuitaElHambreATodos(Comida, Grupo).

todosPuedenComprar(Grupo, Comida) :-
    forall(grupo(Integrante, Grupo), puedeComprar(Integrante, Comida)).

puedeComprar(Visitante, Comida) :-
    visitante(Visitante, datosSuperficiales(_, Dinero), _),
    puestoDeComida(Comida, Precio),
    Dinero >= Precio.

leQuitaElHambreATodos(Comida, Grupo) :-
    forall(grupo(Integrante, Grupo), leQuitaElHambre(Comida, Integrante)).

% TODO: en sus casas, unifiquen todosPuedenComprar y leQuitaElHambreATodos en un solo forall

leQuitaElHambre(hamburguesa, Visitante) :-
    visitante(Visitante, _, sentimiento(Hambre, _)),
    Hambre < 50.
leQuitaElHambre(panchitoConPapas, Visitante) :-
    esChico(Visitante).
leQuitaElHambre(lomitoCompleto, Visitante) :-
    visitante(Visitante).

leQuitaElHambre(lomitoCompleto, _). % el lomimto completo le saca el hambre a CUALQUIER cosa
leQuitaElHambre(caramelos, Visitante) :-
    forall(comida(Comida), (not(puedeComprar(Visitante, Comida), Comida /= caramelos))).
% TODO: delegar la segunda parte del forall

esChico(Visitante) :-
    visitante(Visitante, datosSuperficiales(Edad, _), _),
    Edad < 13.

%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%
% lluviaDeHamburguesas(Visitante, Nombre de Atraccion)
lluviaDeHamburguesas(Visitante, Atraccion) :-
    puedeComprar(Visitante, hamburguesa),
    atraccionVomitiva(Visitante, Atraccion).

atraccionVomitiva(_, tobogan).
atraccionVomitiva(Visitante, Atraccion) :-
    atraccion(Atraccion, TipoDeAtraccion),
    tipoDeAtraccionVomitiva(Visitante, TipoDeAtraccion).

tipoDeAtraccionVomitiva(_, intensa(CoeficienteDeLanzamiento)) :-
    CoeficienteDeLanzamiento > 10.
tipoDeAtraccionVomitiva(Visitante, MontaniaRusa) :-
    esPeligrosa(Visitante, MontaniaRusa).

esPeligrosa(Visitante, montaniaRusa(Giros, _)) :-
    not(esChico(Visitante)),
    not(bienestar(Visitante, necesitaEntretenerse)),
    tieneLaMaximaCantidadDeGiros(Giros).

esPeligrosa(Visitante, montaniaRusa(_, Duracion)) :-
    esChico(Visitante),
    Duracion > 60.

tieneLaMaximaCantidadDeGiros(Giros) :-
    forall(atraccion(_, montaniaRusa(OtrosGiros, _)), OtrosGiros =< Giros).

%%%%%%%%%%%%%
%% Punto 5 %%
%%%%%%%%%%%%%
% opcionDeEntretenimiento(Mes, Visitante, Opcion)
opcionDeEntretenimiento(Mes, Visitante, Opcion) :-
    % TODO: hacer en casa (y que sea inversible)

opcionParticularDeEntretenimiento(_, Visitante, PuestoDeComida) :-
    puedeComprar(Visitante, PuestoDeComida).

opcionParticularDeEntretenimiento(_, Visitante, Atraccion) :-
    atraccion(Atraccion, tranquila(FranjaEtaria)),
    puedeAcceder(Visitante, FranjaEtaria).

opcionParticularDeEntretenimiento(_, _, Atraccion) :-
    atraccion(Atraccion, intensa(_)).
    
opcionParticularDeEntretenimiento(_, Visitante, Atraccion) :-
    atraccion(Atraccion, montaniaRusa(Giros, Duracion)),
    not(esPeligrosa(Visitante, montaniaRusa(Giros, Duracion))).

opcionParticularDeEntretenimiento(Mes, _, Atraccion) :-
    atraccion(Atraccion, acuatica),
    member(Mes, [septiembre, octubre, noviembre, diciembre, enero, febrero, marzo]).


puedeAcceder(Visitante, chicos) :-
    esChico(Visitante).
puedeAcceder(Visitante, chicos) :-
    grupo(Visitante, Grupo),
    not(esChico(Visitante)),
    hayAlgunChicoEnElGrupo(Grupo).

puedeAcceder(_, chicosYAdultos).

hayAlgunChicoEnElGrupo(Grupo) :-
    grupo(Integrante, Grupo),
    esChico(Integrante).
