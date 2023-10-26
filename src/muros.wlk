import wollok.game.*
import juego.*
import jugadores.*

class Muro inherits Polimorfismo{
	const ancho = 35
	const largo = 24
	const posicionesMuros = []
	var property position = game.at(0,0)
	method generar(){}
	method agregar(muro) {
		game.addVisual(muro)
	}
}


class MuroIzquierda inherits Muro {
	override method generar(){
		(0 .. largo).forEach{ num => posicionesMuros.add(new Position(x=1, y=num))}
		posicionesMuros.forEach {p => self.agregar(new MuroIzquierda(position = p))}
	}

	override method colision(quien){
		quien.position().right(1)
	}
}


class MuroDerecha inherits Muro {
	override method generar(){
		(0 .. largo).forEach{ num => posicionesMuros.add(new Position(x=34, y=num))}
		posicionesMuros.forEach {p => self.agregar(new MuroDerecha(position = p))}
	}
	override method colision(quien){
		quien.position().left(1)
	}
}


class MuroArriba inherits Muro {
	override method generar(){
		(0 .. ancho).forEach{ num => posicionesMuros.add(new Position(x=num, y=largo))}
		posicionesMuros.forEach {p => self.agregar(new MuroArriba(position = p))}
	}
	override method colision(quien){
		quien.position().down(1)
	}
}


class MuroAbajo inherits Muro {
	override method generar(){
		(0 .. ancho).forEach{ num => posicionesMuros.add(new Position(x=num, y=1))}
		posicionesMuros.forEach {p => self.agregar(new MuroAbajo(position = p))}
	}
	override method colision(quien){
		quien.position().up(1)
	}
}
