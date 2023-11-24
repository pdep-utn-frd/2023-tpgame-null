import wollok.game.*
import juego.*
import jugadores.*


class Visual inherits juego.ElementosDeJuego {
	var property image
	var property position = game.origin()
}
const finDelJuegoEmpate = new Visual(
	image = "GameOverTie.png",
	position = game.at(-1,2)
)
const finDelJuegoRojo = new Visual(
	image = "GameOverRed.png",
	position = game.at(-1,2)
)
const finDelJuegoAzul = new Visual(
	image = "GameOverBlue.png",
	position = game.at(-1,2)
) 
const inicioDelJuego = new Visual(
	image =  "inicio.png",
	position = game.at(-1,2)
)

// puntos
class Contador{
	var image = "nro0.png"
	var property puntos = 0
	method puntos() = puntos
	method image() = image
	method default(){
		puntos = 0
		image = "nro0.png"
	}
	method cambiarPuntos(numero) {
		image = "nro"+ numero + ".png"
	}
	 method sumarPuntos(){
		puntos += 1
		self.cambiarPuntos(puntos)
	}
}
object puntosAzul {
	method position() = game.at(30,24)
	method image() = "puntosA.png"
}
object puntosRojo{
	method position() = game.at(5,24)
	method image() = "puntosR.png"
}
object contadorAzul inherits Contador{
	method position() = game.at(33,24)
}
object contadorRojo inherits Contador{
	method position() = game.at(8,24)
}
