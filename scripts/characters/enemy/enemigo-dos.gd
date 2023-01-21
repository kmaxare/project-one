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
			
		velocidad_despl(is_on_floor())
			
func saltar() -> void:
	if is_on_floor(): move.y = -jump

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.damageReceived(ataque)

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
	print ('Saltar')
	saltar()
