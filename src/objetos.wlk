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

//CAJA
class Caja {
    var property position
    var property estado

    method image() {
        return "caja_" + estado.toString() + ".png"
    }

    method esAtravesable() { return false }

    method esDesplazable() { 
        return estado.esDesplazable()
     }

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

// MURO
class Muro {
    var property position
    const property image = "muro.png"

    
    method esAtravesable() { return false }

    method esDesplazable() { return false }

    method puedePresionar() { return false }
}
