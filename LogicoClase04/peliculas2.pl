% pelicula/2 (película, género)
pelicula(losVengadores, accion).
pelicula(laLaLand, musical).
pelicula(americanPsycho, thriller).
pelicula(starWarsAmenazaFantasma, cienciaFiccion).
pelicula(mentirasVerdaderas, comedia).
pelicula(elResplandor, thriller).
pelicula(cloverfield, thriller).
pelicula(oppenheimer, drama).
pelicula(toyStory, musical).
pelicula(wallaceYGrommit, cienciaFiccion).

% asesinato(Pelicula, Asesino, Victima).
asesinato(americanPsycho, patrickBateman, paulAllen).
asesinato(americanPsycho, perro, patrickBateman).
asesinato(americanPsycho, patrickBateman, perro).
asesinato(americanPsycho, patrickBateman, perroRabioso).
asesinato(americanPsycho, patrickBateman, gato).
asesinato(americanPsycho, patrickBateman, pajarito).
asesinato(americanPsycho, patrickBateman, paulAllen).
asesinato(elResplandor, jack, elJardinero).

% cancion(Pelicula, Cancion).
cancion(toyStory, yoSoyTuAmigoFiel).
cancion(toyStory, cambiosExtranios).
cancion(toyStory, noNavegareNuncaMas).

% anio(Pelicula, Anio).
anio(starWarsAmenazaFantasma, 3200).
anio(wallaceYGrommit, 1989).

% segmentos(Pelicula, Segmento).
% segmento(Pelicula, casorio).
% segmento(Pelicula, funeral).
% segmento(Pelicula, pelea).
% segmento(Pelicula, enganio).
% segmento(Pelicula, mediosHermanos).
segmento(oppenheimer, mediosHermanos).

culebronMexicano(Pelicula) :-
  segmento(Pelicula, casorio),
  segmento(Pelicula, mediosHermanos),
  segmento(Pelicula, funeral),
  segmento(Pelicula, peleas).

futurista(Pelicula) :-
  anio(Pelicula, Anio),
  Anio >= 3000.

puroSuspenso(Pelicula):-
  pelicula(Pelicula, thriller),
  not(asesinato(Pelicula, _, _)).

asesinoSerial(Pelicula, Asesino) :-
  pelicula(Pelicula, thriller),
  asesinato(Pelicula, Asesino, _),
  forall(asesinato(Pelicula, OtroAsesino, _),
    sosElMismoAsesino(Asesino, OtroAsesino)).

asesinoSerialBis(Pelicula, Asesino) :-
  pelicula(Pelicula, thriller),
  asesinato(Pelicula, Asesino, _),
  not(hayOtroAsesino(Pelicula, Asesino)).

hayOtroAsesino(Pelicula, Asesino) :-
  % asesinato(Pelicula, Asesino)
  asesinato(Pelicula, OtroAsesino, _),
  OtroAsesino \= Asesino.

sosElMismoAsesino(Asesino, Asesino).

slasher(Pelicula) :-
  pelicula(Pelicula, thriller),
  asesinatosDe(Pelicula, Cantidad),
  Cantidad >= 5.

asesinatosDe(Pelicula, Cantidad) :-
  % findall/3
  % findall(Individuo, Consulta, Lista).
  findall(Victima, asesinato(Pelicula, _, Victima), Victimas),
  length(Victimas, Cantidad).
