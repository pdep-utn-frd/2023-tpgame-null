import wollok.game.*
import juego.*

////////////////////////////// CLASES DE LOS RECURSOS


class Arbol inherits Polimorfismo {
	const cantidadMadera = 1
	var property position
	method image() = "arbol.png"
	override method recolectado(quien){
		game.removeVisual(self)  // mejorar mas adelante
		quien.recolectarMadera(cantidadMadera)
	}
}

class Piedras inherits Polimorfismo {
	const cantidadPiedra = 1
	var property position
	method image() = "piedra.png"
	override method recolectado(quien){
		game.removeVisual(self) // mejorar mas adelante
		quien.recolectarPiedra(cantidadPiedra)
	}
}
