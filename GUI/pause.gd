extends Control

onready var resume = $VBoxContainer/Resume

# Variable para almacenar el estado de pausa del juego
var game_paused = false

func _ready():
	resume.grab_focus()

func _physics_process(delta):
	# Comprueba si se ha presionado la acción de pausa
	if Input.is_action_just_pressed("pause"):
		# Si el juego no está en pausa, pausa el juego
		if game_paused == false:
			game_paused = true
			visible = true
			get_tree().paused = true
		# Si el juego está en pausa, reanuda el juego
		else:
			game_paused = false
			visible = false
			get_tree().paused = false

# Función que se ejecuta al presionar el botón de reanudar
func _on_resume_pressed():
	# Reanuda el juego y oculta la pantalla de pausa
	game_paused = false
	visible = false
	get_tree().paused = false

# Función que se ejecuta al presionar el botón de volver al menú principal
func _on_return_menu_pressed():
	get_tree().paused = false
	# Cambia a la escena del menú principal
	get_tree().change_scene("res://GUI/main_screen.tscn")

# Función que se ejecuta al presionar el botón de salir
func _on_quit_pressed():
	get_tree().paused = false
	# Sale del juego
	get_tree().quit()
