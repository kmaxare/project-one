extends KinematicBody2D

var attack_power = 2
var is_alive = true
var current_speed: int
var direction_multiplier = -1

onready var animation = $animation

export (float) var gravity = 150
export (float) var speed = 130
export (float) var jump_force = 250
export (bool) var should_move = true

var move_distance = Vector2()
var movement = Vector2()

func _ready():
	set_direction_raycast()
	current_speed = speed
	animation.play("idle")

func _physics_process(delta):
	motion_ctrl()
	
func change_direction():
	direction_multiplier *= -1
	$Sprite.flip_h = not $Sprite.flip_h
	set_direction_raycast()

func check_npc_look():
	if $RayCastVision.enabled:
		observe_npc(looking_at())
	
func handle_death(death_tipe: String):
	if not is_alive: return

	is_alive = false
	if death_tipe == 'crushed':
		print('Muerte por aplastamiento')
		animation.play("hurt")
	queue_free()
	
func handle_jump():
	movement.y += gravity
	move_and_slide(movement, Vector2(0, -1))

func jump():
	if is_on_floor(): 
		movement.y = - jump_force
		
func launch_attack_on_player():
	should_move = false
	current_speed = 0
	animation.play("charger")
	yield(animation, "animation_finished")
	current_speed = speed * 2
	should_move = true
	$Timer.start()

func looking_at():
	return $RayCastVision.get_collider() or null
	
func motion_ctrl():
	if is_alive:
		if should_move:
			animation.play("walk")
			movement.x = direction_multiplier * current_speed
			handle_jump()
			
		if is_on_wall():
			change_direction()
		
		check_npc_look()

func observe_npc(target: Node):
	if target == null:
		return

	if target.is_in_group("player"):
		print("Es el jugador mi patasa")
		$RayCastVision.enabled = false
		launch_attack_on_player()
	elif target.is_in_group("enemigo"):
		print("Es Billy el quejumbroso")

func set_direction_raycast():
	var shape_extents = $CollisionShape2D.shape.get_extents()
	$RayCastLimit.position.x = shape_extents.x * direction_multiplier
	$RayCastVision.position.x = (shape_extents.x + 10) * direction_multiplier
	$RayCastVision.rotation_degrees = -$RayCastVision.rotation_degrees

func set_movement_speed(is_jumping: bool):
	current_speed = speed if is_jumping else speed / 2
	
func _on_Area2D_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(attack_power, global_position)

func _on_Timer_timeout():
	animation.play("run")
	current_speed = speed
	$RayCastVision.enabled = true
