# Extiende la clase Control
extends Control

# Obtiene el nodo de texto para mostrar la puntuación del jugador
onready var score = $VBoxContainer/VBoxContainer2/Player/Score

onready var return_menu = $VBoxContainer/ReturnMenu

# Función llamada al terminar la carga del nodo
func _ready():
	# Establece el texto de la puntuación del jugador en el valor actual de la puntuación
	score.text = str(game_handler.points)
	return_menu.grab_focus()

func _on_ReturnMenu_pressed():
	if get_tree().change_scene("res://GUI/main_screen.tscn") != OK:
		print("Error")
