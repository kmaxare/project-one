extends KinematicBody2D

# Constante para establecer la dirección del suelo
const FLOOR = Vector2(0, -1)

# Variable para almacenar el movimiento del objeto
onready var motion = Vector2.ZERO

# Variable exportada para establecer la velocidad del objeto
export var SPEED = 100

# Variable para establecer la gravedad del objeto
var GRAVITY = 8

# Función que se ejecuta en cada ciclo de física
func _physics_process(delta):
	# Establecer la velocidad en el eje x
	motion.x = SPEED
	# Aumentar la velocidad en el eje y debido a la gravedad
	motion.y += GRAVITY
	# Mover el objeto y evitar colisiones con el suelo
	motion = move_and_slide(motion, FLOOR)
	
	animDisplacement()

# Función para cambiar la dirección del movimiento del objeto
func change_direction(direction: float):
	# Multiplicar la velocidad actual por la dirección especificada
	SPEED *= direction
	
func animDisplacement():
	if (motion.x != 0):
		$AnimBarrel.play("rolling")
	else:
		$AnimBarrel.stop()
