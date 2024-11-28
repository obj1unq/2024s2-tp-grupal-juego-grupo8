import wollok.game.*
import personaje.*
object reloj {
    var property segundos = 0
    method image() = "reloj.png"
    method position() = game.at(0,0)

    method text() {
        return segundos.toString()
    }

    method textColor() {
        return "FF0000FF"
    }

    method pasarElTiempo() {
        segundos += 1
    }
}

object mapaTeclado {
    method image() = "teclas.png"
    method position() = game.at(0,8)
}

object fondoVictoria {
    method image() = "fondo_victoria.png"
    method position() = game.at(0,0)
}

object textoVictoria {
    method position() = game.at(7,10)

    method text() {
        return "Tus resultados:   " + personaje.movimientos() + "  movimientos  en  "
            + reloj.segundos() + "  segundos."
    }
}

object pantallaInicial {
    method position() = game.at(0,0)
    method image() = "inicio_pantalla.png"

    method intermitencia() {
        game.addVisual(imgIntermitente)
        game.schedule(1000, {game.removeVisual(imgIntermitente)})
    }
}

object imgIntermitente {
    method position() = game.at(2,3)
    method image() = "inicio_intermitencia.png"
}

object pantallaFinal {
    method position() = game.at(0,0)
    method image() = "fin_de_juego.png"
}