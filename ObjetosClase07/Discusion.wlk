class Discusion {
  const partido1
  const partido2

  method esBuena() = partido1.esBueno() && partido2.esBueno()
}

class Partido {
  const filosofo
  const argumentos

  method esBueno() = filosofo.estaEnLoCorrecto() && self.tieneBuenosArgumentos()

  method tieneBuenosArgumentos() =
    self.cantidadArgumentosEnriquecedores() > self.cantidadArgumentos() / 2

  method cantidadArgumentos() = argumentos.size()

  method cantidadArgumentosEnriquecedores() = argumentos.count {
    argumento => argumento.esEnriquecedor()
  }
}
