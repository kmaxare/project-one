extends Node

#variable de la dirección ultima escena jugada 
var current_level : String

var is_music_playing = true
var song_position = 0

#variables para el ranking de jugadores 
var player_name : String = "New Player"
var player_score = 0
var top_player_name : String = "Top Player Name"
var top_player_score = 15

# Lista de jugadores
var players_list = []

# Variable para puntos del jugador
var points = 0
# Gravedad para personajes
var gravity = 20
# Tiempo para que termine el nivel
var time = 180

func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("ui_focus_next"):
		if (get_tree().reload_current_scene()):
			print('Error para reconocer escena recargada')
			
func game_over():
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
	
	#Si existe un registro
	for index in range(players_list.size()):
		if players_list[index]['player'] == player_param:
			players_list[index]['points'] = points
			print(players_list)
			return # Si encuentra al jguador retorn y ya no continua con la funcion

	players_list.append({'player': player_param, 'points': 0})
	print(players_list)
	
func save_player():
	
	pass
