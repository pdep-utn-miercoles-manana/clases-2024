/*
Requisitos:
* Vender entradas. De quién es la
  responsabilidad de vender una entrada para una función?
*/

class Asiento {
  var persona = ""

  method estaOcupado() = persona != ""

  method asignar(otraPersona) {
    persona = otraPersona
  }
}

class Funcion {
  var predio
  var asientos = [
    new Asiento(), 
    new Asiento() 
  ]
  // son 2 instancias de asiento distintas!

  method venderEntrada(persona) {
    predio.asignarAsiento(persona)
  }
}

class Estadio {
  var property capacidadCampo
  method capacidadPlateaAlta() {}
  method capacidadPlateaBaja() {}
  method capacidadPlateaPreferencial() {}
}

class Teatro {
  method capacidadPlateaAlta() {}
  method capacidadPlateaBaja() {}
  method capacidadPlateaPreferencial() {}
  method capacidadCampo() = 0
}
