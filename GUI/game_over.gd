extends Control

# Obtiene el nodo de texto para mostrar la puntuación del jugador
onready var score = $VBoxContainer/Scores/Player/Score
onready var top_player_score = $VBoxContainer/Scores/TopPlayer/Score
onready var player_name = $VBoxContainer/Scores/Player/Name
onready var top_player_name = $VBoxContainer/Scores/TopPlayer/Name

# Función llamada al terminar la carga del nodo
func _ready() -> void:
	# Establece el texto de la puntuación del jugador en el valor actual de la puntuación
	_adjust_score()

func _adjust_score() -> void:
	# Establece el texto de la puntuación del jugador en el valor actual de la puntuación
	score.text = str(game_handler.points)
	player_name.text = game_handler.player_name
	# Si se supera el puntaje máximo actualizar ranking
	if game_handler.points > game_handler.top_player_score:
		game_handler.top_player_score = game_handler.points
		game_handler.top_player_name = game_handler.player_name
	top_player_score.text = str(game_handler.top_player_score)
	top_player_name.text = game_handler.top_player_name

# Función llamada al presionar el botón de volver al menú principal
func _on_return_menu_pressed() -> void:
	# Cambia a la escena del menú principal
	get_tree().change_scene("res://GUI/main_screen.tscn")

func _on_restart_level_pressed() -> void:
	get_tree().change_scene(game_handler.previous_scene)
	pass # Replace with function body.
