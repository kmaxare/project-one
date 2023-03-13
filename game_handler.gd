extends Node

# Variable de la dirección ultima escena jugada 
var current_level : String
var current_song

var is_level_music_playing = true
var level_song_position = 0

var is_menu_music_playing = true
var menu_song_position = 0

#variables para el ranking de jugadores 
var player_name : String = "New Player"
var player_score = 0
var top_player_name : String = "Top Player Name"
var top_player_score = 0

# Lista de jugadores
var players_list = []

# Variable para puntos del jugador
var points = 0
# Gravedad para personajes
var gravity = 20
# Tiempo para que termine el nivel
var time = 60

func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("ui_focus_next"):
		if (get_tree().reload_current_scene()):
			print('ERROR PARA RECONOCER ESCENA RECARGADA')
			
func game_over():
	save_player()
	if get_tree().change_scene("res://GUI/game_over.tscn") != OK:
		print("Error")

func create_player(player_param: String):
	var player_exists = false
	for index in range(players_list.size()):
		if players_list[index]['player'] == player_param:
			player_exists = true
	if !player_exists:
		players_list.append({'player': player_param, 'points': 0})
	
	player_name = player_param
	print(players_list)
	
func save_player():
	for index in range(players_list.size()):
		if players_list[index]['player'] == player_name:
			players_list[index]['points'] = points
			print(players_list)
			return # Si encuentra al jugador ya no continua con la funcion
		else: print('ERROR NO SE ENCONTRO AL PLAYER EN LA LISTA')
	print(players_list)
