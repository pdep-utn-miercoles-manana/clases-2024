import src.personas.Persona.*

class Medico inherits Persona {
  const dosis

  override method contraerEnfermedad(unaEnfermedad) {
    super(unaEnfermedad)
    self.atenderA(self)
  }

  method atenderA(unaPersona) {
    unaPersona.recibirMedicamento(dosis)
  }
}
