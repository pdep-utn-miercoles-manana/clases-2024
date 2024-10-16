class Persona {
  const nombre = "Gregory House"
  const titulo = "PhD"
  const enfermedades = []
  const property grupoSanguineo = "a"
  var temperatura
  var cantidadCelulas
  
  method contraerEnfermedad(unaEnfermedad) {
    enfermedades.add(unaEnfermedad)
  }
  
  method tiene(unaEnfermedad) = enfermedades.contains(unaEnfermedad)
  
  method vivirUnDia() {
    enfermedades.forEach({ enfermedad => enfermedad.afectar(self) })
  }
  
  method aumentarTemperatura(unosGrados) {
    temperatura = 45.min(temperatura + unosGrados)
  }
  
  method destruirCelulas(unaCantidad) {
    cantidadCelulas -= unaCantidad
  }
  
  method cantidadCelulasAfectadasPorEnfermedadesAgresivas() = self.enfermedadesAgresivas().sum(
    { enfermedad => enfermedad.cantidadCelulasAmenazadas() }
  )
  
  method enfermedadesAgresivas() = enfermedades.filter({ enfermedad => enfermedad.esAgresivaPara(self) })
  
  method cantidadCelulas() = cantidadCelulas
  
  method enfermedadQueMasCelulasAfecta() = enfermedades.max({ enfermedad => enfermedad.cantidadCelulasAmenazadas() })
  
  method estaEnComa() = self.estaDelirando() || self.tienePocasCelulas()
  
  method estaDelirando() = temperatura == 45
  
  method tienePocasCelulas() = cantidadCelulas < 1000000
  
  method vivir(unosDias) {
    unosDias.times({ _ => self.vivirUnDia() })
  }
  
  method recibirMedicamento(unaDosis) {
    self.aplicarDosis(unaDosis)
    self.removerEnfermedadesCuradas()
  }
  
  method aplicarDosis(unaDosis) {
    enfermedades.forEach({ enfermedad => enfermedad.atenuarse(unaDosis * 15) })
  }
  
  method removerEnfermedadesCuradas() {
    enfermedades.removeAllSuchThat({ enfermedad => enfermedad.estaCurada() })
  }
  
  /*
  var donó? = cameron.donarA(logan, 3000)
  if (donó? == "Pará loco lo vas a matar!!!") {
  :skull:
  }
  */
  method donarA(otraPersona, cantidadADonar) {
    // o bien no hace nada, o bien tira una excepción
    self.verificarCantidadCelulas(cantidadADonar)
    self.verificarCompatibilidad(otraPersona) // si lanzó, no se ejecuta esto
    
    
    cantidadCelulas -= cantidadADonar
    otraPersona.aumentarCelulas(cantidadADonar)
  }
  
  method verificarCantidadCelulas(cantidadADonar) {
    if (!self.tieneSuficienteParaDonar(cantidadADonar)) {
      throw new Exception(message = "Pará loco, lo vas a matar!!")
    }
  }
  
  method verificarCompatibilidad(otraPersona) {
    if (!self.esCompatibleCon(otraPersona)) {
      throw new Exception(message = "Pará loco, no son compatibles!!")
    }
  }
  
  method aumentarCelulas(cantidad) {
    cantidadCelulas += cantidad
  }
  
  method puedeDonar(otraPersona, cantidadADonar) = self.tieneSuficienteParaDonar(cantidadADonar) and self.esCompatibleCon(
    otraPersona
  ) // return cantidadADonar.between(500, cantidadCelulas * 0.25)
  
  method tieneSuficienteParaDonar(cantidadADonar) = (cantidadADonar > 500) and (cantidadADonar <= (cantidadCelulas * 0.25))
  
  method esCompatibleCon(otraPersona) = grupoSanguineo.esCompatibleCon(otraPersona.grupoSanguineo())
}

class GrupoSanguineo {
  const tipo
  const factor
  
  method esCompatibleCon(otroGrupo) = tipo.puedeDonarle(otroGrupo.tipo()) and factor.puedeDonarle(otroGrupo.factor())
}

object o {
  method puedeDonarle(otroTipo) = true
}

object a {
  method puedeDonarle(otroTipo) = [self, ab].contains(otroTipo)
}

object b {
  method puedeDonarle(otroTipo) = [self, ab].contains(otroTipo)
}

object ab {
  method puedeDonarle(otroTipo) = otroTipo == self
}

object factorPositivo {
  method puedeDonarle(factor) = factor == self
}

object factorNegativo {
  method puedeDonarle(factor) = true
}