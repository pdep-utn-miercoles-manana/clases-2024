
juego(nombre, precio, accion()).
juego(nombre, precio, rol(usuariosActivos)).
juego(nombre, precio, puzzle(cantidadNiveles, dificultad)).

oferta(nombre, porcentajeDescuento).

%%%%

cuantoSale(Juego, PrecioFinal) :-
  juego(Juego, PrecioSinDescuento, _),
  oferta(Juego, Descuento),
  PrecioFinal is PrecioSinDescuento - PrecioSinDescuento / 100 * Descuento.

cuantoSale(Juego, Precio) :-
  juego(Juego, Precio, _),
  not(oferta(Juego, _)).

%%%%

tieneUnBuenDescuento(Juego) :-
  oferta(Juego, Descuento),
  Descuento >= 50.

%%%%

popular(minecraft).
popular(counterStrike).

popular(Juego) :-
  juego(Juego, _, Tipo),
  popularSegunTipo(Tipo).

popularSegunTipo(accion()).

popularSegunTipo(rol(UsuariosActivos)) :-
  UsuariosActivos > 1000000.

popularSegunTipo(puzzle(_, facil)).
popularSegunTipo(puzzle(25, _)).

%%%%

usuario(nombre, juegosQueTiene, juegosQuePiensaAdquirir).
usuario(user123, [minecraft],
        [compra(counterStrike), regalo(counterStrike, user1581)]).

adictoALosDescuentos(Usuario) :-
  usuario(Usuario, _, _),
  forall(piensaAdquirir(Juego, Usuario, _), tieneUnBuenDescuento(Juego)).

piensaAdquirir(Juego, Usuario, TipoDeAdquisicion) :-
  usuario(Usuario, _, Adquisiciones),
  member(Adquisicion, Adquisiciones),
  nombreSegunAdquisicion(Juego, Adquisicion, TipoDeAdquisicion).

nombreSegunAdquisicion(Nombre, compra(Nombre), compra).
nombreSegunAdquisicion(Nombre, regalo(Nombre, _), regalo).

nombreSegunAdquisicion(Nombre, regalo(Nombre, _), ambas).
nombreSegunAdquisicion(Nombre, compra(Nombre), ambas).

%%%%

fanatico(Usuario, Genero) :-
  tieneJuegoDe(Genero, Usuario, Juego1),
  tieneJuegoDe(Genero, Usuario, Juego2),
  Juego1 \= Juego2.

tieneJuegoDe(Genero, Usuario, Juego) :-
  usuario(Usuario, JuegosQueTiene, _),
  member(Juego, JuegosQueTiene),
  esDeGenero(Genero, Juego).

esDeGenero(Genero, Juego) :-
  juego(Juego, _, GeneroFunctor),
  nombreDeGenero(Genero, GeneroFunctor).

nombreDeGenero(accion, accion()).
nombreDeGenero(rol, rol(_)).
nombreDeGenero(puzzle, puzzle(_, _)).

%%%%

monotematico(Usuario, Genero) :-
  usuario(Usuario, JuegosQueTiene, _),
  tieneJuegoDe(Genero, Usuario, _),
  forall(member(Juego, JuegosQueTiene), esDeGenero(Genero, Juego)).

%%%%

buenosAmigos(Usuario1, Usuario2) :-
  leRegalaJuegoPopularA(Usuario1, Usuario2),
  leRegalaJuegoPopularA(Usuario2, Usuario1).

leRegalaJuegoPopularA(Usuario1, Usuario2) :-
  usuario(Usuario1, _, Adquisiciones),
  member(Regalo, Adquisiciones),
  popularPara(Usuario2, Regalo).

popularPara(Usuario, regalo(Juego, Usuario)) :-
  popular(Juego).

%%%%

cuantoGastara(Usuario, Cuanto, TipoDeAdquisicion) :-
  usuario(Usuario, _, _),
  tipoDeAdquisicion(TipoDeAdquisicion),
  findall(Costo,
          costoDeLoQuePiensaAdquirir(Costo, Usuario, TipoDeAdquisicion),
          Costos),
  sumlist(Costos, Cuanto).

costoDeLoQuePiensaAdquirir(Costo, Usuario, TipoDeAdquisicion) :-
  piensaAdquirir(Juego, Usuario, TipoDeAdquisicion),
  cuantoSale(Juego, Costo).

tipoDeAdquisicion(compra).
tipoDeAdquisicion(regalo).
tipoDeAdquisicion(ambas).
