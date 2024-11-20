import wollok.game.*
import personaje.*

object historial {
    const registros = []

    method clear() {
        registros.clear()
    }

    method registrarMovimiento() {
        registros.add(new Registro(posicionPersonaje = personaje.position(), orientacionPersonaje = personaje.orientacion()))
    }

    method registrarMovimiento(objeto) {
        registros.last().registrarObjeto(objeto)
    }

    method undo() {
        self.validarUndo()
        const registro = registros.last()
        registro.revertir()
        registros.remove(registro)
    }

    method validarUndo() {
        if (registros.size() == 0) {
            self.error("No hay movimiento para deshacer")
        }
    }
}

class Registro {
    const posicionPersonaje
    const orientacionPersonaje
    const objetos = []
    const posicionObjetos = []

    method revertir() {
        personaje.position(posicionPersonaje)
        personaje.orientacion(orientacionPersonaje)
        self.revertirObjetos()
    }

    method revertirObjetos() {
        if (objetos.size() > 0) {
            var i = 0

            objetos.forEach({ objeto =>
                const posicion = posicionObjetos.get(i)
                objeto.position(posicion)
                i = i + 1
            })
        }
    }

    method registrarObjeto(objeto) {
        objetos.add(objeto)
        posicionObjetos.add(objeto.position())
    }

}
