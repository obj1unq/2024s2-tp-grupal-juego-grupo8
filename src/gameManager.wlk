import wollok.game.*
import posiciones.*
import objetos.*
import extras.*
import personaje.*
import historial.*
import mapper.*

object gameManager {
    var nivelActual = n1
    const botones = #{}
    const ventiladores = #{}

    method configurarControles() {
        keyboard.enter().onPressDo({self.iniciar()})
    
        keyboard.up().onPressDo({personaje.mover(arriba)})
        keyboard.down().onPressDo({personaje.mover(abajo)})
        keyboard.right().onPressDo({personaje.mover(derecha)})
        keyboard.left().onPressDo({personaje.mover(izquierda)})

        keyboard.r().onPressDo({self.reset()})
        keyboard.z().onPressDo({historial.undo()})
        keyboard.space().onPressDo({self.nextLevel()})

        keyboard.n().onPressDo({self.saltarASiguiente()}) // Trampa para mostrar todos los niveles sin pasarlos.
    }

    // El 'if' es necesario por la asignación de la tecla. Si no estuviese se llamaría a 'start()' sin haber limpiado visuales y rompería.
    method iniciar() {
        if (game.hasVisual(pantallaInicial)) {
            game.removeVisual(pantallaInicial)
            game.removeTickEvent("inicio")
            self.start()
        }
    }

    method start() {
        self.addVisuals()
        self.addOnTicks()
    }

    method addVisuals() {
        game.addVisual(reloj)
        game.addVisual(mapaTeclado)
        mapper.crearMapa(nivelActual)
    }

    method addOnTicks() {
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

    method reset() {
        self.clear()
        reloj.segundos(0)
        self.start()
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
        self.removerTickEvents()
        game.addVisual(fondoVictoria)
        game.addVisual(textoVictoria)
    }

    method clear() {
        game.allVisuals().forEach({visual => game.removeVisual(visual)})
        botones.clear()
        ventiladores.clear()
        mapper.clear()
        historial.clear()
    }

    method removerTickEvents() {
        game.removeTickEvent("reloj")
        game.removeTickEvent("ventilador")
    }

    // El 'if' es necesario. Si no está se puede pasar al siguiente nivel sin haber terminado el actual.
    method nextLevel() {
        if (game.hasVisual(fondoVictoria)) {
            nivelActual.iniciarSiguiente()
        }
    }

    method pasarANivel(nivel) {
        nivelActual = nivel
        self.reset()
    }

    // Método sin 'if' para poder saltar de nivel. 
    method saltarASiguiente() {
        self.removerTickEvents()
        nivelActual.iniciarSiguiente()
    }
}
