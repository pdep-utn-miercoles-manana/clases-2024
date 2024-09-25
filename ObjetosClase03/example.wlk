// object showDeLali {
//   var asientos = []

//   var entradasVendidas = 0

//   method ventaEntrada(persona) {
//     asientos.add(persona)
//   }
// }

// object showDeTaylor {
//   var asientos = []

//   var entradasVendidas = 0

//   method ventaEntrada(persona) {
//     asientos.add(persona)
//   }
// }

class Recital {
  var asientos = []

  method ventaEntrada(persona) {
    asientos.add(persona)
  }

  method entradasVendidas() = asientos.size()


  /*
    empiezaConA ('a':_) = True
    empiezaConA       _ = False

    filter empiezaConA
    filter (\palabra -> head palabra == 'a')
  */
  method asientosAsignadosConInicial(inicial) {
    return asientos.filter({ nombre => nombre.startsWith(inicial) })
    // map
    // forEach
    // all
    // any
  }
}
