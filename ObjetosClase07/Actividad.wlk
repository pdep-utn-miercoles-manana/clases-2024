object tomarVino {
  method apply(unFilosofo) {
    unFilosofo.disminuirIluminacion(10)
    unFilosofo.agregarHonorifico("el borracho")
  }
}

class JuntarseEnElAgora {
  const filosofo

  method apply(unFilosofo) {
    unFilosofo.aumentarIluminacion(filosofo.nivelIluminacion() / 10)
  }
}

object admirarPaisaje {
  method apply(unFilosofo) {
    // No hace nada
  }
}

class MeditarBajoCascada {
  const altura

  method apply(unFilosofo) {
    unFilosofo.aumentarIluminacion(altura * 10)
  }
}

class PracticarDeporte {
  const deporte

  method apply(unFilosofo) {
    unFilosofo.rejuvenecer(deporte.diasRejuvenecimiento())
  }
}

object futbol {
  method diasRejuvenecimiento() = 1
}
object polo {
  method diasRejuvenecimiento() = 2
}
object waterpolo {
  method diasRejuvenecimiento() = polo.diasRejuvenecimiento() * 2
}