import wollok.game.*

////////////////////////////// CLASE CONSTRUCCION

class Construccion {
	const maderaRequiere = 5
	const piedraRequiere = 5
	var cantidadMadera = 0 // cantidad necesaria para finalizar la contruccion
	var cantidadPiedra = 0
	var total = 0
	var property position = game.at(1.randomUpTo(35),7.randomUpTo(17))
	
	method default(){
		position = game.at(1.randomUpTo(35),7.randomUpTo(17))
		total = 0
		cantidadMadera = 0
		cantidadPiedra =0
	}
	method cmadera() = cantidadMadera
	method cpiedra() = cantidadPiedra
	method calcularTotal(){
		total = (cantidadMadera + cantidadPiedra)/2
	}
	method darMadera(cantidad){  // el parametro es  la cantidad de recurso que el jugador tiene, y pierde al usarlo en la construccion
		cantidadMadera = cantidadMadera + cantidad
		self.calcularTotal()
	}
	method darPiedra(cantidad){
		cantidadPiedra = cantidadPiedra + cantidad
		self.calcularTotal()
	}
	method recolectado(x){}
}

object construccion1 inherits Construccion{
	const progreso = new Dictionary()

	method iniciar(){
		progreso.put(0,"casa0a.png")
		progreso.put(1,"casa1a.png")
		progreso.put(2,"casa2a.png")
		progreso.put(3,"casa3a.png")
		progreso.put(4,"casa4a.png")
	}
	method image(){
		if (total <= 4){
			return progreso.basicGet(total.roundUp())
		} else {return "casa4a.png"}
	} 
	method terminado(){
		if (cantidadMadera >= maderaRequiere and cantidadPiedra >= piedraRequiere){
			game.addVisual(casaAzulFinal)
			self.default()	
		}
	}
}

object construccion2 inherits Construccion{
	const progreso = new Dictionary()

	method iniciar(){
		progreso.put(0,"casa0r.png")
		progreso.put(1,"casa1r.png")
		progreso.put(2,"casa2r.png")
		progreso.put(3,"casa3r.png")
		progreso.put(4,"casa4r.png")
	}
	method image(){
		if (total <= 4){
			return progreso.basicGet(total.roundUp())
		} else {return "casa4r.png"}
	}
	method terminado(){
		if (cantidadMadera >= maderaRequiere and cantidadPiedra >= piedraRequiere){
			game.addVisual(casaRojaFinal)
			self.default()
		}
	}
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
	method darMadera(x){}
	method darPiedra(x){}
	method terminado(){}
}

class Jugador1 inherits Jugador{
	var property position = game.at(29,15)
	method image() = "jugador1.png"
	method recolectado(x){}
}

class Jugador2 inherits Jugador{
	var property position = game.at(5,15)
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}	
	method image() = "jugador2.png"
	method recolectado(x){}
	
}

const jugador1 = new Jugador1()
const jugador2 = new Jugador2()

////////////////////////////// CLASES DE LOS RECURSOS

class Recurso{
	method darMadera(x){}
	method darPiedra(x){}
	method terminado(){}
}

class Arbol inherits Recurso{
	const cantidad_madera = 1
	var property position
	method image() = "arbol.png"
	method recolectado(quien){
		game.removeVisual(self)  // mejorar mas adelante
		quien.recolectar_madera(cantidad_madera)
	}
}

class Piedras inherits Recurso{
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
	method position() = game.at(34,24)
	method text() = 'madera:' + jugador1.madera() + ' ' + 'piedra:' + jugador1.piedra()
}

object ui2{
	method position() = game.at(2,24)
	method text() = 'madera:' + jugador2.madera() + ' ' + 'piedra:' + jugador2.piedra()
}

object timer{
	var tiempo = 50
	method changeTime(){
		tiempo =50	}
	method tiempo() = tiempo
	method position() = game.at(18,24)
	method text() = "Tiempo:" + self.tiempo()
	method descontarTiempo() {
		if (tiempo > 0){
		tiempo= tiempo-1}
		else
		pantalla.gameOver()
	}
}


////////////////////////////// PANTALLA

object pantalla{

	method inicio(){
		game.clear()
		game.height(25) // resolucion optima, poner mas de 25 hace que los png pierdan la relacion de aspecto
		game.width(36)
		game.title("Mini builder")
		game.boardGround("fondo.png")
		game.addVisual(inicioDelJuego)
		keyboard.f().onPressDo{
			game.stop()
		}
		keyboard.space().onPressDo{self.start()}
		construccion1.iniciar()
		construccion2.iniciar()
	}
	method start(){
		game.removeVisual(inicioDelJuego)
		self.configuracion()
		self.visuals()
		self.teclas()
		self.collisiones(jugador1)
		self.collisiones(jugador2)
	}
	method configuracion(){
		game.height(25) // resolucion optima, poner mas de 25 hace que los png pierdan la relacion de aspecto
		game.width(36)
		game.title("Mini builder")
		game.boardGround("fondo.png")
	}
	method visuals(){
		game.addVisual(ui1)
		game.addVisual(ui2)
		game.addVisual(timer)
		game.addVisualCharacter(jugador1)
		game.addVisual(jugador2)
		game.addVisual(construccion1)
		game.addVisual(construccion2)
		game.onTick(1000,"generar arboles",{game.addVisual(new Arbol(position = game.at(1.randomUpTo(35),18.randomUpTo(23))))})
		game.onTick(1000,"generar piedras",{game.addVisual(new Piedras(position = game.at(1.randomUpTo(35),1.randomUpTo(6))))})
		game.onTick(1000,"timer",{ timer.descontarTiempo()})
		
	}

	method gameOver(){
		game.clear()
		game.addVisual(finDelJuego)
		keyboard.space().onPressDo{
			game.removeVisual(finDelJuego)
			timer.changeTime()
			self.inicio()
		}
		keyboard.f().onPressDo{
			game.stop()
		}
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
		game.onCollideDo(quien,{algo => algo.darMadera(quien.madera())})
		game.onCollideDo(quien,{algo => algo.darPiedra(quien.piedra())})
		game.onCollideDo(quien,{algo => algo.terminado()})
	}
}
	class Visual {
	var property image
	var property position = game.origin()
}
	
	const finDelJuego = new Visual(
		image = "gameOverRed.png",
		position = game.at(-1,2)
	)
	const inicioDelJuego = new Visual(
	image =  "inicio.png",
	position = game.at(-1,2)
	)
	const casaAzulFinal = new Visual(
		image = "casafa.png",
		position = construccion1.position()
	)
	const casaRojaFinal = new Visual(
		image = "casafr.png",
		position = construccion2.position()
	)
	
	
	
	
	
	
	
	