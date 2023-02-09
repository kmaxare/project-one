# Extiende la clase Control
extends Control

# Obtiene el nodo de texto para mostrar la puntuación del jugador
onready var score = $VBoxContainer/VBoxContainer2/player/score

# Función llamada al terminar la carga del nodo
func _ready():
	# Establece el texto de la puntuación del jugador en el valor actual de la puntuación
	score.text = str(game_handler.points)

# Función llamada al presionar el botón de volver al menú principal
func _on_Button_pressed():
	# Cambia a la escena del menú principal
	get_tree().change_scene("res://GUI/main_screen.tscn")

func _on_return_menu_pressed():
	pass # Replace with function body.

func _on_retry_pressed():
	pass # Replace with function body.
