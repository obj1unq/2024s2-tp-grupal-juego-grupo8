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
    method position() = game.at(0,4)
}

object fondoVictoria {
    method image() = "fondo_victoria.png"
    method position() = game.at(0,0)
}

object textoVictoria {
    method position() = game.at(7,9)

    method text() {
        return "Lo conseguiste en ¡" + reloj.segundos() + " segundos! \n\n\n" 
            + "Pulsá la tecla SPACE para avanzan al siguiente nivel"
    }
}