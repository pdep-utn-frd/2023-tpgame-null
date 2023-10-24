import wollok.game.*
import juego.*

////////////////////////////// CLASES DE JUGADORES

class Jugador inherits Polimorfismo  {
	var property madera = 0
	var property piedra = 0
	method madera() = madera
	method piedra() = piedra
	method recolectarMadera(cantidad){
		madera = madera + cantidad
	}
	method recolectarPiedra(cantidad){
		piedra = piedra + cantidad
	}
	method restarMadera(cantidad){
		if(cantidad < 5){
			madera = madera - cantidad
		}else{
			madera = madera - 5
		}
		
	}
	method restarPiedra(cantidad){
		if(cantidad < 5){
			piedra = piedra - cantidad
		}else{
			piedra = piedra - 5
		}
	}
	override method default(){
		madera = 0
		piedra = 0
	} 
}

object jugador1 inherits Jugador{
	var property position = game.at(29,15)
	method image() = "jugador1.png"
	override method default(){
		super()
		position = game.at(29,15)
	}
}

object jugador2 inherits Jugador{
	var property position = game.at(5,15)
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}	
	method image() = "jugador2.png"
	override method default(){
		super()
		position = game.at(5,15)
	}
}


	
