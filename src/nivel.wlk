import wollok.game.*
import objetos.*
import extras.*
import personaje.*

object nivel {
    var nivelActual = n1
    const botones = #{}
    const objetos = #{} // necesario para poder remover visuales en cada cambio de nivel
    const ventiladores = #{} // necesario para el onTick

    method nivelActual() {
        return nivelActual
    }

    // Metodo para poder testear el comprobarFinDeJuego
    method addBoton(boton) {
        botones.add(boton)
    }

    method addVisual() {
        game.addVisual(reloj)
        game.addVisual(mapaTeclado)
        mapper.crearMapa(nivelActual)
        game.onTick(1000, "reloj", {reloj.pasarElTiempo()})
        game.onTick(3000, "ventilador", {ventiladores.forEach({v => v.atraer()})})
    }

    /* Recibe los objetos con las posiciones configuradas 
        según el mapa actual y los hace visuales.*/
    method agregar(objeto) { 
        game.addVisual(objeto)
        objetos.add(objeto)
    }

    /* Similar al anterior, pero se necesita diferenciar, 
        para comprobar el fin del juego.*/
    method agregarBoton(boton) {
        game.addVisual(boton)
        botones.add(boton)
    }

    method agregarVentilador(v) {
        game.addVisual(v)
        ventiladores.add(v)
    }

    method comprobarFinNivel() {
        if (self.hayCajasEnBotones()) {
            self.finNivel()
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
        self.addVisual()
    }

    method clear() {
        botones.forEach({boton => game.removeVisual(boton)})
        botones.clear()
        objetos.forEach({obj => game.removeVisual(obj)})
        objetos.clear()
        ventiladores.forEach({v => game.removeVisual(v)})
        ventiladores.clear()
        game.removeVisual(personaje)
        game.removeVisual(reloj)
        game.removeVisual(fondoVictoria)
        game.removeVisual(textoVictoria)
        game.removeVisual(mapaTeclado)
    }

    
    method nextLevel() {
        nivelActual = nivelActual.siguiente()
        self.reset()
    }
}

object mapper {

    method crearMapa(nivel) {
        game.height(nivel.tablero().size())
        game.width(nivel.tablero().get(0).size())

        (0..game.width() - 1).forEach({ x =>
            (0..game.height() -1).forEach({y =>
                nivel.tablero().get(y).get(x).configurar(game.at(x,y))
            })
        })
        game.addVisual(personaje) // Se agrega al final para que esté por encima de todo
    }

}

object n1 {

    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,m,m,m,m,m,m,m,_,_,_],     
     [_,_,_,m,bz,_,cz,_,m,m,_,_,_],     
     [_,_,_,m,m,_,cm,_,bm,m,_,_,_],     
     [_,_,_,m,bv,_,cv,_,m,m,_,_,_],     
     [_,_,_,m,m,_,cn,p,bn,m,_,_,_],
     [_,_,_,m,bm,_,cm,_,m,m,_,_,_],
     [_,_,_,m,m,_,cz,_,bz,m,_,_,_],
     [_,_,_,m,m,m,m,m,m,m,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse()

    method siguiente() {
        return n2
    }
}

object n2 {

    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,m,m,m,m,m,_,_,_,_],
     [_,_,_,m,m,_,m,_,m,m,_,_,_],          
     [_,_,_,m,_,v,_,v,_,m,_,_,_],     
     [_,_,_,m,m,_,m,_,m,m,_,_,_],     
     [_,_,_,_,m,_,m,_,m,_,_,_,_],     
     [_,_,_,_,m,_,m,c,m,_,_,_,_],
     [_,_,_,m,m,_,m,p,m,_,_,_,_],
     [_,_,_,m,_,v,_,b,m,_,_,_,_],
     [_,_,_,m,m,_,m,m,m,_,_,_,_],  
     [_,_,_,_,m,m,m,_,_,_,_,_,_],   
     [_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse()

    method siguiente() {
        return n1
    }
}



object _ {
    method configurar(position) {  }
}

object p {
    method configurar(position) {
        personaje.position(position)
    }
}

object m {
    method configurar(position) {
        nivel.agregar(new Muro(position = position))
    }
}

object v {
    method configurar(position) {
        nivel.agregarVentilador(new Ventilador(position = position))
    }
}

// Botones

object b {
    method configurar(position) {
        nivel.agregarBoton(new Boton(position = position))
    }
}

object bz {
    method configurar(position) {
        nivel.agregarBoton(new BotonColorido(position = position, color = "azul"))
    }
}

object bm {
    method configurar(position) {
        nivel.agregarBoton(new BotonColorido(position = position, color = "amarillo"))
    }
}

object bn {
    method configurar(position) {
        nivel.agregarBoton(new BotonColorido(position = position, color = "negro"))
    }
}

object bv {
    method configurar(position) {
        nivel.agregarBoton(new BotonColorido(position = position, color = "violeta"))
    }
}

// Cajas

object c {
    method configurar(position) {
        nivel.agregar(new CajaNormal(position = position))
    }
}

object cz {
    method configurar(position) {
        nivel.agregar(new CajaColorida(position = position, color = "azul"))
    }
}

object cm {
    method configurar(position) {
        nivel.agregar(new CajaColorida(position = position, color = "amarillo"))
    }
}

object cn {
    method configurar(position) {
        nivel.agregar(new CajaColorida(position = position, color = "negro"))
    }
}

object cv {
    method configurar(position) {
        nivel.agregar(new CajaColorida(position = position, color = "violeta"))
    }
}