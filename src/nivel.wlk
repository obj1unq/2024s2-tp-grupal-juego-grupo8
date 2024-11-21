import wollok.game.*
import objetos.*
import extras.*
import personaje.*
import historial.*

object nivel {
    var nivelActual = n1
    const botones = #{}
    const ventiladores = #{} // necesario para el onTick

    method addVisual() {
        game.addVisual(reloj)
        game.addVisual(mapaTeclado)
        mapper.crearMapa(nivelActual)
        game.onTick(1000, "reloj", {reloj.pasarElTiempo()})
        game.onTick(3000, "ventilador", {ventiladores.forEach({v => v.atraer()})})
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
        self.addVisual()
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

object mapper {

    const cajas = #{} // necesario para tener las cajas por encima de botones y ventiladores 

    method agregarCaja(caja) {
        cajas.add(caja)
    }

    method clear() {
        // Para que no se agreguen las cajas de un nivel en el siguiente.
        cajas.clear()
    }

    method crearMapa(nivel) {
        game.height(nivel.tablero().size())
        game.width(nivel.tablero().get(0).size())

        (0..game.width() - 1).forEach({ x =>
            (0..game.height() -1).forEach({y =>
                nivel.tablero().get(y).get(x).configurar(game.at(x,y))
            })
        })
        cajas.forEach({caja => game.addVisual(caja)})
        game.addVisual(personaje) // Se agrega al final para que esté por encima de todo
    }

}

object n1 {

    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,m,m,m,m,m,m,m,_,_,_,_,_],     
     [_,_,_,_,_,m,bz,_,cz,_,m,m,_,_,_,_,_],     
     [_,_,_,_,_,m,m,_,cm,_,bm,m,_,_,_,_,_],     
     [_,_,_,_,_,m,bv,_,cv,_,m,m,_,_,_,_,_],     
     [_,_,_,_,_,m,m,_,cn,p,bn,m,_,_,_,_,_],
     [_,_,_,_,_,m,bm,_,cm,_,m,m,_,_,_,_,_],
     [_,_,_,_,_,m,m,_,cz,_,bz,m,_,_,_,_,_],
     [_,_,_,_,_,m,m,m,m,m,m,m,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse()

    method siguiente() {
        return n2
    }
}

object n2 {

    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],         
     [_,_,_,_,_,_,m,m,m,m,m,_,_,_,_,_,_],
     [_,_,_,_,_,m,m,_,m,_,m,m,_,_,_,_,_],          
     [_,_,_,_,_,m,_,v,_,v,_,m,_,_,_,_,_],     
     [_,_,_,_,_,m,m,_,m,_,m,m,_,_,_,_,_],     
     [_,_,_,_,_,_,m,_,m,_,m,_,_,_,_,_,_],     
     [_,_,_,_,_,_,m,_,m,c,m,_,_,_,_,_,_],
     [_,_,_,_,_,m,m,_,m,p,m,_,_,_,_,_,_],
     [_,_,_,_,_,m,_,v,_,b,m,_,_,_,_,_,_],
     [_,_,_,_,_,m,m,_,m,m,m,_,_,_,_,_,_],  
     [_,_,_,_,_,_,m,m,m,_,_,_,_,_,_,_,_],   
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse()

    method siguiente() {
        return n3
    }
}
/*
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],         
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],    
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],         
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]
*/

object n3 {
    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],         
     [_,_,_,_,_,m,m,m,m,m,m,m,_,_,_,_,_],
     [_,_,_,_,_,m,b,_,_,m,m,m,_,_,_,_,_],
     [_,_,_,_,_,m,m,_,_,_,m,m,_,_,_,_,_],    
     [_,_,_,_,_,m,m,_,b,c,_,m,_,_,_,_,_],
     [_,_,_,_,_,m,p,c,_,_,_,m,_,_,_,_,_],
     [_,_,_,_,_,m,m,_,_,m,m,m,_,_,_,_,_],         
     [_,_,_,_,_,m,m,m,m,m,m,m,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],        
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]        
    ].reverse()

    method siguiente() {
        return n4
    }
}

object n4 {

    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,m,m,m,m,m,m,m,m,m,_,_,_,_],         
     [_,_,_,_,m,p,m,m,m,m,m,m,m,_,_,_,_],
     [_,_,_,_,m,_,b,_,_,_,_,m,m,_,_,_,_],
     [_,_,_,_,m,b,_,m,m,m,c,m,m,_,_,_,_],    
     [_,_,_,_,m,_,_,m,b,m,_,m,m,_,_,_,_],
     [_,_,_,_,m,c,_,_,c,_,_,_,m,_,_,_,_],
     [_,_,_,_,m,_,_,_,c,b,_,_,m,_,_,_,_],         
     [_,_,_,_,m,m,m,_,_,m,m,m,m,_,_,_,_],
     [_,_,_,_,m,m,m,m,m,m,m,m,m,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]      
    ].reverse()

    method siguiente() {
        return n5
    }
}

object n5 {
    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,m,m,m,m,m,m,m,m,m,m,m,_,_,_],
     [_,_,_,m,m,m,m,_,p,_,m,_,b,m,_,_,_],         
     [_,_,_,m,_,_,_,_,m,_,m,_,b,m,_,_,_],
     [_,_,_,m,_,_,_,_,c,_,m,_,b,m,_,_,_],
     [_,_,_,m,m,m,m,m,c,_,m,_,b,m,_,_,_],    
     [_,_,_,m,m,_,_,m,_,_,b,_,b,m,_,_,_],
     [_,_,_,m,m,c,_,m,_,_,m,_,_,m,_,_,_],
     [_,_,_,m,m,_,_,m,c,_,m,m,m,m,_,_,_],         
     [_,_,_,m,_,c,_,c,_,_,_,_,m,m,_,_,_],
     [_,_,_,m,_,_,_,_,_,m,_,_,m,m,_,_,_],
     [_,_,_,m,m,m,m,m,m,m,m,m,m,m,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]  
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
        game.addVisual(new Muro(position = position))
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
        nivel.agregarBoton(new BotonDeColor(position = position, color = "azul"))
    }
}

object bm {
    method configurar(position) {
        nivel.agregarBoton(new BotonDeColor(position = position, color = "amarillo"))
    }
}

object bn {
    method configurar(position) {
        nivel.agregarBoton(new BotonDeColor(position = position, color = "negro"))
    }
}

object bv {
    method configurar(position) {
        nivel.agregarBoton(new BotonDeColor(position = position, color = "violeta"))
    }
}

// Cajas

object c {
    method configurar(position) {
        mapper.agregarCaja(new Caja(position = position))
    }
}

object cz {
    method configurar(position) {
        mapper.agregarCaja(new CajaDeColor(position = position, color = "azul"))
    }
}

object cm {
    method configurar(position) {
        mapper.agregarCaja(new CajaDeColor(position = position, color = "amarillo"))
    }
}

object cn {
    method configurar(position) {
        mapper.agregarCaja(new CajaDeColor(position = position, color = "negro"))
    }
}

object cv {
    method configurar(position) {
        mapper.agregarCaja(new CajaDeColor(position = position, color = "violeta"))
    }                           
}
