import wollok.game.*
import juego.*
import visuales.*

////////////////////////////// CLASE CONSTRUCCION
	
class Construccion inherits Polimorfismo  {
	const property maderaRequiere = 5
	const property piedraRequiere = 5
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
	override method darMadera(cantidad,quien){  // el parametro es  la cantidad de recurso que el jugador tiene, y pierde al usarlo en la construccion
		if (cantidadMadera < maderaRequiere){
			cantidadMadera = cantidadMadera + cantidad
			self.calcularTotal()
			quien.restarMadera(cantidad)
		}
	}
	override method darPiedra(cantidad,quien){
		if (cantidadPiedra < piedraRequiere){
			cantidadPiedra = cantidadPiedra + cantidad
			self.calcularTotal()
			quien.restarPiedra(cantidad)
		}
	}
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
	override method terminado(){
		if (cantidadMadera >= maderaRequiere and cantidadPiedra >= piedraRequiere){
			game.addVisual(new Visual(image ="casafa.png", position = self.position()))
			self.default()
			contadorj1.sumarPuntos()
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
	override method terminado(){
		if (cantidadMadera >= maderaRequiere and cantidadPiedra >= piedraRequiere){
			game.addVisual( new Visual(image = "casafr.png",position = self.position()))
			self.default()
			contadorj2.sumarPuntos()
		}
	}
}


