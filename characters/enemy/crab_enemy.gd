extends KinematicBody2D
# Enemigo Uno
enum states {idle, run, hurt}
var enemy_state = states

export (float) var gravity = 150
export (float) var speed = 60
export (bool) var it_move = true # El enemigo se puede mover

var ataque = 2
var live = true
export (int) var dir_desp = -1

var distance = Vector2()
var move = Vector2()


func _ready():
	enemy_state = states.idle
	set_direction_raycast()


func _physics_process(delta):
	if (live):
		if (it_move):
			$AnimEnemyUno.play("run")
			distance.x = speed * delta
			move.x = (dir_desp * distance.x)/delta
			move.y += gravity * delta
			move_and_slide(move, Vector2(0,-1))

		if is_on_wall() or (is_on_floor() and !$RayCastLimit.is_colliding()):
			dir_desp = -dir_desp
			$Sprite.flip_h = !$Sprite.flip_h
			set_direction_raycast()


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.damage_received(ataque, global_position)


func set_direction_raycast() -> void:
	# Reubicacion dinamica de rayCast para detectar borde
	$RayCastLimit.position.x = $CollisionShape2D.shape.get_extents().x * dir_desp


func death(deathTipe) -> void:
	if !live: return
		
	live = false
	if (deathTipe == 'crushed'):
		print('Muerte por aplastamiento')
		$AnimEnemyUno.play("hurt")
	yield($AnimEnemyUno, "animation_finished")
	queue_free()
	
