class Panelista {
  var property puntos = 0

  method puntosOpinionComun() = 1
  method puntosOpinionDeportiva() = self.puntosOpinionComun()
  method puntosOpinionFarandulera(unFarandulero) = self.puntosOpinionComun()

  method rematar(unaTematica) {
    self.aumentarPuntos(self.puntosRemate(unaTematica))
    self.postRemate()
  }

  method aumentarPuntos(unosPuntos) {
    puntos += unosPuntos
  }

  method postRemate() {
    // No hace nada
  }

  method opinar(unaTematica) {
    self.aumentarPuntos(unaTematica.puntosPorOpinion(self))
  }

  method opinarConRemate(unaTematica) {
    self.opinar(unaTematica)
    self.rematar(unaTematica)
  }

  method puntosRemate(unaTematica)
}

class Celebridad inherits Panelista {
  override method puntosRemate(unaTematica) = 3

  override method puntosOpinionFarandulera(unaTematica) =
    if (unaTematica.estaInvolucrado(self)) {
      unaTematica.cantidadInvolucrados()
    } else {
      self.puntosOpinionComun()
    }

}

class Colorado inherits Panelista {
  var property gracia

  override method puntosRemate(unaTematica) = gracia / 5

  override method postRemate() {
    gracia += 1
  }
}

class ColoradoConPeluca inherits Colorado {
  override method puntosRemate(unaTematica) = super(unaTematica) + 1
}

class Viejo inherits Panelista {
  override method puntosRemate(unaTematica) = unaTematica.cantidadPalabras()
}

class Deportivo inherits Colorado {
  override method puntosOpinionDeportiva() = 5
  override method puntosRemate(unaTematica) = 0
}


class Tematica {
  var property titulo
  method esInteresante() = false

  method cantidadPalabras() = titulo.words().size()

  method puntosPorOpinion(unPanelista) = unPanelista.puntosOpinionComun(self)
}

class Filosofica inherits Tematica {
  override method esInteresante() = self.cantidadPalabras() > 20
}

class Farandula inherits Tematica {
  const involucrados = []

  method estaInvolucrado(unFarandulero) = involucrados.contains(unFarandulero)

  override method esInteresante() = self.cantidadInvolucrados() >= 3

  method cantidadInvolucrados() = involucrados.size()

  override method puntosPorOpinion(unPanelista) = unPanelista.puntosOpinionFarandulera(self)
}

class Deportiva inherits Tematica {
  override method puntosPorOpinion(unPanelista) = unPanelista.puntosOpinionDeportiva(self)

  override method esInteresante() = titulo.contains("Messi")
}

class TematicaMixta inherits Tematica {
  var property tematicas = []

  override method titulo() =
    tematicas.map { tematica => tematica.titulo() }.join()

  override method puntosPorOpinion(unPanelista) =
    tematicas.sum { tematica => tematica.puntosPorOpinion(unPanelista) }

  override method esInteresante() =
    tematicas.any { tematica => tematica.esInteresante() }

}

const filosofica = new Filosofica(titulo = "¿Por qué el coyote nunca alcanza al correcaminos?")
const farandula = new Farandula(titulo = "Romeo Vega y Julieta Navarro, ¿nace un nuevo amor?")
const deportiva = new Deportiva(titulo = "¿Llegó el momento de armar un torneo de 55 equipos?")
const economica = new Tematica(titulo = "Compra y venta de órganos, ¿el boom de un viejo instrumento musical?")
const moral = new Tematica(titulo = "¿En serio estás transcribiendo el enunciado en ChatGPT?")

class Programa {
  const property panelistas = []
  const property tematicas = []
  var emitido = false

  method puedeEmitirse() =
    self.cantidadPanelistas() > 2 && self.esProgramaInteresante()

  method cantidadTematicas() = tematicas.size()
  method cantidadPanelistas() = panelistas.size()

  method esProgramaInteresante() =
    self.cantidadTematicasInteresantes() >= self.cantidadTematicas() / 2

  method cantidadTematicasInteresantes() =
    tematicas.count { tematica => tematica.esInteresante() }

  method emitirse() {
    self.tratarTematicas()
    self.finalizarEmision()
  }

  method tratarTematicas() {
    tematicas.forEach { tematica => self.opinarSobre(tematica) }
  }

  method opinarSobre(unaTematica) {
    panelistas.forEach { panelista => panelista.opinarConRemate(unaTematica) }
  }

  method finalizarEmision() {
    emitido = true
  }

  method panelistaEstrella() {
    self.validarProgramaEmitido()
    return panelistas.max { panelista => panelista.puntos() }
  }

  method validarProgramaEmitido() {
    if (!emitido) {
      throw new DomainException(message = "El programa todavía no fue emitido")
    }
  }
}