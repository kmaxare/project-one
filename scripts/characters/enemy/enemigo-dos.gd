extends KinematicBody2D

# Enemigo Dos
export (float) var gravity = 300
export (float) var speed = 60
export (bool) var it_move = true # El enemigo se puede mover

var ataque = 2
var live = true
export (int) var dir_desp = -1

var distance = Vector2()
var move = Vector2()

var speed_force = 200

func _ready():
	set_dir()

func _physics_process(delta):
	if (live):
		if (it_move):
			distance.x = speed_force * delta
			move.x = (dir_desp * distance.x)/delta
			move.y += gravity * delta
			move_and_slide(move, Vector2(0,-1))
			
		if is_on_wall():
			dir_desp = -dir_desp
			set_dir()
			
func saltar() -> void:
	if is_on_floor():
		move.y = -200
		pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.damageReceived(ataque)

func set_dir() -> void:
	$RayCastLimit.position.x = $CollisionShape2D.shape.get_extents().x * dir_desp
		
func death(deathTipe) -> void:
	if (deathTipe == 'crushed'):
		# Animacion de aplastamiento
		# Animacion muerte
		print('Muerte por aplastamiento')
	queue_free()
	

func _on_Timer_timeout():
	print ('Saltar')
	saltar()
