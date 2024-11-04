import wollok.game.*
import objetos.*
import personaje.*

object nivel {
    //var property nivelActual = n1
    const property botones = #{}
    const property cajas = #{}
    const property muros = #{}

    // Metodo para poder testear el comprobarFinDeJuego
    method addBoton(boton) {
        botones.add(boton)
    }

    method addVisual() {
        cajas.add(new CajaColorida(position=game.at(1,3), color = "azul"))
        cajas.add(new CajaNormal(position=game.at(1,6)))
        cajas.add(new CajaColorida(position=game.at(4,4), color = "gris"))
        muros.add(new Muro(position=game.at(2,3)))
        botones.add(new BotonColorido(position=game.at(2,2), color = "azul"))
        botones.add(new BotonColorido(position=game.at(7,7), color = "gris"))

        personaje.position(game.at(3,3))

        botones.forEach({boton => game.addVisual(boton)})
        cajas.forEach({caja => game.addVisual(caja)})
        muros.forEach({muro => game.addVisual(muro)})

        game.addVisual(personaje)
        game.addVisual(reloj)

        game.onTick(1000, "reloj", {reloj.pasarElTiempo()})
    }

    method comprobarFinNivel() {
        if (self.hayCajasEnBotones()) {
            game.removeTickEvent("reloj")
            game.addVisual(fondoVictoria)
            game.addVisual(textoVictoria)
        }
    }

    method hayCajasEnBotones() {
        return botones.all({boton => boton.hayCajaEnBoton()})
    }

    method reset() {
        self.clear()
        reloj.segundos(0)
        self.addVisual()
    }

    method clear() {
        botones.forEach({boton => game.removeVisual(boton)})
        botones.clear()
        cajas.forEach({caja => game.removeVisual(caja)})
        cajas.clear()
        muros.forEach({muro => game.removeVisual(muro)})
        muros.clear()
        game.removeVisual(personaje)
        game.removeVisual(reloj)
        game.removeVisual(fondoVictoria)
        game.removeVisual(textoVictoria)
    }
}

object n1 {

}