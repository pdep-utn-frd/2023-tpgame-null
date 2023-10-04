import wollok.game.*

/////////////////// CLASE CONSTRUCCION
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
}

class Jugador2 inherits Jugador{
	var property position = game.at(24,15)
	method image() = "jugador2.png"
}

const jugador1 = new Jugador1()
const jugador2 = new Jugador2()

/////////////////// CLASES DE LOS RECURSOS

class Arbol{
	const cantidad_madera = 1

	method image() = "arbol.png"
	method recolectado(quien){
		game.removeVisual(self)  // mejorar mas adelante
		quien.recolectar_madera(cantidad_madera)
	}
}

class Piedras{
	const cantidad_piedra = 1

	method image() = "piedra.png"
	method recolectado(quien){
		game.removeVisual(self) // mejorar mas adelante
		quien.recolectar_piedra(cantidad_piedra)
	}
}


////////////////////// INTERFACES DE USUARIO


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
	method position() = game.at(15,29)
	game.onTick(1000,"timer", tiempo = tiempo - 1)
	method text() = "Tiempo:" + self.tiempo()
}


///////////////////////////// PANTALLA

object pantalla{

	method inicio(){
		self.configuracion()
		self.visuals()
		self.teclas()
		//self.collisiones()
	}
	method configuracion(){
		game.height(25) // resolucion optima, poner mas de 25 hace que los png pierdan la relacion de aspecto
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
	method collisiones(quien){
		game.onCollideDo(quien,{algo => algo.recolectado(quien)})
	}
}