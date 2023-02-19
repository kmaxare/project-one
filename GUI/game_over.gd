extends Control

# Se obtiene el nodo del botón Retry
onready var button_retry = $VBoxContainer/HBoxContainer/Retry
# Se obtiene el nodo de texto para mostrar la puntuación del jugador
onready var score = $VBoxContainer/VBoxContainer2/Player/Score

# Función llamada al terminar la carga del nodo
func _ready():
	# Establece el texto de la puntuación del jugador en el valor actual de la puntuación
	score.text = str(GameHandler.points)
	# Se establece el foco en el botón Retry para que sea seleccionado por defecto
	button_retry.grab_focus()

# Función llamada cuando se presiona el botón Retry
func _on_Retry_pressed():
	if get_tree().change_scene("res://levels/level_one.tscn") != OK:
		print("Error")

# Función llamada cuando se presiona el botón Return
func _on_Return_pressed():
	if get_tree().change_scene("res://GUI/main_screen.tscn") != OK:
		print("Error")
