extends KinematicBody2D

const UP_VECTOR = Vector2(0, -1)

var velocity = Vector2.ZERO

onready var main_camera : Camera2D = $Camera2D
onready var animation_tween : Tween = $Camera2D/Tween
onready var coyote_timer : Timer = $timer_coyote
onready var random_gen = RandomNumberGenerator.new()

var facing_right = true
var current_state = "falling"
var previous_state = "idle"
var is_disabled = false
var is_invulnerable = false
var was_damaged = false
var damaged_from_right = false
var coyote_time = false
var first_jump_enabled = false
var second_jump_enabled = false

var gravity = 20
var jump_force = -420
var knockback_velocity = 100

export var initial_velocity = 30
export var stop_velocity = 150

func _ready():
	game_handler.points += 7
	set_borders()
	pass

func _physics_process(_delta):
	motion_ctrl()
	
func _on_the_air():
	if Input.is_action_pressed("ui_right"):
		velocity.x = clamp(velocity.x + initial_velocity, - stop_velocity, stop_velocity)
		facing_right = true
	elif Input.is_action_pressed("ui_left"):
		velocity.x = clamp(velocity.x - initial_velocity, - stop_velocity, stop_velocity)
		facing_right = false
	else:
		velocity.x = 0

	if Input.is_action_just_pressed("ui_jump"):
		if coyote_time or (first_jump_enabled and not second_jump_enabled):
			jump()
			first_jump_enabled = true
			second_jump_enabled = true

	if is_on_floor():
		current_state = "idle"
		first_jump_enabled = false
		second_jump_enabled = false

func _on_the_floor():
	velocity.x = 0

	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + initial_velocity, stop_velocity)
		facing_right = true
	elif Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - initial_velocity, - stop_velocity)
		facing_right = false

	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		jump()
		first_jump_enabled = true
		
func animation():
	if was_damaged:
		jump_check()
		current_state = "hurt"
		$AnimationPlayer.play(current_state)
		previous_state = current_state
		was_damaged = false
		is_disabled = true
		is_invulnerable = true
		$timer_invunerable.start(0.74)
		if damaged_from_right:
			velocity.x += - knockback_velocity
			update_collision_direction(false)
		else:
			velocity.x += knockback_velocity
			update_collision_direction(true)
	elif current_state != previous_state:
		jump_check()
		$AnimationPlayer.play(current_state)
		previous_state = current_state
		update_collision_direction(facing_right)
		
func damage_received(damage, position_enemy: Vector2):
	if is_invulnerable:
		return
	
	screen_shake(0.3, 0.1, 2)
	was_damaged = true
	damaged_from_right = global_position.x < position_enemy.x
	
	if game_handler.points < damage:
		game_handler.game_over()
	else:
		game_handler.points -= damage
		
func func_hurt():
	if not is_disabled:
		current_state = "idle"
		
func get_random(minimum, maximum):
	random_gen.randomize()
	var random = random_gen.randf_range(minimum, maximum)
	return random
		
func jump():
	velocity.y = jump_force
	current_state = "jump"

# Check if the player can jump
func jump_check():
	# If the player is in the idle or run state
	if current_state == "idle" or current_state == "run":
		# Reset the jump variables
		first_jump_enabled = false
		second_jump_enabled = false
		coyote_time = false
	# If the player is in the fall state
	elif current_state == "fall":
		# If the player hasn't performed a first jump
		if not first_jump_enabled:
			# Start the coyote time timer
			coyote_timer.start(0.3)
			# Set the coyote time flag
			coyote_time = true
			
func motion_ctrl():
	match current_state:
		"idle", "run":
			_on_the_floor()
		"jump", "fall":
			_on_the_air()
		"hurt":
			func_hurt() 
	velocity.y += gravity 
	animation()
	velocity = move_and_slide(velocity, UP_VECTOR)
	if !is_on_floor() and not is_disabled:
		if velocity.y < -1:
			current_state = "jump"
		if velocity.y > 1:
			current_state = "fall"
	smash()

func post_hurt():
	is_disabled = false

func update_collision_direction(right: bool):
	if right:
		$CollisionShape2D.position = Vector2(2.5, 1.5)
	else:
		$CollisionShape2D.position = Vector2(-2.5, 1.5)
	$Sprite.flip_h = not right 
	
func screen_shake(shake_length : float, shake_power : float, shake_priority : int):
	var current_shake_priority : int = 0
	if shake_priority > current_shake_priority:
		animation_tween.interpolate_method(
			self, #es el objeto a afectar
			"shake_camera", #metodo o funcion afectada
			shake_power, #valor inicial
			0, #valor final, es 0 porque se regresa el offset al inicio
			shake_length, #tiempo que transcurre entre uno y otro
			Tween.TRANS_SINE, #transcision inicial
			Tween.EASE_OUT #Transcision final 
		)
		animation_tween.start()
		
#Ajusta las esquinas de la camara con respectos a los nodos 
# Position2D corner TL (Top Left) y cornerBR (Bottom Right)
func set_borders():
	if not has_node("../settings/cornerTL") or not has_node("../settings/cornerBR"):
		print("No se encuentra el nodo 'settings'")

	var cornerTL = get_node("../settings/cornerTL")
	var cornerBR = get_node("../settings/cornerBR")
	main_camera.limit_bottom = cornerBR.global_position.y
	main_camera.limit_right = cornerBR.global_position.x
	main_camera.limit_top = cornerTL.global_position.y
	main_camera.limit_left = cornerTL.global_position.x
	
func shake_camera(shake_pomer):
	main_camera.offset_h = get_random(-shake_pomer, shake_pomer)
	main_camera.offset_v = get_random(-shake_pomer, shake_pomer)
	
func smash():
	if($RaycastBott.is_colliding()):
		var object_coll = $RaycastBott.get_collider()
		if object_coll.is_in_group("enemy"):
			object_coll.handle_death("crushed")
			velocity.y = jump_force / 2

func _on_timer_coyote_timeout():
	coyote_time = false
	
func _on_timer_invunerable_timeout():
	is_invulnerable = false
