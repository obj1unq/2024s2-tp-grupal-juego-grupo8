import historial.*
import wollok.game.*
import personaje.*
import posiciones.*
import tablero.*

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

    method colisionar(direccion) {  }

    method esAtravesable() { return true }

    method esDesplazable() { return false }

    method puedePresionar() { return false }

    method poseeOrientacion() { return false }

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

class BotonDeColor inherits Boton {
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

    method image() {
        return "caja_normal.png"
    }

    method poseeOrientacion() { return false }

    method esAtravesable() { return false }

    method esDesplazable() { return true }

    method puedePresionar() { return true }

    method colisionar(direccion) { 
        self.desplazar(direccion)
    }

    method desplazar(direccion) {
        const siguiente = direccion.siguiente(position)
        self.validarDesplazamiento(siguiente)
        historial.registrarMovimiento(self)
        position = siguiente
    }

    method validarDesplazamiento(posicion) {
        tablero.validarLimites(posicion)
        tablero.validarAtravesables(posicion)
        tablero.validarOrientacion(posicion)
    }
    
    method aceptaColor(color) { return true } 
}

class CajaDeColor inherits Caja {
    const color

    override method image() {
        return "caja_" + color + ".png"
    }

    method color() { return color }

    override method esDesplazable() {
        return true
    }

    override method aceptaColor(colorBoton) {
        return self.color() == colorBoton
    }
}

//VENTILADORES
class Ventilador {
    const property position
    var encendido = false

    method image() {
         return "ventilador_" + self.imgSegunEstado() + ".png"
    }

    method imgSegunEstado() {
        return if (encendido) "encendido" else "apagado"
    }

    method encender() {
        encendido = true
    }

    method apagar() {
        encendido = false
    }

    method colisionar(direccion) {  }

    method atraer() {
        self.validarAtraer()
        self.encender()
        game.schedule(1000, {self.apagar()})
        if (self.hayObjetosVecinos()) self.objetosVecinos().anyOne().position(position)
    }

    method validarAtraer() {
        if (self.hayObjetoEncima())
            self.error("El ventilador no puede atraer. Ya tiene un objeto.")
    }

    method hayObjetoEncima() {
        return game.getObjectsIn(position).size() > 1 // > 1 ya que está el propio ventilador
    }

    method hayObjetosVecinos() {
        return not self.objetosVecinos().isEmpty()
    }

    method objetosVecinos() {
        const objVec = []
        objVec.addAll(self.objetoDesplazableVecino(arriba))
        objVec.addAll(self.objetoDesplazableVecino(abajo))
        objVec.addAll(self.objetoDesplazableVecino(izquierda))
        objVec.addAll(self.objetoDesplazableVecino(derecha))
        return objVec
    }

    method objetoDesplazableVecino(direccion) {
        return game.getObjectsIn(direccion.siguiente(position)).filter({obj => obj.esDesplazable()})
    }

    method esAtravesable() { return true }

    method esDesplazable() { return false }

    method poseeOrientacion() { return false }
}

// MURO
class Muro {
    const property position
    const property image = "muro.png"

    method colisionar(direccion) { self.error("No me pueden atravesar.") }

    method esAtravesable() { return false }

    method esDesplazable() { return false }

    method poseeOrientacion() { return false }

}

// CAMINOS CON DIRECCION

class CaminoConDireccion {
    var property position 
    var property orientacion

    method image () {
        return "camino_" + orientacion.toString() + ".png"
    }

    method colisionar(direccion) { }

    method poseeOrientacion() { return true }

    method esAtravesable() { return true }

    method esDesplazable() { return false} 
}