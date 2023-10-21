import wollok.game.*
import jugadores.*
import construcciones.*
import recursos.*

const jugador1 = new Jugador1()
const jugador2 = new Jugador2()


////////////////////////////// CLASE POLIMORFICA

class Polimorfismo {
	method recolectado(x) {}
	method darMadera(x) {}
	method darPiedra(x) {}
	method terminado() {}
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
	class Visual inherits Polimorfismo {
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
	
	
	
	
	
	
	
	
	