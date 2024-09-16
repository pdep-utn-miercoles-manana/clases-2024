// Objeto: 
// Difinición formal: Representación de un ente computacional que exhibe comportamiento.
// Definición informal: Cosa que hace cosas.

// La forma en la que exhibe ese comportamiento es a través de mensajes
// Mediante el envío de mensajes es la forma en la que los objetos se comunican entre sí

// Para hacer que un objeto entienda un mensaje hay que codificar un método en el objeto

object francoColapinto {
  var peso = 70
  var auto = williams

  method chamuyar() { //No pongan espacio entre nombre y parentesis
    return "Me contaron que sos muy divertida"
  }

  method correr(kilometros) {
    auto.correr(kilometros)
    peso = peso - kilometros / 50
  }

  //getter
  method peso() { 
    return peso
  }

  //setter
  method auto(unAuto) { //No usar cambiarAuto -> convención método se llama igual que el atributo
    auto = unAuto
  }
}

//No piensen en atributos -> piensen en comportamiento
object williams {
  var nafta = 100

  method correr(kilometros) {
    nafta = nafta - kilometros / 7 
  }
}

object ferrari {
  var nafta = 10
  var bateria = 80

  method correr(kilometros) {
    self.gastarNafta(kilometros)
    self.gastarBateria(kilometros)
  }
  
  method gastarNafta(kilometros){
    nafta = nafta - kilometros / 7
  }
  
  method gastarBateria(kilometros){
    if (kilometros >= 100) {
      bateria = bateria - (kilometros - 100) / 100
    }
  }
}