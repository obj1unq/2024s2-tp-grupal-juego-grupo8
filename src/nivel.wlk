import wollok.game.*
import objetos.*
import personaje.*

object nivel {
    var property botones = #{}
    var property cajas = #{}
    var property muros = #{}

    method addVisual() {
        cajas = #{new Caja(position=game.at(1,3), estado = normal), new Caja(position=game.at(1,6), estado = bloqueada)}
        muros = #{new Muro(position=game.at(2,3))}
        botones = #{new Boton(position=game.at(2,2))}

        botones.forEach({boton => game.addVisual(boton)})
        cajas.forEach({caja => game.addVisual(caja)})
        muros.forEach({muro => game.addVisual(muro)})
        personaje.position(game.at(3,3))
    }

    method clear() {
        botones.forEach({boton => game.removeVisual(boton)})
        cajas.forEach({caja => game.removeVisual(caja)})
        muros.forEach({muro => game.removeVisual(muro)})
    }

    method reset() {
        self.clear()
        self.addVisual()
    }
}
