import wollok.game.*
import objetos.*
import extras.*
import personaje.*
import historial.*
import mapper.*

object nivel {
    var nivelActual = n1
    const botones = #{}
    const ventiladores = #{}

    method start() {
        self.addVisual()
        self.onTick()
    }

    method addVisual() {
        game.addVisual(reloj)
        game.addVisual(mapaTeclado)
        mapper.crearMapa(nivelActual)
    }

    method onTick() {
        game.onTick(1000, "reloj", {reloj.pasarElTiempo()})
        game.onTick(3000, "ventilador", {ventiladores.forEach({v =>
            try {
                v.atraer()
            }
            catch exception {
                game.say(v, exception.toString())
            }
        })})
    }

    
    method agregarBoton(boton) {
        /* Es necesario guardar los botones en una colección 
        para comprobar el fin del juego.*/
        game.addVisual(boton)
        botones.add(boton)
    }

    method agregarVentilador(v) {
        /* Similar al anterior, pero se necesita diferenciar, 
        para poder prender los ventiladores con el onTick.*/
        game.addVisual(v)
        ventiladores.add(v)
    }

    method comprobarFinNivel() {
        if (self.hayCajasEnBotones()) {
            game.schedule(500, {self.finNivel()})
        }
    }

    method hayCajasEnBotones() {
        return botones.all({boton => boton.hayCajaEnBoton()})
    }

    method finNivel() {
        game.removeTickEvent("reloj")
        game.removeTickEvent("ventilador")
        game.addVisual(fondoVictoria)
        game.addVisual(textoVictoria)
        keyboard.space().onPressDo({self.nextLevel()})
    }

    method reset() {
        self.clear()
        reloj.segundos(0)
        self.start()
    }

    method clear() {
        game.allVisuals().forEach({visual => game.removeVisual(visual)})
        botones.clear()
        ventiladores.clear()
        mapper.clear()
        historial.clear()
    }

    
    method nextLevel() {
        self.validarFinDeNivel()
        nivelActual = nivelActual.siguiente()
        self.reset()
    }

    method validarFinDeNivel() {
        if (not game.hasVisual(fondoVictoria))
            self.error("No se puede pasar al siguiente nivel si no se ganó el actual.")
    }

    method saltarASiguiente() {
        nivelActual = nivelActual.siguiente()
        self.reset()
    }
}

