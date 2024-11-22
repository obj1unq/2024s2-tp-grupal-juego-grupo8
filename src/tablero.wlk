import wollok.game.*

object tablero {

    method objetosEn(position) {
        return game.getObjectsIn(position)
    }

    method  hayObjetoEn(position) { 
        return not self.objetosEn(position).isEmpty()
    }

    method validarLimites(position) {
		if (not self.estaDentro(position)) {
			self.error("No puede mover fuera del límite.")
		}
	}

	method estaDentro(position) {
		return position.x().between(0, game.width() - 1) and position.y().between(0, game.height() - 1)
	}

	method validarAtravesables(posicion) {
		if (self.objetosEn(posicion).any({obj => not obj.esAtravesable()}))
			self.error("No puedo mover. Ya un objeto en esa posición.")
	}

	// method validarBloqueo(position) {
	// 	if (game.getObjectsIn(position).any({obj => not obj.esAtravesable() and not obj.esDesplazable()}))
	// 		self.error("No puedo mover. Un objeto bloquea.")
	// }
}