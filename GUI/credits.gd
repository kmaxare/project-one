extends Control

export var reset = -375

# Obtiene el nodo del botón de retorno
onready var button_return = $Return
# Obtiene el nodo de control de los créditos
onready var credits_control = $CreditsControl
onready var music_player = $Music

# Función llamada al terminar la carga del nodo
func _ready():
	# Establece el enfoque en el botón de retorno
	button_return.grab_focus()
	
	if game_handler.is_menu_music_playing == true:
		music_player.play(game_handler.menu_song_position)
	else:
		music_player.seek(game_handler.menu_song_position)

# Función de proceso de física, se llama en cada fotograma
func _physics_process(_delta):
	# Controla el movimiento de los créditos
	move_credits()
		
func move_credits():
	# Mueve los créditos 0.25 píxeles hacia arriba
	credits_control.rect_position.y -= 0.25
	
	# Si los créditos llegan al final, reinicia su posición
	if credits_control.rect_position.y == reset:
		credits_control.rect_position.y = 200

# Función llamada al presionar el botón de retorno
func _on_return_pressed():
	game_handler.menu_song_position = music_player.get_playback_position()
	# Cambia a la pantalla principal
	if get_tree().change_scene("res://GUI/main_screen.tscn") != OK:
		print("Error")
