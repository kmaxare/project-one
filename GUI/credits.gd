extends Control

# Obtiene el nodo del botón de retorno
onready var button_return = $Return
# Obtiene el nodo de control de los créditos
onready var credits_control = $CreditsControl

# Función llamada al terminar la carga del nodo
func _ready():
	# Establece el enfoque en el botón de retorno
	button_return.grab_focus()

# Función de proceso de física, se llama en cada fotograma
func _physics_process(_delta):
	# Controla el movimiento de los créditos
	move_credits()
		
func move_credits():
	# Mueve los créditos 0.25 píxeles hacia arriba
	credits_control.rect_position.y -= 0.25
	
	# Si los créditos llegan al final, reinicia su posición
	if credits_control.rect_position.y == -275:
		credits_control.rect_position.y = 200

# Función llamada al presionar el botón de retorno
func _on_return_pressed():
	# Cambia a la pantalla principal
	if get_tree().change_scene("res://GUI/main_screen.tscn") != OK:
		print("Error")
