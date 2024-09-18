

object pepe {
  var puesto = desarrollador
  var bonoResultado = bonoResultadoFijo
  var bonoPresentismo = bonoPresentismoNulo
  var property aniosAntiguedad = 1
  var property faltas = 0

  method sueldo() = self.sueldoNeto() + self.bonoPresentismo() + self.bonoResultado()

  method sueldoNeto() = puesto.sueldoNeto(aniosAntiguedad)

  method bonoPresentismo() = bonoPresentismo.sueldo(self)

  method bonoResultado() = bonoResultado.sueldo(self)

  method puesto(unPuesto) {
    puesto = unPuesto
  }
  
  method bonoPresentismo(unBonoPresentismo) {
    bonoPresentismo = unBonoPresentismo
  }
  
  method bonoResultado(unBonoResultado) {
    bonoResultado = unBonoResultado
  }
}

object desarrollador {
  method sueldoNeto(unosAniosAntiguedad) = 1000 + 25 * unosAniosAntiguedad
}

object manager {
  method sueldoNeto(unosAniosAntiguedad) = 1500 + 50 * unosAniosAntiguedad
}

object gerente {
  method sueldoNeto(unosAniosAntiguedad) = 2500 + 100 * unosAniosAntiguedad
}

object bonoPresentismoNulo {
  method sueldo(_unEmpleado) = 0
}

object bonoPresentismoPorFaltas {
  method sueldo(unEmpleado) {
    if (unEmpleado.faltas() == 0) {
      return 100
    } else if (unEmpleado.faltas() == 1) {
      return 50 - unEmpleado.aniosAntiguedad()
    } else {
      return 0
    }
  }
}

object bonoPresentismoNioqui {
  method sueldo(unEmpleado) = 2 ** unEmpleado.faltas()
}


object bonoResultadoSTI {
  method sueldo(unEmpleado) = unEmpleado.sueldoNeto() * 0.25
}

object bonoResultadoFijo {
  method sueldo(unEmpleado) = 15 + unEmpleado.aniosAntiguedad()
}

object bonoResultadoNulo {
  method sueldo(_unEmpleado) = 0
}