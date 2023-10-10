import wollok.game.*

////////////////////////////// CLASE CONSTRUCCION

class Construccion {
	var cmadera = 20 // cantidad necesaria para finalizar la contruccion
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
	// if cmadera and cpiedra <= 0 'finaliza construccion'
	/*method finalizar(){
		method image() = "casa.png"
	} */
}
////////////////////////////// CLASES DE JUGADORES

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

class Jugador1 inherits Jugador{
	var property position = game.at(5,15)
	method image() = "jugador1.png"
	method recolectado(x){}
}

class Jugador2 inherits Jugador{
	var property position = game.at(24,15)
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}	
	method image() = "jugador2.png"
	method recolectado(x){}
	
}

const jugador1 = new Jugador1()
const jugador2 = new Jugador2()

////////////////////////////// CLASES DE LOS RECURSOS

class Arbol{
	const cantidad_madera = 1
	var property position
	method image() = "arbol.png"
	method recolectado(quien){
		game.removeVisual(self)  // mejorar mas adelante
		quien.recolectar_madera(cantidad_madera)
	}
}

class Piedras{
	const cantidad_piedra = 1
	var property position
	method image() = "piedra.png"
	method recolectado(quien){
		game.removeVisual(self) // mejorar mas adelante
		quien.recolectar_piedra(cantidad_piedra)
	}
}


////////////////////////////// INTERFACES DE USUARIO


// rehacer las ui como clase si es posible
object ui1{
	method position() = game.at(2,24)
	method text() = 'madera:' + jugador1.madera() + ' ' + 'piedra:' + jugador1.piedra()
}

object ui2{
	method position() = game.at(34,24)
	method text() = 'madera:' + jugador2.madera() + ' ' + 'piedra:' + jugador2.piedra()
}

object timer{
	var tiempo = 120
	method tiempo() = tiempo
	method position() = game.at(15,24)
	method text() = "Tiempo:" + self.tiempo()
	method descontarTiempo() {
		tiempo= tiempo-1
	}
}


////////////////////////////// PANTALLA

object pantalla{

	method inicio(){
		self.configuracion()
		self.visuals()
		self.teclas()
		self.collisiones(jugador1)
		self.collisiones(jugador2)
	}
	method configuracion(){
		game.height(25) // resolucion optima, poner mas de 25 hace que los png pierdan la relacion de aspecto
		game.width(37)
		game.title("Crafting battle")
		game.boardGround("fondo.png")
	}
	method visuals(){
		game.addVisual(ui1)
		game.addVisual(ui2)
		game.addVisual(timer)
		game.addVisualCharacter(jugador1)
		game.addVisual(jugador2)
		game.onTick(1000,"generar arboles",{game.addVisual(new Arbol(position = game.at(1.randomUpTo(36),18.randomUpTo(23))))})
		game.onTick(1000,"generar piedras",{game.addVisual(new Piedras(position = game.at(1.randomUpTo(36),1.randomUpTo())))})
		game.onTick(1000,"timer",{ timer.descontarTiempo()})
		
		
		
		// agregar construcciones para cada jugador (que solo haya 1 para cada uno en cada momento)
		// agregar arboles y piedras de forma random (tener en cuenta posisicion de contrucciones)
	}
	method teclas(){
//MOVIMIENTO JUGADOR 2
		
		keyboard.w().onPressDo{jugador2.move(jugador2.position().up(1))}
		keyboard.s().onPressDo{jugador2.move(jugador2.position().down(1))}
		keyboard.a().onPressDo{jugador2.move(jugador2.position().left(1))}
		keyboard.d().onPressDo{jugador2.move(jugador2.position().right(1))}
	}
	method collisiones(quien){
		game.onCollideDo(quien,{algo => algo.recolectado(quien)})
	}
}