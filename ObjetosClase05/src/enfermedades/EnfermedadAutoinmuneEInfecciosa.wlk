import src.enfermedades.Enfermedad.*
import src.enfermedades.EnfermedadAutoinmune.*
import src.enfermedades.EnfermedadInfecciosa.*

class EnfermedadAutoinmuneEInfecciosa {
  const autoinmune
  const infecciosa
  
  method afectar(unaPersona) {
    autoinmune.afectar(unaPersona)
    infecciosa.afectar(unaPersona)
  }
  
  method esAgresivaPara(unaPersona) = autoinmune.esAgresivaPara(
    unaPersona
  ) or infecciosa.esAgresivaPara(unaPersona)
  
  method reproducirse() {
    infecciosa.reproducirse()
  }
  
  method atenuarse(cantidadCelulas) {
    autoinmune.atenuarse(cantidadCelulas)
    infecciosa.atenuarse(cantidadCelulas)
  }
  
  method cantidadCelulasAmenazadas() = infecciosa.cantidadCelulasAmenazadas() + autoinmune.cantidadCelulasAmenazadas()
  
  method estaCurada() = infecciosa.estaCurada() and autoinmune.estaCurada()
}
