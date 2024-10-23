class Jugador {
  var estaVivo = true
  var puedoVotar = true
  var nivelSospecha = 40
  var personalidad

  const mochila = []

  method nivelSospecha() = nivelSospecha

  method esSospechoso() = nivelSospecha > 50

  method buscarItem(unItem) {
    mochila.add(unItem)
  }

  method aumentarSospecha(unaCantidad) {
    nivelSospecha += unaCantidad
  }

  method disminuirSospecha(unaCantidad) {
    nivelSospecha -= unaCantidad
  }

  method tiene(unItem) = mochila.contains(unItem)

  method tieneItems() = !mochila.isEmpty()

  method usar(unItem) {
    mochila.remove(unItem)
  }

  method impugnarVoto() {
    puedoVotar = false
  }

  method llamarReunionDeEmergencia() {
    nave.llamarReunionDeEmergencia()
  }

  method estaVivo() = estaVivo
}

class Tripulante inherits Jugador {
  const tareas = []

  method completoSusTareas() = tareas.isEmpty()

  method realizarTarea() {
    const tarea = self.tareaPendienteHacible()
    tarea.realizatePor(self)
    tareas.remove(tarea)
    nave.terminarTarea()
  }

  method tareaPendienteHacible() = tareas.find { tarea => tarea.puedeRealizarla(self) }

  method voto() = if (puedoVotar) {
    personalidad.voto()
  } else {
    self.votarEnBlanco()
  }

  method votarEnBlanco() {
    puedoVotar = true
    return votoEnBlanco  // EL CASO PROHIBIDO
  }

  method expulsar() {
    estaVivo = false
    nave.expulsarTripulante()
  }
}

class Impostor inherits Jugador {
  method completoSusTareas() = true

  method realizarTarea() {
    // No hace nada
  }

  method realizarSabotaje(unSabotaje) {
    self.aumentarSospecha(5)
    unSabotaje.realizate()
  }

  method voto() = nave.cualquierJugadorVivo()

  method expulsar() {
    estaVivo = false
    nave.expulsarImpostor()
  }
}

class Tarea {
  const itemsNecesarios

  method puedeRealizarla(unJugador) =
    itemsNecesarios.all { item => unJugador.tiene(item) }

  method realizatePor(unJugador) {
    self.afectarA(unJugador)
    self.usarItemsNecesarios(unJugador)
  }

  method usarItemsNecesarios(unJugador) {
    itemsNecesarios.forEach { item => unJugador.usar(item) }
  }

  method afectarA(unJugador)
}

class ArreglarTablero inherits Tarea(itemsNecesarios = ["llave inglesa"]) {
  override method afectarA(unJugador) {
    unJugador.aumentarSospecha(10)
  }
}

object sacarBasura inherits Tarea(itemsNecesarios = ["escoba", "bolsa consorcio"]){
  override method afectarA(unJugador) {
    unJugador.disminuirSospecha(4)
  }
}

object ventilarNave inherits Tarea(itemsNecesarios = []) {
  override method afectarA(unJugador) {
    nave.aumentarOxigeno(5)
  }
}

object nave {
  var nivelOxigeno = 100
  var cantidadImpostores = 0
  var cantidadTripulantes = 0

  const jugadores = []

  method aumentarOxigeno(unaCantidad) {
    nivelOxigeno += unaCantidad
  }

  method terminarTarea() {
    if (self.seCompletaronTodasLasTareas()) {
      throw new DomainException(message = "Ganaron los tripulantes")
    }
  }

  method seCompletaronTodasLasTareas() =
    jugadores.all { jugador => jugador.completoSusTareas() }

  method alguienTieneTuboDeOxigeno() =
    jugadores.any { jugador => jugador.tiene("tubo de oxigeno") }

  method reducirOxigeno(unaCantidad) {
    nivelOxigeno -= unaCantidad
    self.validarGanaronImpostores()
  }

  method validarGanaronImpostores() {
    if (nivelOxigeno <= 0 or cantidadImpostores == cantidadTripulantes) {
      throw new DomainException(message = "Ganaron los impostores")
    }
  }

  method llamarReunionDeEmergencia() {
    const losVotitos = self.jugadoresVivos().map { jugador => jugador.voto() }
    const elMasVotado = losVotitos.max { alguien => losVotitos.occurrencesOf(alguien) }
    elMasVotado.expulsar()
  }

  method jugadoresVivos() =
    jugadores.filter { jugador => jugador.estaVivo() }

  method jugadorNoSospechoso() =
    self.jugadoresVivos().findOrDefault({ jugador => !jugador.esSospechoso() }, votoEnBlanco)

  method jugadorSinItems() =
    self.jugadoresVivos().findOrDefault({ jugador => !jugador.tieneItems() }, votoEnBlanco)

  method jugadorMasSospechoso() =
    self.jugadoresVivos().max { jugador => jugador.nivelSospecha() }

  method cualquierJugadorVivo() = self.jugadoresVivos().anyOne()

  method expulsarTripulante() {
    cantidadTripulantes -= 1
    self.validarGanaronImpostores()
  }

  method expulsarImpostor() {
    cantidadImpostores -= 1
    if (cantidadImpostores == 0) {
      throw new DomainException(message = "Ganaron los tripulantes")
    }
  }
}

object reducirOxigeno {
  method realizate() {
    if (!nave.alguienTieneTuboDeOxigeno()) {
      nave.reducirOxigeno(10)
    }
  }
}

class ImpugnarJugador {
  const jugadorImpugnado

  method realizate() {
    jugadorImpugnado.impugnarVoto()
  }
}


object troll {
  method voto() = nave.jugadorNoSospechoso()
}

object materialista {
  method voto() = nave.jugadorSinItems()
}

object detective {
  method voto() = nave.jugadorMasSospechoso()
}

object votoEnBlanco {
  method expulsar() {
    // No hace nada
  }
}