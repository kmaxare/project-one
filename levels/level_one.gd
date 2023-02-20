extends Node2D

var cont = 0

func _ready() -> void:
	game_handler.current_level = "res://levels/level_one.tscn"
	
	game_handler.time = 180
	game_handler.points = 0

func _physics_process(delta) -> void:
	time_control()

func time_control() -> void:
	cont += 1
	if cont > 60:
		cont = 0
		game_handler.time -= 1
		
		if game_handler.time == 0:
			game_handler.game_over()

func _on_LevelOne_tree_exiting() -> void:
	get_tree().change_scene("res://GUI/game_over.tscn")
