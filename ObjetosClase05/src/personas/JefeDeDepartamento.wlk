import src.personas.Persona.*
import src.personas.Medico.*

class JefeDeDepartamento inherits Persona {
  const subordinados = #{}

  method atenderA(unaPersona) {
    subordinados.anyOne().atenderA(unaPersona)
  }

  method agregarSubordinado(unSubordinado) {
    subordinados.add(unSubordinado)
  }
}