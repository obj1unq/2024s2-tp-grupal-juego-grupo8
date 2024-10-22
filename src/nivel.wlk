import wollok.game.*
import objetos.*
import personaje.*

object nivel {
    var property botones = #{}
    var property cajas = #{}
    var property muros = #{}

    method addVisual() {
        cajas = #{
            new CajaNormal(position=game.at(1,3), estado = normal), 
            new CajaNormal(position=game.at(1,6), estado = bloqueada),
            new CajaColorida(position=game.at(4,4), color = 'gris')}
        muros = #{new Muro(position=game.at(2,3))}
        botones = #{new Boton(position=game.at(2,2)),
                    new BotonColorido(position=game.at(7,7), color = 'gris')}

        botones.forEach({boton => game.addVisual(boton)})
        cajas.forEach({caja => caja.agregarAlTablero()})
        muros.forEach({muro => game.addVisual(muro)})


        game.addVisual(personaje)
        personaje.position(game.at(3,3))
    }

    method clear() {
        botones.forEach({boton => game.removeVisual(boton)})
        cajas.forEach({caja => game.removeVisual(caja)})
        muros.forEach({muro => game.removeVisual(muro)})
        game.removeVisual(personaje)
    }

    method reset() {
        self.clear()
        self.addVisual()
    }
}
