extends Node2D

var cont = 0

func _ready():
	game_handler.points = 0
	game_handler.time = 180

func _physics_process(delta):
	time_control()
		
func time_control():
	cont += 1
	if cont > 60:
		cont = 0
		game_handler.time -= 1
		
		if game_handler.time == 0:
			game_handler.game_over()
