extends KinematicBody2D

export (float) var gravity = 250.0
export (float) var speed = 60
export (bool) var it_move = true # El enemigo se puede mover

var ataque = 2
var live = true
export (int) var dir_desp = -1

var move: Vector2 = Vector2(0, 0)

var precipicio = 1

func _ready():
	set_dir()

func _physics_process(delta):
	var suelo = $RayCastLimit.get_collider()
	if (live):
		var dimension = transform
		
		apply_gravity(delta)
		if (it_move):
			move.x = speed * dir_desp
		move_and_slide(Vector2(move.x, 0), Vector2(0,-1))
		if is_on_wall():
			dir_desp = -dir_desp
			set_dir()

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.damageReceived(ataque)

func apply_gravity(delta) -> void:
	var G = gravity * delta
	move.y += G
	move_and_slide(Vector2(0, move.y), Vector2(0, -1))
	if is_on_floor():
		move.y = 0

func set_dir() -> void:
	$RayCastLimit.position.x = $CollisionShape2D.shape.get_extents().x * dir_desp
		
func death(deathTipe) -> void:
	if (deathTipe == 'crushed'):
		# Animacion de aplastamiento
		# Animacion muerte
		print('Muerte por aplastamiento')
	queue_free()
	
