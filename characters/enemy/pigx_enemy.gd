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
var is_on_camera: bool = false

func _ready():
	set_direction_raycast()
	speed_copy = speed

func _physics_process(delta):
	if !is_on_camera:
		return
	
	if (live):
		if (it_move):
			$AnimEnemyUno.play("walk")
			distance.x = speed_copy * delta
			
			move.x = (dir_desp * distance.x)/delta
			move.y += gravity * delta
			move_and_slide(move, Vector2(0,-1))

		if is_on_wall(): # Colosion de lados
			dir_desp = -dir_desp
			$Sprite.flip_h = !$Sprite.flip_h
			set_direction_raycast() 
			
		if (is_on_ceiling()): # Colosion con el techo
			move.y = +150

		velocidad_despl(is_on_floor())

func saltar() -> void:
	it_move = false
	speed_copy = 0
	randomize()
	var rand = int(rand_range(1, 5))
	$AnimEnemyUno.play("charger")
	yield($AnimEnemyUno, "animation_finished")
	speed_copy = speed
	if is_on_floor() and rand < 2.5:
		move.y = -jump
		$AnimEnemyUno.play("jump")
		yield($AnimEnemyUno, "animation_finished")
	it_move = true

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.damage_received(ataque, global_position)

func set_direction_raycast() -> void:
	# Reubicacion dinamica de rayCast para detectar borde
	$RayCastLimit.position.x = $CollisionShape2D.shape.get_extents().x * dir_desp

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

func _on_Timer_timeout():
	if is_on_floor(): saltar()


func _on_VisibilityNotifier2D_screen_entered():
	is_on_camera = true
