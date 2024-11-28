import wollok.game.*
import objetos.*
import personaje.*
import gameManager.*
import posiciones.*
import extras.*

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

class Nivel {
    const siguienteNivel

    method iniciarSiguiente() {
        gameManager.pasarANivel(siguienteNivel)
    }
}

object n1 inherits Nivel(siguienteNivel = n2) {

    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],         
     [_,_,_,_,_,_,_,m,m,m,m,m,m,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,m,b,_,_,m,m,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,m,m,_,_,_,m,m,_,_,_,_,_,_],    
     [_,_,_,_,_,_,_,m,m,_,b,c,_,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,m,p,c,_,_,_,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,m,m,_,_,m,m,m,_,_,_,_,_,_],         
     [_,_,_,_,_,_,_,m,m,m,m,m,m,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],        
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]        
    ].reverse()
}

object n2 inherits Nivel(siguienteNivel = n3) {

    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,m,m,m,m,m,m,m,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,m,m,_,_,_,_,_,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,m,_,cz,cz,cm,cm,_,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,m,_,m,p,_,m,_,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,m,_,bm,bm,bz,bz,_,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,m,m,_,_,_,_,m,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,m,m,m,m,m,m,m,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]
    ].reverse()
}


object n3 inherits Nivel(siguienteNivel = n4) {

    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],         
     [_,_,_,_,_,_,_,_,m,m,m,m,m,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,m,m,_,m,_,m,m,_,_,_,_,_,_],          
     [_,_,_,_,_,_,_,m,_,v,_,v,_,m,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,m,m,_,m,_,m,m,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,m,_,m,_,m,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,m,_,m,c,m,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,m,_,m,p,m,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,m,m,_,m,m,m,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,m,_,v,_,b,m,_,_,_,_,_,_,_],  
     [_,_,_,_,_,_,_,m,m,_,m,m,m,_,_,_,_,_,_,_],   
     [_,_,_,_,_,_,_,_,m,m,m,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse()
}

object n4 inherits Nivel(siguienteNivel = n5) {
    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,m,m,m,m,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,m,_,_,m,m,m,m,_,_,_,_,_,_,_,_],    
     [_,_,_,_,_,m,_,_,m,_,_,m,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,m,_,_,p,_,_,m,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,m,m,caa,m,m,cab,m,m,m,m,_,_,_,_,_],
     [_,_,_,_,_,m,_,cv,_,_,_,_,_,_,m,_,_,_,_,_],         
     [_,_,_,_,_,m,m,_,m,m,_,m,m,_,m,_,_,_,_,_],
     [_,_,_,_,_,m,bv,_,_,_,_,_,_,_,m,_,_,_,_,_],
     [_,_,_,_,_,m,m,m,m,m,m,m,m,m,m,_,_,_,_,_],         
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],        
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]        
    ].reverse()
}

object n5 inherits Nivel(siguienteNivel = n6) {
    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,m,m,m,m,m,m,m,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,m,b,_,c,_,m,m,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,m,m,_,cz,_,bn,m,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,m,bm,_,cv,_,m,m,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,m,m,_,cn,p,bz,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,m,bv,_,cm,_,m,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,m,m,_,c,_,b,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,m,m,m,m,m,m,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse()
}

object n6 inherits Nivel(siguienteNivel = n7) {
    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],         
     [_,_,_,_,_,m,m,m,m,m,m,m,m,m,_,_,_,_,_,_],
     [_,_,_,_,_,m,_,_,b,_,_,m,m,m,_,_,_,_,_,_],
     [_,_,_,_,_,m,_,_,m,_,_,_,m,m,_,_,_,_,_,_],    
     [_,_,_,_,_,m,_,caa,m,_,b,c,_,m,_,_,_,_,_,_],
     [_,_,_,_,_,m,_,_,p,c,_,_,_,m,_,_,_,_,_,_],
     [_,_,_,_,_,m,_,_,m,_,_,m,m,m,_,_,_,_,_,_],         
     [_,_,_,_,_,m,m,m,m,m,m,m,m,m,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]  
    ].reverse()
}

object n7 inherits Nivel(siguienteNivel = n8) {
    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,m,m,m,m,m,m,m,m,m,_,_,_,_,_],         
     [_,_,_,_,_,_,m,p,m,m,m,m,m,m,m,_,_,_,_,_],
     [_,_,_,_,_,_,m,_,b,_,_,_,_,m,m,_,_,_,_,_],
     [_,_,_,_,_,_,m,b,_,m,m,m,c,m,m,_,_,_,_,_],    
     [_,_,_,_,_,_,m,_,_,m,b,m,_,m,m,_,_,_,_,_],
     [_,_,_,_,_,_,m,c,_,_,c,_,_,_,m,_,_,_,_,_],
     [_,_,_,_,_,_,m,_,_,_,c,b,_,_,m,_,_,_,_,_],         
     [_,_,_,_,_,_,m,m,m,_,_,m,m,m,m,_,_,_,_,_],
     [_,_,_,_,_,_,m,m,m,m,m,m,m,m,m,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]      
    ].reverse()
}

