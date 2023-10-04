import wollok.game.*

class Jugador{
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

class Construccion {
	var cmadera = 20 // cantidad necesaria para finalizaar la contruccion
	var cpiedra = 20

	method image() = "sitio.png"
	method cmadera() = cmadera
	method cpiedra() = cpiedra
	method dar_madera(cantidad){  // el parametro es  la cantidad de recurso que el jugador tiene, y pierde al usarlo en la construccion
		cmadera = cmadera - cantidad
	}
	method dar_piedra(cantidad){
		cpiedra = cpiedra - cantidad
	}
	// if 'ambas cantidades' <= 0 'finaliza construccion'
	/*method finalizar(){
		method image() = "casa.png"
	} */
}

class Jugador1 inherits Jugador{
	var property position = game.at(5,15)
	method image() = "jugador1.png"
}

class Jugador2 inherits Jugador{
	var property position = game.at(24,15)
	method image() = "jugador2.png"
}

const jugador1 = new Jugador1()
const jugador2 = new Jugador2()

class Arbol{
	const cantidad_madera = 1

	method image() = "arbol.png"
	method recolectado(){
		game.removeVisual(self)  // mejorar mas adelante
		// agregar madera al jugador que toque el arbol
	}
}

class Piedras{
	const cantidad_piedra = 1

	method image() = "piedra.png"
	method recolectado(){
		game.removeVisual(self) // mejorar mas adelante
		// agregar piedra al jugador que toque la piedra
	}
}

// rehacer las ui como clase si es posible

object ui1{
	method position() = game.at(2,29)
	method text() = 'madera:' + jugador1.madera() + ' ' + 'piedra:' + jugador1.piedra()
}

object ui2{
	method position() = game.at(28,29)
	method text() = 'madera:' + jugador2.madera() + ' ' + 'piedra:' + jugador2.piedra()
}

object timer{
	method position() = game.at(15,29)
	//method text() = // agregar temporizador
}

object pantalla{
	

	method inicio(){
		self.configuracion()
		self.visuals()
		self.teclas()
		//self.collisiones()
	}
	method configuracion(){
		game.height(25) // resolucion optima, poner mas de 25 hace que los png pierdan la relacion de aspecto que tienen
		game.width(37)
		game.title("prueba")
		game.boardGround("fondo.png")
	}
	method visuals(){
		game.addVisual(ui1)
		game.addVisual(ui2)
		game.addVisual(timer)
		game.addVisualCharacter(jugador1)
		game.addVisualCharacter(jugador2)
		// agregar construcciones para cada jugador (que solo haya 1 para cada uno en cada momento)
		// agregar arboles y piedras de forma random (tener en cuenta posisicion de contrucciones)
	}
	method teclas(){

	}
	/*method collisiones(){
		game.onCollideDo
	}*/
}