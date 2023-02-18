# Extiende la clase Control
extends Control

# Obtiene el nodo de texto para mostrar la puntuación del jugador
onready var score = $VBoxContainer/VBoxContainer2/Player/Score

# Función llamada al terminar la carga del nodo
func _ready():
	# Establece el texto de la puntuación del jugador en el valor actual de la puntuación
	score.text = GameHandler.points

# Función llamada al presionar el botón de volver al menú principal
func _on_Button_pressed():
	# Cambia a la escena del menú principal
	get_tree().change_scene("res://GUI/main_screen.tscn")
