object centro {
  const aparatos = []
  const pacientes = []

  method agregarPacientes(unosPacientes) {
    pacientes.addAll(unosPacientes)
  }

  method agregarAparatos(unosAparatos) {
    aparatos.addAll(unosAparatos)
  }

  method coloresDeLosAparatos() {
    return aparatos.map({a => a.color()}).asSet()
  }

  method pacientesMenoresA(unaEdad) {
    return pacientes.filter({p => p.anios() < unaEdad})
  }

  method pacientesQueNoCumplenUnaSesion() {
    return pacientes.count({p => not p.puedeHacerLaRutina()})
  }

  method estaEnOptimasCondiciones() {
    return aparatos.all({a => not a.necesitaMantenimiento()})
  }

  method estaComplicado() {
    const necesitanMantenimiento = aparatos.count({a => a.necesitaMantenimiento()})
    necesitanMantenimiento >= aparatos.size().div(2)
  }

  method visitaDelTecnico() {
    const aparatosSinMantenimiento = aparatos.filter({a => a.necesitaMantenimiento()})
    aparatosSinMantenimiento.forEach({a => a.hacerMantenimiento()})
  }
}