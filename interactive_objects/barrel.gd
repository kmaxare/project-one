extends KinematicBody2D

# Constante para establecer la dirección del suelo
const FLOOR = Vector2(0, -1)

# Variable exportada para establecer la velocidad del objeto
export var speed = 100

# Variable para almacenar el movimiento del objeto
onready var motion = Vector2.ZERO

# Variable para establecer la gravedad del objeto
var gravity = 8

# Función que se ejecuta en cada ciclo de física
func _physics_process(delta):
	# Establecer la velocidad en el eje x
	motion.x = speed
	# Aumentar la velocidad en el eje y debido a la gravedad
	motion.y += gravity
	# Mover el objeto y evitar colisiones con el suelo
	motion = move_and_slide(motion, FLOOR)
	
	

# Función para cambiar la dirección del movimiento del objeto
func change_direction(direction: float):
	# Multiplicar la velocidad actual por la dirección especificada
	speed *= direction
	
	anim_position_damage_area_of_barrel(direction)

# Funcion para ajustar animacion del barril con respecto a su direccion
func anim_position_damage_area_of_barrel(direction):
	if (direction > 0):
		$AnimBarrel.play("rolling_right")
	elif (direction < 0):
		$AnimBarrel.play("rolling_left")
	
	$AreaDamage.position = Vector2(3 * direction, 6)

# Función llamada cuando un cuerpo entra en contacto con este objeto
func _on_AreaDamage_body_entered(body):
	# Verifica si el cuerpo que entró en contacto es el jugador
	if body.is_in_group("player"):
		$AnimBarrel.play("smash")
		# Llama a la función damage_received en el cuerpo del jugador
		body.damage_received(1, global_position)
		yield($AnimBarrel, "animation_finished")
		# Elimina este objeto de la escena
		queue_free()
