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

    method validarCajaEnBoton() {
        return self.estaPresionado() and game.uniqueCollider(self).esDesplazable()
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

    method esCajaDeMismoColor(objeto) {
        return objeto.aceptarElColor(self.color())
    }

    override method validarCajaEnBoton() {
        return super() and self.esCajaDeMismoColor(game.uniqueCollider(self))      
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

    method agregarAlTablero(){
        game.addVisual(self)
        game.onCollideDo(self, {boton => boton.validarPosicion(self) })
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

    method aceptarElColor(color) {} 
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

    method aceptarElColor(colorBoton) {
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
