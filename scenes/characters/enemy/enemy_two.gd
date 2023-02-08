extends KinematicBody2D

var attack_power = 2
var current_speed: int
var is_alive = true

onready var animation = $animation

export (float) var gravity = 300
export (float) var speed = 130
export (float) var jump_force = 250
export (bool) var should_move = true
export (int) var direction_multiplier = -1

var move_distance = Vector2()
var movement = Vector2()

func _ready():
	set_direction_raycast()
	current_speed = speed

func _physics_process(delta):
	motion_ctrl()
	
func handle_death(death_tipe):
	if (death_tipe == 'crushed'):
		print('Muerte por aplastamiento')
	queue_free()

func jump():
	should_move = false
	current_speed = 0

	if rand_range(1, 5) < 3:
		animation.play("charger")
		yield(animation, "animation_finished")
		movement.y = -jump_force
		animation.play("jump")
		yield(animation, "animation_finished")

	current_speed = speed
	should_move = true

func motion_ctrl():
	if is_alive:
		if should_move:
			animation.play("walk")
			move_distance.x = current_speed
			
			movement.x = direction_multiplier * move_distance.x
			movement.y += gravity
			move_and_slide(movement, Vector2(0, -1))

		if is_on_wall():
			direction_multiplier = - direction_multiplier
			$Sprite.flip_h = not $Sprite.flip_h
			set_direction_raycast() 
			
		if is_on_ceiling():
			movement.y = 150

		set_speed(is_on_floor())

func set_direction_raycast():
	$RayCastLimit.position = $CollisionShape2D.shape.get_extents().x * Vector2(direction_multiplier, 0)

func set_speed(is_jump: bool):
	current_speed = speed if is_jump else speed / 2

func _on_Area2D_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(attack_power, global_position)

func _on_timer_timeout():
	if !is_on_floor():
		return
	jump()
