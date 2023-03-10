extends Control

onready var score = $VBoxContainer/VBoxContainer2/Player/Score
onready var player_name = $VBoxContainer/VBoxContainer2/Player/Name
onready var legend_bonus_time = $VBoxContainer/VBoxContainer2/panel_time/bouns_time
onready var return_menu = $ReturnMenu
var bonus_time = 0
export var factor_bonus_time = 1

func _ready():
	# Establece el texto de bonus de tiempo por terminar el nivel
	bonus_time = game_handler.time * factor_bonus_time
	legend_bonus_time.text = str(bonus_time)
	# Establece la puntuación del jugador sumado el bono de tiempo
	game_handler.points += bonus_time
	# Se establece el foco en el botón "ReturnMenu" para que pueda ser activado mediante teclado
	return_menu.grab_focus()
	_adjust_score()

func _adjust_score() -> void:
	# Establece el texto de la puntuación del jugador en la Label actual de la puntuación
	score.text = str(game_handler.points)
	player_name.text = game_handler.player_name
	# Si se supera el puntaje máximo actualizar ranking
	if game_handler.points > game_handler.top_player_score:
		game_handler.top_player_score = game_handler.points
		game_handler.top_player_name = game_handler.player_name
#	top_player_score.text = str(game_handler.top_player_score)
#	top_player_name.text = game_handler.top_player_name

func _on_ReturnMenu_pressed():
	if get_tree().change_scene("res://GUI/main_screen.tscn") != OK:
		print("Error")
