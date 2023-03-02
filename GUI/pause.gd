extends Control

onready var resume = $VBoxContainer/Resume

# Variable para almacenar el estado de pausa del juego
var game_paused = false

func _ready():
	# Activar cuando sea necesario
	$Sound/Bgm.playing_music('FirstLevel')

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

func _on_Restart_pressed():
	get_tree().paused = false
	if get_tree().reload_current_scene() != OK:
		print("Error al recargar la escena del nivel")

func _on_Resume_pressed():
	# Reanuda el juego y oculta la pantalla de pausa
	game_paused = false
	visible = false
	get_tree().paused = false
