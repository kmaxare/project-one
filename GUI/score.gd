extends Control

onready var music_player = $Music
onready var return_button = $Return

onready var score_list = $ScoreList

func _ready():
	var scores = ""
	var player_name
	var player_points
	for index in range(game_handler.players_list.size()):
		player_name = str(game_handler.players_list[index]['player'])
		player_points = str(game_handler.players_list[index]['points'])
		scores += player_name + " " + player_points + "\n"
	score_list.text = scores
	
	return_button.grab_focus()
	
	if game_handler.is_music_playing:
		music_player.play(game_handler.song_position)
	else:
		music_player.seek(game_handler.song_position)

func _on_Return_pressed():
	game_handler.song_position = music_player.get_playback_position()
	if get_tree().change_scene("res://GUI/main_screen.tscn") != OK:
		print("Error")
