import wollok.game.*
import juego.*

////////////////////////////// CLASES DE JUGADORES

class Jugador inherits Polimorfismo  {
	var madera = 0
	var piedra = 0
	method madera() = madera
	method piedra() = piedra
	method recolectar_madera(cantidad){
		madera = madera + cantidad
	}
	method recolectar_piedra(cantidad){
		piedra = piedra + cantidad
	}
}

class Jugador1 inherits Jugador{
	var property position = game.at(29,15)
	method image() = "jugador1.png"
}

class Jugador2 inherits Jugador{
	var property position = game.at(5,15)
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}	
	method image() = "jugador2.png"
	
}


	
