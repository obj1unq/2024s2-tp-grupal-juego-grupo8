import wollok.game.*
import historial.*
import posiciones.*
import tablero.*
import gameManager.*

object personaje {
    var property position = game.at(3,3)
    var property orientacion = arriba

    method image () {
        return "personaje_" + orientacion + ".png"
    }

    method movimientos() { return historial.cantidadMovimientos() }

    method mover(direccion) {
        historial.registrarMovimiento()
        orientacion = direccion
        const siguiente = direccion.siguiente(self.position())
        tablero.validarLimites(siguiente)
        self.colisionarSiHayObjetos(siguiente)
        position = siguiente
        gameManager.comprobarFinNivel()
    }

    method colisionarSiHayObjetos(posicion) {
        if (tablero.hayObjetoEn(posicion)) {
            tablero.objetosEn(posicion).forEach({obj => obj.colisionar(orientacion)})
        }
    }

    method esDesplazable() { return false }

    method aceptaColor(color) { return false } 
}
