extends Node2D

var cont = 0

func _ready():
	Gamehundler.tiempo = 180
	Gamehundler.puntos = 0

func _physics_process(delta):
	time_control()
		
func time_control():
	cont += 1
	if cont > 60:
		cont = 0
		Gamehundler.tiempo -= 1
		
		if Gamehundler.tiempo == 0:
			Gamehundler.gameOver()
