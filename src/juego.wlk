import wollok.game.*
import jugadores.*
import construcciones.*
import recursos.*
import visuales.*


////////////////////////////// CLASE POLIMORFICA

class Polimorfismo {
	method recolectado(x){}
	method darMadera(x,y){}
	method darPiedra(x,y){}
	method terminado(){}
	method default(){}
}


////////////////////////////// INTERFACES DE USUARIO


// rehacer las ui como clase si es posible
object ui1{
	method position() = game.at(27,24)
	method text() = 'Madera:' + jugador1.madera() + ' ' + 'Piedra:' + jugador1.piedra()
}

object ui2{
	method position() = game.at(2,24)
	method text() = 'Madera:' + jugador2.madera() + ' ' + 'Piedra:' + jugador2.piedra()
}


// tiempo
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
		game.addVisual(puntosAzul)
		game.addVisual(puntosRojo)
		game.addVisual(contadorAzul)
		game.addVisual(contadorRojo)
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
		jugador1.default()
		jugador2.default()
		contadorAzul.default()
		contadorRojo.default()
		construccion1.default()
		construccion2.default()
		if (contadorAzul.puntos() >= contadorRojo.puntos()){
			game.addVisual(finDelJuegoAzul)	
		}else{
			game.addVisual(finDelJuegoRojo)
		}
		keyboard.space().onPressDo{
			if (game.hasVisual(finDelJuegoAzul)){
				game.removeVisual(finDelJuegoAzul)
			}else{
				
				game.removeVisual(finDelJuegoRojo)
			}
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
		game.onCollideDo(quien,{algo => algo.darMadera(quien.madera(),quien)})
		game.onCollideDo(quien,{algo => algo.darPiedra(quien.piedra(),quien)})
		game.onCollideDo(quien,{algo => algo.terminado()})
	}
}

	
	
	
	
	
	
	