# Enemigo Uno
extends KinematicBody2D
 #posibles estados de animación del personaje
enum states {idle, run, hurt} 
#posibles direcciones de mira del personaje
enum directions {left, right}
#indicación de haciadonde mira el personaje en la nimación 
const dir_original = directions.left
export (float) var gravity = 90
export (float) var speed = 60
#bandera que indica que el enemigo puede realizar algo
export (bool) var it_move = true 
export (directions) var dir = directions.left
onready var ray_cast_limit : RayCast2D = $ray_cast_limit
onready var floor_detector : RayCast2D = $floor_detector
onready var sprite : Sprite = $Sprite
onready var collision_shape_2D : CollisionShape2D = $collision_shape_2D
onready var detector_wall : RayCast2D = $detector_wall
var enemy_state = states
var ataque = 2
var live = true
var move = Vector2()
var floor_detected : bool
var limit_detected : bool

func _ready() -> void:
	enemy_state = states.idle
	_set_direction_character()

func _physics_process(delta) -> void:
	if (live):
		floor_detected = floor_detector.is_colliding()
		#la negación es porque así, en true limit_detected
		# indica que se ha encontrado un limite
		limit_detected = !ray_cast_limit.is_colliding()
		#checa si se debe cambiar de dirección
		_check_condition_change_direction()
		print(it_move)
		if (it_move):
			$AnimEnemyUno.play("run")
			move.x = (speed * _direction_sign())
		else:
			$AnimEnemyUno.play("idle")
			move.x = 0.0
	#ajuste de gravedad del personaje 
	if is_on_floor():
		move.y = gravity * 0.5
	else:
		move.y += gravity * delta
		move.x *= 0.25
			
	move = move_and_slide(move, Vector2.UP)

#cuando el area2D choca con el personaje se activa 
func _on_hit_box_body_entered(body) -> void:
	if body.is_in_group("player"):
		body.damage_received(ataque, global_position)

#regresa el signo que debe tener el personaje en el movimiento 
#en x, según la dirección del mismo personaje
func _direction_sign() -> float:
	if dir == directions.left:
		return -1.0
	else:
		return 1.0
	pass
	
# checa si se debe girar el personaje 
func _check_condition_change_direction() -> void:
	#mientras no haya ondición de cambio de personaje
	it_move = true #el personaje se moverá
	# si esta en eire y choca con pared 
	if detector_wall.is_colliding():
		_change_direction_character()
		_set_direction_character()
		it_move = false
		print("wall")
	#si esta en el suelo y choca con osbtaculo (limites)
	elif (floor_detected and limit_detected):
		_change_direction_character()
		_set_direction_character()
		it_move= false
		print("limit")


#se cambia la dirección del personaje por medio
# de la variable dir
func _change_direction_character() -> void:
	if dir == directions.left:
		dir = directions.right
	else:
		dir = directions.left

#ajusta elementos de acuerdo a la dirección que debe tener el 
#personaje
func _set_direction_character() -> void:
# Reubicacion dinamica del rayCast para detectar borde
	#checa si esta en la dirección original
	#para arreglar la vista horizontal del sprite
	if dir == dir_original:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	#ajusta la posicion del raycast del límite
	ray_cast_limit.position.x = _variable_sign(ray_cast_limit.position.x)
	ray_cast_limit.cast_to.x = _variable_sign(ray_cast_limit.cast_to.x)
	collision_shape_2D.position.x = _variable_sign(collision_shape_2D.position.x)
	detector_wall.position.x = -_variable_sign(detector_wall.position.x)
	detector_wall.cast_to.x = -_variable_sign(detector_wall.cast_to.x)

#regresa un valor con respecto a la dirección del personaje actual
func _variable_sign(variable : float) -> float:
	return abs(variable) * _direction_sign()

func death(deathTipe) -> void:
	if !live: return
		
	live = false
	if (deathTipe == 'crushed'):
		print('Muerte por aplastamiento')
		$AnimEnemyUno.play("hurt")
		#set_co
	yield($AnimEnemyUno, "animation_finished")
	queue_free()
	
