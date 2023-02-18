extends Node

#variable de la dirección ultima escena jugada 
var previous_scene : String = "res://GUI/main_screen.tscn"
#variables para el ranking de jugadores 
var player_name : String = "New Player"
var player_score = 0
var top_player_name : String = "Top Player"
var top_player_score = 15
# Variable para puntos del jugador
var points = 0
# Gravedad para personajes
var gravity = 20
# Tiempo para que termine el nivel
var time = 180

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("ui_focus_next"):
		get_tree().reload_current_scene()

func game_over():
	get_tree().change_scene("res://GUI/game_over.tscn")
