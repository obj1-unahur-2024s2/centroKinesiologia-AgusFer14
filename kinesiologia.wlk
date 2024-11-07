class Persona {
  var property edad
  var property fortaleza
  var property nivelDeDolor
  const rutina = [] 

  method disminuirDolor(unValor) {
    nivelDeDolor -= unValor
  }

  method aumentarFortaleza(unValor) {
    fortaleza += unValor
  }

  method cumplirAnios() {
    edad = edad + 1
  }

  method puedeUsar(unAparato) {
    return unAparato.puedeSerUsadoPor(self)
  }

  method usar(unAparato) {
    if(self.puedeUsar(unAparato))
      unAparato.consecuenciaDelUso(self)
  }

  method crearRutina(nuevaRutina) {
    rutina.clear()
    rutina.addAll(nuevaRutina)
  }

  method puedeHacerLaRutina() {
    return rutina.all({a => self.puedeUsar(a)})
  }

  method hacerRutina() {
    rutina.forEach({a => self.usar(a)})
  }
}

class Resistente inherits Persona {
  override method hacerRutina() {
    super()
    self.aumentarFortaleza(rutina.size())
  }
}

class Caprichosa inherits Persona {
  override method puedeHacerLaRutina() {
    return super() and rutina.any({a => a.color() == "rojo"})
  }

  override method hacerRutina() {
    super()
    super()
  }
}

class RapidaRecuperacion inherits Persona {
  var property dolorExtra = 3

  override method hacerRutina() {
    super()
    self.disminuirDolor(dolorExtra)
  } 
}

class Aparato {
  var property color = "blanco"

  method consecuenciaDelUso(persona)

  method puedeSerUsadoPor(persona)

  method necesitaMantenimiento() = false

  method hacerMantenimiento() {}
}

class Magneto inherits Aparato {
  var imantacion = 800

  override method necesitaMantenimiento() {
    return imantacion < 100
  }

  override method hacerMantenimiento() {
    imantacion = imantacion + 500
  }

  override method consecuenciaDelUso(persona) {
    persona.disminuirDolor(
      persona.nivelDeDolor() * 0.1
      )
    imantacion -= 1
  }

  override method puedeSerUsadoPor(persona) {
    return true
  }
}

class Bicicleta inherits Aparato {
  var desajustanTornillos = 0
  var pierdeAceite = 0

  override method necesitaMantenimiento() {
    return desajustanTornillos >= 10 or pierdeAceite >= 5
  }

  override method hacerMantenimiento() {
    desajustanTornillos = 0
    pierdeAceite = 0
  }

  override method consecuenciaDelUso(persona) {
    if(persona.nivelDeDolor() > 30)
      desajustanTornillos += 1
    if(persona.edad().between(30, 50))
      pierdeAceite += 1
    persona.disminuirDolor(4)
    persona.aumentarFortaleza(3)
  }

  override method puedeSerUsadoPor(persona) {
    return persona.edad() > 8
  }
}

class Minitramp inherits Aparato {
  override method consecuenciaDelUso(persona) {
    persona.aumentarFortaleza(
      persona.edad() * 0.1
    )
  }

  override method puedeSerUsadoPor(persona) {
    return persona.nivelDeDolor() < 20
  }
}