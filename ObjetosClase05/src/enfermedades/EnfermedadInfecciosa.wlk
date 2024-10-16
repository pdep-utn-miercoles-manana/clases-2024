import src.enfermedades.Enfermedad.*

class EnfermedadInfecciosa inherits Enfermedad {

  method reproducirse() {
    cantidadCelulasAmenazadas *= 2
  }

  override method afectar(unaPersona) {
    unaPersona.aumentarTemperatura(cantidadCelulasAmenazadas / 1000)
  }

  override method esAgresivaPara(unaPersona) = 
    cantidadCelulasAmenazadas > unaPersona.cantidadCelulas() * 0.10
}
