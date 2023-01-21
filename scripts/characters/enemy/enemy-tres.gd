extends KinematicBody2D

# Enemigo Dos
export (float) var gravity = 300
export (float) var speed = 130
export (float) var jump = 250
var speed_copy: int
export (bool) var it_move = true # El enemigo se puede mover

var ataque = 2
var live = true
export (int) var dir_desp = -1

var distance = Vector2()
var move = Vector2()
var alert_watching: bool = false

func _ready():
	set_direction_raycast()
	speed_copy = speed

func _physics_process(delta):
	if (live):
		if (it_move):
			distance.x = speed_copy * delta
			
			move.x = (dir_desp * distance.x)/delta
			move.y += gravity * delta
			move_and_slide(move, Vector2(0,-1))
			
		if is_on_wall():
			dir_desp = -dir_desp
			set_direction_raycast()
		
		if !alert_watching:
			observe_npc(looking_at())

func saltar() -> void:
	if is_on_floor(): move.y = -jump

func looking_at():
	var looking_object
	if $RayCastVision.is_colliding():
		looking_object = $RayCastVision.get_collider()
		alert_watching = true
	elif !$RayCastVision.is_colliding():
		looking_object = null
	
	return looking_object

func observe_npc(looking_object):
	if looking_object != null:
		if looking_object.is_in_group('player'):
			print('Es el juguador mi patasa')
			attack_player()
		elif looking_object.is_in_group('enemigo'):
			print('Es Billy el quejumbroso')

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.damageReceived(ataque)

func set_direction_raycast() -> void:
	# Reubicacion dinamica de rayCast para detectar borde
	$RayCastLimit.position.x = $CollisionShape2D.shape.get_extents().x * dir_desp
	#Reubicacion dinamica de rayCast para la vision del enemigo
	$RayCastVision.position.x = ($CollisionShape2D.shape.get_extents().x + 10) * dir_desp
	$RayCastVision.rotation_degrees = - $RayCastVision.rotation_degrees

func death(deathTipe) -> void:
	if (deathTipe == 'crushed'):
		# Animacion de aplastamiento
		# Animacion muerte
		print('Muerte por aplastamiento')
	queue_free()

func velocidad_despl(isJump: bool):
	if (isJump):
		speed_copy = speed 
	elif (!isJump):
		speed_copy = speed / 2

func attack_player():
	speed_copy = 0
	yield(get_tree().create_timer(3.0), "timeout")
	speed_copy = speed * 2
	$Timer.start()

func _on_Timer_timeout():
	print ('Cargar')
	yield(get_tree().create_timer(1.0), "timeout")
	speed_copy = speed