object n8 inherits Nivel(siguienteNivel = n9) {

    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],         
     [_,_,_,_,_,_,_,_,_,_,_,_,m,m,m,m,_,_,_,_],
     [_,_,_,_,m,m,m,m,m,m,m,m,m,_,_,m,m,_,_,_],
     [_,_,_,_,m,m,p,_,_,m,_,_,_,_,_,_,m,_,_,_],
     [_,_,_,_,m,m,_,cv,_,cad,_,_,_,m,_,_,m,_,_,_],    
     [_,_,_,_,m,m,caa,m,m,m,m,m,_,_,_,_,m,_,_,_],
     [_,_,_,_,m,m,_,_,_,cai,v,_,m,_,_,_,m,_,_,_],
     [_,_,_,_,m,m,_,v,bv,m,_,_,cai,_,_,_,m,_,_,_],         
     [_,_,_,_,m,m,m,m,m,m,m,m,m,m,m,m,m,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]  
    ].reverse()
}


object n9 inherits Nivel(siguienteNivel = n10) {
    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,m,m,m,m,m,m,m,m,m,m,m,_,_,_,_],
     [_,_,_,_,_,m,m,m,m,_,p,_,m,_,b,m,_,_,_,_],         
     [_,_,_,_,_,m,_,_,_,_,m,_,m,_,b,m,_,_,_,_],
     [_,_,_,_,_,m,_,_,_,_,c,_,m,_,b,m,_,_,_,_],
     [_,_,_,_,_,m,m,m,m,m,c,_,m,_,b,m,_,_,_,_],    
     [_,_,_,_,_,m,m,_,_,m,_,_,b,_,b,m,_,_,_,_],
     [_,_,_,_,_,m,m,c,_,m,_,_,m,_,_,m,_,_,_,_],
     [_,_,_,_,_,m,m,_,_,m,c,_,m,m,m,m,_,_,_,_],         
     [_,_,_,_,_,m,_,c,_,c,_,_,_,_,m,m,_,_,_,_],
     [_,_,_,_,_,m,_,_,_,_,_,m,_,_,m,m,_,_,_,_],
     [_,_,_,_,_,m,m,m,m,m,m,m,m,m,m,m,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]  
    ].reverse()
}

object n10 inherits Nivel(siguienteNivel = n1) {
    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,_,_],
     [_,_,_,m,m,m,m,_,_,_,_,m,m,m,m,m,m,m,_,_],
     [_,_,_,m,_,_,_,_,m,_,_,_,_,_,bv,_,_,m,_,_],
     [_,_,_,m,_,_,m,bv,m,bv,m,m,m,m,m,_,_,m,_,_],
     [_,_,_,m,_,bv,m,m,m,m,m,_,_,_,m,_,m,m,_,_],
     [_,_,_,m,m,_,m,_,_,_,_,_,_,_,m,_,m,m,_,_],
     [_,_,_,m,m,_,m,cv,_,m,_,m,_,cv,m,_,m,m,_,_],
     [_,_,_,m,m,_,_,cv,cn,m,p,m,cn,cv,_,_,m,m,_,_],
     [_,_,_,m,m,_,m,cv,_,m,_,m,_,cv,m,_,m,m,_,_],
     [_,_,_,m,m,_,m,_,_,_,_,_,_,_,m,_,m,m,_,_],
     [_,_,_,m,m,_,m,m,m,m,bn,m,m,m,m,_,m,m,_,_],
     [_,_,_,m,m,_,_,_,_,_,_,_,_,_,_,_,m,m,_,_],
     [_,_,_,m,m,m,_,m,m,m,_,m,m,m,_,m,m,m,_,_],
     [_,_,_,m,m,m,_,_,_,_,_,_,_,_,_,m,m,m,_,_],
     [_,_,_,m,m,m,bv,m,m,m,bn,m,m,m,bv,m,m,m,_,_],
     [_,_,_,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]
    ].reverse()

    override method iniciarSiguiente() {
        gameManager.clear()
        game.addVisual(pantallaFinal)
        game.schedule(500, {game.stop()})
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
        gameManager.agregarVentilador(new Ventilador(position = position))
    }
}

// Botones

object b {
    method configurar(position) {
        gameManager.agregarBoton(new Boton(position = position))
    }
}

object bz {
    method configurar(position) {
        gameManager.agregarBoton(new BotonDeColor(position = position, color = "azul"))
    }
}

object bm {
    method configurar(position) {
        gameManager.agregarBoton(new BotonDeColor(position = position, color = "amarillo"))
    }
}

object bn {
    method configurar(position) {
        gameManager.agregarBoton(new BotonDeColor(position = position, color = "negro"))
    }
}

object bv {
    method configurar(position) {
        gameManager.agregarBoton(new BotonDeColor(position = position, color = "violeta"))
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
