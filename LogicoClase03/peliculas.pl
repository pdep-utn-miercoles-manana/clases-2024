% pelicula/2 (película, género)
pelicula(losVengadores, accion).
pelicula(laLaLand, musical).
pelicula(americanPsycho, thriller).
pelicula(starWarsAmenazaFantasma, cienciaFiccion).
pelicula(mentirasVerdaderas, comedia).

% critica/2 (película, estrellas)
critica(losVengadores, 3).
critica(losVengadores, 4).
critica(laLaLand, 5).
critica(americanPsycho, 4).
critica(starWarsAmenazaFantasma, 1).
critica(mentirasVerdaderas, 2).

% trabajaEn/2 (película, actor/actriz)
trabajaEn(losVengadores, robertDowneyJr).
trabajaEn(losVengadores, chrisEvans).
trabajaEn(laLaLand, emmaStone).
trabajaEn(laLaLand, ryanGosling).
trabajaEn(americanPsycho, christianBale).
trabajaEn(starWarsAmenazaFantasma, nataliePortman).
trabajaEn(mentirasVerdaderas, arnoldSchwarzenegger).
trabajaEn(mentirasVerdaderas, jamieLeeCurtis).
trabajaEn(mentirasVerdaderas, tomArnold).

% premio/2 (actor/actriz, premio)
premio(arnoldSchwarzenegger, mejorMusculo).
premio(christianBale, mejorBatman).
premio(nataliePortman, mejorActriz).
premio(emmaStone, mejorActriz).

% imperdible: no hay actores que no hayan ganado algún premio
imperdible(Pelicula) :-
  pelicula(Pelicula, _),
  not(actoresQueNoGanaronAlgunPremio(Pelicula)).

actoresQueNoGanaronAlgunPremio(Pelicula) :-
  trabajaEn(Pelicula, Actor), %  p(x)
  not(premio(Actor, _)).      % ~q(x)

% imperdible2: todos los actores ganaron algún premio (es lo mismo!)
% forall/2 (Antecedente, Consecuente)
imperdible2(Pelicula) :-
  pelicula(Pelicula, _),
  forall(trabajaEn(Pelicula, Actor), premio(Actor, _)).

% actorDramatico/2 si todas las pelis en las que trabajó son de drama
actorDramatico(Actor) :-
  trabajaEn(_, Actor),
  forall(trabajaEn(Pelicula, Actor), esDeDrama(Pelicula)).

esDeDrama(Pelicula) :-
  pelicula(Pelicula, drama).

% aclamada: todas las críticas de la peli son 4 ó 5 estrellas
pochoclera(Pelicula) :-
  pelicula(Pelicula, _),
  forall(critica(Pelicula, Estrellas), Estrellas >= 4).

% mala: es mala cuando todas sus críticas tienen una estrella.
mala(Pelicula) :-
  pelicula(Pelicula, _),
  forall(critica(Pelicula, Estrellas), criticaMala(Estrellas)).

criticaMala(1).

% selectivo: todas las películas en las que actúa un actor/actriz son imperdibles
selectivo(Actor) :-
  trabajaEn(_, Actor),
  forall(trabajaEn(Pelicula, Actor), imperdible(Pelicula)).

% unánime: todas las críticas de la película son el mismo puntaje
unanime(Pelicula) :-
  critica(Pelicula, Puntaje),
  forall(critica(Pelicula, OtroPuntaje), sonIguales(Puntaje, OtroPuntaje)).

sonIguales(Puntaje, Puntaje).

% mejor crítica: la crítica más alta para una peli
mejorCritica(Pelicula, MejorCritica) :-
  critica(Pelicula, MejorCritica),
  forall(critica(Pelicula, OtraCritica), MejorCritica >= OtraCritica).

