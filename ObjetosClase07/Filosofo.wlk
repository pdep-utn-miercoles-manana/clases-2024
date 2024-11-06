import Actividad.admirarPaisaje

class Filosofo {
  var dias
  var nivelIluminacion
  const property nombre
  const property actividades = []
  const property honorificos = #{}

  method presentate() = self.nombre() + self.honorificosString()

  method honorificosString() = self.honorificos().join(",")

  method estaEnLoCorrecto() = self.nivelIluminacion() > 1000

  method nivelIluminacion() = nivelIluminacion

  method esElCumpleanito() = dias % 365 == 0

  method edad() = dias.div(365)

  method agregarHonorifico(unHonorifico) {
    actividades.add(unHonorifico)
  }

  method disminuirIluminacion(unNivel) {
    nivelIluminacion -= unNivel
  }

  method aumentarIluminacion(unNivel) {
    nivelIluminacion += unNivel
  }

  method vivirDia() {
    self.realizarActividades()
    self.envejecer(1)
    self.verificarCumpleanito()
  }

  method realizarActividades() {
    actividades.forEach {
      actividad => actividad.apply(self)
    }
  }

  method envejecer(unosDias) {
    dias += unosDias
  }

  method rejuvenecer(unosDias) {
    dias -= unosDias
  }

  method verificarCumpleanito() {
    if (self.esElCumpleanito()) {
      self.aumentarIluminacion(10)
      self.verificarJubilacion()
    }
  }

  method verificarJubilacion() {
    if (self.edad() == 60) {
      self.agregarHonorifico("el sabio")
    }
  }
}

class FilosofoContemporaneo inherits Filosofo {
  override method presentate() = "Hola"
  override method nivelIluminacion() = super() * self.coeficienteIluminacion()

  method coeficienteIluminacion() = if (self.amaAdmirarPaisajes()) 5 else 1

  method amaAdmirarPaisajes() = self.actividades().contains(admirarPaisaje)
}