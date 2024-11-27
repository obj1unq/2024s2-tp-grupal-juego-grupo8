import historial.*
import wollok.game.*
import personaje.*
import posiciones.*
import tablero.*

class Atravesable {

    const property position

    method esAtravesable() { return true }

    method esDesplazable() { return false }

    method colisionar(direccion) {  }

    method hayObjetoEncima() {
        return tablero.objetosEn(position).size() > 1 // > 1 ya que en la colección está el propio objeto
    }
 
}

//BOTON
class Boton inherits Atravesable {

    method image() {
            return "boton_" + self.estado().color() + ".png"
    }

    method estado() {
        return if (self.hayObjetoEncima()) presionado else noPresionado
    }

    method objetoQuePresiona() {
        // Rompe en el caso de que no haya nada presionando.
        return game.uniqueCollider(self)
    }

    method hayCajaEnBoton() {
        return self.hayObjetoEncima() and self.objetoQuePresiona().esDesplazable()
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

//VENTILADORES
class Ventilador inherits Atravesable {
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
        self.atraerSiHayDesplazable()
    }

    method validarAtraer() {
        if (self.hayObjetoEncima())
            self.error("El ventilador no puede atraer. Ya tiene un objeto.")
    }

    method atraerSiHayDesplazable() {
        if (self.haydesplazablesVecinos()) self.desplazablesVecinos().anyOne().position(position)
    }

    method haydesplazablesVecinos() {
        return not self.desplazablesVecinos().isEmpty()
    }

    method desplazablesVecinos() {
        const objVec = []
        objVec.addAll(self.objetoDesplazableVecino(arriba))
        objVec.addAll(self.objetoDesplazableVecino(abajo))
        objVec.addAll(self.objetoDesplazableVecino(izquierda))
        objVec.addAll(self.objetoDesplazableVecino(derecha))
        return objVec
    }

    method objetoDesplazableVecino(direccion) {
        return tablero.objetosEn(direccion.siguiente(position)).filter({obj => obj.esDesplazable()})
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
    }
    
    method aceptaColor(color) { return true } 
}

class CajaDeColor inherits Caja {
    const color

    override method image() {
        return "caja_" + color + ".png"
    }

    method color() { return color }

    override method aceptaColor(colorBoton) {
        return self.color() == colorBoton
    }
}

// MURO
class Muro {
    const property position
    const property image = "muro.png"

    method colisionar(direccion) { self.validacion() }

    method validacion() {
        self.error("No se puede atravesar el muro.")
    }

    method esAtravesable() { return false }

    method esDesplazable() { return false }
}

// CAMINOS CON DIRECCION

class CaminoConDireccion inherits Atravesable {
    var property orientacion

    method image () {
        return "camino_" + orientacion.toString() + ".png"
    }

    override method colisionar(direccion) { self.validarOrientacion(direccion) }

    method validarOrientacion(direccion) {
        if (orientacion != direccion)
            self.error("No se puede atravesar el camino desde esa dirección.")
    }

}