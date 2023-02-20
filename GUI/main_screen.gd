extends Control

#se carga el nodo del panel de introducción de nombre
onready var name_panel : Panel = $NamePanel
#se carga la propiedad text del nodo name_intro
onready var name_player : String = $NamePanel/NameIntro.text

#función que se ejecuta al principio de ejecutarse la escena
func _ready() -> void:
	#oculta el panel de introducir nombre
	name_panel.hide()

#Función que se activa cuando se presiona el botón "start"
func _on_start_pressed() -> void:
	name_panel.show()

#Función que se activa cuando se presiona el botón "score"
func _on_score_pressed() -> void:
	#Cambia a la escena "score.tscn"
	get_tree().change_scene("res://GUI/score.tscn")

#Función que se activa cuando se presiona el botón "instruccions"
func _on_instruccions_pressed() -> void:
	#Cambia a la escena "instruccions.tscn"
	get_tree().change_scene("res://GUI/instruccions.tscn")

#Función que se activa cuando se presiona el botón "controls"
func _on_controls_pressed() -> void:
	#Cambia a la escena "controls.tscn"
	get_tree().change_scene("res://GUI/controls.tscn")

#Función que se activa cuando se presiona el botón "credits"
func _on_credits_pressed() -> void:
	#Cambia a la escena "credits.tscn"
	get_tree().change_scene("res://GUI/credits.tscn")

#Función que se activa cuando se presiona el botón "quit"
func _on_quit_pressed() -> void:
	#Cierra el programa
	get_tree().quit()

# Función que se activa cuando se presiona el botón OK
# de cuando se introduce el juego
func _on_name_done_pressed() -> void:
	game_handler.player_name = name_player
	get_tree().change_scene("res://levels/level_one.tscn")

# se presiono el boton regresar del panel de introducir nombre
func _on_panel_hide_pressed() -> void:
	name_panel.hide()
	
