extends Node

# Variable para puntos del jugador
var puntos = 0
# Gravedad para personajes
var gravity = 20
# Tiempo para que termine el nivel
var tiempo = 400
var estadoGameOver = false

func _ready():
	pass 

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("ui_focus_next"):
		get_tree().reload_current_scene()

func gameOver():
	get_tree().paused = true
	print("El jugador ha muerto")
	estadoGameOver = true
	pass
