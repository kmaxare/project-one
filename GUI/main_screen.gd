extends Control

#Función que se activa cuando se presiona el botón "start"
func _on_start_pressed():
	#Cambia a la escena "level-one.tscn"
	get_tree().change_scene("res://levels/level_one.tscn")

#Función que se activa cuando se presiona el botón "score"
func _on_score_pressed():
	#Cambia a la escena "score.tscn"
	get_tree().change_scene("res://GUI/score.tscn")

#Función que se activa cuando se presiona el botón "instruccions"
func _on_instruccions_pressed():
	#Cambia a la escena "instruccions.tscn"
	get_tree().change_scene("res://GUI/instruccions.tscn")

#Función que se activa cuando se presiona el botón "controls"
func _on_controls_pressed():
	#Cambia a la escena "controls.tscn"
	get_tree().change_scene("res://GUI/controls.tscn")

#Función que se activa cuando se presiona el botón "credits"
func _on_credits_pressed():
	#Cambia a la escena "credits.tscn"
	get_tree().change_scene("res://GUI/credits.tscn")

#Función que se activa cuando se presiona el botón "quit"
func _on_quit_pressed():
	#Cierra el programa
	get_tree().quit()
