extends Control

onready var score = $VBoxContainer/VBoxContainer2/Player/Score
onready var return_menu = $VBoxContainer/ReturnMenu

func _ready():
	# Establece el texto de la puntuación del jugador en el valor actual de la puntuación
	score.text = str(game_handler.points)
	# Se establece el foco en el botón "ReturnMenu" para que pueda ser activado mediante teclado
	return_menu.grab_focus()

func _on_ReturnMenu_pressed():
	if get_tree().change_scene("res://GUI/main_screen.tscn") != OK:
		print("Error")
