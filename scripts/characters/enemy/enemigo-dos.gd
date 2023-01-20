extends KinematicBody2D

# Para eliminar
const VectorUP = Vector2(0,-1);
var GRAVITY = 20
var v_inicial = 20

# Enemigo Dos

export (float) var gravity = 250.0
export (float) var speed = 60
export (bool) var it_move = true # El enemigo se puede mover

var ataque = 2
var live = true
export (int) var dir_desp = -1

var JUMPFORCE = -200
var velocity
var is_jumping: bool = false

var move: Vector2 = Vector2(0, 0)

func _ready():
	set_dir()
	velocity = Vector2.ZERO

func _physics_process(delta):
	if (live):
#		var dimension = transform
		apply_gravity(delta)
		if (it_move):
			if (v_inicial > 0):
				velocity.x = min(velocity.x + v_inicial, 80)
			elif (v_inicial < 0):
				velocity.x = min(velocity.x - v_inicial, -80)
#		move_and_slide(Vector2(move.x, 0), Vector2(0,-1))
		velocity = move_and_slide(velocity, VectorUP)
		if is_on_wall():
			if (v_inicial > 0):
				v_inicial = -(v_inicial)
			elif (v_inicial < 0):
				v_inicial = +(v_inicial)
			set_dir()

func desp_lados():
	
	pass

func apply_gravity(delta) -> void:
	velocity.y += GRAVITY

func saltar() -> void:
	if (is_on_floor()):
		velocity.y = JUMPFORCE

func set_dir() -> void:
	$RayCastLimit.position.x = $CollisionShape2D.shape.get_extents().x * dir_desp

func death(deathTipe) -> void:
	if (deathTipe == 'crushed'):
		# Animacion de aplastamiento
		# Animacion muerte
		print('Muerte por aplastamiento')
	queue_free()
	

func _on_Timer_timeout():
	saltar()

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.damageReceived(ataque)
