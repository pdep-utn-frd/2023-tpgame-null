import wollok.game.*
import juego.*
import jugadores.*


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

