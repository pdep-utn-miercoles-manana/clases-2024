class Enfermedad {
  var cantidadCelulasAmenazadas

  method cantidadCelulasAmenazadas() = cantidadCelulasAmenazadas

  method atenuarse(cantidadCelulas) {
    cantidadCelulasAmenazadas -= cantidadCelulas
  }

  method estaCurada() = cantidadCelulasAmenazadas <= 0

  method afectar(unaPersona)
  method esAgresivaPara(unaPersona)
}