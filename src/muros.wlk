import wollok.game.*
import juego.*
import jugadores.*

class Muros inherits Polimorfismo{
	method position()
	method colision(quien)
}

object muroIzquierda inherits Muros {
	override method position() = game.at(,)
	override method colision(quien){
		quien.position().right(1)
	}
}

object muroDerecha inherits Muros {
	override method position() = game.at(,)
	override method colision(quien){
		quien.position().left(1)
	}
}
object muroArriba inherits Muros {
	override method position() = game.at(,)
	override method colision(quien){
		quien.position().down(1)
	}
}

object muroAbajo inherits Muros {
	override method position() = game.at(,)
	override method colision(quien){
		quien.position().up(1)
	}
}