extends Control

onready var return_button = $Return
onready var music_player = $Music

onready var wasd_animation = $WASD/WASDAnimation
onready var m_animation = $M/MAnimation
onready var space_animation = $Space/SpaceAnimation

func _ready():
	return_button.grab_focus()
	
	wasd_animation.play("idle")
	m_animation.play("idle")
	space_animation.play("idle")
	
	if game_handler.is_music_playing == true:
		music_player.play(game_handler.song_position)
	else:
		music_player.seek(game_handler.song_position)

func _on_Return_pressed():
	game_handler.song_position = music_player.get_playback_position()
	if get_tree().change_scene("res://GUI/main_screen.tscn") != OK:
		print("Error al cargar la pantalla principal")
