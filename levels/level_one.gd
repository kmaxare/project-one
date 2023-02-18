extends Node2D

var cont = 0

func _ready():
	GameHandler.tiempo = 180
	GameHandler.puntos = 0

func _physics_process(delta):
	time_control()

func time_control():
	cont += 1
	if cont > 60:
		cont = 0
		GameHandler.tiempo -= 1
		
		if GameHandler.tiempo == 0:
			GameHandler.game_over()
