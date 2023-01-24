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

func _ready():
	set_direction_raycast()
	speed_copy = speed
	$AnimEnemyUno.play("idle")

func _physics_process(delta):
	if (live):
		
		if (it_move):
			$AnimEnemyUno.play("walk")
			distance.x = speed_copy * delta
			
			move.x = (dir_desp * distance.x)/delta
			move.y += gravity * delta
			move_and_slide(move, Vector2(0,-1))
			
		if is_on_wall():
			dir_desp = -dir_desp
			$Sprite.flip_h = !$Sprite.flip_h
			set_direction_raycast()
		
		if $RayCastVision.enabled:
			observe_npc(looking_at())

func saltar() -> void:
	if is_on_floor(): move.y = -jump

func looking_at():
	var looking_object
	if $RayCastVision.is_colliding():
		print ('coliciono')
		looking_object = $RayCastVision.get_collider()
		$RayCastVision.enabled = false
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
		body.damageReceived(ataque, global_position)

func set_direction_raycast() -> void:
	# Reubicacion dinamica de rayCast para detectar borde
	$RayCastLimit.position.x = $CollisionShape2D.shape.get_extents().x * dir_desp
	#Reubicacion dinamica de rayCast para la vision del enemigo
	$RayCastVision.position.x = ($CollisionShape2D.shape.get_extents().x + 10) * dir_desp
	$RayCastVision.rotation_degrees = - $RayCastVision.rotation_degrees

func death(deathTipe) -> void:
	if !live: return
	
	live = false
	if (deathTipe == 'crushed'):
		# Animacion de aplastamiento
		# Animacion muerte
		print('Muerte por aplastamiento')
		$AnimEnemyUno.play("hurt")
	queue_free()

func velocidad_despl(isJump: bool):
	if (isJump):
		speed_copy = speed 
	elif (!isJump):
		speed_copy = speed / 2

func attack_player():
	it_move = false
	$AnimEnemyUno.play("charger")
	speed_copy = 0
#	yield(get_tree().create_timer(3.0), "timeout")
	yield($AnimEnemyUno, "animation_finished")
	speed_copy = speed * 2
	$Timer.start()

func _on_Timer_timeout():
	yield(get_tree().create_timer(1.0), "timeout")
	it_move = true
	$AnimEnemyUno.play("run")
	speed_copy = speed
	$RayCastVision.enabled = true

