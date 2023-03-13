extends Control

# Variables para controlar la música
export (Texture) var music_on
export (Texture) var music_on_hover
export (Texture) var music_off
export (Texture) var music_off_hover

onready var resume = $VBoxContainer/Resume

var song
onready var music_button = $MusicButton
onready var music_player = $MusicPlayer

# Variable para almacenar el estado de pausa del juego
var game_paused = false

func _ready():
	game_handler.current_song = "res://music/bgm/first_level.ogg"
	song = load(game_handler.current_song)
	game_handler.level_song_position = 0
	music_player.stream = song
	music_player.play()

func _physics_process(_delta):
	# Comprueba si se ha presionado la acción de pausa
	if Input.is_action_just_pressed("pause"):
		# Si el juego no está en pausa, pausa el juego
		if game_paused == false:
			resume.grab_focus()
			game_paused = true
			visible = true
			get_tree().paused = true
		# Si el juego está en pausa, reanuda el juego
		else:
			game_paused = false
			visible = false
			get_tree().paused = false

func _on_BackToMenu_pressed():
	get_tree().paused = false
	# Cambia a la escena del menú principal
	if get_tree().change_scene("res://GUI/main_screen.tscn") != OK:
		print("Error al cargar el menu principal")
		
func _on_MusicButton_pressed():
	if game_handler.is_level_music_playing:
		# Si la música está sonando, se detiene y se cambia la textura del botón
		game_handler.is_level_music_playing = false
		music_button.texture_normal = music_off
		music_button.texture_focused = music_off_hover
		music_button.texture_hover = music_off_hover
		game_handler.level_song_position = music_player.get_playback_position()
		music_player.stop()
	else:
		# Si la música está detenida, se reproduce y se cambia la textura del botón
		game_handler.is_level_music_playing = true
		music_button.texture_normal = music_on
		music_button.texture_focused = music_on_hover
		music_button.texture_hover = music_on_hover
		music_player.play(game_handler.level_song_position)

func _on_Restart_pressed():
	get_tree().paused = false
	if get_tree().reload_current_scene() != OK:
		print("Error al recargar la escena del nivel")

func _on_Resume_pressed():
	# Reanuda el juego y oculta la pantalla de pausa
	game_paused = false
	visible = false
	get_tree().paused = false
