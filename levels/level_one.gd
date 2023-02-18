extends Node2D

var cont = 0

func _ready():
	GameHandler.time = 180
	GameHandler.points = 0

func _physics_process(delta):
	time_control()

func time_control():
	cont += 1
	if cont > 60:
		cont = 0
		GameHandler.time -= 1
		
		if GameHandler.time == 0:
			GameHandler.game_over()
