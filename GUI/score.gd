extends Control

onready var music_player = $Music
onready var return_button = $Return

onready var local_top_player_name = $ScoreContainer/LocalTopPlayer/Name
onready var local_top_player_score = $ScoreContainer/LocalTopPlayer/Score

func _ready():
	return_button.grab_focus()
	
	local_top_player_name.text = game_handler.top_player_name
	local_top_player_score.text = str(game_handler.top_player_score)
	
	if game_handler.is_music_playing:
		music_player.play(game_handler.song_position)
	else:
		music_player.seek(game_handler.song_position)

func _on_Return_pressed():
	game_handler.song_position = music_player.get_playback_position()
	if get_tree().change_scene("res://GUI/main_screen.tscn") != OK:
		print("Error")
