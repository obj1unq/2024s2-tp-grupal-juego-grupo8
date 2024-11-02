import wollok.game.*
import personaje.*
import posiciones.*

//BOTON
class Boton {
    const property position

    method image() {
            return "boton_" + self.estado().color() + ".png"
    }

    method estado() {
        return if (self.estaPresionado()) presionado else noPresionado
    }

    method estaPresionado() {
        return game.getObjectsIn(position).any({obj => obj.puedePresionar()})
    }

    method objetoQuePresiona() {
        // Rompe en el caso de que no haya nada presionando.
        return game.uniqueCollider(self)
    }

    method esAtravesable() { return true }

    method esDesplazable() { return false }

    method puedePresionar() { return false }

    method hayCajaEnBoton() {
        return self.estaPresionado() and self.objetoQuePresiona().esDesplazable()
    }
}

object presionado {
    method color() { return "verde" }
}

object noPresionado {
    method color() { return "rojo" }
}

class BotonColorido inherits Boton {
    const color

    override method image() {
        return "boton_" + color + ".png"
    }

    method color() { return color }

    method esDeMismoColor(objeto) {
        return objeto.aceptaColor(self.color())
    }

    override method hayCajaEnBoton() {
        return super() and self.esDeMismoColor(self.objetoQuePresiona())
    }
}

//CAJA
class Caja {
    var property position

    method esAtravesable() { return false }

    method esDesplazable()

    method puedePresionar() { return true }

    method desplazar(direccion) {
        const siguiente = direccion.siguiente(position)
        self.validarDesplazamiento(siguiente)
        position = siguiente
    }

    method validarDesplazamiento(posicion) {
        limite.validarLimites(posicion)
        limite.validarAtravesables(posicion)
    }
}

class CajaNormal inherits Caja {
    var property estado = normal

    method image() {
        return "caja_" + estado.toString() + ".png"
    }

    override method esDesplazable() { 
        return estado.esDesplazable()
    }

    method aceptaColor(color) { return true } 
}

object normal {
    method esDesplazable() {
        return true
    }
}

object bloqueada {
    method esDesplazable() {
        return false
    }
}

class CajaColorida inherits Caja {
    const color

    method image() {
        return "caja_" + color + ".png"
    }

    method color() { return color }

    override method esDesplazable() {
        return true
    }

    method aceptaColor(colorBoton) {
        return self.color() == colorBoton
    }
}

// MURO
class Muro {
    var property position
    const property image = "muro.png"

    method esAtravesable() { return false }

    method esDesplazable() { return false }

    method puedePresionar() { return false }
}

// OTROS
object reloj {
    var property segundos = 0
    const property position = game.at(0,0)

    method text() {
        return segundos.toString()
    }

    method textColor() {
        return "FF0000FF"
    }

    method pasarElTiempo() {
        segundos += 1
    }
}

object fondoVictoria {
    var property image = "fondo_victoria.png"
    const property position = game.at(0,0)
}

object textoVictoria {
    const property position = game.at(4,6)

    method text() {
        return "¡Ganaste en " + reloj.segundos() + " segundos!"
    }
}