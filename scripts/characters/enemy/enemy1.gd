extends KinematicBody2D

export (float) var gravity = 250.0
export (float) var speed = 60
export (bool) var it_move = true # El enemigo se puede mover

var ataque = 2
var live = true
var dir = -1

var move: Vector2 = Vector2(0, 0)
export (float) var displSpeed

func _physics_process(delta):
	if (live):
		apply_gravity(delta)
		if (it_move):
			move.x = speed * dir
		move_and_slide(Vector2(move.x, 0), Vector2(0,-1))
		
		if is_on_wall():
			dir = -dir

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.damageReceived(ataque, body)

func apply_gravity(delta) -> void:
	var G = gravity * delta
	move.y += G
	move_and_slide(Vector2(0, move.y), Vector2(0, -1))
	if is_on_floor():
		move.y = 0
	
