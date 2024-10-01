import src.enfermedades.Enfermedad.*

class EnfermedadAutoinmune inherits Enfermedad {
  var cantidadDeVecesQueAfecto = 0

  override method afectar(unaPersona) {
    unaPersona.destruirCelulas(cantidadCelulasAmenazadas)
    self.aumentarVecesQueAfecto()
  }

  override method esAgresivaPara(_unaPersona) = cantidadDeVecesQueAfecto > 30

  method aumentarVecesQueAfecto() {
    cantidadDeVecesQueAfecto += 1
  }
}