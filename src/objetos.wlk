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

    method esAtravesable() { return false }

    method esDesplazable() { return true }

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
    
    method aceptaColor(color) { return true } 

    method atraer(posicion) {
        position = posicion
    }
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
    var property position
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

    method atraer() {
        self.validarAtraer()
        self.encender()
        game.schedule(1000, {self.apagar()})
        if (not self.objetosVecinos().isEmpty()) self.objetosVecinos().anyOne().position(position)
    }

    method validarAtraer() {
        if (self.hayObjetoEncima())
            self.error("El ventilador no puede atraer. Ya tiene un objeto.")
    }

    method hayObjetoEncima() {
        return game.getObjectsIn(position).size() > 1
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
}

// MURO
class Muro {
    var property position
    const property image = "muro.png"

    method esAtravesable() { return false }

    method esDesplazable() { return false }

}