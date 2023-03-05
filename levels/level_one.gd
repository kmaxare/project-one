extends Node2D

var cont = 0
export var timer_level: int = 60

func _ready() -> void:
	game_handler.current_level = "res://levels/level_one.tscn"
	game_handler.points = 0
	
	if timer_level > 0:
		game_handler.time = timer_level
	else:
		print('ERROR VALOR NUMERICO DE TIEMPO ES NEGATIVO O CERO')
		game_handler.time = 60

func _physics_process(delta) -> void:
	time_control()

func time_control() -> void:
	cont += 1
	if cont > 60:
		cont = 0
		game_handler.time -= 1
		
		if game_handler.time == 0:
			game_handler.game_over()

#func _on_LevelOne_tree_exiting() -> void:
	#get_tree().change_scene("res://GUI/game_over.tscn")

