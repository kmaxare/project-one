extends Control

# Variables para controlar la música
export (Texture) var music_on
export (Texture) var music_off
onready var music_button = $Music/MusicButton
onready var music_player = $Music/MusicPlayer

# Variables para el panel de introducción del nombre del jugador
onready var start_button = $VBoxContainer/Start
onready var name_panel = $NamePanel
onready var name_player = $NamePanel/NameIntro

func _ready() -> void:
	# Al cargar el nodo, se oculta el panel y se pone el foco en el botón de inicio
	name_panel.hide()
	start_button.grab_focus()
	
	if game_handler.is_music_playing == true:
		music_player.play(game_handler.song_position)
	else:
		music_button.texture_normal = music_off

# Botón para ir a la pantalla de créditos
func _on_Credits_pressed():
	game_handler.song_position = music_player.get_playback_position()
	if get_tree().change_scene("res://GUI/credits.tscn") != OK:
		print('Error para reconocer escena credits')

# Botón para mostrar las instrucciones y controles del juego
func _on_InstruccionsControls_pressed():
	pass # Replace with function body.
	
# Botón para controlar el volumen de la música
func _on_MusicButton_pressed():
	if game_handler.is_music_playing:
		# Si la música está sonando, se detiene y se cambia la textura del botón
		game_handler.is_music_playing = false
		music_button.texture_normal = music_off
		music_player.stop()
		game_handler.song_position = music_player.get_playback_position()
	else:
		# Si la música está detenida, se reproduce y se cambia la textura del botón
		game_handler.is_music_playing = true
		music_button.texture_normal = music_on
		music_player.play(game_handler.song_position)
	
# Botón para guardar el nombre del jugador y comenzar el juego
func _on_NameDone_pressed():
	game_handler.player_name = name_player.text
	if get_tree().change_scene("res://levels/level_one.tscn") != OK:
		print("Error para reconocer la escena del nivel")
		
# Botón para cancelar la introducción del nombre del jugador y volver al menú principal
func _on_NameReturn_pressed():
	name_panel.hide()
	start_button.grab_focus()

# Botón para salir del juego
func _on_Quit_pressed():
	get_tree().quit()

# Botón para ir a la pantalla de puntuación
func _on_Score_pressed():
	if get_tree().change_scene("res://GUI/score.tscn") != OK:
		print('Error para reconocer escena score')

# Botón para empezar a jugar, se muestra el panel de introducción del nombre
func _on_Start_pressed():
	name_panel.show()
	name_player.grab_focus()
