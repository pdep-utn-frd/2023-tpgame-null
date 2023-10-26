import wollok.game.*
import jugadores.*
import construcciones.*
import recursos.*
import visuales.*
import muros.*


////////////////////////////// CLASE POLIMORFICA

class Polimorfismo {
	method recolectado(x){}
	method darMadera(x,y){}
	method darPiedra(x,y){}
	method terminado(){}
	method default(){}
	method colision(x){}
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

//// MUSICA
object musica {
	var cancion = game.sound("mainMenu.mp3")
	method play(){
		cancion.volume(0.1)
		cancion.play()
	}
	method pause() {
		cancion.stop() 
	}
	method changeToStart(){
		cancion.stop()
		cancion = game.sound("gameStart.mp3")
		self.play()
	}
	method changeToMenu(){
		cancion.stop()
		cancion = game.sound("mainMenu.mp3")
		self.play()
	}
}

const muroIzquierda = new MuroIzquierda()
const muroDerecha = new MuroDerecha()
const muroArriba = new MuroArriba()
const muroAbajo = new MuroAbajo()

////////////////////////////// PANTALLA

object pantalla{
var flagInicio = true
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
		if (flagInicio){
			game.onTick(0, "nose",{
				flagInicio = false
				musica.play()
				game.removeTickEvent("nose")
		} )}
		
	}
	method start(){
		musica.changeToStart()
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
		//muroIzquierda.generar()
		//muroDerecha.generar()
		//muroArriba.generar()
		//muroAbajo.generar()
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
		musica.changeToMenu()
		jugador1.default()
		jugador2.default()
		construccion1.default()
		construccion2.default()
		if (contadorAzul.puntos() >= contadorRojo.puntos()){
			game.addVisual(finDelJuegoAzul)
			contadorAzul.default()
			contadorRojo.default()	
		}else{
			game.addVisual(finDelJuegoRojo)
			contadorAzul.default()
			contadorRojo.default()
		}
		keyboard.space().onPressDo{
			if (game.hasVisual(finDelJuegoAzul)){
				game.removeVisual(finDelJuegoAzul)
			}else{
				
				game.removeVisual(finDelJuegoRojo)
			}
			musica.pause()
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

	
	
	
	
	
	
	