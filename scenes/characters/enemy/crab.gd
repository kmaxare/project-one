extends KinematicBody2D

enum States {IDLE, RUN, HURT}
var state = States.IDLE

var is_moving = true
export var gravity = 150
export var speed = 60

var damage = 2
var is_alive = true
export var direction = -1

var distance = Vector2()
var movement = Vector2()

onready var animation = $animation

func _ready():
	set_direction_raycast()

func _physics_process(delta):
	motion_ctrl()

func handle_death(death_tipe):
	if not is_alive:
		return
	
	is_alive = false
	
	if death_tipe == "crushed":
		print("Muerte por aplastamiento")
		animation.play("hurt")
		yield(animation, "animation_finished")
	
	queue_free()
	
func motion_ctrl():
	if not is_moving or not is_alive:
		return
	
	animation.play("run")
	distance.x = speed
	movement.x = direction * distance.x
	movement.y += gravity
	move_and_slide(movement, Vector2(0,-1))

	var ray_cast_limit_colliding = $RayCastLimit.is_colliding()
	if is_on_wall() or (is_on_floor() and not ray_cast_limit_colliding):
		direction = - direction
		$Sprite.flip_h = not $Sprite.flip_h
		set_direction_raycast()

func set_direction_raycast() -> void:
	$RayCastLimit.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.damageReceived(damage, global_position)
