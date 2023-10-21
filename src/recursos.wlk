import wollok.game.*
import juego.*

////////////////////////////// CLASES DE LOS RECURSOS


class Arbol inherits Polimorfismo {
	const cantidad_madera = 1
	var property position
	method image() = "arbol.png"
	override method recolectado(quien){
		game.removeVisual(self)  // mejorar mas adelante
		quien.recolectar_madera(cantidad_madera)
	}
}

class Piedras inherits Polimorfismo {
	const cantidad_piedra = 1
	var property position
	method image() = "piedra.png"
	override method recolectado(quien){
		game.removeVisual(self) // mejorar mas adelante
		quien.recolectar_piedra(cantidad_piedra)
	}
}
