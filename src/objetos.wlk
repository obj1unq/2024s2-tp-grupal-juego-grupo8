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

    method esAtravesable() { return true }

    method esDesplazable() { return false }

    method puedePresionar() { return false }
}

object presionado {
    method color() { return "verde" }
}

object noPresionado {
    method color() { return "rojo" }
}

class BotonColorido inherits Boton {
    const color

    override method estado() {
        return if (self.estaPresionado() and not self.esCajaDeMismoColor(game.uniqueCollider(self))) malPresionado else self
    }

    method color() { return color }

    method esCajaDeMismoColor(objeto) {
        return objeto.esDesplazable() and objeto.color() == self.color()
    }
}

object malPresionado {
    method color() {return "rojo2"}
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
    var property estado

    method image() {
        return "caja_" + estado.toString() + ".png"
    }

    override method esDesplazable() { 
        return estado.esDesplazable()
    }
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
        return "caja_color_" + color + ".png"
    }

    method color() { return color }

    override method esDesplazable() {
        return true
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
