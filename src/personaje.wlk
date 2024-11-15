import wollok.game.*
import historial.*
import posiciones.*
import nivel.*

object personaje {
    var property position = game.at(3,3)
    var property orientacion = arriba

    method image () {
        return "personaje_normal_" + orientacion.toString() + ".png"
    }

    method puedePresionar() { return true }

    method mover(direccion) {
        historial.registrarMovimiento()
        orientacion = direccion
        const siguiente = direccion.siguiente(self.position())
        self.validarMovimiento(siguiente)
        self.desplazarSiHayCaja(direccion)
        position = siguiente
        nivel.comprobarFinNivel()
    }

    method validarMovimiento(posicion) {
        limite.validarLimites(posicion)
        limite.validarBloqueo(posicion)
    }

    method desplazarSiHayCaja(direccion) {     
        if (self.hayAlgunObjEnSiguientePos(direccion)) {
            historial.registrarMovimiento(self.cajaObjEnSiguientePosicion(direccion))
            self.cajaObjEnSiguientePosicion(direccion).desplazar(direccion)
        }
    }

    method cajaObjEnSiguientePosicion(direccion) { 
        return self.objsEnSiguientePosicion(direccion).find({obj => obj.esDesplazable()}) 
    }

    method objsEnSiguientePosicion(direccion) { 
        return game.getObjectsIn(direccion.siguiente(self.position()))
    }


    method  hayAlgunObjEnSiguientePos(direccion) { 
        return self.objsEnSiguientePosicion(direccion).any({obj => obj.esDesplazable()}) 
    }


    method esDesplazable() { return false }

    method aceptaColor(color) { return false } 
}
