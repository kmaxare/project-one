extends Node

# Variable para puntos del jugador
var puntos = 0
# Gravedad para personajes
var gravity = 20
# Tiempo para que termine el nivel
var tiempo = 180

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("ui_focus_next"):
		get_tree().reload_current_scene()

func game_over():
	get_tree().change_scene("res://GUI/game_over.tscn")
