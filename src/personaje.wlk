import wollok.game.*
import historial.*
import posiciones.*
import tablero.*
import nivel.*

object personaje {
    var property position = game.at(3,3)
    var property orientacion = arriba

    method image () {
        return "personaje_" + orientacion + ".png"
    }

    method movimientos() { return historial.cantidadMovimientos() }

    method puedePresionar() { return true }

    method mover(direccion) {
        historial.registrarMovimiento()
        orientacion = direccion
        const siguiente = direccion.siguiente(self.position())
        tablero.validarLimites(siguiente)
        tablero.validarOrientacion(siguiente)
        self.colisionarSiHayObjetos(siguiente)
        position = siguiente
        nivel.comprobarFinNivel()
    }



    method colisionarSiHayObjetos(posicion) {
        if (tablero.hayObjetoEn(posicion)) {
            tablero.objetosEn(posicion).forEach({obj => obj.colisionar(orientacion)})
        }
    }

    // method validarMovimiento(posicion) {
    //     tablero.validarLimites(posicion)
    //     tablero.validarBloqueo(posicion)
    // }

    // method desplazarSiHayCaja(direccion) {     
    //     if (self.hayAlgunObjEnSiguientePos(direccion)) {
    //         historial.registrarMovimiento(self.cajaObjEnSiguientePosicion(direccion))
    //         self.cajaObjEnSiguientePosicion(direccion).desplazar(direccion)
    //     }
    // }

    // method cajaObjEnSiguientePosicion(direccion) { 
    //     return self.objsEnSiguientePosicion(direccion).find({obj => obj.esDesplazable()}) 
    // }

    method esDesplazable() { return false }

    method aceptaColor(color) { return false } 
}
