import wollok.game.*
import objetos.*
import personaje.*
import nivel.*
import posiciones.*
object mapper {

    // necesario para tener las cajas por encima de botones y ventiladores 
    const cajas = #{} 

    method agregarCaja(caja) {
        cajas.add(caja)
    }

    // Para que no se agreguen las cajas de un nivel en el siguiente.
    method clear() {
        cajas.clear()
    }

    method crearMapa(nivelActual) {
        game.height(nivelActual.tablero().size())
        game.width(nivelActual.tablero().get(0).size())

        (0..game.width() - 1).forEach({ x =>
            (0..game.height() -1).forEach({y =>
                nivelActual.tablero().get(y).get(x).configurar(game.at(x,y))
            })
        })
        cajas.forEach({caja => game.addVisual(caja)})
        game.addVisual(personaje) 
        // Se agrega al final para que esté por encima de todo
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

object ntest {

    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,m,m,_,_,_,m,m,m,m,m,_,_,_,_,_],     
     [_,_,m,_,cab,_,bz,_,cz,_,m,m,_,_,_,_,_],     
     [_,_,m,m,_,_,_,cm,_,bm,m,_,_,_,_,_],     
     [_,_,m,_,_,cad,bv,_,cv,_,m,m,_,_,_,_,_],     
     [_,_,m,caa,_,_,_,cn,p,bn,m,_,_,_,_,_],
     [_,_,m,_,_,cai,bm,_,cm,_,m,m,_,_,_,_,_],
     [_,_,m,m,_,_,_,cz,_,bz,m,_,_,_,_,_],
     [_,_,m,m,m,m,m,m,m,m,m,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
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

// Caminos con direccion, arriba, abajo, derecha, izquierda.
object caa {
    method configurar(position) {
       game.addVisual(new CaminoConDireccion(position = position, orientacion = arriba))
    }
}

object cab {
    method configurar(position) {
       game.addVisual(new CaminoConDireccion(position = position, orientacion = abajo))
    }
}

object cad {
    method configurar(position) {
       game.addVisual(new CaminoConDireccion(position = position, orientacion = derecha))
    }
}

object cai {
    method configurar(position) {
       game.addVisual(new CaminoConDireccion(position = position, orientacion = izquierda))
    }
}
